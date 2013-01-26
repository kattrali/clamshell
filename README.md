# ClamShell

Tidy Documentation Viewer


## What is it?

ClamShell is a fast and flexible documentation viewer. It can be used as a standalone window or as a popover above other running applications.

![ClamShell Window](https://github.com/kattrali/clamshell/raw/master/Documentation/ClamShell.png)


## Usage

- Download a [Documentation Set](http://code.google.com/p/dash-docsets/downloads/list) on a topic that interests you.

- Open `ClamShell.app` or run `open clamshell://searchText=text` to launch ClamShell as a standalone window. 

- Select a Documentation Set to be used as the search index from the menu using `File > Select Documentation Set...`.

- Use the search bar to find useful documentation or launch ClamShell as a popover as detailed below:


## Integration Usage

To launch ClamShell as a popover, call `open clamshell://searchText=text` and append `&x=500&y=600` where `x` and `y` are the origin coordinates for the popover arrow, relative to the bottom left corner of the screen.

![ClamShell Window](https://github.com/kattrali/clamshell/raw/master/Documentation/ClamShell%20Popover.png)

Example usage for ClamShell, integrated into Redcar Editor.
