cat copied_data/raw_data/train.de.shuf | perl moses_scripts/normalize-punctuation.perl -l de | perl moses_scripts/tokenizer.perl -l de -a -q > copied_data/preprocessed_data/train.de.p

cat copied_data/raw_data/train.en.shuf | perl moses_scripts/normalize-punctuation.perl -l en | perl moses_scripts/tokenizer.perl -l en -a -q > copied_data/preprocessed_data/train.en.p

perl moses_scripts/train-truecaser.perl --model copied_data/preprocessed_data/tm.de --corpus copied_data/preprocessed_data/train.de.p

perl moses_scripts/train-truecaser.perl --model copied_data/preprocessed_data/tm.en --corpus copied_data/preprocessed_data/train.en.p

cat copied_data/preprocessed_data/train.de.p | perl moses_scripts/truecase.perl --model copied_data/preprocessed_data/tm.de > copied_data/preprocessed_data/train.de 

cat copied_data/preprocessed_data/train.en.p | perl moses_scripts/truecase.perl --model copied_data/preprocessed_data/tm.en > copied_data/preprocessed_data/train.en

cat copied_data/raw_data/valid.de | perl moses_scripts/normalize-punctuation.perl -l de | perl moses_scripts/tokenizer.perl -l de -a -q | perl moses_scripts/truecase.perl --model copied_data/preprocessed_data/tm.de > copied_data/preprocessed_data/valid.de

cat copied_data/raw_data/valid.en | perl moses_scripts/normalize-punctuation.perl -l en | perl moses_scripts/tokenizer.perl -l en -a -q | perl moses_scripts/truecase.perl --model copied_data/preprocessed_data/tm.en > copied_data/preprocessed_data/valid.en

cat copied_data/raw_data/test.de | perl moses_scripts/normalize-punctuation.perl -l de | perl moses_scripts/tokenizer.perl -l de -a -q | perl moses_scripts/truecase.perl --model copied_data/preprocessed_data/tm.de > copied_data/preprocessed_data/test.de

cat copied_data/raw_data/test.en | perl moses_scripts/normalize-punctuation.perl -l en | perl moses_scripts/tokenizer.perl -l en -a -q | perl moses_scripts/truecase.perl --model copied_data/preprocessed_data/tm.en > copied_data/preprocessed_data/test.en

cat copied_data/raw_data/tiny_train.de | perl moses_scripts/normalize-punctuation.perl -l de | perl moses_scripts/tokenizer.perl -l de -a -q | perl moses_scripts/truecase.perl --model copied_data/preprocessed_data/tm.de > copied_data/preprocessed_data/tiny_train.de

cat copied_data/raw_data/tiny_train.en | perl moses_scripts/normalize-punctuation.perl -l en | perl moses_scripts/tokenizer.perl -l en -a -q | perl moses_scripts/truecase.perl --model copied_data/preprocessed_data/tm.en > copied_data/preprocessed_data/tiny_train.en


rm copied_data/preprocessed_data/train.de.p
rm copied_data/preprocessed_data/train.en.p

python preprocess.py --target-lang en --source-lang de --dest-dir copied_data/prepared_data/ --train-prefix copied_data/preprocessed_data/train --valid-prefix copied_data/preprocessed_data/valid --test-prefix copied_data/preprocessed_data/test --tiny-train-prefix copied_data/preprocessed_data/tiny_train --threshold-src 1 --threshold-tgt 1 --num-words-src 4000 --num-words-tgt 4000
