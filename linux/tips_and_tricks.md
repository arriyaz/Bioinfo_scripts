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


