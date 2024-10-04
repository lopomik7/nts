#!/bin/sh

# Define variables
LAST_LATEX_DIRS="/tmp/.last_latex_directories"
TERMINAL="st"
EDITOR="nvim"
INKSCAPE="inkscape"
INKSCAPE_FIGURES_CMD="inkscape-figures watch"
SHORTCUT_MANAGER_SCRIPT="$HOME/Documents/note-taking-scripts/inkscape-shortcut-manager/main.py"
SXHKD="sxhkd"

# Function to start sxhkd, inkscape-figures, and the shortcut manager
run_useful_programs() {
    # Start sxhkd
    if command -v $SXHKD > /dev/null; then
        $SXHKD &
        echo "sxhkd started."
    else
        echo "sxhkd command not found."
    fi

    # Start inkscape-figures
    if command -v inkscape-figures > /dev/null; then
        $INKSCAPE_FIGURES_CMD &
        echo "inkscape-figures started."
    else
        echo "inkscape-figures command not found."
    fi

    # Start inkscape-shortcut-manager
    if [ -f "$SHORTCUT_MANAGER_SCRIPT" ]; then
        python3 "$SHORTCUT_MANAGER_SCRIPT" &
        echo "inkscape-shortcut-manager started."
    else
        echo "inkscape-shortcut-manager script not found."
    fi
}

# Function to handle directory creation and setup
setup_directory() {
    dir_name=$(dmenu -p "Enter directory name:")
    tex_file_name=$(dmenu -p "Enter .tex file name (without extension):")

    full_dir_path="$HOME/$dir_name"
    mkdir -p "$full_dir_path/figures"
    touch "$full_dir_path/$tex_file_name.tex"

    echo "$full_dir_path/$tex_file_name.tex" >> "$LAST_LATEX_DIRS"

    $TERMINAL -e $EDITOR "$full_dir_path/$tex_file_name.tex" &
}

# Function to handle opening a file
open_file() {
    chosen_dir=$1
    file_to_open=$2

    case "$file_to_open" in
        *.tex) $TERMINAL -e $EDITOR "$chosen_dir/$file_to_open" & ;;
        *.svg) $INKSCAPE "$chosen_dir/$file_to_open" & ;;
        *) echo "Unsupported file type" ;;
    esac
}

# Function to create a new LaTeX directory
make_new_directory() {
    setup_directory
    run_useful_programs
}

# Function to open an existing LaTeX directory
open_existing_directory() {
    chosen_dir=$(dmenu -p "Enter existing LaTeX directory:")
    full_chosen_dir="$HOME/$chosen_dir"

    if [ -d "$full_chosen_dir" ]; then
        file_to_open=$(ls "$full_chosen_dir" | dmenu -p "Choose a file to open:")
        open_file "$full_chosen_dir" "$file_to_open"
        run_useful_programs
        echo "$full_chosen_dir" >> "$LAST_LATEX_DIRS"
    else
        echo "Directory does not exist."
    fi
}

# Function to open the last used LaTeX directory
open_last_used_directory() {
    if [ -f "$LAST_LATEX_DIRS" ]; then
        last_dir=$(tail -n 1 "$LAST_LATEX_DIRS")

        if [ -d "$last_dir" ]; then
            file_to_open=$(ls "$last_dir" | dmenu -p "Choose a file to open:")
            open_file "$last_dir" "$file_to_open"
            run_useful_programs
        else
            echo "Last used directory does not exist."
        fi
    else
        echo "No previous LaTeX directory found."
    fi
}

# Prompt the user for action selection
action=$(printf "Run scripts\nMake new LaTeX directory\nOpen existing LaTeX directory\nOpen last used LaTeX directory" | dmenu -p "Choose an option:")
echo "Selected action: $action"

# Perform actions based on user choice
case "$action" in
    "Run scripts")
        run_useful_programs
        ;;
    "Make new LaTeX directory")
        make_new_directory
        ;;
    "Open existing LaTeX directory")
        open_existing_directory
        ;;
    "Open last used LaTeX directory")
        open_last_used_directory
        ;;
    *)
        echo "Invalid choice"
        ;;
esac
