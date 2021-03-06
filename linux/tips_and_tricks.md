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
## Grep all the line that start with a particular word
Let's say you want to extract all the lines which start with word SRR:
`grep ^SRR FileName`
**Code Explanation:**  
Here, the `^` sign denotes the begining of lines.

## Cut the 2nd to last column of a file
`cut -f 2- FILENAE`

**Code Explanation:**  
Here, the `2-` means column 2 to last column. Ovbiously, you can use other number also.

=======
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

## Check the file sizes to see if they are all present and of reasonable size
```bash
ls -lha | awk '{print $5, $NF}'
```
**Code Explanation:**
In **awk** the `NF` basically means how many number of fields/columns present in the data.  
But here, in the above code, `$NF` denotes the last column, because the number of filed is the number of last column.

## Check if the system cotains a certain command
Let's say you want to check whether your system contains **cowsay** command.
**NB: We can include this code in your bash script.**
```bash
if ! command -v cowsay &> /dev/null
then
    echo "	Command 'cowsay' could not be found"
    echo "	You can install it by using following commamd: "
    echo 
    echo "	sudo apt install cowsay"
    echo
	
    exit
fi
```
## Check if a directory contains files then delete it.
If directory contains previous **txt** files following code will remove them.

```bash
if [ -n "$(ls -A DirName/ 2> /dev/null)" ]
then
  echo "SMILES directory cotains previous files."
  echo "Removing them........"
  sleep 1s
  rm -rf DirName/*.txt
fi
```

## Repeat a string or number for *n* times
### By `for loop`
```bash
for i in {1..5}
do
echo "Hello World"
done
```
Or, in one line,
```bash
for i in {1..3}; do echo "Hi";done
```
### By `seq` and `awk`
```bash
seq 5 | awk '{print "Hello World"}'
```

### By `seq` and `sed`
```bash
seq 5 | sed "c Hello World"
```

## Generating list of names with sequential number
Sometime while we creating a dataset, metadata etc we may need to generate a list of names as like following example:
```
BD-01
BD-02
BD-03
BD-04
BD-05
```
Using `seq` command we can achive this output easily.
```bash
seq -f 'BD-%02g' 5
```
To learn more about this command, go to this link [seq command in Linux with Examples](https://www.geeksforgeeks.org/seq-command-in-linux-with-examples/)

## Combine two column from two file (side by side)
Let's say we have two files.  
One contains sample names (in *names.txt* file) as follows:
```
sample-01
sample-02
sample-03
sample-04
sample-05
```
Another contains DNA barcode ( in *dan.txt* file) as follows:
```
CATCCCTCTAGG
CCTTAGATAACC
GGATACAGTGAC
TTTGATAGGTTT
GTGGGGTACAGC
```
Now we want to combine both files to get a **csv** file as follows:
```
sample-01,CATCCCTCTAGG
sample-02,CCTTAGATAACC
sample-03,GGATACAGTGAC
sample-04,TTTGATAGGTTT
sample-05,GTGGGGTACAGC
```
To get this result we can use `paste` command:
```
paste -d ',' names.txt dna.txt
```
To learn more about `paste` command go to this link: [Paste command in Linux with examples](https://www.geeksforgeeks.org/paste-command-in-linux-with-examples/)


