## Filtering a column based on conditions from other two column.

```bash
awk '$3== "WT" && $4 == 1 {print $1}' filename.tsv > newfile.txt
```

**Code Explanation**: The above code will print only those data from 1st column (`$1`) of **filename.tsv** file whose 3rd column contains **WT** (`$3 == "WT"`) and 4th column contain **1** (`$4 == 1`).

Then it will save the resulted file in **newfile.txt** file.

---------

## Replace a word with another word

```bash
sed 's/old_word/new_word/g' file
```

**Code Explanation:** Using the sed substitution(s) command, all(g) `old_word` will be repalced with with `new_word`.

---------

## Change the *field separator* in a file
### Method 1: awk solution

```bash
awk '$1=$1' FS="," OFS=":" filename
```
**Code Explanations:** `FS` and `OFS` are awk special variables which means **Input Field separator** and **Output field separator** respectively. `FS` is set to **comma** which is the input field separator, `OFS` is the output field separator which is **colon**. `$1=$1` actually does nothing. For awk, to change the delimiter, there should be some change in the data and hence this dummy assignment.


### Method 2: awk using gsub function
```bash
awk 'gsub(",",":")' filename
```
**Code Explanation:** `gsub` function in awk is for **global substitution**. Global, in the sense, to substitute all occurrences. awk provides one more function for substitution: `sub`. The difference between `sub` and `gsub` is `sub` replaces or substitutes only the first occurrence, whereas gsub substitutes all occurrences.

### Method 3:  tr solution
```bash
tr ',' ':' < filename
```
**Code Explanation:** `tr` can be used for mutliple things: ***to delete, squeeze or replace specific characters***. In this case, it is used to repalce the commas with colons.


---------


