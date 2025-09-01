# romnamer v1.1 (Bulk ROM Renamer) + listgen v1.1 (gamelist generator)

WHAT IS IT?
Basically my own BASH script to help you delete words in ROM filenames that stop you from scrapping for cover art, videos, etc. Great to correct ROMS for emulation environments like retrodeck or emudeck. I've combined both of my scripts to be a bit more efficient. I have to do some additional tweaking later on but this will work great!

INSTRUCTIONS:
1. Download the BASH script and drop it in your Linux machine.
2. Give it executable rights (sudo chmod +x romnamer.sh).
3. Add ROMS to the machine or use Shared Folders and run the command to the path.
4. Run it: './romnamer.sh'
5. Enter the exact words you want to remove from all your roms (E.g., PROPER, REPACK, WiiWare).
6. Generate a clean gamelist.xml file at the end. You can also use Genpal from Retropie if you want to.

Note: If you want it to be a global command to be run from any directory, give it executable rights, then move the file to /usr/local/bin directory.
