library(ggplot2)
library(ggpubr)
library(ggrepel)
library(kableExtra)
library(xts)
library(anytime)
library(tidyquant)
library(RiskPortfolios)
library(shiny)
#
# Risky portfolio:
# ======================================================================================= # 
# 
myportr=read.csv("hrp.csv")
myportr=as.xts(myportr[,-1], order.by = as.Date(myportr[,1], format = "%d/%m/%Y"))
#
myportr_w=to.weekly(myportr, OHLC=FALSE)   
myportr_r=diff(log(myportr_w))             
myportr_r=na.omit(myportr_r)             
myportr_ry=split(myportr_r, "years")     
#
myportr_cov=cov(myportr_r)
myportr_ave=colMeans(myportr_r)
myportr_w1=optimalPortfolio(myportr_cov, myportr_ave, 
                            control = list(type = 'mv', 
                                           constraint = 'lo', gamma=5))
myportr_w2=optimalPortfolio(myportr_cov, myportr_ave, 
                            control = list(type = 'minvol', 
                                           constraint = 'lo', gamma=5))
myportr_w3=optimalPortfolio(myportr_cov, myportr_ave, 
                            control = list(type = 'maxdiv', 
                                           constraint = 'lo', gamma=5))
#
pr1=data.frame(colnames(myportr_r), myportr_w1)
pr2=data.frame(colnames(myportr_r), myportr_w2)
pr3=data.frame(colnames(myportr_r), myportr_w3)
#
colnames(pr1)=c("Asset (Risky)", "Weight (Risky)")
colnames(pr2)=c("Asset (Risky)", "Weight (Risky)")
colnames(pr3)=c("Asset (Risky)", "Weight (Risky)")
#
p1perfr=myportr_w1[1]*myportr_r[,1]+myportr_w1[2]*myportr_r[,2]+myportr_w1[3]*myportr_r[,3]
p2perfr=myportr_w2[1]*myportr_r[,1]+myportr_w2[2]*myportr_r[,2]+myportr_w2[3]*myportr_r[,3]
p3perfr=myportr_w3[1]*myportr_r[,1]+myportr_w3[2]*myportr_r[,2]+myportr_w3[3]*myportr_r[,3]
#
p1perfr=cumsum(p1perfr)
p2perfr=cumsum(p2perfr)
p3perfr=cumsum(p3perfr)
#
colnames(p1perfr)=c("PR")
colnames(p2perfr)=c("PR")
colnames(p3perfr)=c("PR")
#
# Med. risk portfolio:
# ====================================================================================== # 
# 
myportf = read.csv("mrp.csv")
myportf=as.xts(myportf[,-1], order.by = as.Date(myportf[,1], format = "%d/%m/%Y"))
#
myportf_w=to.weekly(myportf, OHLC=FALSE)   
myportf_r=diff(log(myportf_w))             
myportf_r=na.omit(myportf_r)             
myportf_ry=split(myportf_r, "years")     
#
myport_cov=cov(myportf_r)
myport_ave=colMeans(myportf_r)
myportf_w1=optimalPortfolio(myport_cov, myport_ave, 
                            control = list(type = 'mv', 
                                           constraint = 'lo', gamma=5))
myportf_w2=optimalPortfolio(myport_cov, myport_ave, 
                            control = list(type = 'minvol', 
                                           constraint = 'lo', gamma=5))
myportf_w3=optimalPortfolio(myport_cov, myport_ave, 
                            control = list(type = 'maxdiv', 
                                           constraint = 'lo', gamma=5))
#
p1=data.frame(colnames(myportf_r), myportf_w1)
p2=data.frame(colnames(myportf_r), myportf_w2)
p3=data.frame(colnames(myportf_r), myportf_w3)
#
colnames(p1)=c("Asset (M. Risk)", "Weight (M. Risk)")
colnames(p2)=c("Asset (M. Risk)", "Weight (M. Risk)")
colnames(p3)=c("Asset (M. Risk)", "Weight (M. Risk)")
#
p1perf=myportf_w1[1]*myportf_r[,1]+myportf_w1[2]*myportf_r[,2]+myportf_w1[3]*myportf_r[,3]
p2perf=myportf_w2[1]*myportf_r[,1]+myportf_w2[2]*myportf_r[,2]+myportf_w2[3]*myportf_r[,3]
p3perf=myportf_w3[1]*myportf_r[,1]+myportf_w3[2]*myportf_r[,2]+myportf_w3[3]*myportf_r[,3]
#
p1perf=cumsum(p1perf)
p2perf=cumsum(p2perf)
p3perf=cumsum(p3perf)
#
colnames(p1perf)=c("PR")
colnames(p2perf)=c("PR")
colnames(p3perf)=c("PR")
#
# Low risk portfolio
# ====================================================================================== #
#
myportl = read.csv("lrp.csv")
myportl=as.xts(myportl[,-1], order.by = as.Date(myportl[,1], format = "%d/%m/%Y"))
#
myportl_w=to.weekly(myportl, OHLC=FALSE)   
myportl_r=diff(log(myportl_w))             
myportl_r=na.omit(myportl_r)             
myportl_ry=split(myportl_r, "years")     
#
myportl_cov=cov(myportl_r)
myportl_ave=colMeans(myportl_r)
myportl_w1=optimalPortfolio(myportl_cov, myportl_ave, 
                            control = list(type = 'mv', 
                                           constraint = 'lo', gamma=5))
