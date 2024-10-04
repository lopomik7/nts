#!/bin/sh

# Directory where contexts (directories) are located
context_dir="$HOME/Documents/note-taking-scripts" # Updated to the full path

# Files to update
shortcut_file="$HOME/Documents/note-taking-scripts/phd/scripts/shortcut.sh"
config_file="$HOME/Documents/note-taking-scripts/university-setup/scripts/config.py"

# Function to list existing contexts
list_contexts() {
    # List all directories in the context directory
    find "$context_dir" -mindepth 1 -maxdepth 1 -type d -printf '%f\n' | rofi -dmenu -p "Select a context:" -kb-custom-1 "Ctrl+0"
}

# Function to add a new context
add_context() {
    # Prompt the user to enter the name of the new context
    new_context=$(echo "" | rofi -dmenu -p "Enter new context name:")

    # Check if the input is not empty
    if [ -n "$new_context" ]; then
        mkdir -p "$context_dir/$new_context"
        echo "Context '$new_context' created."
    else
        echo "No context name provided."
    fi
}

# Function to update files with the new context
update_files() {
    selected_context="$1"

    # Update the shortcut.sh file
    sed -i "s|DOCS_DIR=\"\$HOME/Documents/note-taking-scripts/.*\"|DOCS_DIR=\"\$HOME/Documents/note-taking-scripts/$selected_context\"|" "$shortcut_file"
    sed -i "s|CURRENT_COURSE_DIR=\"\$HOME/Documents/note-taking-scripts/.*\"|CURRENT_COURSE_DIR=\"\$HOME/Documents/note-taking-scripts/$selected_context/current_course\"|" "$shortcut_file"

    # Update the config.py file
    sed -i "s|CURRENT_COURSE_SYMLINK = Path('/home/user/Documents/note-taking-scripts/.*/current_course').expanduser()|CURRENT_COURSE_SYMLINK = Path('/home/user/Documents/note-taking-scripts/$selected_context/current_course').expanduser()|" "$config_file"
    sed -i "s|ROOT = Path('/home/user/Documents/note-taking-scripts/.*').expanduser()|ROOT = Path('/home/user/Documents/note-taking-scripts/$selected_context').expanduser()|" "$config_file"

    echo "Files updated with context: $selected_context"
}

# Main script logic
selected_context=$(list_contexts)

# Check if the user pressed Ctrl+0 to add a new context
if [ "$?" -eq "10" ]; then
    add_context
    # Re-list contexts after adding a new one
    selected_context=$(list_contexts)
elif [ -n "$selected_context" ]; then
    echo "You selected context: $selected_context"
    update_files "$selected_context"
else
    echo "No context selected."
fi
