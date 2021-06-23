# Install
Krona can be easily installed from `conda` by follwoing command
```shell
conda install -c bioconda krona -y
```
## Update Taxonomy Database
Before using krona for the first time the taxnomoy database is needed to be updated.

Run the following command.

NB: Internet connection should be better.

```shell
ktUpdateTaxonomy.sh
```

If you use this databse many days later, then you should update the database using above command.
