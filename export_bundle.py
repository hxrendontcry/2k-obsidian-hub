import os
import zipfile

OUTPUT_ZIP = "2K_Obsidian_Hub_Package.zip"
BASE_DIR = os.path.dirname(os.path.abspath(__file__))

FILES_TO_PACK = [
    "GEMINI.md",
    "3D_Knowledge_Graph.html",
    "server.py",
    "graph_data.json",
    "Install_For_Friend.bat",
    "README_FOR_FRIEND.txt"
]

DIRS_TO_PACK = [
    ".agents/skills/roblox-scripting",
    "wiki"
]

print(f"[*] Packaging bundle into {OUTPUT_ZIP}...")

with zipfile.ZipFile(os.path.join(BASE_DIR, OUTPUT_ZIP), 'w', zipfile.ZIP_DEFLATED) as zipf:
    # Files
    for filename in FILES_TO_PACK:
        filepath = os.path.join(BASE_DIR, filename)
        if os.path.exists(filepath):
            zipf.write(filepath, arcname=filename)
            print(f"  + Added file: {filename}")
        else:
            print(f"  ! File not found: {filename}")

    # Dirs
    for dirname in DIRS_TO_PACK:
        dirpath = os.path.join(BASE_DIR, dirname)
        if os.path.exists(dirpath):
            for root, _, files in os.walk(dirpath):
                for file in files:
                    full_p = os.path.join(root, file)
                    rel_p = os.path.relpath(full_p, BASE_DIR)
                    zipf.write(full_p, arcname=rel_p)
            print(f"  + Added directory: {dirname}")
        else:
            print(f"  ! Directory not found: {dirname}")

print(f"\n[OK] Package created successfully: {os.path.join(BASE_DIR, OUTPUT_ZIP)}")
print(f"Size: {round(os.path.getsize(os.path.join(BASE_DIR, OUTPUT_ZIP)) / 1024, 2)} KB")
