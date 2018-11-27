# Prognozowanie ceny akcji i wartości indeksów za pomocą ruchów Browna i metody Monte Carlo
## Podstawa teoretyczna

Kompletny opis podstawy teoretycznej znajduję się [tutaj](https://ro.uow.edu.au/cgi/viewcontent.cgi?article=1705&context=aabfj).

### Ruchy Browna

Wzór na przyszłą cenę jest następujący:
$$
S_{t+\Delta t} = S_t \exp[(\mu - \frac{\sigma^2}{2})\Delta t+\sigma \varepsilon \sqrt{\Delta t}]
$$
Gdzie:

$S_{t + \Delta t}$ - przyszła cena akcji

S_t - obecna cena akcji

\mu - spodziewana stopa zwrotu

\sigma - spodziewana roczna zmienność

$\varepsilon$ - zmienna losowa o rozkładzie normalnym ze średnią 0 i odchyleniu standardowym 1

\Delta t - interwał prognozy w latach

### Obliczanie rocznej zmienności

$$
\sigma = \frac{s}{\sqrt{\tau}}
$$

Gdzie:

$\sigma$ - spodziewana roczna zmienność

$s$ - dzienne odchylenie standardowe

$\tau$ - interwał mierzony w latach

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