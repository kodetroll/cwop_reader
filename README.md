                           cwop_reader 

A simple collection of bash scripts and one c program that will fetch 
(over the internet) WX related information provided by the NWS Civilian 
Weather Observer Program (CWOP). 

This data is in the form of APRS WX formatted data from the wxqa.com search 
engine. Scripts found here can be used to retrieve one specific parameter, 
i.e. temperature, from the stored data of the specified weather station. 
It does this by calling a bash script that uses curl to fetch the current 
weather data (in html page format) from the wxqa search engine for the 
specified weather station and store to a temporary file. The fetch script 
then greps the APRS WX formatted packet data from the stored page and
stores this in a second temporary file and exits. The calling script can 
then use aprs_wx_parse (a C program whose source is provided here) to parse 
the WX formatted APRS message and deliver the desired parameter (based on 
which script has actually been called). These tools are of use in building 
embedded WX widgets where you might have a need to fetch the temperature, 
rain fall, or wind speed from a specified CWOP WX station, perhaps near 
your location.

To build:

do a 'git clone https://github.com/kodetroll/cwop_reader.git' to get the
project onto your machine. CD into the cwop_reader folder. Type 'make'
to compile the aprs packet parser app. At this point, you should figure
out the station id of the CWOP WX station you would like to use as a source
for your weather data. It is unlikely that the default provided will be 
correct for your use. Please refer to the howto-station-id.txt text file 
for instructions on determining the station ID of your desired CWOP WX 
station using the NWS NOAA mesonet web site. You can then use the wxqa.com
website to query the data for your selected station using the CWOP Search
Tool. The 'local.cfg' file (which is a Bash script) is where the station id
and all other tool suite defaults are kept. Edit those values to suit your
end use case. You should now be able to run any of the .sh scripts, 
e.g. type './getTemp.sh' at the command line to get the current temp from
your selected CWOP WX station.

 * See: http://wxqa.com/ for more info on the wxqa search engine.

 * See: http://www.aprs.net/vm/DOS/WX.HTM for more information on APRS WX
   formatted packets.

 * Note: APRS is registered trademark of Bob Bruniga, WB4APR, please
   refer to his website http://www.aprs.org/ for more information on 
   the APRS protocol and general information on the formatting of APRS 
   data packets.
