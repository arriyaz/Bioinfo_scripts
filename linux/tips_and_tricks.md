## Extract url from a file and download data by *while loop**

```bash
while read ID
do
	grep ${ID} urlfile.txt | \
	cut -f7 | xargs wget -P WT_data/	
done < wt_ids.txt
```
