## Filtering a column based on conditions from other two column.

```bash
awk '$3== "WT" && $4 == 1 {print $1}' filename.tsv > newfile.txt
```

**Code Explanation**: The above code will print only those data from 1st column (`$1`) of **filename.tsv** file whose 3rd column contains **WT** (`$3 == "WT"`) and 4th column contain **1** (`$4 == 1`).

Then it will save the resulted file in **newfile.txt** file.
