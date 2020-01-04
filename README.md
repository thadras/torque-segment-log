# torque-segment-log
Script for [Torque Pro](https://play.google.com/store/apps/details?id=org.prowl.torque) app's CSV trackLog files.  Because the application can create files with thousands of lines of data, yet importing into Google Maps will only parse upto 2000 data lines. Hence, this script segements the CSV file into segments suitable for importing into a Google Map.  Note, the script uses the `find` command to locate any such trackLog CSV files that exist within the directory.  Such that one ought to avoid running the script multiple times within the same directory.  Nonetheless, the original CSV files are left unmodified.

A typical workflow for using the script
1. Export Logs from Torque Pro to Google Drive
2. Download ZIP files from Google Drive
3. Extract the ZIP files to get a set of trackLog\*.csv files
4. Run the `segment.sh` script
5. Create a new Google Map by using the Menu button
* Select **Your places**, then click the `MAPS` tab
* Click the `CREATE MAP` button
* Then Import each segmented CSV file into its own layer

As example, a [Map](https://drive.google.com/open?id=1ducy-lCxYeF5YNEDQxqLN0Ntts7C0L_N&usp=sharing) genereated from importing the segmented CSV files.

