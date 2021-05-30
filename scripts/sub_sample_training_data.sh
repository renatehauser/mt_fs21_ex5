#! /bin/bash

scripts=`dirname "$0"`
base=$scripts/..

data=$base/data
#shared_models=$base/shared_models

# paste files together, shuffle and subsample
paste -d'|' $data/train.de-it.de $data/train.de-it.it | cat -n | shuf -n 100000 | sort -n | cut -f2 > $data/pasted_train.de-it

# split up en and it again
cut -d'|' -f1 $data/pasted_train.de-it > $data/100k_train.de-it.de
cut -d'|' -f2 $data/pasted_train.de-it > $data/100k_train.de-it.it


echo "Find your sub-sampled files 100k_train.de-it.de and 100k_train.de-it.it in your ./data folder"
