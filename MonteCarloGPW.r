library(MonteCarlo)

rframe <- knime.in

lastest_stock_price <- tail(rframe$"<CLOSE>", n=1)
return_std_deviation <- sd(rframe$"<CLOSE>")

Black_Scholes <- function(risk_free_intrest_rate, forecast_time) { 
  nradom <- rnorm(1, 0, 1)
  return(list("price"=lastest_stock_price * exp((risk_free_intrest_rate - 0.5 * return_std_deviation ^ 2) * forecast_time + return_std_deviation * sqrt(forecast_time) * nradom)))
}

GBM <- function(risk_free_intrest_rate, forecast_time) {
    nradom <- rnorm(1, 0, 1)
    eturn(list("price"=lastest_stock_price + lastest_stock_price * (risk_free_intrest_rate * forecast_time + return_std_deviation * nradom * sqrt(forecast_time))))
}

risk_free_intrest_rate_grid <- c(0.024)
forecast_time_grid <- c(2555)

param_list = list ("risk_free_intrest_rate" = risk_free_intrest_rate_grid, "forecast_time" = forecast_time_grid)

MC_result <- MonteCarlo(func=Black_Scholes, nrep=1000, param_list=param_list)

MakeTable(output=MC_result, rows="risk_free_intrest_rate", cols="forecast_time", digits=2, include_meta=FALSE)