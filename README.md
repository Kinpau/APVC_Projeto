# Aprendizagem Profunda para Visão por Computador 

### Tempo para entrega do 1º Desafio:

![Countdown Timer](https://i.countdownmail.com/415jet.gif)

Realizado por Grupo 7:

- Diogo Freitas
- João Francisco Botas
- Miguel Gonçalves
- Ricardo Galvão

### Recomendações de execução:

Para manter as dependências isoladas, é recomendado criar um ambiente virtual na pasta raiz do projeto após dar clone.

#### 🖥️ Criar o ambiente virtual:

Execute o seguinte comando no terminal na raiz do projeto (algo do género -> **./APVC-Desafio1**):  

```bash
python -m venv venv
```

Esta pasta criada está no ficheiro `.gitignore` e portanto não será alterada (pull/push).

#### 🚀 Ativar o ambiente virtual:

- Em Windows:
  ```bash
  venv\Scripts\Activate
  ```
- Em Mac/Linux:
  ```bash
  source venv/bin/activate
  ```
#### 📚 Importar as bibliotecas:

Após ativar o ambiente virtual, deve-se utilizar o seguinte comando para instalar todas as bibliotecas e versões listadas no `requirements.txt`:  

```bash
pip install -r requirements.txt
```

# APVC - Desafio 1: Classificação de Imagens com Redes Neuronais  

Este projeto implementa redes neuronais para a classificação de imagens de roupas, calçados e malas utilizando o _dataset_ **FASHION_MNIST**. O objetivo é desenvolver e avaliar modelos de aprendizagem profunda para classificação multiclasse e binária.  

## 📌 Descrição  

O trabalho é dividido em três partes:  

1. **Classificação Multiclasse**:  
   - Implementação de uma rede neuronal para classificar imagens em 10 categorias de peças de roupa distintas;  
   - Utilização de validação, escolha de função de perda e otimização, treinamento do modelo e análise dos resultados; 
   - Avaliação por meio de métricas de accuracy, curvas de aprendizado e matriz de confusão.  

2. **Classificação Binária**:  
   - Adaptação do dataset para classificar imagens em duas categorias: **Vestuário (1)** e **Calçado/Malas (0)**;
   - Implementação de uma nova rede neuronal para essa tarefa.  

3. **Análise Comparativa**:  
   - Comparação entre utilizar uma rede multiclasse e depois binarizar as predições ou treinar diretamente uma rede binária.  

## 🔧 Tecnologias Utilizadas  

- **Python**  
- **TensorFlow/Keras**  
- **Numpy, Matplotlib, Seaborn** (para análise e visualização)  

## 📂 Estrutura do Repositório  