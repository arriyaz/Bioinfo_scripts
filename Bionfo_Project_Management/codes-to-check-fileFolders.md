## Check file counts in subfolders
This bash script will generate a count of the number of files in each subfolder.
```bash
#!/bin/bash

find . -maxdepth 1 -type d | while read -r dir; do printf "%s:\t" "$dir"; find "$dir" -type f | wc -l; done > fc.txt &  
```

## Check file/folder sizes
File sizes for all files and folders in your project folder can be determined with this command:
```bash
du -hs * > fileSizes.txt
```
## Check file list
find . > files.txt
