## Extract url from a file and download data by *while loop**

```bash
while read ID
do
	grep ${ID} urlfile.txt | \
	cut -f7 | xargs wget -P WT_data/	
done < wt_ids.txt
```
-----------
## To make the texts editable in svg file from svglit() R function
First run the follwoing code on the desired svg file, then open the file in **Inkscape**. Then you will find the all text can be edited.

```bash
sed -i "s/ textLength='[^']*'//" file.svg
```
--------------
