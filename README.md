# romnamer v1.2 (Bulk ROM Renamer) + listgen v1.1 (gamelist generator) Combined!

WHAT IS IT?
My own BASH script to help delete unwanted words in ROM filenames. Some unwanted words stops the scrapping of cover art, videos, etc. Great to correct ROMS for emulation environments like retrodeck or emudeck. I have to do some additional tweaking later on but this will work for now!

INSTRUCTIONS:
1. Download the BASH script and drop it in your Linux home directory
2. Give it executable rights (sudo chmod +x romnamer.sh).
    - If using a VM, then use the 'SHARED FOLDER' option to the folder where the ROMS are located
4. Make a list of all the words to remove (E.g., PROPER, REPACK, iNJECT)
5. Run the script (e.g., ./romnamer) and follow the instructions
    - If using from a VM, use the following command (sudo ./romnamer /media/<sf_ROMS>)
    - Change the path to your specific <ROMS> folder
    - Or if you have enough space in your Linux system, add the roms to it, then add the script and run is from the same location
6. Generate a clean gamelist.xml file at the end (optional)
    - You can also use Genpal from Retropie if you want to generate a gamelist.xml file

Note: You can also run the script from a Linux VM out to a Windows folder via the Shared Folders.
