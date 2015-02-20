/*****************************************************************************
 * aprs_wx_parse.c - Ssimple program to parse a WX related APRS message and
 * deliver the desired parameter. Of use in building embedded wx widgets.
 * The APRS WX formatted message to be parsed is sent to STDIN (most useful
 * used with a pipe). Which parameter to be parsed (can be a list) and printed
 * to STDOUT is provided as a command line arg input.
 *
 * Build with: 'gcc -o aprs_parse aprs_parse.c' -or- 'make'
 *
 * (C) 2015 KB4OID Labs, A division of Kodetroll Heavy Industries
 * Author: Kodetroll (KB4OID)
 * Date: January 2015
 * Usage:
 * 'aprs_parse -t' will parse the input and display the temperature.
 *
 * Where:
 * 		--help or -h	Show program help
 * 		--id or -i		Show Station id
 * 		--path or -p	Show APRS Reported Path
 * 		--time or -z	Show Time Stamp
 * 		--temp or -t	Show Temperature
 * 		--lat or -x		Show Station Position Report Latitude
 * 		--long or -y	Show Station Position Report Longitude
 * 		--speed or -s	Show Wind Speed
 * 		--gust or -g	Show Wind Gust
 * 		--rain or -r	Show Rainfall
 * 		--precip or -e	Show Precipitation
 *
 * 	See: http://www.aprs.net/vm/DOS/WX.HTM for more information
 *
 ******************************************************************************/

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <getopt.h>

/* Flag set by '--verbose'. */
static int verbose_flag;
static int debug_flag;

//char cli[130];
char inbuf[130];
char sId[10];
char sPath[120];
char sTime[20];
char sLat[20];
char sLong[20];
char sSpd[20];
char sGust[20];
char sTemp[20];
char sRain[20];
char sPrecip[20];

#define MAJOR "0"
#define MINOR "99"

void version(char * name);
void copyright(void);
void header(char * name);
void usage(char * name);

void version(char * name)
{
	printf("%s V%s.%s - An APRS WX Message Parser\n",name,MAJOR,MINOR);
}

void copyright(void)
{
	printf("(C) 2015 KB4OID Labs, A division of Kodetroll Heavy Industries");
}

void header(char * name)
{
	version(name);
	copyright();
}

void usage(char * name)
{
	header(name);
	printf("\n");
	printf("Usage:\n");
	printf("'%s -t' will parse the input and display the temperature.\n",name);
 	printf("\n");
 	printf("Where:\n");
 	printf("		--help or -h	Show program help\n");
 	printf("		--id or -i		Show Station id\n");
 	printf("		--path or -p	Show APRS Reported Path\n");
 	printf(" 		--time or -z	Show Time Stamp\n");
 	printf(" 		--temp or -t	Show Temperature\n");
 	printf(" 		--lat or -x		Show Station Position Report Latitude\n");
 	printf(" 		--long or -y	Show Station Position Report Longitude\n");
 	printf(" 		--speed or -s	Show Wind Speed\n");
 	printf(" 		--gust or -g	Show Wind Gust\n");
 	printf(" 		--rain or -r	Show Rainfall\n");
 	printf(" 		--precip or -e	Show Precipitation\n");
 	printf("\n");
 	printf(" 	See: http://www.aprs.net/vm/DOS/WX.HTM for more information\n");
}

