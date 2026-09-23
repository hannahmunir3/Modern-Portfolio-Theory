Creating an application to analyse investment portfolios, using Shiny!

Three portfolios are composed using LSEG to explain the link between MPT and investment stocks. R programming is used to create an app using Shiny.

This is an interactive R Shiny application that analyses three investment portfolios using Modern Portfolio Theory.
The application calculates portfolio risk and return, compares the individual investment, compares the investment portfolios using financial data from the LSEG.

RStudio is used to write and run the code.

Firstly, the necessary packages must be installed. 
Secondly, run each library.
Next, the CSV files are imported into RStudio.
Each page is created including: Methodology, Moving averages, Weekly densities and portfolio comparison.
The portfolio comparison page includes: risk-return, maximum diversification and minimum risk.


MOVING AVERAGES:
![MA](https://github.com/user-attachments/assets/ceb91ce7-ffb9-4eab-901b-d5db57c19888)
The market sentiment is depicted from the average price, which is represented by the black line.

The 200 day moving average is preferred when analysing the individual portfolios. This is because it represents a more long term trend.
Therefore I decide if the company is structurally strong over time.

If the 50 day moving average line is above the 200 day moving average line, I suggest an investor to buy. Example: Microsoft.
Moreover, if the 50 day day moving average line is below the 200 day moving average line, I suggest an investor to sell. Example: Tesla.

The 200 day moving average line crosses the average market price lines several times, suggests the price isn't stable and lacks a clear long term trend.


WEEKLY RETURN DENSITIES:
![MA](https://github.com/user-attachments/assets/1ac78fc9-ebde-4ea5-8d2e-5168b99b7ea2).

The width of each density gives an indication of the weekly returns.
Narrower distributions indicate lower variability in weekly returns.
Wider distributions indicate greater variability in weekly returns.

Several distributions exhibit asymmetry and heavy tails.
This indicates extreme weekly movements occur more frequently than a bell-shaped curve, which fits the normality assumption.

If the stock has multiple peaks, it's possible its returns behave differently under different market conditions.


3 PORFOLIOS HISTORICAL PERFORMANCE:

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
