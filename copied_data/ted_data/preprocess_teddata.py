import argparse
import collections
import logging
import os
import sys
import re
import pickle


def main():

    train_DE = open("../raw_data/train.de", "a", encoding="utf-8")
    train_EN = open("../raw_data/train.en", "a", encoding="utf-8")

    num_of_sentences = 0
    with open("TED2013.de-en.de", encoding="utf-8") as ted_DE, open("TED2013.de-en.en", encoding="utf-8") as ted_EN:

        for line1, line2 in zip(ted_DE, ted_EN):
            if num_of_sentences == 5000:
                break
            elif len(line1) > 10 and len(line1) < 100:

                # autoencoding
                train_DE.write(line2)
                train_EN.write(line2)

                # back translation 
                train_DE.write(line1)
                train_EN.write(line2)

                num_of_sentences += 1

            else:
                continue

    train_EN.close()
    train_DE.close()

if __name__ == '__main__':
    main()
