EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Regulator_Switching:LM2596S-5 U?
U 1 1 6058F530
P 3100 1650
F 0 "U?" H 3100 2017 50  0000 C CNN
F 1 "LM2596S-5" H 3100 1926 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:TO-263-5_TabPin3" H 3150 1400 50  0001 L CIN
F 3 "http://www.ti.com/lit/ds/symlink/lm2596.pdf" H 3100 1650 50  0001 C CNN
	1    3100 1650
	1    0    0    -1  
$EndComp
Wire Wire Line
	2600 1550 2050 1550
$Comp
L Device:D_Schottky D?
U 1 1 605930F8
P 3750 1950
F 0 "D?" V 3704 2030 50  0000 L CNN
F 1 "D_Schottky" V 3795 2030 50  0000 L CNN
F 2 "" H 3750 1950 50  0001 C CNN
F 3 "~" H 3750 1950 50  0001 C CNN
	1    3750 1950
	0    1    1    0   
$EndComp
$Comp
L pspice:INDUCTOR L?
U 1 1 60594D64
P 4150 1750
F 0 "L?" H 4150 1965 50  0000 C CNN
F 1 "33u" H 4150 1874 50  0000 C CNN
F 2 "" H 4150 1750 50  0001 C CNN
F 3 "~" H 4150 1750 50  0001 C CNN
	1    4150 1750
	1    0    0    -1  
$EndComp
Wire Wire Line
	3600 1750 3750 1750
Wire Wire Line
	3750 1800 3750 1750
Connection ~ 3750 1750
Wire Wire Line
	3750 1750 3900 1750
Wire Wire Line
	4400 1750 4600 1750
Wire Wire Line
	4600 1750 4600 1550
Wire Wire Line
	4600 1550 3600 1550
Wire Wire Line
	2600 1750 2450 1750
Wire Wire Line
	2450 1750 2450 2300
Wire Wire Line
	3100 1950 3100 2300
Wire Wire Line
	3750 2100 3750 2300
$Comp
L power:GND #PWR?
U 1 1 6059638C
P 3750 2300
F 0 "#PWR?" H 3750 2050 50  0001 C CNN
F 1 "GND" H 3755 2127 50  0000 C CNN
F 2 "" H 3750 2300 50  0001 C CNN
F 3 "" H 3750 2300 50  0001 C CNN
	1    3750 2300
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 60596A8F
P 3100 2300
F 0 "#PWR?" H 3100 2050 50  0001 C CNN
F 1 "GND" H 3105 2127 50  0000 C CNN
F 2 "" H 3100 2300 50  0001 C CNN
F 3 "" H 3100 2300 50  0001 C CNN
	1    3100 2300
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 60596F9D
P 2450 2300
F 0 "#PWR?" H 2450 2050 50  0001 C CNN
F 1 "GND" H 2455 2127 50  0000 C CNN
F 2 "" H 2450 2300 50  0001 C CNN
F 3 "" H 2450 2300 50  0001 C CNN
	1    2450 2300
	1    0    0    -1  
$EndComp
$Comp
L Device:C C?
U 1 1 60598E9E
P 4600 1950
F 0 "C?" H 4715 1996 50  0000 L CNN
F 1 "330u" H 4715 1905 50  0000 L CNN
F 2 "" H 4638 1800 50  0001 C CNN
F 3 "~" H 4600 1950 50  0001 C CNN
	1    4600 1950
	1    0    0    -1  
$EndComp
$Comp
L Device:C C?
U 1 1 60599319
P 2050 1950
F 0 "C?" H 2165 1996 50  0000 L CNN
F 1 "330u" H 2165 1905 50  0000 L CNN
F 2 "" H 2088 1800 50  0001 C CNN
F 3 "~" H 2050 1950 50  0001 C CNN
	1    2050 1950
	1    0    0    -1  
$EndComp
Wire Wire Line
	4600 1800 4600 1750
Connection ~ 4600 1750
Wire Wire Line
	4600 2100 4600 2300
$Comp
L power:GND #PWR?
U 1 1 6059AB5A
P 4600 2300
F 0 "#PWR?" H 4600 2050 50  0001 C CNN
F 1 "GND" H 4605 2127 50  0000 C CNN
F 2 "" H 4600 2300 50  0001 C CNN
F 3 "" H 4600 2300 50  0001 C CNN
	1    4600 2300
	1    0    0    -1  
$EndComp
Wire Wire Line
	2050 2100 2050 2300
$Comp
L power:GND #PWR?
U 1 1 6059B05B
P 2050 2300
F 0 "#PWR?" H 2050 2050 50  0001 C CNN
F 1 "GND" H 2055 2127 50  0000 C CNN
F 2 "" H 2050 2300 50  0001 C CNN
F 3 "" H 2050 2300 50  0001 C CNN
	1    2050 2300
	1    0    0    -1  
$EndComp
Wire Wire Line
	2050 1800 2050 1550
Connection ~ 2050 1550
$Comp
L Device:C C?
U 1 1 6059EE3E
P 1750 1950
F 0 "C?" H 1550 2000 50  0000 L CNN
F 1 "330u" H 1450 1900 50  0000 L CNN
F 2 "" H 1788 1800 50  0001 C CNN
F 3 "~" H 1750 1950 50  0001 C CNN
	1    1750 1950
	1    0    0    -1  
$EndComp
Wire Wire Line
	1750 1800 1750 1550
Connection ~ 1750 1550
Wire Wire Line
	1750 1550 2050 1550
Wire Wire Line
	1750 2100 1750 2300
$Comp
L power:GND #PWR?
U 1 1 6059F8E9
P 1750 2300
F 0 "#PWR?" H 1750 2050 50  0001 C CNN
F 1 "GND" H 1755 2127 50  0000 C CNN
F 2 "" H 1750 2300 50  0001 C CNN
F 3 "" H 1750 2300 50  0001 C CNN
	1    1750 2300
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR?
U 1 1 605A9B12
P 5050 1200
F 0 "#PWR?" H 5050 1050 50  0001 C CNN
F 1 "+5V" H 5065 1373 50  0000 C CNN
F 2 "" H 5050 1200 50  0001 C CNN
F 3 "" H 5050 1200 50  0001 C CNN
	1    5050 1200
	1    0    0    -1  
$EndComp
Wire Wire Line
	5050 1750 4600 1750
Wire Wire Line
	5050 1200 5050 1750
$Comp
L power:+12V #PWR?
U 1 1 605AB153
P 1350 1200
F 0 "#PWR?" H 1350 1050 50  0001 C CNN
F 1 "+12V" H 1365 1373 50  0000 C CNN
F 2 "" H 1350 1200 50  0001 C CNN
F 3 "" H 1350 1200 50  0001 C CNN
	1    1350 1200
	1    0    0    -1  
$EndComp
Wire Wire Line
	1350 1200 1350 1550
Wire Wire Line
	1350 1550 1750 1550
$EndSCHEMATC