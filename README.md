# romnamer

WHAT IS IT?
Basically my own BASH script to help you delete words in ROM filenames that stop you from scrapping for cover art, videos, etc. Great to correct ROMS for emulation environments like retrodeck or emudeck.

INSTRUCTIONS:
1. Download the BASH script and drop it in your Linux machine.
2. Give it executable rights (sudo chmod +x romnamer.sh).
3. Add ROMS to the machine or use Shared Folders and run the command to the path.
4. Run it: './romnamer.sh'
5. Enter the exact words you want to remove from all your roms (E.g., PROPER, REPACK, WiiWare).
6. Use listgen.sh to generate a clean gamelist.xml file. You can also use Genpal from Retropie.

Note: If you want it to be a global command to be run from any directory, give it executable rights, then move the file to /usr/local/bin directory.
