import subprocess

def open_editor(filename):
    # Define the command to open st as a scratchpad with nvim
    cmd = [
        'st',
        '-n', 'spterm', # Give the window a name to match dwm's scratchpad configuration
        '-g', '100x7', # Specify the geometry
        '-e', 'nvim',
        '-u', '~/.config/inkscape-shortcut-manager/minimal_nvim_latex/init.vim',
        filename,
    ]

    # Run the command
    subprocess.run(cmd)

def latex_document(latex):
    return r"""
        \documentclass[12pt,border=12pt]{standalone}

        \usepackage[utf8]{inputenc}
        \usepackage[T1]{fontenc}
        \usepackage{textcomp}
        \usepackage{amsmath, amssymb}
        \newcommand{\R}{\mathbb R}
        \usepackage{cmbright}

        \begin{document}
    """ + latex + r"\end{document}"

config = {
    'rofi_theme': '~/.config/rofi/themes/purple.rasi',
    'font': 'Iosevka Term',
    'font_size': 10,
    'open_editor': open_editor,
    'latex_document': latex_document
}
