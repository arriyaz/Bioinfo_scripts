## Extract url from a file and download data by *while loop**

```bash
while read ID
do
	grep ${ID} urlfile.txt | \
	cut -f7 | xargs wget -P WT_data/	
done < wt_ids.txt
```
-----------
## To make the texts editable in svg file from svglite() R function
First run the follwoing code on the desired svg file, then open the file in **Inkscape**. Then you will find the all text can be edited.

```bash
sed -i "s/ textLength='[^']*'//" file.svg
```
--------------

## To set Ctrl+` as the shortcut to toggle between editor and terminal in VSCode
Open the keybindings.json from the editor: CMD-SHIFT-P -> Preferences: Open Keyboard Shortcuts File and add these entries:
```bash
// Toggle between terminal and editor focus
{ "key": "ctrl+`", "command": "workbench.action.terminal.focus"},
{ "key": "ctrl+`", "command": "workbench.action.focusActiveEditorGroup", "when": "terminalFocus"}
```

## To search a word in man page of a command
When the man page is active type `/` and then type your search word.

## Remove directory names from a file PATH
Let's say I've a file in the following path:
`home/user/Documents/temp/myfilename.txt`  
Now I want to remove directory part from this path and only keep the `myfilename.txt` part. I can do this by following code,
```bash
basename home/user/Documents/temp/myfilename.txt
```
If I want to remove extension part (`.txt`) and get only `myfilename` then following code will do that,
```bash
basename home/user/Documents/temp/myfilename.txt
```
## Setting up Shortcut key to open terminal in the current directory
- Create a script named as **Terminal** and save it in the following PATH.
- Then make it executable
```bash
echo "#! /bin/sh
gnome-terminal" > ~/.local/share/nautilus/scripts/Terminal

chmod +x ~/.local/share/nautilus/scripts/Terminal
```
- Then set the shortcut key (here, **F12**) as like below:
```bash
echo "F12 Terminal" > ~/.config/nautilus/scripts-accels
```
**Then close File Manager Windows and Reopen them.** Now press **F12** and the terminal should open in current directory.  
If shortcut key doesn't work **restart your computer**. Then upon pressing **F12** button you will find that the terminal will open in the current active directory.