myportl_w2=optimalPortfolio(myportl_cov, myportlave, 
                            control = list(type = 'minvol', 
                                           constraint = 'lo', gamma=5))
myportl_w3=optimalPortfolio(myportl_cov, myportl_ave, 
                            control = list(type = 'maxdiv', 
                                           constraint = 'lo', gamma=5))
#
pl1=data.frame(colnames(myportl_r), myportl_w1)
pl2=data.frame(colnames(myportl_r), myportl_w2)
pl3=data.frame(colnames(myportl_r), myportl_w3)
#
colnames(pl1)=c("Asset (L. Risk)", "Weight (L. Risk)")
colnames(pl2)=c("Asset (L. Risk)", "Weight (L. Risk)")
colnames(pl3)=c("Asset (L. Risk)", "Weight (L. Risk)")
#
p1perfl=myportl_w1[1]*myportl_r[,1]+myportl_w1[2]*myportl_r[,2]+myportl_w1[3]*myportl_r[,3]
p2perfl=myportl_w2[1]*myportl_r[,1]+myportl_w2[2]*myportl_r[,2]+myportl_w2[3]*myportl_r[,3]
p3perfl=myportl_w3[1]*myportl_r[,1]+myportl_w3[2]*myportl_r[,2]+myportl_w3[3]*myportl_r[,3]
#
p1perfl=cumsum(p1perfl)
p2perfl=cumsum(p2perfl)
p3perfl=cumsum(p3perfl)
#
colnames(p1perfl)=c("PR")
colnames(p2perfl)=c("PR")
colnames(p3perfl)=c("PR")
#
# ====================================================================================== #
#
ui = fluidPage(                                   # UI
  withMathJax(),                       #LaTeX for methodology page
  tabsetPanel(
    id = "tabs", type = "tabs",
    
    tabPanel(title = "Title",
             fluidRow(align = "center",
                      br(),      
                      h2("Three Investment Recommendations in the Uncertain Interest Rate Environment"),
                      br(),
                      h4("BIE0014: Econometrics"),
                      br(),
                      h4("Tej Hayre (U2058050), Hannah Munir (U2453243), Ntembe Mupwaya (U2297235) & James Evans (U2353402)"),
                      br(),
                      h4("28th of January 2026")
             )
    ),
    #  ======================================================================================= # 
    tabPanel(title = "Overview",
             fluidRow(align = "center",
                      br(),
                      h3("Overview"),
                      br(),
                      h4("- Constructed three equity portfolios (high, medium and low risk) for an investor using LSEG Workspace. We assume there is an uncertain interest rate environment."),
                      br(),
                      h4("- First we will discuss the methodology used relative to our investments."),
                      br(),
                      h4("- Furthermore we apply modern portfolio theory to evaluate the risk and return characteristics of each portfolio."),
                      br(),
                      h4("- Additionally, we will discuss the moving averages and the current geopolitical trend"),
                      br(),
                      h4("- Lastly, we analyse the weekly distributions of each portfolio."),
                      br(),
                      br(),
                      h3("The assets used for each portfolio:"),
                      h4("High risk – TSLA, PLTR, SPCE"),
                      h4("Medium risk – MSFT, CSCO, SBUX"),
                      h4("Low risk – JNJ, KO, PEP"),
             )
    ),
    #  ======================================================================================= #   
    tabPanel(title = "Methodology",    #We use expected returns. Risk ( Variance and Covariance) and  Portfolio Risk ( Portfolio Variance) differ.
             fluidRow(align = "center",
                      br(),      
                      h4("Logarithmic Returns: \\( R_{i,t} = \\log (\\frac{P_{i,t}}{P_{i,t-1}}) \\)"),
                      br(),
                      h4("Expected Return: \\( E(R_{i}) = T^{-1} \\sum_{t=1}^{T} R_{i,t} \\)"),
                      br(),
                      h4("Variance: \\( \\sigma_{i}^{2} = \\frac{1}{T-1} \\sum_{t=1}^{T} [R_{i,t} - E(R_{i}) ]^2 \\)"),
                      br(),
                      h4("Covariance: \\( Cov(R_{i}, R_{j}) = \\frac{1}{T-1} \\sum_{t=1}^{T} [R_{i,t} - E(R_{i})][R_{j,t} - E(R_{j})] \\)"),
                      br(),
                      h4("Portfolio Return: \\( E(R_{P}) = \\sum_{i} w_{i} E(R_{i}) = w' E(r) \\)" ),
                      br(),
                      h4("Portfolio Risk: \\( \\sigma_{p}^{2} = \\sum_{i} \\sum_{j} w_{i} w_{j} \\sigma_{i,j} = w'\\Sigma w  \\)" ),
                      br(),
                      h4("Portfolio Weights: \\( \\sum_{i} w_{i}  = w'1 = 1  \\)" )
             )
    ),
    #  ======================================================================================= #    
    tabPanel(title = "Moving Averages",
             fluidRow(align = "center",
                      plotOutput("my_fig"),
                      checkboxGroupInput(
                        inputId = "MA",
                        label   = "Moving average window:",
                        choices = c("SMA 25" = 25, "SMA 50" = 50, "SMA 100" = 100, "SMA 200" = 200),
                        selected = c(50, 200),
                        inline = TRUE
                      )
             )
    ),
    #  ======================================================================================= #    
    tabPanel(title = "Weekly Returns Densities",
             fluidRow(align = "center",
                      plotOutput("my_den"),
                      selectInput( 
                        inputId = "DEN", 
                        label   = "Select year:", 
                        choices = list("2023" = 2023, "2024" = 2024, "2025" = 2025),
                        selected = c(2024),
                        multiple = TRUE 
                      )
             )
    ),
    #  ======================================================================================= #    
    tabPanel(title = "Portfolios",
             fluidRow(align = "center",
                      plotOutput("my_port"),
                      tableOutput("my_tab"),
                      selectInput(
                        inputId = "PORT",
                        label = "Investor choice: select optimisation strategy:",
                        choices = c("Risk - Return" =  "rr", "Min. Risk" = "mr", "Max. Diversification" = "md"),
                        selected = c("rr")
                      )
             ) 
    ),
    #  ======================================================================================= #    
    tabPanel(title = "Recommendation",
             fluidRow(align = "center",
                      br(),
                      h3("Recommendation"),
                      br(),
                      h4("- High-risk portfolio: Suitable only for very risk-tolerant investors willing to accept large drawdowns in exchange for growth potential."),
                      br(),
                      h4("- Low-risk portfolio: Most resilient in an uncertain interest-rate environment; smoother returns but limited upside."),
                      br(),
                      h4("- Medium-risk portfolio: Balanced choice between volatility and return; benefits from growth but less exposed than the high-risk portfolio."),
                      br(),
                      h4("- Optimisation strategy: In this environment we favour the minimum-risk or maximum-diversification versions of the medium- and low-risk portfolios."),
                      br(),
                      h4("- Final recommendation: For a typical investor facing interest-rate uncertainty, allocate the core of the portfolio to the low- and medium-risk buckets, with optional satellite exposure to the high-risk portfolio depending on risk appetite.")
             )
    ),
    #  ======================================================================================= #    
    tabPanel(title = "References",
             fluidRow(align = "center",
                      br(),
                      h5("- Bajaj Finance. (2025). Expected Returns. Bajaj Finance. https://www.bajajfinserv.in/investment/expected-return "),
                      br(),
                      h5("- Bodie, Z., Kane, A. and Marcus, A. (2014) Investments. 10th edn. McGraw-Hill."),
                      br(),
                      h5("- Chen, N., & Zhang, F. (1998). Risk and Return of Value Stocks. The Journal of Business, 71(4), 501–535. https://doi.org/10.1086/209755"),
                      br(),
                      h5("- Choueifaty, Y. and Coignard, Y. (2008) 'Toward Maximum Diversification', The Journal of Portfolio Management, 35(1), pp. 40–51."),
                      br(),
                      h5("- CFA. (2026). LM02 Portfolio Risk and Return Part 1. CFA. https://ift.world/booklets/portfolio-management-portfolio-risk-and-return-part-i-part3/#:~:text=Return%20Part%20I-,Part%203,a%20standard%20deviation%20of%2016%25. "),
                      br(),
                      h5("- Collin, V. (2024). Covariance. Financial Edge. https://www.fe.training/free-resources/portfolio-management/covariance/ "),
                      br(),
                      h5("- Collin, V. (2025a). Deviation Risk Measure. Financial Edge. https://www.fe.training/free-resources/asset-management/deviation-risk-measure/ "),
                      br(),
                      h5("- Collin, V. (2025b). Modern Portfolio Theory. Financial Edge. https://www.fe.training/free-resources/financial-markets/modern-portfolio-theory/ "),
                      br(),
                      h5("- Financial Times (2026). FT equities: Johnsons and Johnsons. (JNJ.NYQ)  [Data set]. Retrieved  January 2, 2026. From https://markets.ft.com/data/equities/tearsheet/forecasts?s=JNJ:NYQ "),
                      br(),
                      h5("- Financial Times (2026). FT equities: Starbucks. (SBUX.NSQ)  [Data set]. Retrieved  January 2, 2026. From https://markets.ft.com/data/equities/tearsheet/forecasts?s=SBUX:NSQ "),
                      br(),
                      h5("-  Financial Times (2026). FT equities: Tesla.Inc. (TSLA.NSQ) [Data set]. Retrieved  January 2, 2026. From https://markets.ft.com/data/equities/tearsheet/forecasts?s=TSLA:NSQ "),
                      br(),
                      h5("- Financial Times (2026). FT equities: Virgin Galactic Holdings Inc. (SPCE.NYQ)  [Data set]. Retrieved  January 2, 2026. From https://markets.ft.com/data/equities/tearsheet/forecasts?s=SPCE:NYQ "),
                      br(),
                      h5("- Green, E. (2014). Analysis and Modelling of Financial Logarithmic Return Data using Multifractal and Agent-Based Techniques. Maynooth University. https://files01.core.ac.uk/download/pdf/297019014.pdf "),
                      br(),
                      h5("- Greenwood, R., & Shleifer, A. (2014). Expectations of Returns and Expected Returns. The Review of Financial Studies, 27(3), 714-746. https://www.jstor.org/stable/24465692 "),
                      br(),
                      h5("- Isidore, R. R., & Christie, P. J. (2019). Drivers of Stock Investment Decision: An Orthogonal Linear Transformation Approach. The Journal of Private Equity, 22(2), 55–65. https://www.jstor.org/stable/26864406 "),
                      br(),
                      h5("- Leung, S. (2024). A brief overview on simple returns and log returns in financial data. Medium. https://medium.com/@simonleung5jobs/a-brief-overview-on-simple-returns-and-log-returns-in-financial-data-07f2dfbc69ff "),
                      br(),
                      h5("- LSEG Workspace (2025) Equity price data. London Stock Exchange Group. "),
                      br(),
                      h5("- Markowitz, H. (1952) 'Portfolio Selection', The Journal of Finance, 7(1), pp. 77–91 "),
                      br(),
                      h5("- Mehta, S. (2021). Volatility. Financial Edge. https://www.fe.training/free-resources/asset-management/volatility/#:~:text=Two%20measures%2C%20standard%20deviation%2C%20and,the%20expected%20rate%20of%20return "),
                      br(),
                      h5("- Pfaff, B. (2016) RiskPortfolios: Portfolio Optimisation with R. R package documentation. "),
                      br(),
                      h5("- Warren, G. (2021). Investment risk for long-term investors. Top1000funds. https://www.top1000funds.com/2021/05/investment-risk-for-long-term-investors/ ")
             )
    )
    
  )
)

