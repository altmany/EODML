function [data, errMsg] = EODML(action, parameters, varargin) %#ok
%EODML - Get historic or real-time market data from eodhistoricaldata.com
%
% Syntax: [data, errMsg] = EODML(action, paramName1,paramValue1, paramName2,paramValue2, ...)
%
% Inputs:
%
%   action (String) - one of: 'license','limits','version','update','revert',
%                             'doc','prices','fundamentals','technicals',
%                             'options','dividends','splits','earnings','ipo',
%                             'shorts','lookup','news','sentiments','index',
%                             'economy','macro','esg','exchange','screener'
%
%   parameters - Matlab struct or XLS filename or parameter name/value pairs with the following optional parameters:
%
%     General:
%        API_Token      (String)  default=''; provided to you by eodhistoricaldata.com
%        Timeout        (Number)  default=5; max # of seconds to wait for a query response (0=infinite)
%        UseParallel    (Logical) default=0 or false; if true or 1, the query will be parallelized (Analyst/Pro license only)
%        Debug          (Logical) default=0 or false; if true or 1, extra data will be displayed in Matlab console
%        RaiseErrorMsgs (Logical) default=1 or true; if false or 0, errors set the errMsg output arg, rather than raise an error
%        Order          (String)  default='asc'; either 'asc' or 'desc'
%
%     Prices:
%        DataType       (String)  default='day'; one of 'day','week','month','live','intraday','ticks','bulk' (bulk in Pro license only)
%        Symbols        (String :-delimited or cell-array) default=''; e.g., 'IBM' or 'IBM:GOOG' or {'IBM','GOOG'}
%        SecType        (String)  default='equity'; one of 'equity','index','bond'
%        FromDate       (Integer or String) default=[]; earliest data date
%        ToDate         (Integer or String) default=[]; latest data date
%        Interval       (String)  default='5m'; one of '5m','1m','1hr'; only relevant when DataType='intraday'
%        Exchange       (String)  default='US'; only relevant when DataType=bulk (Pro license only)
%        Filter         (String)  default=''; comma-delimited fields e.g. 'close,change,volume'
%        Limit          (Integer) default=100; max number of prices to return in results (ticks only)
%
%     Fundamentals:
%        DataType       (String)  default='standard'; one of 'standard','insiderTrading','marketCap','bulk' (bulk in Pro license)
%        Symbols        (String :-delimited or cell-array) default=''; e.g., 'IBM' or 'IBM:GOOG' or {'IBM','GOOG'}
%        SecType        (String)  default='equity'; one of 'equity','index','bond'
%        FromDate       (Integer or String) default=[]; earliest data date
%        ToDate         (Integer or String) default=[]; latest data date
%        Exchange       (String)  default='US'; only relevant when DataType=bulk (Pro license only)
%        Filter         (String)  default=''; comma-delimited groups/fields e.g. 'General,Financials::Balance_Sheet::yearly'
%        Limit          (Integer) default=100; max number of data points to return in results
%
%     Splits, Dividends:
%        DataType       (String)  default='standard'; either 'standard' or 'bulk' (bulk in Pro license only)
%        Symbols        (String :-delimited or cell-array) default=''; e.g., 'IBM' or 'IBM:GOOG' or {'IBM','GOOG'} (unused in bulk)
%        FromDate       (Integer or String) default=[]; earliest data date
%        ToDate         (Integer or String) default=[]; latest data date (unused when DataType=bulk)
%        Exchange       (String)  default='US'; only relevant when DataType=bulk (Pro license only)
%
%     Earnings, Shorts:
%        DataType       (String)  default='standard'; either 'standard' or 'trends' (trends is only relevant to earnings)
%        Symbols        (String :-delimited or cell-array) default=''; e.g., 'IBM' or 'IBM:GOOG' or {'IBM','GOOG'}
%        FromDate       (Integer or String) default=[]; earliest data date
%        ToDate         (Integer or String) default=[]; latest data date
%
%     Technicals:
%        Symbols         (String :-delimited or cell-array) default=''; e.g., 'IBM' or 'IBM:GOOG' or {'IBM','GOOG'}
%        FromDate        (Integer or String) default=[]; earliest data date
%        ToDate          (Integer or String) default=[]; latest data date
%        Function        (String)  default='SMA'; one of 'SMA','EMA','WMA','RSI','StdDev','AvgVol','AvgVolCcy',
%                                  'Volatility','SplitAdjusted','AvgVolCcy','Stochastic','StochRSI','Slope',
%                                  'DMI','ADX','MACD','ATR','CCI','SAR','Beta','BBands'
%                                  See https://eodhd.com/financial-apis/technical-indicators-api?ref=OX6LJ2BE
%        Period          (Number)  default=50; number of data points used to calculate the function (2-100k)
%        FastPeriod      (Number)  default=12; used by MACD
%        SlowPeriod      (Number)  default=26; used by MACD
%        SignalPeriod    (Number)  default=9;  used by MACD
%        FastKPeriod     (Number)  default=14; used by Stochastic, StochRSI
%        FastDPeriod     (Number)  default=14; used by StochRSI
%        SlowKPeriod     (Number)  default=3;  used by Stochastic
%        SlowDPeriod     (Number)  default=3;  used by Stochastic
%        AGGPeriod       (String)  default='day'; one of 'day','week','month'; used by SplitAdjusted function
%        AdjustDividends (Logical) default=1 or true; if false or 0, close prices are only adjusted for splits, not dividends
%        Acceleration    (Number)  default=0.02; used by SAR
%        Maximum         (Number)  default=0.20; used by SAR
%        Code2           (String)  default='GSPC.INDX'; used by Beta
%
%     Options:
%        Symbols        (String :-delimited or cell-array) default=''; e.g., 'IBM' or 'IBM:GOOG' or {'IBM','GOOG'}
%        FromExpiryDate (Integer or String) default=[]; earliest data date
%        ToExpiryDate   (Integer or String) default=[]; latest data date
%        FromTradeDate  (Integer or String) default=[]; earliest data date
%        ToTradeDate    (Integer or String) default=[]; latest data date
%        ContractName   (String)  default=''; query only the specified contract e.g. 'AAPL180420P00002500'
%
%     IPO:
%        FromDate       (Integer or String) default=[]; earliest data date
%        ToDate         (Integer or String) default=[]; latest data date
%
%     Lookup:
%        Symbol         (String)  default='';  e.g., 'IBM'
%        DataType       (String)  default='symbol';  either 'symbol' or 'exchange'
%        Exchange       (String)  default='';  e.g. 'US' or 'NASDAQ' or 'NYSE'
%        SecType        (String)  default='all'; one of 'all','stock','etf','fund','bond','index','crypto' (symbol lookup only)
%        BondsOnly      (Logical) default=0 or false; if true or 1, bonds symbols are returned (symbol lookup only)
%        Limit          (Integer) default=15; max number of elements to return in results
%
%     News:
%        Symbols        (String :-delimited or cell-array) default=''; e.g., 'IBM' or 'IBM:GOOG' or {'IBM','GOOG'}
%        FromDate       (Integer or String) default=[]; earliest data date
%        ToDate         (Integer or String) default=[]; latest data date
%        Topic          (String)  default=''; e.g., 'balance sheet'; https://eodhd.com/financial-apis/stock-market-financial-news-api?ref=OX6LJ2BE
%        Limit          (Integer) default=50; max number of news items to return in results
%
%     Sentiments:
%        Symbols        (String :-delimited or cell-array) default=''; e.g., 'IBM' or 'IBM:GOOG' or {'IBM','GOOG'}
%        FromDate       (Integer or String) default=[]; earliest data date
%        ToDate         (Integer or String) default=[]; latest data date
%
%     Macro indicators:
%        Country        (String)  default='USA'; 3-letter ISO code (https://en.wikipedia.org/wiki/ISO_3166-1_alpha-3)
%        Indicator      (String)  default='gdp_current_usd'; https://eodhd.com/financial-apis/macroeconomics-data-and-macro-indicators-api?ref=OX6LJ2BE
%
%     Sentiments:
%        Symbols        (String :-delimited or cell-array) default=''; e.g., 'GSPC.INDX'. If empty, returns list of indexes
%                                (https://eodhd.com/marketplace/unicornbay/spglobal/docs?ref=OX6LJ2BE); Alternative: Fundamental query of index symbol
%
%     Exchange:
%        Code           (String)  default='US'; 2-letter country/exchange code as returned by DataType='list' query
%        DataType       (String)  default='details';  one of 'details','list','symbols-list','symbol-changes'
%        FromDate       (Integer or String) default=[]; earliest data date; only relevant for DataType='symbol-changes'
%        ToDate         (Integer or String) default=[]; latest   data date; only relevant for DataType='symbol-changes'
%
%     Screener:
%        Filters        (String comma-delimited or cell-array) default=''; e.g., 'earnings_share>0' or {'earnings_share>0','name=B*'}
%        Signals        (String comma-delimited or cell-array) default=''; e.g., '200d_new_lo' or {'200d_new_lo','bookvalue_neg'}
%        SortField      (String)  default=''; e.g. 'market_capitalization' https://eodhd.com/financial-apis/stock-market-screener-api?ref=OX6LJ2BE
%        SortOrder      (String)  default='asc'; one of 'asc' (ascending) or 'desc' (descending)
%        Limit          (Integer) default=100; max number of items to return in results
%
%     ESG:
%        DataType       (String)  default='companies';  one of 'companies','countries','sectors','company','country','sector'
%        Country        (String)  default=''; e.g. 'US'; 2-letter country code as returned by DataType='countries' query
%        Company        (String)  default=''; e.g. 'AAPL'; company symbol as returned by DataType='companies' query
%        Sector         (String)  default=''; e.g. 'Airlines'; sector name as returned by DataType='sectors' query
%        Year           (Integer) default=(current year); e.g. 2025;  relevant only for country/company query, not sector
%        Frequency      (String)  default=''; one of 'FY','Q1','Q2','Q3','Q4'; only for country/company query, not sector
%                                 see https://eodhd.com/marketplace/investverte/esg_data/docs?ref=OX6LJ2BE
%
% THIS SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED
% TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT
% OR OTHERWISE, ARISING FROM, OUT OF, OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
%
% Copyright (c) Yair Altman, Octahedron Ltd. (info @ undocumentedmatlab.com)
%
% EODML webpage: https://UndocumentedMatlab.com/EODML
% EOD   webpage: https://eodhistoricaldata.com/r/?ref=OX6LJ2BE
