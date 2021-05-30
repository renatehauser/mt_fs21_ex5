import matplotlib.pyplot as plt
import numpy as np

bleu_scores = [11.5, 12.3, 12.3, 12.1, 12.2, 12.0, 11.8, 11.9, 11.8, 11.7]
beamsizes = [1, 3, 5, 7, 9, 11, 13, 15, 17, 19]


def main():
    plt.plot(beamsizes, bleu_scores)
    plt.ylabel('BLEU')
    plt.xlabel('BEAMSIZES')
    plt.axis([0, 20, 11, 13])
    plt.xticks(np.arange(min(beamsizes), max(beamsizes) + 1, 2.0))
    plt.savefig('beamsizes.png')


if __name__=='__main__':
    main()




