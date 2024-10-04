#!/bin/sh

# Define variables for easy modification
ROOT="$(dirname "$(realpath "$0")")"
KEY="$1"
TERMINAL="st"
EDITOR="nvim"
NODE="/usr/bin/node"
PHD_DIR="$HOME/Documents/note-taking-scripts/phd"
DOCS_DIR="$HOME/Documents/note-taking-scripts/wildmath"
SCRIPTS_DIR="$PHD_DIR/scripts"
NOTES_DIR="$DOCS_DIR/notes"
CURRENT_DATE="$(date +"%F")"
INSTANT_REF_DIR="$HOME/Documents/note-taking-scripts/instant-reference"
UNI_SETUP_DIR="$HOME/Documents/note-taking-scripts/university-setup/scripts"
CURRENT_COURSE_DIR="$HOME/Documents/note-taking-scripts/wildmath/current_course"

open_xournal() {
    cd "$NOTES_DIR/$CURRENT_DATE" || exit 1
    if [ -f "note.xoj" ]; then
        xournal note.xoj
    else
        cp "$SCRIPTS_DIR/template.xoj" note.xoj
        xournal note.xoj
    fi
}

# Create the daily notes directory if it doesn't exist
mkdir -p "$NOTES_DIR/$CURRENT_DATE"

# Use a case statement to handle different keys
case "$KEY" in
    p)
        cd "$PHD_DIR/papers" || exit 1
        PDF_FILE="$(ls . | rofi -theme "$HOME/.config/rofi/themes/Monokai.rasi" -i -dmenu)"
        [ -z "$PDF_FILE" ] && exit 0
        if [ -f "$PDF_FILE" ]; then
            zathura "$(realpath "$PDF_FILE")"
        else
            sensible-browser "https://google.com/search?q=$PDF_FILE"
        fi
        ;;
    r)
        "$TERMINAL" lfub "$NOTES_DIR/$CURRENT_DATE"
        ;;
    n)
        "$TERMINAL" "$EDITOR" "$NOTES_DIR/$CURRENT_DATE/note.tex"
        ;;
    1)
        "$TERMINAL" "$EDITOR" "$NOTES_DIR/master.tex"
        ;;
    x)
        open_xournal
        ;;
    f)
        "$NODE" "$INSTANT_REF_DIR/copy-reference.js"
        ;;
    2)
        python "$UNI_SETUP_DIR/rofi-courses.py"
        ;;
    c)
        zathura "$CURRENT_COURSE_DIR/master.pdf"
        ;;
    t)
        "$TERMINAL" lfub "$CURRENT_COURSE_DIR"
        ;;
    3)
        "$TERMINAL" -e zsh -c "cd $CURRENT_COURSE_DIR; exec zsh"
        ;;
    m)
        "$TERMINAL" "$EDITOR" "$CURRENT_COURSE_DIR/master.tex"
        ;;
    v)
        python "$UNI_SETUP_DIR/rofi-lectures-view.py"
        ;;
    l)
        python "$UNI_SETUP_DIR/rofi-lectures.py"
        ;;
    4)
        inkscape-figures edit "$CURRENT_COURSE_DIR/figures"
        ;;
    7)
        python "$UNI_SETUP_DIR/init-all-courses.py"
        ;;
    *)
        echo "Invalid option"
        exit 1
        ;;
esac
