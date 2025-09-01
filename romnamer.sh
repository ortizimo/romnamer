#!/bin/bash
# author: ortizimo
# date: 20250720-1249
# update: 20250831-1549
# version: 1.1
# desc: very basic script to remove unwanted words from rom filenames
# why: because there is no FileBot program to do this for roms

# instructions: 
#	1. Make a list of all the words you want to remove
#	2. Place this script in home/ 
#	3. Edit the path below to the roms you need to fix (i.e. nano romnamer)
#	4. Save the changes and exit
#	5. Give it execute rights (i.e. chmod +x romnamer)
#	6. Run it

clear

echo ""
echo "██████╗  ██████╗ ███╗   ███╗███╗   ██╗ █████╗ ███╗   ███╗███████╗██████╗ "
echo "██╔══██╗██╔═══██╗████╗ ████║████╗  ██║██╔══██╗████╗ ████║██╔════╝██╔══██╗"
echo "██████╔╝██║   ██║██╔████╔██║██╔██╗ ██║███████║██╔████╔██║█████╗  ██████╔╝"
echo "██╔══██╗██║   ██║██║╚██╔╝██║██║╚██╗██║██╔══██║██║╚██╔╝██║██╔══╝  ██╔══██╗"
echo "██║  ██║╚██████╔╝██║ ╚═╝ ██║██║ ╚████║██║  ██║██║ ╚═╝ ██║███████╗██║  ██║"
echo "╚═╝  ╚═╝ ╚═════╝ ╚═╝     ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝"
echo "                                                                     v1.1"

# Define the directory where your files are located
# IMPORTANT: Replace path below with the actual directory you need
DIRECTORY="retrodeck/roms/wii/wiiware"

# Prompt the user to enter the words to remove
# The words should be separated by spaces
read -p "Enter the words to remove separated by a space (e.g., old uGLY T3mp): " WORDS_TO_REMOVE

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

# A simple Bash script to ask the user to continue or exit.

while true; do
    # Read user input with a prompt. The -p option displays a prompt.
    read -p "Do you want to generate a gamelist (Yy) or Exit (Nn)? (y/n) " yn

    # Use a case statement to handle different user responses.
    case $yn in
        [yY]* ) # If the user enters 'y' or 'Y', continue.
            echo "Continuing..."

# ************************************************************
# author: ortizimo
# date: 20250720-1530
# udpate: 20250831-2030
# desc: script to generate a gamelist in XML format

echo ""
echo "██╗     ██╗███████╗████████╗ ██████╗ ███████╗███╗   ██╗"
echo "██║     ██║██╔════╝╚══██╔══╝██╔════╝ ██╔════╝████╗  ██║"
echo "██║     ██║███████╗   ██║   ██║  ███╗█████╗  ██╔██╗ ██║"
echo "██║     ██║╚════██║   ██║   ██║   ██║██╔══╝  ██║╚██╗██║"
echo "███████╗██║███████║   ██║   ╚██████╔╝███████╗██║ ╚████║"
echo "╚══════╝╚═╝╚══════╝   ╚═╝    ╚═════╝ ╚══════╝╚═╝  ╚═══╝"
echo "                                                   v1.1"

# Define the output XML file name
OUTPUT_XML="gamelist.xml"

# Prompt the user for the root directory to scan and store the input in ROOT_DIR
echo "Generating a gamelist from ('$DIRECTORY')...Please wait!"

# Validate if the entered path is a valid directory
if [[ ! -d "$DIRECTORY" ]]; then
    echo "Error: The provided path '$DIRECTORY' is not a valid directory or does not exist."
    exit 1
fi

# Start the XML document with the root element
echo '<?xml version="1.0" encoding="UTF-8"?>' > "$OUTPUT_XML"
echo '<FolderContents>' >> "$OUTPUT_XML"

# Loop through all files recursively using 'find' in the user-specified directory
find "$DIRECTORY" -type f | while read -r filepath; do

    # Extract filename from the path
    filename=$(basename "$filepath")

    # Write file information to the XML file, including path and name
    echo "  <File>" >> "$OUTPUT_XML"
    echo "    <Path>$filepath</Path>" >> "$OUTPUT_XML"
    echo "    <Name>$filename</Name>" >> "$OUTPUT_XML"
    echo "  </File>" >> "$OUTPUT_XML"
done

# Close the root element
echo '</FolderContents>' >> "$OUTPUT_XML"

echo "XML file '$OUTPUT_XML' generated successfully in the root of HOME/."

#***************************************************************

            exit 0 # Exit the script with a successful status code.
            ;;
        [nN]* ) # If the user enters 'n' or 'N', exit.
            echo "Exiting..."
            exit 0
            ;;
        * ) # If the user enters anything else, ask again.
            echo "Invalid response. Please answer 'y' or 'n'."
            ;;
    esac
done

