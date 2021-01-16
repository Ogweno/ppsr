
<!-- README.md is generated from README.Rmd. Please edit that file -->

<!-- badges: start -->

[![R-CMD-check](https://github.com/paulvanderlaken/ppsr/workflows/R-CMD-check/badge.svg)](https://github.com/paulvanderlaken/ppsr/actions)
<!-- badges: end -->

# `ppsr` - Predictive Power Score

`ppsr` is the R implementation of [8080labs Predictive Power
Score](https://github.com/8080labs/ppscore).

The Predictive Power Score is an asymmetric, data-type-agnostic score
that can detect linear or non-linear relationships between two columns.
The score ranges from 0 (no predictive power) to 1 (perfect predictive
power). It can be used as an alternative to the correlation (matrix).

Read more about the (dis)advantages of the Predictive Power Score in
[this blog
post](https://towardsdatascience.com/rip-correlation-introducing-the-predictive-power-score-3d90808b9598).

## Installation

You can install the development version of `ppsr` using the following R
code:

``` r
# You can get the development version from GitHub:
# install.packages('devtools')
devtools::install_github('https://github.com/paulvanderlaken/ppsr')
```

## Computing PPS

You can think of the predictive power score as a framework for a family
of scores. There is not one single best way to calculate a predictive
power score. In fact, there are many possible ways to calculate a PPS
that satisfy the definition mentioned before.

Currently, the `ppsr` package calculates PPS by default:

  - Using the default decision tree implementation of the `rpart`
    package, wrapped by `parsnip`
  - Using 5 cross-validations
  - Using F1 scores to evaluate classification models. Scores are
    normalized relatively to a naive benchmark consisting of predicting
    the modal or random `y` classes
  - Using MAE to evaluate regression models. Scores are normalized using
    relatively to a naive benchmark of predicting the mean `y` value

## Usage

The `ppsr` package has three main functions that compute PPS:

  - `score()` - which computes an x-y PPS
  - `score_predictors()` - which computes X-y PPS
  - `score_matrix()` - which computes X-Y PPS

where `x` and `y` represent an individual feature/target, and `X` and
`Y` represent all features/targets in a given dataset.

Examples:

``` r
ppsr::score(x = iris$Sepal.Length, y = iris$Sepal.Width)
#> [1] 0.06790301
```

``` r
ppsr::score_predictors(df = iris, y = 'Species')
#> $Sepal.Length
#> [1] 0.5591864
#> 
#> $Sepal.Width
#> [1] 0.3134401
#> 
#> $Petal.Length
#> [1] 0.916758
#> 
#> $Petal.Width
#> [1] 0.9398532
#> 
#> $Species
#> [1] 1
```

``` r
ppsr::score_matrix(df = iris)
#>              Sepal.Length Sepal.Width Petal.Length Petal.Width   Species
#> Sepal.Length   1.00000000  0.04632352    0.5491398   0.4127668 0.4075487
#> Sepal.Width    0.06790301  1.00000000    0.2376991   0.2174659 0.2012876
#> Petal.Length   0.61608360  0.24263851    1.0000000   0.7917512 0.7904907
#> Petal.Width    0.48735314  0.20124105    0.7437845   1.0000000 0.7561113
#> Species        0.55918638  0.31344008    0.9167580   0.9398532 1.0000000
```

## Visualizing PPS

Subsequently, there are two main functions that wrap around these
computational functions to help you visualize your PPS using `ggplot2`:

  - `visualize_predictors()` - producing a barplot of all X-y PPS
  - `visualize_matrix()` - producing a heatmap of all X-Y PPS

Examples:

``` r
ppsr::visualize_predictors(df = iris, y = 'Species')
```

![](man/README/PPS-barplot-1.png)<!-- -->

``` r
ppsr::visualize_matrix(df = iris)
```

![](man/README/PPS-heatmap-1.png)<!-- -->

## Open issues & development

PPS is a relatively young concept, and likewise the `ppsr` package is
still under development. If you spot any bugs or potential improvements,
please raise an issue or submit a pull request.

On the developmental agenda are currently:

  - Implementation of different modeling techniques / algorithms
  - Implementation of different model evaluation metrics
  - Implementation of downsampling for large datasets

Note that there’s also an unfinished [R implementation of the PPS
package by 8080labs](https://github.com/8080labs/ppscoreR).
