# imports mais comuns que poderão ser necessários
import tensorflow as tf
import keras
from keras import layers

import numpy as np
import matplotlib.pyplot as plt
from sklearn.metrics import ConfusionMatrixDisplay
from sklearn.metrics import confusion_matrix

# constantes - dimensão das imagens
IMG_HEIGHT = 28
IMG_WIDTH = 28

# constantes - labels/classes
LABELS = ["Vestuário",
          "Calçado/Malas"]
N_CLASSES = 2

print("IMG_HEIGHT: " + str(IMG_HEIGHT))
print("IMG_WIDTH: " + str(IMG_WIDTH))
print("N_CLASSES: " + str(N_CLASSES) + "\n")

# callbacks
BEST_MODEL_CHECKPOINT = keras.callbacks.ModelCheckpoint(
    filepath="tmp/best_model.weights.h5",      # ficheiro para os pesos do "melhor modelo"
    save_weights_only=True,
    monitor='val_loss',
    mode='min',
    save_best_only=True)

EARLY_STOPPING = keras.callbacks.EarlyStopping(
    monitor='val_loss',
    patience=5)

# carregar o dataset FASHION_MNIST
dataset = keras.datasets.fashion_mnist
(x_train, y_train), (x_test, y_test) = dataset.load_data()

# normalização
x_train = x_train / 255.0
x_test = x_test / 255.0

print("Número de amostras no training set original: " + str(x_train.shape[0]))
print("Número de amostras no test set original: " + str(x_test.shape[0]))
print("Não esquecer que se pretende também gerar um validation set!")


'''
| CLASSE_10 | PEÇA         || NOVA_CLASSE
| 0         | T-shirt/top  || 1
| 1         | Trouser      || 1
| 2         | Pullover     || 1
| 3         | Dress        || 1
| 4         | Coat         || 1
| 5         | Sandal       || 0
| 6         | Shirt        || 1
| 7         | Sneaker      || 0
| 8         | Bag          || 0
| 9         | Ankle boot   || 0


1- Vestuário
0- Calçado/Malas
'''


BINARY_MAP = {
    0: 1, 1: 1, 2: 1, 3: 1, 4: 1, 6: 1,  # Vestuário -> 1
    5: 0, 7: 0, 8: 0, 9: 0   # Calçado/Malas -> 0
}

y_train = np.vectorize(BINARY_MAP.get)(y_train)
y_test = np.vectorize(BINARY_MAP.get)(y_test)

y_train = keras.utils.to_categorical(y_train,N_CLASSES)
y_test = keras.utils.to_categorical(y_test,N_CLASSES)
