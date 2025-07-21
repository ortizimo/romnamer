#!/bin/bash
# author: ortizimo
# date: 20250720-1249
# desc: very basic script to remove unwanted words from rom files
# why: because there is no FileBot program to do this for roms

echo ""
echo "██████╗  ██████╗ ███╗   ███╗███╗   ██╗ █████╗ ███╗   ███╗███████╗██████╗ "
echo "██╔══██╗██╔═══██╗████╗ ████║████╗  ██║██╔══██╗████╗ ████║██╔════╝██╔══██╗"
echo "██████╔╝██║   ██║██╔████╔██║██╔██╗ ██║███████║██╔████╔██║█████╗  ██████╔╝"
echo "██╔══██╗██║   ██║██║╚██╔╝██║██║╚██╗██║██╔══██║██║╚██╔╝██║██╔══╝  ██╔══██╗"
echo "██║  ██║╚██████╔╝██║ ╚═╝ ██║██║ ╚████║██║  ██║██║ ╚═╝ ██║███████╗██║  ██║"
echo "╚═╝  ╚═╝ ╚═════╝ ╚═╝     ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝"
echo "                                                                     v1.0"

# Define the directory where your files are located
# IMPORTANT: Replace "roms/" with the actual directory path if it's different
DIRECTORY="roms/"

# Prompt the user to enter the words to remove
# The words should be separated by spaces
read -p "Enter words to remove (space-separated, e.g., 'old ugly temp'): " WORDS_TO_REMOVE

# Loop through each file in the specified directory
for file in "$DIRECTORY"/*; do

    # Skip directories, process only regular files
    [[ -f "$file" ]] || continue

    # Extract the base filename (without the directory path)
    filename=$(basename "$file")

    # Extract the original file extension (if any)
    extension=""
    if [[ "$filename" == *.* ]]; then
        extension=".${filename##*.}" # Stores the extension like ".txt", ".mp3", etc.
        # Now remove the extension from the filename for processing
        new_filename_base="${filename%.*}" # This is the filename without its original extension
    else
        new_filename_base="$filename" # No extension, so the whole filename is the base
    fi

    # Initialize the working filename
    new_filename="$new_filename_base"

    # Remove the specified words from the filename
    # Each word is replaced by a single space to maintain separation
    for word in $WORDS_TO_REMOVE; do
        new_filename="${new_filename//$word/ }" # This is Bash parameter expansion for string replacement
    done

    # Replace periods between words with spaces
    # Example: "my.file.name" becomes "my file name"
    new_filename="${new_filename//./ }"

    # Clean up the filename:
    # 1. Replace multiple spaces with a single space
    # 2. Remove leading/trailing spaces
    new_filename=$(echo "$new_filename" | sed 's/  */ /g' | sed 's/^ *//;s/ *$//')

    # Remove any trailing space just before adding the extension back
    new_filename=$(echo "$new_filename" | sed 's/ *$//')

    # Reconstruct the new filename with the original extension
    final_new_filename="${new_filename}${extension}"

    # Check if the new filename is the same as the original filename
    # If they are the same, skip renaming to avoid unnecessary operations.
    if [[ "$filename" == "$final_new_filename" ]]; then
        echo "Skipping '$filename': no changes detected after processing."
        continue
    fi

    # Check if the cleaned filename (without extension) is simply "wad" (case-insensitive)
    # This prevents renaming to "wad.original_extension" if the base filename is "wad".
    # We do this check AFTER cleaning, but BEFORE adding the extension back.
    if [[ "$(echo "$new_filename" | tr '[:upper:]' '[:lower:]')" == "wad" ]]; then
        echo "Skipping file '$filename' to prevent renaming base name to 'wad'."
        continue # Skip to the next file in the loop
    fi

    # Perform the renaming operation
    # Use 'mv -v' for verbose output to see the changes...remove -v for less on screen verbose
    mv -v "$file" "$DIRECTORY/$final_new_filename"

done

echo "You can now generate an XML gamelist using Genpal (RetroPie), or the other script I made named listgen"
echo ""
echo "File renaming process complete!"

