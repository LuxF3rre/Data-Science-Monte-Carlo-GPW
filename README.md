# Prognozowanie ceny akcji i wartości indeksów za pomocą ruchów Browna i metody Monte Carlo
## Podstawa teoretyczna

Kompletny opis podstawy teoretycznej znajduję się [tutaj](https://ro.uow.edu.au/cgi/viewcontent.cgi?article=1705&context=aabfj).

### Ruchy Browna

Wzór na przyszłą cenę jest następujący:

![Wzór na ruch Browna](https://latex.codecogs.com/gif.latex?S_%7Bt+%5CDelta%20t%7D%20%3D%20S_t%20%5Cexp%5B%28%5Cmu%20-%20%5Cfrac%7B%5Csigma%5E2%7D%7B2%7D%29%5CDelta%20t+%5Csigma%20%5Cvarepsilon%20%5Csqrt%7B%5CDelta%20t%7D%5D)

Gdzie:

![](https://latex.codecogs.com/gif.latex?S_%7Bt%20+%20%5CDelta%20t%7D) - przyszła cena akcji

![](https://latex.codecogs.com/gif.latex?S_t) - obecna cena akcji

![](https://latex.codecogs.com/gif.latex?%5Cmu) - spodziewana stopa zwrotu akcji

![](https://latex.codecogs.com/gif.latex?%5Csigma) - spodziewana roczna zmienność akcji

![](https://latex.codecogs.com/gif.latex?%5Cvarepsilon) - zmienna losowa o rozkładzie normalnym ze średnią 0 i odchyleniu standardowym 1

![](https://latex.codecogs.com/gif.latex?%5CDelta%20t) - interwał prognozy w latach

### Obliczanie rocznej zmienności

![](https://latex.codecogs.com/gif.latex?%5Csigma%20%3D%20%5Cfrac%7Bs%7D%7B%5Csqrt%7B%5Ctau%7D%7D)

Gdzie:

![](https://latex.codecogs.com/gif.latex?%5Csigma) - spodziewana roczna zmienność akcji

![](https://latex.codecogs.com/gif.latex?s) - dzienne odchylenie standardowe ceny akcji

![](https://latex.codecogs.com/gif.latex?%5Ctau) - interwał mierzony w latach. Zakładamy, że w roku jest 250 dni z możliwością handlu akcjami, więc:

![](https://latex.codecogs.com/gif.latex?%5Ctau%20%3D%20%5Cfrac%7B1%7D%7B250%7D)

### Metoda Monte Carlo

## Założenia projektu

Produktem końcowym projektu ma być w pełni zautomatyzowany workflow (pobieranie notowań, prognoza, policzenie statystyk i narysowanie wykresów) w programie [KNIME](https://www.knime.com/) przeprowadzający prognozę cen i wartości indeksów za pomocą ruchów Browna i metody Monte Carlo.

Analiza, liczenie statystyk i tworzenie wykresu ma zostać przeprowadzone w języku skryptowym R, umożliwiającym dalszą rozbudowę workflow wedle potrzeb.

Dodatkowo pisząc algorytm do workflow, wszelkie możliwe jego części mają zostać udostępnione do wielokrotnego użytku w ramach projektu [Handy Scripts](https://github.com/LuxF3rre/Handy-Scripts). 

## Schemat workflow
![Schemat workflow](https://github.com/LuxF3rre/Data-Science-Monte-Carlo-GPW/blob/master/Schemat.svg)
## Zmienne modelu



## Przykładowy wynik analizy

![Projekcja ceny CD Projekt](https://github.com/LuxF3rre/Data-Science-Monte-Carlo-GPW/blob/master/CDPROJEKT.mst.png)