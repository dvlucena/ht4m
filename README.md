# Hyperspectral Toolbox for Matlab (HT4M)

O propósito desse Toolbox é prover um conjunto de algoritmos para análise e classificação de Imagem Hiperespectral (HSI).  Essa é uma iniciativa do Grupo de Pesquisa em Computação Ciêntifica da Pontifícia Universidade Católica de Goiás (PUC-GO).
A primeira versão deste Toolbox (v 0.1) possui as seguinte organização:

| Diretório | Descrição |
| ------ | ------ |
| functions | Contém os arquivos .m referente a cada uma das funções do Toolbox. A medida que novas funções forem implementadas, sugere-se categorizar as funções em subdiretórios conforme sua finalidade.  |
| data | Contém as matrizes de exemplo para experimentar os algoritmos. |
| app | Contém um arquivo _hsiAnalisys.m_ referente a um pequeno aplicativo para explorar uma HSI. |

## Funções

As funções disponíveis nesta implementadas até agora são:
- **getCluster**: 
- **hsi2matrix**
- **hsiGetImageLayer**
- **hsiGetLayer**
- **hsiNormalize**
- **hsiRemoveBackground**
- **hsiShowLayer**
- **hsiShowSpectrum**
- **matrix2hsi**
- **showClusterOnImage**

## Dados

## App



## Instalação

Para utilizar o Toolbox, basta clicar no botão verde "Clone or Download" no canto superior direito dessa página e descompactar o arquivo em qualquer diretório em seu computador. Para executar os algoritmos é necessário ter o software Matlab instalado. Recomenda-se a versão R2014a a ou posterior.

## Como executar o conteúdo de exemplo

```sh
>> hsiAnalisys(CUBE);
>>
```

## Como contribuir com o projeto
O primeiro passo é familiarizar com o sistema de versionamento de código. Para quem não possui conhecimento sobre controle de versão usando Git, recomento o seguinte curso disponível no YouTube: [Curso básico de Git e GitHub](https://www.youtube.com/watch?v=f60coDuMX4s&list=PL_J0pcBTAsJ4dtHza_UvebrK1yNX7HNx0).

O segundo passo é entrar em contato comigo por meio do grupo LAMV.


