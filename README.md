# man
Something I created for personal use, decided I could upload it here.

Adds a `man` command which displays manual pages in a new, read-only tab without leaving Micro.
- Opens the man page in a new tab
- Buffer is read-only
## Installation
This plugin is installed by cloning the repository into Micro’s plugin directory.
1. Create the plugin directory if it doesn’t exist:
    ```
    mkdir -p ~/.config/micro/plug
    ```
2. Change into the plugin directory:
    ```
    cd ~/.config/micro/plug
    ```
3. Clone the repository:
    ```
    git clone https://github.com/Lnk016/microman
    ```
4. Open Micro and enable the plugin:
    ```
    set microman on
    ```
*Note: The Micro configuration directory is usually located at `~/.config/micro`, but this can vary depending on your system and configuration. If your setup uses a different config directory, clone the plugin into the `plug` subdirectory of that location instead.*
## Usage
Inside Micro, run `man <page>` and it'll open that man page in a new tab. 
## Requirements

- Micro >= 2.0.0
- Unix system with `man`, `sh`, and `col`
