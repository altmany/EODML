EODML
=====

A toolbox for connecting MATLAB to EODHistoricalData, to retrieve financial market data.

![EODML](https://undocumentedmatlab.com/images/EODML.png)

### Table of contents
 * [Overview](#overview)
 * [Main functionalities](#main-functionalities)
 * [Additional program features](#additional-program-features)
 * [Requirements](#requirements)
 * [Compatibility](#compatibility)
 * [Installation](#installation)
 * [Disclaimer](#disclaimer)
 * [Contact us](#contact-us)

### Overview
EODML is a Matlab connector to EODHistoricalData, enabling users to leverage Matlab’s superior analysis and visualization capabilities, with EODHistoricalData’s financial data-feed. EODML can be used for both automated algo-trading and selective manual trading, as well as continuous market data feed. EODML provides a reliable, easy-to-use Matlab interface to EODHistoricalData that works right out of the box, and was optimized for reliability, stability and compatibility. 

This downloaded version is fully-functional and free for a full year. The free license has some restrictions on the query rate and does not include support. A paid license that enables increased query rate and includes support can be purchased on [EODML's webpage](https://undocumentedmatlab.com/EODML#Pricing).

### Main functionalities
Simple Matlab commands fetch market data from EODHistoricalData:
 * Historic, intra-day and live (delayed) market data – OHLC bars, adjusted close and volume data
 * Historic and upcoming splits, dividends, IPO, and earning events
 * Historic basic technicals – SMA, EMA, WMA, RSI, AvgVol
 * Historic short interests
 * Symbols lookup – all listed symbols in a certain exchange, or all exchanges that list a certain symbol
 * Option chains lookup – contract info, in/out of money, trade info, Greeks, implied volatility; grouped by expiration date
 * Fundamental info – corporate info, shares stats or bond data, technicals, split/dividend events, ESG scores, earnings, financials
 * Combine all of the above for a full-fledged end-to-end automated trading system using plain Matlab
 
### Additional program features
 * **Full solution** – EODML provides easy-to-use access to EODHistoricalData’s entire data-set within Matlab. Only the core Matlab is required – no additional toolbox or component is required.
 * **Stability** – EODML has been extensively tested. It is rock solid.
 * **Easy to use** – Users can access EODHistoricalData’s data by simple Matlab commands, without need for any Matlab programming. EODML simplifies the EODHistoricalData API in a very easy-to-use yet powerful interface that can be used by any Matlab user, novice or advanced.
 * **Novice and advanced users** – Users can use easy-to-use Matlab commands, to access EODHistoricalData’s data. Minimal or no programming is required to access this data.
 * **Compatibility** – EODML works on all platforms where Matlab runs (Windows, Mac OS, Linux), using practically any recent Matlab release.
 * **Security** – EODML does not transmit any information externally except to EODHistoricalData, so your trading information are as safe as your own computer.
 * **Development** – EODML was developed by an acknowledged Matlab expert, who wrote the reference textbooks on Matlab-Java connectivity and Matlab performance, as well as the acclaimed [IB-Matlab connector](https://undocumentedmatlab.com/IB-Matlab) (Matlab connector to Interactive Brokers) and [IQML - Matlab connector to IQFeed](https://undocumentedmatlab.com/IQML). EODML is continuously improved and maintained.
 * **Support** – Custom development and ongoing support is available directly from the developer, with extremely fast response times.
 * **Backtesting** – EODML does not include backtesting functionality. EODML’s author (Yair Altman) has extensive experience in developing complete backtesting and real-time trading applications. Yair will be happy to either develop a new application based on your specifications, or to integrate EODML into an existing application, under a consulting contract.

### Requirements
EODML is a Matlab connector to EODHistoricalData, so it naturally needs the user to have both
 * a locally-installed Matlab
 * an EODHistoricalData token - you can get a free token [here](https://eodhistoricaldata.com/r/?ref=OX6LJ2BE&utm_source=referral&utm_medium=link&utm_campaign=EODML)

### Compatibility
 * Platforms: EODML works on all platforms on which EODHistoricalData runs: Windows, Mac OS, Linux.
 * Matlab: EODML works on all Matlab releases since 2008, including the latest release (R2020a).

### Installation
 1. Download or clone EODML into a local folder on your computer (preferably a separate EODML folder)
 2. Add the local folder to your Matlab path using the path tool (in the Matlab Desktop’s toolstrip, click HOME / ENVIRONMENT / Set path… and save). The folder needs to be in your Matlab path whenever you run EODML.
 3. You can now run EODML within Matlab. To verify that EODML is properly installed, run the following command in your Matlab console:
```Matlab
>> limits = EODML('limits')
```
 4. Read the usage examples on https://undocumentedmatlab.com/EODML/usage-examples
 
### Disclaimer
THIS SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES, LOSS OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

(A detailed disclaimer is available in [EODML’s License Agreement](https://undocumentedmatlab.com/files/EODML/EODML_License_Agreement.pdf), as well as in the separate [DISCLAIMER](https://github.com/altmany/EODML/blob/master/DISCLAIMER) file)

### Contact us
For additional information about EODML, please visit the product's webpage (https://undocumentedmatlab.com/EODML).

If you have any question or feedback, or need professional assistance in integrating EODML into your trading system, please email us (info@UndocumentedMatlab.com) and we will be happy to help.

![](https://undocumentedmatlab.com/images/choose_any_5_animated.gif)