// DW6196>APRS,TCPXX*,qAX,CWOP-7:@272051z3030.38N/08630.08W_315/003g007t067r000p00
int main(int argc, char * argv[])
{
	char * ptr;
	int c,i,p,z,t,x,y,s,g,r,e = 0;

	while (1)
    {
		static struct option long_options[] =
		{
			/* These options set a flag. */
			{"verbose", no_argument,       &verbose_flag, 1},
			{"quiet",   no_argument,       &verbose_flag, 0},
			{"debug",   no_argument,       &debug_flag,   1},
			{"nodebug", no_argument,       &debug_flag,   0},

			/* These options don't set a flag.
				We distinguish them by their indices. */
			{"id",      no_argument,       0, 'i'},
			{"path",    no_argument,       0, 'p'},
			{"time",    no_argument,       0, 'z'},
			{"temp",    no_argument,       0, 't'},
			{"lat",     no_argument,       0, 'x'},
			{"long",    no_argument,       0, 'y'},
			{"speed",   no_argument,       0, 's'},
			{"gust",    no_argument,       0, 'g'},
			{"rain",    no_argument,       0, 'r'},
			{"precip",  no_argument,       0, 'e'},
			{"version", no_argument,       0, 'v'},
			{"help",    no_argument,       0, 'h'},

			{"file",    required_argument, 0, 'f'},
			{0, 0, 0, 0}
		};

		/* getopt_long stores the option index here. */
		int option_index = 0;

		c = getopt_long (argc, argv, "ipztxysgrevhf:", long_options, &option_index);

		/* Detect the end of the options. */
		if (c == -1)
			break;

		switch (c)
		{
			case 0:
				/* If this option set a flag, do nothing else now. */
				if (long_options[option_index].flag != 0)
					break;
				printf ("option %s", long_options[option_index].name);
				if (optarg)
					printf (" with arg %s", optarg);
				printf ("\n");
				break;
			case 'h':
				// Print the help/usage info and exit
				usage(argv[0]);
				exit(0);
				break;

	// id 'i', path 'p', time 'z', temp 't', lat 'x', long 'y', speed 's', gust 'g', rain 'r', precip 'e'
			case 'i':
				i = 1;
				break;
			case 'p':
				p = 1;
				break;
			case 'z':
				z = 1;
				break;
			case 't':
				t = 1;
				break;
			case 'x':
				x = 1;
				break;
			case 'y':
				y = 1;
				break;
			case 's':
				s = 1;
				break;
			case 'g':
				g = 1;
				break;
			case 'r':
				r = 1;
				break;
			case 'e':
				e = 1;
				break;

			case 'v':
				version(argv[0]);
				exit(0);
				break;

			case 'f':
				printf ("option -f with value `%s'\n", optarg);
				break;

			case '?':
				/* getopt_long already printed an error message. */
				break;

			default:
				abort ();
		}
	}

	/* Instead of reporting '--verbose'
		and '--brief' as they are encountered,
		we report the final status resulting from them. */
	if (verbose_flag) {
		header(argv[0]);
	}

	if (verbose_flag)
		puts (" verbose flag is set ");

	if (debug_flag)
		puts (" debug flag is set ");

	scanf("%79s",inbuf);

	if (debug_flag)
		printf("inbuf: '%s'\n",inbuf);

	/* Print any remaining command line arguments (not options). */
	if (optind < argc)
	{
		printf ("non-option ARGV-elements: ");
		while (optind < argc)
			printf ("%s ", argv[optind++]);
		putchar ('\n');
	}

	ptr = strtok(inbuf,">");
	if (debug_flag)
		printf("ptr('>'): '%s'\n",ptr);
	sprintf(sId,"%s",ptr);
	ptr = strtok(NULL,":");
	if (debug_flag)
		printf("ptr(':'): '%s'\n",ptr);
	sprintf(sPath,"%s",ptr);
	ptr = strtok(NULL,"z");
	if (debug_flag)
		printf("ptr('z'): '%s'\n",ptr);
	sprintf(sTime,"%s",ptr);
	ptr = strtok(NULL,"/");
	if (debug_flag)
		printf("ptr('/'): '%s'\n",ptr);
	sprintf(sLat,"%s",ptr);
	ptr = strtok(NULL,"/");
	if (debug_flag)
		printf("ptr('/'): '%s'\n",ptr);
	sprintf(sLong,"%s",ptr);
	ptr = strtok(NULL,"g");
	if (debug_flag)
		printf("ptr('g'): '%s'\n",ptr);
	sprintf(sSpd,"%s",ptr);
	ptr = strtok(NULL,"t");
	if (debug_flag)
		printf("ptr('t'): '%s'\n",ptr);
	sprintf(sGust,"%s",ptr);
	ptr = strtok(NULL,"r");
	if (debug_flag)
		printf("ptr('r'): '%s'\n",ptr);
	sprintf(sTemp,"%s",ptr);
	ptr = strtok(NULL,"p");
	if (debug_flag)
		printf("ptr('p'): '%s'\n",ptr);
	sprintf(sRain,"%s",ptr);
	ptr = strtok(NULL,"");
	if (debug_flag)
		printf("ptr(''): '%s'\n",ptr);
	sprintf(sPrecip,"%s",ptr);

	if (i == 1)
		if (verbose_flag)
			printf("sId: '%s'\n",sId);
		else
			printf("%s\n",sId);
	if (p == 1)
		if (verbose_flag)
			printf("sPath: '%s'\n",sPath);
		else
			printf("%s\n",sPath);
	if (z == 1)
		if (verbose_flag)
			printf("sTime: '%s'\n",sTime);
		else
			printf("%s\n",sTime);
	if (x == 1)
		if (verbose_flag)
			printf("sLat: '%s'\n",sLat);
		else
			printf("%s\n",sLat);
	if (y == 1)
		if (verbose_flag)
			printf("sLong: '%s'\n",sLong);
		else
			printf("%s\n",sLong);
	if (s == 1)
		if (verbose_flag)
			printf("sSpd: '%s'\n",sSpd);
		else
			printf("%s\n",sSpd);
	if (t == 1)
		if (verbose_flag)
			printf("sTemp: '%s'\n",sTemp);
		else
			printf("%s\n",sTemp);
	if (g == 1)
		if (verbose_flag)
			printf("sGust: '%s'\n",sGust);
		else
			printf("%s\n",sGust);
	if (r == 1)
		if (verbose_flag)
			printf("sRain: '%s'\n",sRain);
		else
			printf("%s\n",sRain);
	if (e == 1)
		if (verbose_flag)
			printf("sPrecip: '%s'\n",sPrecip);
		else
			printf("%s\n",sPrecip);

	exit(0);
}

