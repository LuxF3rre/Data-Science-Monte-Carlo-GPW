#
# To be used in KNIME node.
#
library(MonteCarlo)

interval_prediction_grid <- c(1) # in years
expected_annual_return_grid <- c(0.15)
numer_of_last_data <- 365 # in days

rframe <- knime.in

stock_name <- tail(rframe$"<TICKER>", n = 1)

lastest_stock_price <- tail(rframe$"<CLOSE>", n = 1)

last_year_stock_prices <- tail(rframe$"<CLOSE>", n = numer_of_last_data)
last_year_stock_daily_return <- diff(last_year_stock_prices) / last_year_stock_prices[-length(vector)]
last_year_stock_daily_return_sd <- sd(last_year_stock_daily_return)

expected_annual_volatility <- last_year_stock_daily_return_sd / sqrt(1 / numer_of_last_data)

GBM <- function(expected_annual_return, interval_prediction) { 
  nradom <- rnorm(1, 0, 1)
  return(list("price"=lastest_stock_price * exp((expected_annual_return - 0.5 * expected_annual_volatility ^ 2) * interval_prediction + expected_annual_volatility * sqrt(interval_prediction) * nradom)))
}

param_list = list ("expected_annual_return" = expected_annual_return_grid, "interval_prediction" = interval_prediction_grid)

MC_result <- MonteCarlo(func=GBM, nrep=1000, param_list=param_list)

forecasted_prices <- MC_result$results$price

hist(forecasted_prices,
  main="Histogram for forecasted prices",
  xlab="Prices",
  prob = TRUE)

lines(density(forecasted_prices))