#
# ====================================================================================== # 
#
server = function(input, output, session) {           # SERVER
  fig1 = renderPlot({
    fp1=myportr %>%
      ggplot(aes(x=Index, y=TSLA.O))+
      geom_line()+
      labs(x='', y='Closing Price', title="TSLA.O")
    #
    if (any(input$MA == 25)) { 
      fp1 = fp1 + geom_ma(ma_fun = SMA, n = 25,  color = "Green",  linetype = 1)
    }
    if (any(input$MA == 50)) { 
      fp1 = fp1 + geom_ma(ma_fun = SMA, n = 50,  color = "Yellow", linetype = 1)
    }
    if (any(input$MA == 100)){ 
      fp1 = fp1 + geom_ma(ma_fun = SMA, n = 100, color = "Orange", linetype = 1)
    }
    if (any(input$MA == 200)){ 
      fp1 = fp1 + geom_ma(ma_fun = SMA, n = 200, color = "Red",    linetype = 1)
    }
    #
    fp2=myportr %>%
      ggplot(aes(x=Index, y=PLTR.O))+
      geom_line()+
      labs(x='', y='Closing Price', title="PLTR.O")
    if (any(input$MA == 25)) { 
      fp2 = fp2 + geom_ma(ma_fun = SMA, n = 25,  color = "Green",  linetype = 1)
    }
    if (any(input$MA == 50)) { 
      fp2 = fp2 + geom_ma(ma_fun = SMA, n = 50,  color = "Yellow", linetype = 1)
    }
    if (any(input$MA == 100)){ 
      fp2 = fp2 + geom_ma(ma_fun = SMA, n = 100, color = "Orange", linetype = 1)
    }
    if (any(input$MA == 200)){ 
      fp2 = fp2 + geom_ma(ma_fun = SMA, n = 200, color = "Red",    linetype = 1)
    }
    #
    fp3=myportr %>%
      ggplot(aes(x=Index, y=SPCE.K))+
      geom_line()+
      labs(x='', y='Closing Price', title="SPCE.K")
    if (any(input$MA == 25)) { 
      fp3 = fp3 + geom_ma(ma_fun = SMA, n = 25,  color = "Green",  linetype = 1)
    }
    if (any(input$MA == 50)) { 
      fp3 = fp3 + geom_ma(ma_fun = SMA, n = 50,  color = "Yellow", linetype = 1)
    }
    if (any(input$MA == 100)){ 
      fp3 = fp3 + geom_ma(ma_fun = SMA, n = 100, color = "Orange", linetype = 1)
    }
    if (any(input$MA == 200)){ 
      fp3 = fp3 + geom_ma(ma_fun = SMA, n = 200, color = "Red",    linetype = 1)
    }
    #
    fp4=myportf %>%
      ggplot(aes(x=Index, y=SBUX.O))+
      geom_line()+
      labs(x='', y='Closing Price', title="SBUX.O")
    if (any(input$MA == 25)) { 
      fp4 = fp4 + geom_ma(ma_fun = SMA, n = 25,  color = "Green",  linetype = 1)
    }
    if (any(input$MA == 50)) { 
      fp4 = fp4 + geom_ma(ma_fun = SMA, n = 50,  color = "Yellow", linetype = 1)
    }
    if (any(input$MA == 100)){ 
      fp4 = fp4 + geom_ma(ma_fun = SMA, n = 100, color = "Orange", linetype = 1)
    }
    if (any(input$MA == 200)){ 
      fp4 = fp4 + geom_ma(ma_fun = SMA, n = 200, color = "Red",    linetype = 1)
    }
    #
    fp5=myportf %>%
      ggplot(aes(x=Index, y=CSCO.O))+
      geom_line()+
      labs(x='', y='Closing Price', title="CSCO.O")
    if (any(input$MA == 25)) { 
      fp5 = fp5 + geom_ma(ma_fun = SMA, n = 25,  color = "Green",  linetype = 1)
    }
    if (any(input$MA == 50)) { 
      fp5 = fp5 + geom_ma(ma_fun = SMA, n = 50,  color = "Yellow", linetype = 1)
    }
    if (any(input$MA == 100)){ 
      fp5 = fp5 + geom_ma(ma_fun = SMA, n = 100, color = "Orange", linetype = 1)
    }
    if (any(input$MA == 200)){ 
      fp5 = fp5 + geom_ma(ma_fun = SMA, n = 200, color = "Red",    linetype = 1)
    }
    #
    fp6=myportf %>%
      ggplot(aes(x=Index, y=MSFT.O))+
      geom_line()+
      labs(x='', y='Closing Price', title="MSFT.O")
    if (any(input$MA == 25)) { 
      fp6 = fp6 + geom_ma(ma_fun = SMA, n = 25,  color = "Green",  linetype = 1)
    }
    if (any(input$MA == 50)) { 
      fp6 = fp6 + geom_ma(ma_fun = SMA, n = 50,  color = "Yellow", linetype = 1)
    }
    if (any(input$MA == 100)){ 
      fp6 = fp6 + geom_ma(ma_fun = SMA, n = 100, color = "Orange", linetype = 1)
    }
    if (any(input$MA == 200)){ 
      fp6 = fp6 + geom_ma(ma_fun = SMA, n = 200, color = "Red",    linetype = 1)
    }
    #
    fp7=myportl %>%
      ggplot(aes(x=Index, y=JNJ))+
      geom_line()+
      labs(x='', y='Closing Price', title="JNJ")
    if (any(input$MA == 25)) { 
      fp7 = fp7 + geom_ma(ma_fun = SMA, n = 25,  color = "Green",  linetype = 1)
    }
    if (any(input$MA == 50)) { 
      fp7 = fp7 + geom_ma(ma_fun = SMA, n = 50,  color = "Yellow", linetype = 1)
    }
    if (any(input$MA == 100)){ 
      fp7 = fp7 + geom_ma(ma_fun = SMA, n = 100, color = "Orange", linetype = 1)
    }
    if (any(input$MA == 200)){ 
      fp7 = fp7 + geom_ma(ma_fun = SMA, n = 200, color = "Red",    linetype = 1)
    }
    #
    fp8=myportl %>%
      ggplot(aes(x=Index, y=KO))+
      geom_line()+
      labs(x='', y='Closing Price', title="KO")
    if (any(input$MA == 25)) { 
      fp8 = fp8 + geom_ma(ma_fun = SMA, n = 25,  color = "Green",  linetype = 1)
    }
    if (any(input$MA == 50)) { 
      fp8 = fp8 + geom_ma(ma_fun = SMA, n = 50,  color = "Yellow", linetype = 1)
    }
    if (any(input$MA == 100)){ 
      fp8 = fp8 + geom_ma(ma_fun = SMA, n = 100, color = "Orange", linetype = 1)
    }
    if (any(input$MA == 200)){ 
      fp8 = fp8 + geom_ma(ma_fun = SMA, n = 200, color = "Red",    linetype = 1)
    }
    #
    fp9=myportl %>%
      ggplot(aes(x=Index, y=PEP.O))+
      geom_line()+
      labs(x='', y='Closing Price', title="PEP.O")
    if (any(input$MA == 25)) { 
      fp9 = fp9 + geom_ma(ma_fun = SMA, n = 25,  color = "Green",  linetype = 1)
    }
    if (any(input$MA == 50)) { 
      fp9 = fp9 + geom_ma(ma_fun = SMA, n = 50,  color = "Yellow", linetype = 1)
    }
    if (any(input$MA == 100)){ 
      fp9 = fp9 + geom_ma(ma_fun = SMA, n = 100, color = "Orange", linetype = 1)
    }
    if (any(input$MA == 200)){ 
      fp9 = fp9 + geom_ma(ma_fun = SMA, n = 200, color = "Red",    linetype = 1)
    }
    
    #
    p1pplot=ggarrange(fp1, fp2, fp3, fp4, fp5, fp6, fp7, fp8, fp9, nrow=3, ncol=3)
    p1pplot
  }
  )
  #
  fig2 = renderPlot({
    fpry1=ggplot()+
      geom_vline(xintercept=0, linetype=2)+
      labs(x="", y="Density", title="TSLA.O")+
      xlim(-0.1, 0.1)+
      ylim(0, 25)
    if (any(input$DEN == 2023)){
      fpry1 = fpry1 + geom_density(aes(x=myportr_ry[[1]]$TSLA.O), fill="red", color="red", alpha=0.1)
    }
    if (any(input$DEN == 2024)){
      fpry1 = fpry1 + geom_density(aes(x=myportr_ry[[2]]$TSLA.O), fill="yellow", color="yellow", alpha=0.1)
    }
    if (any(input$DEN == 2025)){
      fpry1 = fpry1 + geom_density(aes(x=myportr_ry[[3]]$TSLA.O), fill="blue", color="blue", alpha=0.1)
    }
    #
    fpry2=ggplot()+
      geom_vline(xintercept=0, linetype=2)+
      labs(x="", y="Density", title="PLTR.O")+
      xlim(-0.225, 0.225)+
      ylim(0, 7)
    if (any(input$DEN == 2023)){
      fpry2 = fpry2 + geom_density(aes(x=myportr_ry[[1]]$PLTR.O), fill="red", color="red", alpha=0.1)
    }
    if (any(input$DEN == 2024)){
      fpry2 = fpry2 + geom_density(aes(x=myportr_ry[[2]]$PLTR.O), fill="yellow", color="yellow", alpha=0.1)
    }
    if (any(input$DEN == 2025)){
      fpry2 = fpry2 + geom_density(aes(x=myportr_ry[[3]]$PLTR.O), fill="blue", color="blue", alpha=0.1)
    }
    #
    fpry3=ggplot()+
      geom_vline(xintercept=0, linetype=2)+
      labs(x="", y="Density", title="SPCE.K")+
      xlim(-0.4, 0.4)+
      ylim(0, 5)
    if (any(input$DEN == 2023)){
      fpry3 = fpry3 + geom_density(aes(x=myportr_ry[[1]]$SPCE.K), fill="red", color="red", alpha=0.1)
    }
    if (any(input$DEN == 2024)){
      fpry3 = fpry3 + geom_density(aes(x=myportr_ry[[2]]$SPCE.K), fill="yellow", color="yellow", alpha=0.1)
    }
    if (any(input$DEN == 2025)){
      fpry3 = fpry3 + geom_density(aes(x=myportr_ry[[3]]$SPCE.K), fill="blue", color="blue", alpha=0.1)
    }
    #
    fpry4=ggplot()+
      geom_vline(xintercept=0, linetype=2)+
      labs(x="", y="Density", title="SBUX.O")+
      xlim(-0.1, 0.1)+
      ylim(0, 16)
    if (any(input$DEN == 2023)){
      fpry4 = fpry4 + geom_density(aes(x=myportf_ry[[1]]$SBUX.O), fill="red", color="red", alpha=0.1)
    }
    if (any(input$DEN == 2024)){
      fpry4 = fpry4 + geom_density(aes(x=myportf_ry[[2]]$SBUX.O), fill="yellow", color="yellow", alpha=0.1)
    }
    if (any(input$DEN == 2025)){
      fpry4 = fpry4 + geom_density(aes(x=myportf_ry[[3]]$SBUX.O), fill="blue", color="blue", alpha=0.1)
    }
    #
    fpry5=ggplot()+
      geom_vline(xintercept=0, linetype=2)+
      labs(x="", y="Density", title="CSCO.O")+
      xlim(-0.1, 0.1)+
      ylim(0, 40)
    if (any(input$DEN == 2023)){
      fpry5 = fpry5 + geom_density(aes(x=myportf_ry[[1]]$CSCO.O), fill="red", color="red", alpha=0.1)
    }
    if (any(input$DEN == 2024)){
      fpry5 = fpry5 + geom_density(aes(x=myportf_ry[[2]]$CSCO.O), fill="yellow", color="yellow", alpha=0.1)
    }
    if (any(input$DEN == 2025)){
      fpry5 = fpry5 + geom_density(aes(x=myportf_ry[[3]]$CSCO.O), fill="blue", color="blue", alpha=0.1)
    }
    #
    fpry6=ggplot()+
      geom_vline(xintercept=0, linetype=2)+
      labs(x="", y="Density", title="MSFT.O")+
      xlim(-0.075, 0.075)+
      ylim(0, 25)
    if (any(input$DEN == 2023)){
      fpry6 = fpry6 + geom_density(aes(x=myportf_ry[[1]]$MSFT.O), fill="red", color="red", alpha=0.1)
    }
    if (any(input$DEN == 2024)){
      fpry6 = fpry6 + geom_density(aes(x=myportf_ry[[2]]$MSFT.O), fill="yellow", color="yellow", alpha=0.1)
    }
    if (any(input$DEN == 2025)){
      fpry6 = fpry6 + geom_density(aes(x=myportf_ry[[3]]$MSFT.O), fill="blue", color="blue", alpha=0.1)
    }
    #
    fpry7=ggplot()+
      geom_vline(xintercept=0, linetype=2)+
      labs(x="", y="Density", title="JNJ")+
      xlim(-0.06, 0.06)+
      ylim(0, 35)
    if (any(input$DEN == 2023)){
      fpry7 = fpry7 + geom_density(aes(x=myportl_ry[[1]]$JNJ), fill="red", color="red", alpha=0.1)
    }
    if (any(input$DEN == 2024)){
      fpry7 = fpry7 + geom_density(aes(x=myportl_ry[[2]]$JNJ), fill="yellow", color="yellow", alpha=0.1)
    }
    if (any(input$DEN == 2025)){
      fpry7 = fpry7 + geom_density(aes(x=myportl_ry[[3]]$JNJ), fill="blue", color="blue", alpha=0.1)
    }
    #
    fpry8=ggplot()+
      geom_vline(xintercept=0, linetype=2)+
      labs(x="", y="Density", title="KO")+
      xlim(-0.05, 0.05)+
      ylim(0, 35)
    if (any(input$DEN == 2023)){
      fpry8 = fpry8 + geom_density(aes(x=myportl_ry[[1]]$KO), fill="red", color="red", alpha=0.1)
    }
    if (any(input$DEN == 2024)){
      fpry8 = fpry8 + geom_density(aes(x=myportl_ry[[2]]$KO), fill="yellow", color="yellow", alpha=0.1)
    }
    if (any(input$DEN == 2025)){
      fpry8 = fpry8 + geom_density(aes(x=myportl_ry[[3]]$KO), fill="blue", color="blue", alpha=0.1)
    }
    #
    fpry9=ggplot()+
      geom_vline(xintercept=0, linetype=2)+
      labs(x="", y="Density", title="PEP.O")+
      xlim(-0.05, 0.05)+
      ylim(0, 35)
    if (any(input$DEN == 2023)){
      fpry9 = fpry9 + geom_density(aes(x=myportl_ry[[1]]$PEP.O), fill="red", color="red", alpha=0.1)
    }
    if (any(input$DEN == 2024)){
      fpry9 = fpry9 + geom_density(aes(x=myportl_ry[[2]]$PEP.O), fill="yellow", color="yellow", alpha=0.1)
    }
    if (any(input$DEN == 2025)){
      fpry9 = fpry9 + geom_density(aes(x=myportl_ry[[3]]$PEP.O), fill="blue", color="blue", alpha=0.1)
    }
    # ================================================================================================== #              
    #
    p1dplot=ggarrange(fpry1, fpry2, fpry3, fpry4, fpry5, fpry6, fpry7, fpry8, fpry9, nrow = 3, ncol = 3)
    p1dplot
  }
  )
  #
  fig3 = renderPlot({
    if (input$PORT == "rr"){
      data0 = p1perfr   # high-risk, mv   # Mid, low are less volatile. TSLA has lower relative volatility, but risk-return weighting is low, so not a reccomended invesment.
      data1 = p1perf    # med-risk, mv
      data2 = p1perfl   # low-risk, mv
    } else if (input$PORT == "mr"){
      data0 = p2perfr   # high-risk, min vol   # High weighting, low volatility.
      data1 = p2perf    # med-risk, min vol
      data2 = p2perfl   # low-risk, min vol
    } else if (input$PORT == "md"){
      data0 = p3perfr   # high-risk, max div   # High weighting, less correlation, good for diversification.
      data1 = p3perf    # med-risk, max div
      data2 = p3perfl   # low-risk, max div
    }
    
    # Compute dynamic y-limits with a small padding
    r0 <- range(data0$PR, na.rm = TRUE)
    r1 <- range(data1$PR, na.rm = TRUE)
    r2 <- range(data2$PR, na.rm = TRUE)
    
    pad0 <- 0.05 * diff(r0)
    pad1 <- 0.05 * diff(r1)
    pad2 <- 0.05 * diff(r2)
    
    p0 = data0 %>%
      ggplot(aes(x = Index, y = PR, group = 1)) +
      geom_line(color = "red") +
      geom_point(color = "red") +
      labs(x = "", y = "", title = "High Risk Portfolio Historical Performance") +
      ylim(r0[1] - pad0, r0[2] + pad0)
    
    p1 = data1 %>%
      ggplot(aes(x = Index, y = PR, group = 1)) +
      geom_line(color = "green") +
      geom_point(color = "green") +
      labs(x = "", y = "", title = "Medium Risk Portfolio Historical Performance") +
      ylim(r1[1] - pad1, r1[2] + pad1)
    
    p2 = data2 %>%
      ggplot(aes(x = Index, y = PR, group = 1)) +
      geom_line(color = "blue") +
      geom_point(color = "blue") +
      labs(x = "", y = "", title = "Low Risk Portfolio Historical Performance") +
      ylim(r2[1] - pad2, r2[2] + pad2)
    
    pr = ggarrange(p0, p1, p2, nrow = 1, ncol = 3)
    pr
  })
  #
  tab1 = renderTable(
    if (input$PORT == "rr"){
      cbind(pr1, p1, pl1)
    } else if (input$PORT == "mr"){
      cbind(pr2, p2, pl2)
    } else if (input$PORT == "md"){
      cbind(pr3, p3, pl3)
    }
  )
  # ===================================================================================== #
  # SERVER OUTPUT
  output$my_fig = fig1
  output$my_den = fig2
  output$my_port = fig3
  output$my_tab = tab1
}
#
# ====================================================================================== # 
shinyApp(ui, server)
