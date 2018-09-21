#
# To be used in KNIME node.
#

library(moments)

rframe <- knime.in
stock_prices <- rframe$"<CLOSE>"

interval_prediction <- 1 # in years
expected_annual_return <- 0.15 #in percent
number_of_last_data <- 365 # in days
number_of_simulations <- 100000
target_price <- tail(stock_prices, n = 1)

stock_name <- rframe$"<TICKER>"[[1]]
lastest_stock_price <- tail(stock_prices, n = 1)

args = list ("lastest_stock_price" = lastest_stock_price, "expected_annual_return" = expected_annual_return, "interval_prediction" = interval_prediction)

expectedAnnualVolatility <- function(stock_prices, number_of_last_data) {
    stock_prices <- tail(stock_prices, n = number_of_last_data)
    stock_daily_return <- diff(stock_prices) / stock_prices[1:length(stock_prices)-1]
    stock_daily_return_sd <- sd(stock_daily_return)
    return(stock_daily_return_sd / sqrt(1 / number_of_last_data))
}

geometricBrownianMotionStockPrice <- function(lastest_stock_price, expected_annual_return, expected_annual_volatility, interval_prediction) { 
  nradom <- rnorm(1, 0, 1)
  return(lastest_stock_price * exp((expected_annual_return - 0.5 * expected_annual_volatility ^ 2) * interval_prediction + expected_annual_volatility * sqrt(interval_prediction) * nradom))
}

simpleMonteCarlo <- function(function, args, number_of_simulations) {
    simulations <- replicate(number_of_simulations, {
        do.call(function, args)
    })
    return(simulations)
}

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
  return(data.frame("Minimum" = population_minumum, "Maximum" = population_maximum, "Mean" = population_mean, "Median" = population_median, "Dominant" = population_dominant, "Standard deviation" = population_sd, "Skewness" = population_skewness, "Kurtosis" = population_kurtosis, "1Q" = population_1q, "3Q" = population_3q, "5C" = population_5c, "95C" = population_95c, "Percent above targer" = population_percent_of_above_target, "Percent below target" = population_percent_of_below_target, "Mean - 2sd" = population_mean_minus_2sd, "Mean - 1sd" = population_mean_minus_1sd, "Mean + 1sd" = population_mean_plus_1sd, "Mean + 2sd" = population_mean_plus_2sd, row.names = stock_name))
}

expected_annual_volatility <- expectedAnnualVolatility(stock_prices, number_of_last_data)

forecasted_prices <- simpleMonteCarlo(geometricBrownianMotionStockPrice, args, number_of_simulations)

statistics <- statisticsMonteCarlo(forecasted_prices, target_price)

#
# To be used in KNIME node.
#

hist(forecasted_prices,
     main=paste("Forecasted price of", stock_name),
     xlab="Price",
     breaks=20)