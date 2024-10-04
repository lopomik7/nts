```markdown
# Using Gilles Castel's LaTeX Note-Taking Scripts

This guide explains how I use Gilles Castel's (RIP) LaTeX note-taking scripts. For this setup, I am using the `st` terminal with `zsh`, and I assume you're working with an XDG-base directory structure. Follow the steps below to set everything up. My main source of information is [Gilles Castel's website](https://www.castel.dev).

## 1. Instant Reference

### Install Dependencies

Make sure the following packages are installed:
- `xclip`
- `exiftool`
- `xdotool`
- `x11-utils`
- `zenity`
- `xsel`
- `npm`

### Clone the Repository

```bash
git clone https://github.com/gillescastel/instant-reference
cd instant-reference
npm install
```

### Update Your `.zprofile`

Add the following to your `.zprofile` (or `.profile` if you're using a different shell):

```bash
# Instant reference
export PATH="$PATH:$(find ~/Documents/note-taking-scripts/instant-reference/ -type d | paste -sd ':' -)"
```

### Create a Desktop Entry

Create a file called `~/.local/share/applications/phd.desktop` with the following content:

```ini
[Desktop Entry]
Name=Phd helper
Exec=phd-protocol-handler.js %u
Icon=emacs-icon
Type=Application
Terminal=false
MimeType=x-scheme-handler/phd;
```

Then run:

```bash
sudo update-desktop-database
xdg-mime default phd.desktop x-scheme-handler/phd
```

This will enable you to add PDF links to your LaTeX documents. For more details, refer to the [Instant Reference GitHub repository](https://github.com/gillescastel/instant-reference).

## 2. Inkscape Figures

### Install Dependencies

You will need:
- `python` (version >= 3.7)
- `pipx`
- `rofi`
- [Inkscape](https://inkscape.org)

### Install Inkscape Figures

```bash
pipx install inkscape-figures
```

### Update Your Vim/Neovim Config

Add the following mappings to your Vim/Neovim config for creating and editing figures:

```vim
inoremap <C-f> <Esc>:silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"'<CR><CR>:w<CR>
nnoremap <C-f> :silent exec '!inkscape-figures edit "'.b:vimtex.root.'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>
```

This allows you to press `Ctrl-f` to create or edit figures directly from Inkscape. For more information, visit the [Inkscape Figures GitHub page](https://github.com/gillescastel/inkscape-figures).

## 3. Inkscape Shortcut Manager

### Install Dependencies

Ensure the following are installed:
- `xlib`
- `pdflatex`
- `pdf2scg`
- `xclip`
- `sxhkd`
- `xournal`

For more information, refer to the [Inkscape Shortcut Manager GitHub page](https://github.com/gillescastel/inkscape-shortcut-manager).

### Clone and Configure Repositories

1. Clone this repo containing:
   - `inkscape-figures`
   - `inkscape-shortcut-manager`
   - `sxhkd`
   - `.xournal`
   - `note-taking-scripts`

2. Move inkscape-figures, inkscape-shortcut-manager and sxhkd to your `~/.config` directory and customize them as needed. Move the .xournal to your home directory.
There is also a minimal Vim config for editing in math mode within Inkscape, which you should also adjust to suit your needs.

The most important part of the Vim config is the snippet engine and a port of Gilles' snippets for LaTeX.

### Workflow

- Place the `note-taking-scripts` directory in `~/Documents`.
- Add the scripts inside `latex-inkscape-helper` to your `$PATH` to make them callable from the terminal or, in my case, via `dmenu`.
- Rename scripts as needed. I mainly use the `Run script` option to run Gilles' scripts and `sxhkd`. To stop it, use the `kill-latex-inkscape` script.
- The contextchanger.sh is just a helper script to change context.

The keybinds for `sxhkd` are inside `phd/scripts`.

## 4. Organizing Courses and Lectures

Once everything is set up:
- Copy the `templatecontext` directory and rename it. As an example, I renamed it to `wildmath`.
- To switch contexts, press `Ctrl + Alt + s` (as defined in `phd/scripts`) and select your context (e.g., `wildmath`).
- To add courses, copy `templatecourse`, rename it, and update `info.yaml`.
- To switch courses, use `Ctrl + Alt + 2`. To add new lectures, press `Ctrl + Alt + l`, then `Ctrl + n`.


## 5. Example
I used Norman J. Wildberger's lectures https://www.youtube.com/watch?v=dyCRPT6iFBg&list=PL5A714C94D40392AB&index=153 to test it out.
I also don't know any maths so it's kinda bad but my goal was to write maths in latex in real time.

---

This is also really good for taking notes using the preamble for the notes directory, so not just maths. For additional resources and further customization, refer to [Gilles Castel's website](https://www.castel.dev) and the GitHub repositories linked throughout this guide.
```
