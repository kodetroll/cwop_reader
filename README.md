cwop_reader
========== 

A simple collection of bash scripts and one c program that will fetch 
(over the internet) WX related information provided by the NWS Civilian 
Weather Observer Program (CWOP). 

INTRODUCTION
------------------
This tool suite uses data in the form of APRS WX formatted data from the 
wxqa.com search engine. Bash scripts and c programs found here can be used 
to retrieve one specific parameter, i.e. temperature, from the stored data 
of the specified weather station. 

It does this by calling a bash script that uses curl to fetch the current 
weather data (in html page format) from the wxqa search engine for the 
specified weather station and store it to a temporary file. The fetch 
function (bash script) then greps the APRS WX formatted packet data from 
the stored page and stores this in a second temporary file. The called script 
can then use aprs_wx_parse (a C program, whose source is provided here) to 
parse the WX formatted APRS message and deliver the desired parameter (based 
on which script has actually been called). These tools are of use in building 
embedded WX widgets where you might have a need to fetch the temperature, 
rain fall, or wind speed from a specified CWOP WX station, perhaps near 
your location.

INSTALLING
----------------
See INSTALL for instructions on how to build and install the cwop-reader
tool suite.

CONFIGURING
---------------
At this point, you should figure out the station id of the CWOP WX station 
you would like to use as a source for your weather data. It is unlikely that 
the default provided will be correct for your use. Please refer to the 
HOWTO-STATION-ID text file for instructions on determining the station 
ID of your desired CWOP WX station using the NWS NOAA mesonet web site. You 
can then use the wxqa.com website to query the data for your selected station 
using the CWOP Search Tool. 

The 'cwop-reader.conf' file (which is a Bash script, itself) is where the 
station id and all other tool suite defaults are kept. This will be in the
local git repo folder or in /etc/cwop-reader if a 'make install' has been
performed. Edit those values to suit your end use case. You should now be 
able to run any of the *.sh scripts, e.g. type './getTemp.sh' at the command 
line to get the current temp from your selected CWOP WX station.

NOTES

 * See: http://wxqa.com/ for more info on the wxqa search engine.

 * See: http://www.aprs.net/vm/DOS/WX.HTM for more information on APRS WX
   formatted packets.

 * Note: APRS is registered trademark of Bob Bruniga, WB4APR, please
   refer to his website http://www.aprs.org/ for more information on 
   the APRS protocol and general information on the formatting of APRS 
   data packets.

 * See LICENSE for whatever license info may be provided
