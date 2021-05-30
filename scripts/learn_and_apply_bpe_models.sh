#! /bin/bash

scripts=`dirname "$0"`
base=$scripts/..

data=$base/data

tools=$base/tools

vocabs=$base/vocabs
mkdir -p $vocabs

bpe_models=$base/bpe_models
mkdir -p $bpe_models
#shared_models=$base/shared_models

# learn BPE model with vocab size 2000
subword-nmt learn-joint-bpe-and-vocab \
-i $data/100k_train.tokenized.de-it.it $data/100k_train.tokenized.de-it.de \
--write-vocabulary $vocabs/2000_it_vocab $vocabs/2000_de_vocab \
-s 2000 --total-symbols -o $bpe_models/2000_bpe

# apply BPE model with vocab size 2000 onto source (it) training set
subword-nmt apply-bpe -c $bpe_models/2000_bpe \
--vocabulary $vocabs/2000_it_vocab \
--vocabulary-threshold 10 \
< $data/100k_train.tokenized.de-it.it > $data/100k_train.bpe2000.de-it.it

# apply BPE model with vocab size 2000 onto target (de) training set
subword-nmt apply-bpe -c $bpe_models/2000_bpe \
--vocabulary $vocabs/2000_de_vocab \
--vocabulary-threshold 10 \
< $data/100k_train.tokenized.de-it.de > $data/100k_train.bpe2000.de-it.de

# apply BPE model with vocab size 2000 onto target (de) test set
subword-nmt apply-bpe -c $bpe_models/2000_bpe \
--vocabulary $vocabs/2000_de_vocab \
--vocabulary-threshold 10 \
< $data/test.tokenized.de-it.de > $data/test.bpe2000.de-it.de

# apply BPE model with vocab size 2000 onto source (it) test set
subword-nmt apply-bpe -c $bpe_models/2000_bpe \
--vocabulary $vocabs/2000_it_vocab \
--vocabulary-threshold 10 \
< $data/test.tokenized.de-it.it > $data/test.bpe2000.de-it.it

# apply BPE model with vocab size 2000 onto target (de) dev set
subword-nmt apply-bpe -c $bpe_models/2000_bpe \
--vocabulary $vocabs/2000_de_vocab \
--vocabulary-threshold 10 \
< $data/dev.tokenized.de-it.de > $data/dev.bpe2000.de-it.de

# apply BPE model with vocab size 2000 onto source (it) dev set
subword-nmt apply-bpe -c $bpe_models/2000_bpe \
--vocabulary $vocabs/2000_it_vocab \
--vocabulary-threshold 10 \
< $data/dev.tokenized.de-it.it > $data/dev.bpe2000.de-it.it


# build joint 2000_vocab
python $tools/joeynmt/scripts/build_vocab.py \
$data/100k_train.bpe2000.de-it.it $data/100k_train.bpe2000.de-it.de \
--output_path $vocabs/2000_de_it_vocab

################################################################################################3

# learn BPE model with vocab size 5000
subword-nmt learn-joint-bpe-and-vocab \
-i $data/100k_train.tokenized.de-it.it $data/100k_train.tokenized.de-it.de \
--write-vocabulary $vocabs/5000_it_vocab $vocabs/5000_de_vocab \
-s 5000 --total-symbols -o $bpe_models/5000_bpe

# apply BPE model with vocab size 5000 onto source (it) training set
subword-nmt apply-bpe -c $bpe_models/5000_bpe \
--vocabulary $vocabs/5000_it_vocab \
--vocabulary-threshold 10 \
< $data/100k_train.tokenized.de-it.it > $data/100k_train.bpe5000.de-it.it

# apply BPE model with vocab size 2000 onto target (de) training set
subword-nmt apply-bpe -c $bpe_models/5000_bpe \
--vocabulary $vocabs/5000_de_vocab \
--vocabulary-threshold 10 \
< $data/100k_train.tokenized.de-it.de > $data/100k_train.bpe5000.de-it.de

# apply BPE model with vocab size 2000 onto target (de) test set
subword-nmt apply-bpe -c $bpe_models/5000_bpe \
--vocabulary $vocabs/5000_de_vocab \
--vocabulary-threshold 10 \
< $data/test.tokenized.de-it.de > $data/test.bpe5000.de-it.de

# apply BPE model with vocab size 2000 onto source (it) test set
subword-nmt apply-bpe -c $bpe_models/5000_bpe \
--vocabulary $vocabs/5000_it_vocab \
--vocabulary-threshold 10 \
< $data/test.tokenized.de-it.it > $data/test.bpe5000.de-it.it

# apply BPE model with vocab size 5000 onto target (de) dev set
subword-nmt apply-bpe -c $bpe_models/5000_bpe \
--vocabulary $vocabs/5000_de_vocab \
--vocabulary-threshold 10 \
< $data/dev.tokenized.de-it.de > $data/dev.bpe5000.de-it.de

# apply BPE model with vocab size 5000 onto source (it) dev set
subword-nmt apply-bpe -c $bpe_models/5000_bpe \
--vocabulary $vocabs/5000_it_vocab \
--vocabulary-threshold 10 \
< $data/dev.tokenized.de-it.it > $data/dev.bpe5000.de-it.it

# build joint 5000_vocab
python $tools/joeynmt/scripts/build_vocab.py \
$data/100k_train.bpe5000.de-it.it $data/100k_train.bpe5000.de-it.de \
--output_path $vocabs/5000_de_it_vocab