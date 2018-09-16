#
# To be used in KNIME node.
#
library(MonteCarlo)
library(moments)

rframe <- knime.in

interval_prediction_grid <- c(1) # in years
expected_annual_return_grid <- c(0.15)
number_of_last_data <- 365 # in days
number_of_simulations <- 100000
target_price <- tail(rframe$"<CLOSE>", n = 1)

stock_name <- tail(rframe$"<TICKER>", n = 1)

lastest_stock_price <- tail(rframe$"<CLOSE>", n = 1)

last_year_stock_prices <- tail(rframe$"<CLOSE>", n = number_of_last_data)
last_year_stock_daily_return <- diff(last_year_stock_prices) / last_year_stock_prices[-length(vector)]
last_year_stock_daily_return_sd <- sd(last_year_stock_daily_return)

expected_annual_volatility <- last_year_stock_daily_return_sd / sqrt(1 / number_of_last_data)

GBM <- function(expected_annual_return, interval_prediction) { 
  nradom <- rnorm(1, 0, 1)
  return (list("price"=lastest_stock_price * exp((expected_annual_return - 0.5 * expected_annual_volatility ^ 2) * interval_prediction + expected_annual_volatility * sqrt(interval_prediction) * nradom)))
}

param_list = list ("expected_annual_return" = expected_annual_return_grid, "interval_prediction" = interval_prediction_grid)

MC_result <- MonteCarlo(func=GBM, nrep=number_of_simulations, param_list=param_list)

forecasted_prices <- MC_result$results$price

findDominants <- function(x) {
  if (length(unique(table(x))) == 1) {
    return("No dominants")
  } else {
    return(as.numeric(names(table(x)[table(x) %in% unique(table(x))[which.max(unique(table(x)))]])))
  }
}

percent_below <- function(target_value, target_list) {
  sorted <- sort(target_list, decreasing = TRUE)
  i <- 1
  for (price in sorted) {
    if (price == target_value) {
      if (price != sorted[i + 1] & i != length(sorted)) {
        return (1 - (i / length(sorted)))
      } else {
        return (0)
      }
    } else if (price < target_value) {
        return (1 - ((i - 1) / length(sorted)))
    } else if (i == length(sorted)) {
      return (0)
    }
    i <- i + 1
  }
}

statisticsMonteCarlo <- function(population, target_price) {
  population_minumum <- min(population)
  population_maximum <- max(population)
  population_mean <- mean(population)
  population_median <- median(population)
  population_dominant <- findDominants(population)
  population_sd <- sd(population)
  population_skewness <- skewness(population)
  population_kurtosis <-kurtosis(population)
  population_1q <- quantile(population, .25)
  population_3q <- quantile(population, .75)
  population_5c <- quantile(population, .05)
  population_95c <- quantile(population, .95)
  population_percent_of_above_target <- 1 - percent_below(target_price, population)
  population_percent_of_below_target <- percent_below(target_price, population)
  population_mean_minus_2sd <- population_mean - 2 * population_sd
  population_mean_minus_1sd <- population_mean - 1 * population_sd
  population_mean_plus_1sd <- population_mean + 1 * population_sd
  population_mean_plus_2sd <- population_mean + 2 * population_sd
  
  return(data.frame(population_minumum, population_maximum, population_mean, population_median, population_dominant, population_sd, population_skewness, population_kurtosis, population_1q, population_3q, population_5c, population_95c, population_percent_of_above_target, population_percent_of_below_target, population_mean_minus_2sd, population_mean_minus_1sd, population_mean_plus_1sd, population_mean_plus_2sd, row.names = "Monte Carlo Statistics"))
}

statistics <- statisticsMonteCarlo(forecasted_prices, target_price)

hist(forecasted_prices,
     main=paste("Forecasted price of", stock_name),
     xlab="Price",
     breaks=20)