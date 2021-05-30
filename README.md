# mt_fs21_ex5

This repo is just a collection of scripts showing how to install [JoeyNMT](https://github.com/joeynmt/joeynmt), download
data and train & evaluate models.

# Requirements

- This only works on a Unix-like system, with bash.
- Python 3 must be installed on your system, i.e. the command `python3` must be available
- Make sure virtualenv is installed on your system. To install, e.g.

    `pip install virtualenv`

# Steps
## Setup of the Virtual Environment

Clone this repository in the desired place:

    git clone https://github.com/renatehauser/mt_fs21_ex5

Create a new virtualenv that uses Python 3. Please make sure to run this command outside of any virtual Python environment:

    ./scripts/make_virtualenv.sh

**Important**: Then activate the env by executing the `source` command that is output by the shell script above.

Download and install required software:

    ./scripts/download_install_packages.sh

## Preparation of the Data
Download data:

    ./scripts/download_iwslt_2017_data.sh

Sub-sample 100k sentences for training:

    ./scripts/sub_sample_training_data.sh
    
Tokenize all data:

    ./scripts/tokenize_data.sh
    
## Apply BPE
Learn and apply BPE-models with vocab sizes 2000 and 5000 and build joint vocabs:

    ./scripts/learn_and_apply_bpe_models.sh
    
## Training
Either train all three models at once:

    ./scripts/train_all.sh
    
- One word-level model with vocab size 2000
- One BPE model with vocab size 2000
- One BPE model with vocav size 5000

Or alternatively, you can train only one model at a time:

    ./scripts/train_word_level.sh
    ./scripts/train_bpe2000.sh
    ./scripts/train_bpe5000.sh
    
The training process can be interrupted at any time, and the best checkpoint will always be saved.

## Evaluation
Either evaluate all three models at once:

    ./scripts/evaluate_all.sh
    
Or, alternatively, you can evaluate only one model at a time:

    ./scripts/evaluate_word_level.sh
    ./scripts/evaluate_bpe2000.sh
    ./scripts/evaluate_bpe5000.sh

# Findings
## BLEU-scores

|  | use BPE | vocabulary size | BLEU |
|---|--------|-----------------|------|
|(a)|no      | 2000            | 7.6  |
|(b)|yes     | 2000            | 10.9 |
|(c)|yes     | 5000            | 12.3 |

We can see here, that applying BPE indeed improves the translation results in terms of the BLEU-score. As expected, the
word_level model produces many \<unk\> tokens, which makes the translation quite unreadable.
What is noticeable, however, is that the BPE models tend to repeat parts more than it seems to be the case for the word_level
model.

An example for this is sentence 6:

word_level: "Ich dachte, es wäre eine interessante Idee, und ich habe es in einem Labor auf dem \<unk\>."

bpe2000: "Also dachte ich, es wäre eine interessante Idee, und ich habe es in einem Labor in einem Labor." 

While the word_level model produces \<unk\> tokens, the bpe-models sometimes produce interesting misspellings of words. One good example
for this is the word "Marshmallow", which occurs in many different variants. The bpe2000 model produces "Marshallow"/"Smarshmallow"/"Marshmalloh"/"Shmallow" etc.,
while the bpe5000 model produces "Smarhallow"/"Smarshmallow"etc. The bpe5000 manages to spell the word correctly more often than
the bpe2000 model. Also worth mentioning is how the two bpe-models handle the case "Ta-Da". The bpe2000 model produces 'Ta-Terraus' and
'"Ta-Ta-Ta-Ta-Welthmalloh"', the bpe5000 model produces 'Ta-T-T-Ta-T-T-T-' and '"T-oh"', where the second one, interestingly,
is a combination of "Ta-Da" and "Uh-oh". From these examples we can nicely see, how sub-word units are combined to form words.
In these cases, however, not very successfully.

The BLEU-score for the bpe5000 model is 1.4 points higher. But when going through the translations manually, I couldn't really
tell that the translations of the bpe5000 model were significantly better. In fact, both models produce quite confused sentences,
which often repeat themselves and are ungrammatical.