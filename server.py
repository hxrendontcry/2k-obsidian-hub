import http.server
import socketserver
import json
import urllib.request
import socket
import os

PORT = 8080
DIRECTORY = os.path.dirname(os.path.abspath(__file__))

def check_port(port):
    try:
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
            s.settimeout(0.3)
            return s.connect_ex(('127.0.0.1', port)) == 0
    except Exception:
        return False

class DualBridgeHandler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=DIRECTORY, **kwargs)

    def do_GET(self):
        if self.path == '/api/mcp-status':
            real_online = check_port(3872)
            bridge_online = check_port(16384)
            bridge_data = {}
            if bridge_online:
                try:
                    req = urllib.request.urlopen("http://127.0.0.1:16384/api/status", timeout=0.8)
                    bridge_data = json.loads(req.read().decode('utf-8'))
                except Exception:
                    pass
            
            payload = {
                "real": {
                    "online": real_online,
                    "port": 3872,
                    "status": "Connected" if real_online else "Offline"
                },
                "bridge": {
                    "online": bridge_online,
                    "port": 16384,
                    "connected": bridge_data.get("connected", False),
                    "clientCount": bridge_data.get("clientCount", 0),
                    "clients": bridge_data.get("clients", [])
                }
            }
            self.send_response(200)
            self.send_header('Content-Type', 'application/json')
            self.send_header('Access-Control-Allow-Origin', '*')
            self.end_headers()
            self.wfile.write(json.dumps(payload).encode('utf-8'))
            return
        
        # Default static file handler
        super().do_GET()

if __name__ == '__main__':
    socketserver.TCPServer.allow_reuse_address = True
    with socketserver.TCPServer(("", PORT), DualBridgeHandler) as httpd:
        print(f"2K Knowledge Server listening at http://localhost:{PORT}")
        httpd.serve_forever()
