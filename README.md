## Project Overview

An interactive R Shiny application exploring portfolio contruction using Modern Portfolio Theory.
The project uses financial market data from LSEG to analyse the relationship between portfolio risk and return across three different portfolios.
The application allows potential investors to explore individual investments, portfolio performance and differnet portfolio optimisation approaches.

## Key Findings

• The three portfolios display different levels of risk and historical performance.
• The analysis of weekly return distributons highlights differences in the variability and distribution of returns between individual investments.
• The portfolio optimisation analysis indentifies differences in how individual assets contribute to portfolio risk under different optimisation approaches.

## Data

Financial market data was obtained from LSEG.

The data is used to investigate:
• Moving averages
• Retrun distributions
• Portfolio risk and return
• Portfolio diversification
• Weekly return distributions
• Historical investment performance

## Methodology

The project follows this workflow:

Raw data, Cleaning, Analysis, Visualisation

# 1. Data

Financial market data was obtained from LSEG and imported into R for analysis.

# 2. Cleaning

The data sets were prepared for analysis and the relevent variables were selected and transformed to allow returns and moving averages.

# 3. Analysis

The analysis includes:
• Moving averages
• Retrun distributions
• Portfolio risk and return
• Portfolio diversification
• Weekly return distributions
•  Minimum-risk portfolio analysis
•  Maximum-diversification portfolio analysis

# 4. Visualisation

The results are presented through an interactive Shiny application.

## Shiny Application

# Methodology

Provides an overview of the analytical approach and modern portfolio theory.

# Moving Averages

The market sentiment is depicted from the average price, which is represented by the black line.

The 200 day moving average is preferred when analysing the individual portfolios. This is because it represents a more long term trend.
Therefore I decide if the company is structurally strong over time.

If the 50 day moving average line is above the 200 day moving average line, I suggest an investor to buy. Example: Microsoft.
Moreover, if the 50 day day moving average line is below the 200 day moving average line, I suggest an investor to sell. Example: Tesla.

The 200 day moving average line crosses the average market price lines several times, suggests the price isn't stable and lacks a clear long term trend.


# Weekly Return Densities

The width of each density gives an indication of the weekly returns.
Narrower distributions indicate lower variability in weekly returns.
Wider distributions indicate greater variability in weekly returns.

Several distributions exhibit asymmetry and heavy tails.
This indicates extreme weekly movements occur more frequently than a bell-shaped curve, which fits the normality assumption.

If the stock has multiple peaks, it's possible its returns behave differently under different market conditions.


# Portfolios Comparison

(Maximum diversification)
![MA](https://github.com/user-attachments/assets/938382e0-201d-4062-ae1f-12626930c8ea).
The high-risk portfolio exhibits substantial time-series variation. 
There are pronounced draw downs as well as periods of rapid recovery, consistent with the higher volatility of the underlying assets.

(Minimum risk)
![MA](https://github.com/user-attachments/assets/6df8f797-e216-4975-bcc7-72ef958bc61b).
The medium-risk portfolio displays a smoother performance profile than the high-risk portfolio, although it can face substantial draw downs. 
The portfolio demonstrates that diversification can reduce fluctuations without eliminating market risk.

(Risk-Return)
![MA](https://github.com/user-attachments/assets/5f1cfbd3-e93b-47e9-8383-621957133b0b).
The stocks JNJ and KO  are less risky under the optimisation criteria.
Therefore, the optimisation process can assign PEP.O with zero return.

## Limitations
• The analysis does not account for factors such as, transaction costs, taxes or liquidity.
• All stocks are from companies. The gold or silver market was not observed.
• The analysis is based on historical financial data, which may not represent future market performance.

## Technologies

• R
• RStudio
• R Shiny
•  Financial data analysis
•  Statistical analysis
•  Data visualisation
•  Modern Portfolio Theory
•  LSEG financial data

## Skills
• Data cleaning and transformation
• Data visualisation
• Statistical Analysis
• Interactive dashboard with Shiny
• Financial data analysis
•  Communicating analytical findings

## Author

Hannah Munir

Third year undergraduate student interested in data analytics, statistical analysis and applying data to real world problems.
