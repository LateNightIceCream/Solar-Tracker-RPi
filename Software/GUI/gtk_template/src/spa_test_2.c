

/* ///////////////////////////////////////////// */
/* //          SPA TESTER for SPA.C           // */
/* //                                         // */
/* //      Solar Position Algorithm (SPA)     // */
/* //                   for                   // */
/* //        Solar Radiation Application      // */
/* //                                         // */
/* //             August 12, 2004             // */
/* //                                         // */
/* //   Filename: SPA_TESTER.C                // */
/* //                                         // */
/* //   Afshin Michael Andreas                // */
/* //   afshin_andreas@nrel.gov (303)384-6383 // */
/* //                                         // */
/* //   Measurement & Instrumentation Team    // */
/* //   Solar Radiation Research Laboratory   // */
/* //   National Renewable Energy Laboratory  // */
/* //   1617 Cole Blvd, Golden, CO 80401      // */
/* ///////////////////////////////////////////// */

/* ///////////////////////////////////////////// */
/* // This sample program shows how to use    // */
/* //    the SPA.C code.                      // */
/* ///////////////////////////////////////////// */

/* #include <stdio.h> */
/* #include <time.h> */
/* #include <unistd.h> */
/* #include "spa.h"  //include the SPA header file */

/* int main (int argc, char *argv[]) */
/* { */
/*     spa_data spa;  //declare the SPA structure */
/*     int result; */
/*     time_t t; */
/*     struct tm tstruct; */

/*     while(1) { */
/*       time(&t); */
/*     tstruct = *gmtime(&t); */
/*     //float min, sec; */

/*     //enter required input values into SPA structure */

/*     spa.year          = tstruct.tm_year+1900; */
/*     //printf("%d\n",spa.year ); */
/*     spa.month         = tstruct.tm_mon+1; */
/*     //printf("%d\n",spa.month ); */
/*     spa.day           = tstruct.tm_mday; */
/*     //printf("%d\n",spa.day ); */
/*     spa.hour          = tstruct.tm_hour+2; */
/*     //printf("%d\n",spa.hour ); */
/*     spa.minute        = tstruct.tm_min; */
/*     //printf("%d\n",spa.minute ); */
/*     spa.second        = tstruct.tm_sec; */
/*     //printf("%d\n",tstruct.tm_sec ); */
/*     spa.timezone      = 2.0; */
/*     spa.delta_ut1     = 0; */
/*     spa.delta_t       = 0; //67 */
/*     spa.longitude     = 11.462020; */
/*     spa.latitude      = 53.888210; */
/*     spa.elevation     = 7; */
/*     spa.pressure      = 500; // was 820 */
/*     spa.temperature   = 10; */
/*     spa.slope         = 0; */
/*     spa.azm_rotation  = 0; */
/*     spa.atmos_refract = 0.5667; */
/*     spa.function      = SPA_ALL; */

/*     //call the SPA calculate function and pass the SPA structure */

/*     result = spa_calculate(&spa); */


/*   //printf("Enter hour: "); */
/*   //scanf("%u",&spa.hour); */

/*   //printf("Enter minute: "); */
/*   //scanf("%u",&spa.minute); */
/*   //result = spa_calculate(&spa); */

/*     if (result == 0)  //check for SPA errors */
/*     { */
/*         //display the results inside the SPA structure */
/*         printf("--------------------------------\n"); */
/*         printf("Month: %d\n",spa.month ); */
/*         printf("Day: %d\n",spa.day ); */
/*         printf("Hour: %d\n",spa.hour ); */
/*         printf("Minute: %d\n",spa.minute ); */
/*         printf("Second: %d\n",tstruct.tm_sec ); */
/*         printf("Zenith:        %.6f degrees\n",90-spa.zenith); */
/*         printf("Azimuth:       %.6f degrees\n",spa.azimuth); */
/*         printf("--------------------------------\n"); */

/*     } else printf("SPA Error Code: %d\n", result); */
/*     sleep(1); */
/* } */
/*     return 0; */
/* } */

/* ///////////////////////////////////////////// */
/* // The output of this program should be: */
/* // */
/* //Julian Day:    2452930.312847 */
/* //L:             2.401826e+01 degrees */
/* //B:             -1.011219e-04 degrees */
/* //R:             0.996542 AU */
/* //H:             11.105902 degrees */
/* //Delta Psi:     -3.998404e-03 degrees */
/* //Delta Epsilon: 1.666568e-03 degrees */
/* //Epsilon:       23.440465 degrees */
/* //Zenith:        50.111622 degrees */
/* //Azimuth:       194.340241 degrees */
/* //Incidence:     25.187000 degrees */
/* //Sunrise:       06:12:43 Local Time */
/* //Sunset:        17:20:19 Local Time */
/* // */
/* ///////////////////////////////////////////// */
