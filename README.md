# romnamer v1.1 (Bulk ROM Renamer) + listgen v1.1 (gamelist generator)

WHAT IS IT?
My own BASH script to help delete unwanted words in ROM filenames. Some unwanted words stops the scrapping of cover art, videos, etc. Great to correct ROMS for emulation environments like retrodeck or emudeck. I've combined both of my scripts to be a bit more efficient. I have to do some additional tweaking later on but this will work for now!

INSTRUCTIONS:
1. Download the BASH script and drop it in your Linux home directory.
2. Give it executable rights (sudo chmod +x romnamer.sh).
3. Add the directory path in the script to point to where the ROMS are
4. Make a list of all the unwanted words you want to remove
5. Enter the exact words you want to remove from all your roms (E.g., PROPER, REPACK, iNJECT).
6. Generate a clean gamelist.xml file at the end. You can also use Genpal from Retropie if you want to.

You can also run the script to a Windows folder via the Shared Folders if using a Linux VM.
