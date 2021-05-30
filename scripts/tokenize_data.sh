#! /bin/bash

scripts=`dirname "$0"`
base=$scripts/..

data=$base/data
#tools=$base/tools

src=it
trg=de
#mkdir -p $data

# tokenize italian training data
cat data/100k_train.de-it.it | tools/moses-scripts/scripts/tokenizer/tokenizer.perl -l it > data/100k_train.tokenized.de-it.it

# tokenize german training data
cat data/100k_train.de-it.de | tools/moses-scripts/scripts/tokenizer/tokenizer.perl -l de > data/100k_train.tokenized.de-it.de

# tokenize italian test data
cat data/test.de-it.it | tools/moses-scripts/scripts/tokenizer/tokenizer.perl -l it > data/test.tokenized.de-it.it

# tokenize german test data
cat data/test.de-it.de | tools/moses-scripts/scripts/tokenizer/tokenizer.perl -l de > data/test.tokenized.de-it.ide

# tokenize italian dev data
cat data/dev.de-it.it | tools/moses-scripts/scripts/tokenizer/tokenizer.perl -l it > data/dev.tokenized.de-it.it

# tokenize german dev data
cat data/dev.de-it.de | tools/moses-scripts/scripts/tokenizer/tokenizer.perl -l de > data/dev.tokenized.de-it.de


echo "All data tokenized"