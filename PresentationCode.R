
library(ggplot2)
library(tidyverse)
library(dplyr)
library(lubridate)
library(patchwork)
UN_ExRates <- UN_ExRates |>
  rename(Country = ...2)

EU_over_time=
  UN_ExRates|>
  filter(`National currency` == "Euro (EUR)", Country == "Euro Area", Series == "Exchange rates: end of period (national currency per US dollar)")|>
  ggplot(aes(x = `Year`, y = Value))+
  geom_line()+
  theme_bw()+
  labs(x = "Year", y = "Exchange Rate (USD per EUR)")+
  ggtitle("USD/Eur Exchange Rate by Year")

EU_over_time

comparison_col=
  UN_ExRates|>
  filter(Country %in% c("Euro Area", "Canada", "Australia", "United Kingdom", "Switzerland"), Series == "Exchange rates: end of period (national currency per US dollar)", Year == "2022")|>
  ggplot(aes(x = Country, y = Value, fill = Country))+
  geom_col()+
  labs(x = "Country", y = "Exchange Rate (USD per Currency)")+
  ggtitle("Exchange Rate by Year")

comparison_line=
  UN_ExRates|>
  filter(Country %in% c("Euro Area", "Canada", "Australia", "United Kingdom", "Switzerland"), Series == "Exchange rates: end of period (national currency per US dollar)")|>
  ggplot(aes(x = Year, y = Value, color = Country))+
  geom_line()+
  labs(x = "Country", y = "Exchange Rate (USD per Currency)")+
  ggtitle("Exchange Rate by Year")+
  scale_x_continuous(
    limits = c(2005, 2022)
  )+
  theme_bw()
  
comp_final=comparison_line+comparison_col

comp_final
