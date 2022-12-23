function [data, errMsg] = EODML(action, parameters, varargin) %#ok
%EODML - Get historic or real-time market data from eodhistoricaldata.com
%
% Syntax: [data, errMsg] = EODML(action, paramName1,paramValue1, paramName2,paramValue2, ...)
%
% Inputs:
%
%   action (String) - one of: license,limits,version,update,revert,doc,prices,fundamentals,technicals,options,dividends,splits,earnings,shorts,ipo,lookup
%
%   parameters - Matlab struct or XLS filename or parameter name/value pairs with the following optional parameters:
%
%     General:
%        API_Token      (String)  default=''; provided to you by eodhistoricaldata.com
%        Timeout        (Number)  default=5; max # of seconds to wait for a query response (0=infinite)
%        UseParallel    (Logical) default=0 or false; if true or 1, the query will be parallelized (Analyst/Pro license only)
%        Debug          (Logical) default=0 or false; if true or 1, extra data will be displayed in Matlab console
%        RaiseErrorMsgs (Logical) default=1 or true; if false or 0, errors set the errMsg output arg, rather than raise an error
%
%     Prices:
%        DataType       (String)  default='day'; one of 'day','week','month','live'
%        Symbols        (String :-delimited or cell-array) default=''; e.g., 'IBM' or 'IBM:GOOG' or {'IBM','GOOG'}
%        SecType        (String)  default='equity'; one of 'equity','index','bond'
%        Order          (String)  default='asc'; either 'asc' or 'desc'
%        FromDate       (Integer or String) default=[]; earliest data date
%        ToDate         (Integer or String) default=[]; latest data date
%        Interval       (String)  default='5m'; one of '5m','1m','1hr'
%
%     Fundamentals:
%        DataType       (String)  default='standard'; one of 'standard','bulk','insiderTrading','marketCap'
%        Symbols        (String :-delimited or cell-array) default=''; e.g., 'IBM' or 'IBM:GOOG' or {'IBM','GOOG'}
%        SecType        (String)  default='equity'; one of 'equity','index','bond'
%        FromDate       (Integer or String) default=[]; earliest data date
%        ToDate         (Integer or String) default=[]; latest data date
%
%     Splits,Dividends,Earnings,Shorts:
%        DataType       (String)  default='standard'; one of 'standard','trends' (trends is only relevant to earnings)
%        Symbols        (String :-delimited or cell-array) default=''; e.g., 'IBM' or 'IBM:GOOG' or {'IBM','GOOG'}
%        FromDate       (Integer or String) default=[]; earliest data date
%        ToDate         (Integer or String) default=[]; latest data date
%
%     Technicals:
%        Symbols         (String :-delimited or cell-array) default=''; e.g., 'IBM' or 'IBM:GOOG' or {'IBM','GOOG'}
%        FromDate        (Integer or String) default=[]; earliest data date
%        ToDate          (Integer or String) default=[]; latest data date
%        Function        (String)  default='SMA'; one of 'SMA','EMA','WMA','RSI','StdDev','AvgVol',
%                                  'Volatility','SplitAdjusted','AvgVolCcy','Stochastic','StochRSI',
%                                  'Slope','DMI','ADX','MACD','ATR','CCI','SAR','BBands'
%        Period          (Number)  default=50; number of data points used to calculate the function (2-100k)
%        FastPeriod      (Number)  default=12; used by MACD
%        SlowPeriod      (Number)  default=26; used by MACD
%        SignalPeriod    (Number)  default=9;  used by MACD
%        FastKPeriod     (Number)  default=14; used by Stochastic, StochRSI
%        FastDPeriod     (Number)  default=14; used by StochRSI
%        SlowKPeriod     (Number)  default=3;  used by Stochastic
%        SlowDPeriod     (Number)  default=3;  used by Stochastic
%        AdjustDividends (Logical) default=1 or true; if false or 0, close prices are only adjusted for splits, not dividends
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
%        Symbol         (String) default='';  e.g., 'IBM'
%        DataType       (String) default='symbol';  either 'symbol' or 'exchange'
%
% Refer to the User Guide for detailed documentation and usage examples.
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
