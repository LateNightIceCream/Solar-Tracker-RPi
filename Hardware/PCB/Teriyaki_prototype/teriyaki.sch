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
Wire Notes Line
	450  3100 11100 3100
Text Notes 9050 600  0    50   ~ 0
Power LEDs
$Comp
L Connector:TestPoint TP1
U 1 1 607096F9
P 9750 2550
F 0 "TP1" H 9808 2668 50  0000 L CNN
F 1 "TestPoint" H 9808 2577 50  0000 L CNN
F 2 "TestPoint:TestPoint_Loop_D3.80mm_Drill2.0mm" H 9950 2550 50  0001 C CNN
F 3 "~" H 9950 2550 50  0001 C CNN
	1    9750 2550
	-1   0    0    1   
$EndComp
$Comp
L power:+3V3 #PWR036
U 1 1 60710449
P 9750 2550
F 0 "#PWR036" H 9750 2400 50  0001 C CNN
F 1 "+3V3" H 9765 2723 50  0000 C CNN
F 2 "" H 9750 2550 50  0001 C CNN
F 3 "" H 9750 2550 50  0001 C CNN
	1    9750 2550
	1    0    0    -1  
$EndComp
Wire Notes Line
	9000 500  9000 3100
$Comp
L power:+3V3 #PWR034
U 1 1 606F8A18
P 9750 1250
F 0 "#PWR034" H 9750 1100 50  0001 C CNN
F 1 "+3V3" H 9765 1423 50  0000 C CNN
F 2 "" H 9750 1250 50  0001 C CNN
F 3 "" H 9750 1250 50  0001 C CNN
	1    9750 1250
	1    0    0    -1  
$EndComp
Wire Wire Line
	9750 1250 9750 1300
Wire Wire Line
	9750 1600 9750 1650
Wire Wire Line
	9750 1950 9750 2000
$Comp
L power:GND #PWR035
U 1 1 606F681E
P 9750 2000
F 0 "#PWR035" H 9750 1750 50  0001 C CNN
F 1 "GND" H 9755 1827 50  0000 C CNN
F 2 "" H 9750 2000 50  0001 C CNN
F 3 "" H 9750 2000 50  0001 C CNN
	1    9750 2000
	1    0    0    -1  
$EndComp
$Comp
L Device:R R16
U 1 1 606F6818
P 9750 1800
F 0 "R16" H 9680 1846 50  0000 R CNN
F 1 "1k2" H 9680 1755 50  0000 R CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 9680 1800 50  0001 C CNN
F 3 "~" H 9750 1800 50  0001 C CNN
F 4 "C17379" H 9750 1800 50  0001 C CNN "LCSC Part #"
	1    9750 1800
	-1   0    0    -1  
$EndComp
$Comp
L Device:LED LED_5V1
U 1 1 607422CB
P 10550 1450
F 0 "LED_5V1" H 10700 1600 50  0000 R CNN
F 1 "RED" V 10498 1332 50  0000 R CNN
F 2 "LED_SMD:LED_0805_2012Metric" H 10550 1450 50  0001 C CNN
F 3 "~" H 10550 1450 50  0001 C CNN
F 4 "C84256" H 10550 1450 50  0001 C CNN "LCSC Part #"
	1    10550 1450
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R17
U 1 1 607422D1
P 10550 1800
F 0 "R17" H 10480 1846 50  0000 R CNN
F 1 "3k" H 10480 1755 50  0000 R CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 10480 1800 50  0001 C CNN
F 3 "~" H 10550 1800 50  0001 C CNN
F 4 "C17661" H 10550 1800 50  0001 C CNN "LCSC Part #"
	1    10550 1800
	-1   0    0    -1  
$EndComp
$Comp
L power:GND #PWR038
U 1 1 607422D7
P 10550 2000
F 0 "#PWR038" H 10550 1750 50  0001 C CNN
F 1 "GND" H 10555 1827 50  0000 C CNN
F 2 "" H 10550 2000 50  0001 C CNN
F 3 "" H 10550 2000 50  0001 C CNN
	1    10550 2000
	1    0    0    -1  
$EndComp
Wire Wire Line
	10550 1950 10550 2000
Wire Wire Line
	10550 1600 10550 1650
Wire Wire Line
	10550 1250 10550 1300
$Comp
L Connector:TestPoint TP2
U 1 1 607422EC
P 10550 2550
F 0 "TP2" H 10608 2668 50  0000 L CNN
F 1 "TestPoint" H 10608 2577 50  0000 L CNN
F 2 "TestPoint:TestPoint_Loop_D3.80mm_Drill2.0mm" H 10750 2550 50  0001 C CNN
F 3 "~" H 10750 2550 50  0001 C CNN
	1    10550 2550
	-1   0    0    1   
$EndComp
Text Notes 9050 700  0    50   ~ 0
and supply test points
$Comp
L Device:LED LED_3V31
U 1 1 606F6812
P 9750 1450
F 0 "LED_3V31" H 9900 1600 50  0000 R CNN
F 1 "RED" V 9700 1350 50  0000 R CNN
F 2 "LED_SMD:LED_0805_2012Metric" H 9750 1450 50  0001 C CNN
F 3 "~" H 9750 1450 50  0001 C CNN
F 4 "C84256" H 9750 1450 50  0001 C CNN "LCSC Part #"
	1    9750 1450
	0    -1   -1   0   
$EndComp
Text Notes 10450 1000 0    39   ~ 0
µUSB in
Text Notes 9550 1000 0    39   ~ 0
STM8 Supply
$Comp
L Connector:TestPoint TP_RX1
U 1 1 608A00CF
P 10550 4050
F 0 "TP_RX1" H 10608 4168 50  0000 L CNN
F 1 "TestPoint" H 10608 4077 50  0000 L CNN
F 2 "TestPoint:TestPoint_Loop_D3.80mm_Drill2.0mm" H 10750 4050 50  0001 C CNN
F 3 "~" H 10750 4050 50  0001 C CNN
	1    10550 4050
	1    0    0    -1  
$EndComp
$Comp
L Connector:TestPoint TP_TX1
U 1 1 608A035D
P 10550 4350
F 0 "TP_TX1" H 10608 4468 50  0000 L CNN
F 1 "TestPoint" H 10608 4377 50  0000 L CNN
F 2 "TestPoint:TestPoint_Loop_D3.80mm_Drill2.0mm" H 10750 4350 50  0001 C CNN
F 3 "~" H 10750 4350 50  0001 C CNN
	1    10550 4350
	1    0    0    -1  
$EndComp
Text GLabel 10450 4050 0    50   Input ~ 0
STM8_RX
Text GLabel 10450 4350 0    50   Input ~ 0
STM8_TX
Wire Wire Line
	10450 4350 10550 4350
Wire Wire Line
	10450 4050 10550 4050
NoConn ~ 2000 6600
Wire Wire Line
	1900 5300 1900 5400
Wire Wire Line
	1900 5700 2000 5700
Wire Wire Line
	1900 5600 1900 5700
$Comp
L power:GND #PWR010
U 1 1 608D656F
P 1900 5300
F 0 "#PWR010" H 1900 5050 50  0001 C CNN
F 1 "GND" H 1905 5127 50  0000 C CNN
F 2 "" H 1900 5300 50  0001 C CNN
F 3 "" H 1900 5300 50  0001 C CNN
	1    1900 5300
	-1   0    0    1   
$EndComp
$Comp
L Device:C_Small C6
U 1 1 608CB689
P 1900 5500
F 0 "C6" H 1808 5454 50  0000 R CNN
F 1 "100n" H 2100 5450 50  0000 R CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 1900 5500 50  0001 C CNN
F 3 "~" H 1900 5500 50  0001 C CNN
F 4 "C49678" H 1900 5500 50  0001 C CNN "LCSC Part #"
	1    1900 5500
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR014
U 1 1 60897B7E
P 2800 7550
F 0 "#PWR014" H 2800 7300 50  0001 C CNN
F 1 "GND" H 2805 7377 50  0000 C CNN
F 2 "" H 2800 7550 50  0001 C CNN
F 3 "" H 2800 7550 50  0001 C CNN
	1    2800 7550
	1    0    0    -1  
$EndComp
Wire Wire Line
	2800 7450 2800 7550
Wire Wire Line
	2600 7450 2800 7450
Wire Wire Line
	3000 7450 3000 7400
Wire Wire Line
	2900 7450 3000 7450
Wire Wire Line
	2900 7450 2900 7400
Connection ~ 2900 7450
Connection ~ 2800 7450
Wire Wire Line
	2800 7450 2900 7450
Wire Wire Line
	2800 7450 2800 7400
Wire Wire Line
	2600 7400 2600 7450
$Comp
L Interface_USB:FT232RL U3
U 1 1 608586C2
P 2800 6400
F 0 "U3" H 3250 7400 50  0000 C CNN
F 1 "FT232RL" H 3250 7300 50  0000 C CNN
F 2 "Package_SO:SSOP-28_5.3x10.2mm_P0.65mm" H 3900 5500 50  0001 C CNN
F 3 "https://www.ftdichip.com/Support/Documents/DataSheets/ICs/DS_FT232R.pdf" H 2800 6400 50  0001 C CNN
F 4 " C8690" H 2800 6400 50  0001 C CNN "LCSC Part #"
	1    2800 6400
	1    0    0    -1  
$EndComp
Wire Wire Line
	2700 5400 2700 5350
Wire Wire Line
	2900 5350 2900 5400
NoConn ~ 3600 5900
NoConn ~ 3600 6000
NoConn ~ 3600 6100
NoConn ~ 3600 6200
NoConn ~ 3600 6300
NoConn ~ 3600 6400
Text GLabel 2000 6000 0    50   Input ~ 0
USB_D+
Text GLabel 2000 6100 0    50   Input ~ 0
USB_D-
NoConn ~ 3600 7100
NoConn ~ 3600 7000
NoConn ~ 3600 6900
Text GLabel 4100 5800 2    50   Input ~ 0
STM8_TX
Text GLabel 4100 5700 2    50   Input ~ 0
STM8_RX
Text GLabel 1350 4000 2    50   Input ~ 0
USB_CON_D-
Text GLabel 1350 3900 2    50   Input ~ 0
USB_CON_D+
NoConn ~ 1350 4100
NoConn ~ 950  4300
Wire Wire Line
	1050 4300 1050 4400
$Comp
L power:GND #PWR05
U 1 1 6081B392
P 1050 4400
F 0 "#PWR05" H 1050 4150 50  0001 C CNN
F 1 "GND" H 1055 4227 50  0000 C CNN
F 2 "" H 1050 4400 50  0001 C CNN
F 3 "" H 1050 4400 50  0001 C CNN
	1    1050 4400
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR08
U 1 1 608128BA
P 1550 3700
F 0 "#PWR08" H 1550 3550 50  0001 C CNN
F 1 "+5V" H 1565 3873 50  0000 C CNN
F 2 "" H 1550 3700 50  0001 C CNN
F 3 "" H 1550 3700 50  0001 C CNN
	1    1550 3700
	1    0    0    -1  
$EndComp
$Comp
L Connector:USB_B_Micro J1
U 1 1 60723E35
P 1050 3900
F 0 "J1" H 1050 4350 50  0000 C CNN
F 1 "USB_B_Micro" H 1050 4250 50  0000 C CNN
F 2 "Connector_USB:USB_Micro-AB_Molex_47590-0001" H 1200 3850 50  0001 C CNN
F 3 "~" H 1200 3850 50  0001 C CNN
	1    1050 3900
	1    0    0    -1  
$EndComp
NoConn ~ 2000 6800
Wire Wire Line
	2000 7100 1900 7100
Wire Wire Line
	1900 7100 1900 7200
$Comp
L power:GND #PWR011
U 1 1 6067EA81
P 1900 7200
F 0 "#PWR011" H 1900 6950 50  0001 C CNN
F 1 "GND" H 1905 7027 50  0000 C CNN
F 2 "" H 1900 7200 50  0001 C CNN
F 3 "" H 1900 7200 50  0001 C CNN
	1    1900 7200
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR01
U 1 1 6084A9CB
P 600 1100
F 0 "#PWR01" H 600 950 50  0001 C CNN
F 1 "+5V" H 615 1273 50  0000 C CNN
F 2 "" H 600 1100 50  0001 C CNN
F 3 "" H 600 1100 50  0001 C CNN
	1    600  1100
	1    0    0    -1  
$EndComp
Wire Wire Line
	600  1100 600  1250
$Comp
L MCU_ST_STM8:STM8L051F3P U2
U 1 1 60645F8E
P 8050 5200
F 0 "U2" H 8250 4300 50  0000 C CNN
F 1 "STM8L051F3P6" H 8450 4400 50  0000 C CNN
F 2 "Package_SO:TSSOP-20_4.4x6.5mm_P0.65mm" H 8100 6200 50  0001 L CNN
F 3 "http://www.st.com/st-web-ui/static/active/en/resource/technical/document/datasheet/DM00060484.pdf" H 8050 4800 50  0001 C CNN
F 4 "C18088" H 8050 5200 50  0001 C CNN "LCSC Part #"
	1    8050 5200
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0106
U 1 1 60647738
P 8050 6100
F 0 "#PWR0106" H 8050 5850 50  0001 C CNN
F 1 "GND" H 8055 5927 50  0000 C CNN
F 2 "" H 8050 6100 50  0001 C CNN
F 3 "" H 8050 6100 50  0001 C CNN
	1    8050 6100
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR0107
U 1 1 6064942E
P 8050 4300
F 0 "#PWR0107" H 8050 4150 50  0001 C CNN
F 1 "+3.3V" H 8065 4473 50  0000 C CNN
F 2 "" H 8050 4300 50  0001 C CNN
F 3 "" H 8050 4300 50  0001 C CNN
	1    8050 4300
	1    0    0    -1  
$EndComp
Text GLabel 7450 4800 0    50   Input ~ 0
RCC_OSC_IN
Text GLabel 7450 4900 0    50   Input ~ 0
RCC_OSC_OUT
Text GLabel 8650 5200 2    50   Input ~ 0
TIM3_CH2
Text GLabel 7450 5100 0    50   Input ~ 0
TIM2_CH1
Text GLabel 8650 4700 2    50   Input ~ 0
I2C_SCL
Text GLabel 8650 4600 2    50   Input ~ 0
I2C_SDA
Text GLabel 8650 4900 2    50   Input ~ 0
STM8_TX
Text GLabel 8650 5000 2    50   Input ~ 0
STM8_RX
Text GLabel 7450 5200 0    50   Input ~ 0
TIM3_CH1
Text GLabel 7450 5300 0    50   Input ~ 0
TIM2_CH2
Text GLabel 7450 5400 0    50   Input ~ 0
GPIO_PB3
Text GLabel 7450 5500 0    50   Input ~ 0
GPIO_PB4
Text GLabel 7450 5600 0    50   Input ~ 0
GPIO_PB5
Text GLabel 7450 5700 0    50   Input ~ 0
GPIO_PB6
Text GLabel 7450 5800 0    50   Input ~ 0
GPIO_PB7
Text GLabel 7450 4700 0    50   Input ~ 0
STM8_NRST
Text GLabel 7450 4600 0    50   Input ~ 0
STM8_SWIM
Text GLabel 8650 4800 2    50   Input ~ 0
GPIO_PC4
$Comp
L Device:C_Small C11
U 1 1 606B52E2
P 7150 3900
F 0 "C11" H 7242 3946 50  0000 L CNN
F 1 "1u" H 7242 3855 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 7150 3900 50  0001 C CNN
F 3 "~" H 7150 3900 50  0001 C CNN
F 4 "C15849" H 7150 3900 50  0001 C CNN "LCSC Part #"
	1    7150 3900
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C12
U 1 1 606B54D5
P 7600 3900
F 0 "C12" H 7692 3946 50  0000 L CNN
F 1 "10n" H 7692 3855 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 7600 3900 50  0001 C CNN
F 3 "~" H 7600 3900 50  0001 C CNN
F 4 "C57112" H 7600 3900 50  0001 C CNN "LCSC Part #"
	1    7600 3900
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR030
U 1 1 606B82E5
P 7150 3700
F 0 "#PWR030" H 7150 3550 50  0001 C CNN
F 1 "+3.3V" H 7165 3873 50  0000 C CNN
F 2 "" H 7150 3700 50  0001 C CNN
F 3 "" H 7150 3700 50  0001 C CNN
	1    7150 3700
	1    0    0    -1  
$EndComp
Wire Wire Line
	7150 3700 7150 3750
Wire Wire Line
	7150 3750 7600 3750
Wire Wire Line
	7600 3750 7600 3800
Connection ~ 7150 3750
Wire Wire Line
	7150 3750 7150 3800
Wire Wire Line
	7150 4000 7150 4050
Wire Wire Line
	7150 4050 7600 4050
Wire Wire Line
	7600 4050 7600 4000
Wire Wire Line
	7150 4050 7150 4100
Connection ~ 7150 4050
$Comp
L power:GND #PWR031
U 1 1 606BCD5A
P 7150 4100
F 0 "#PWR031" H 7150 3850 50  0001 C CNN
F 1 "GND" H 7155 3927 50  0000 C CNN
F 2 "" H 7150 4100 50  0001 C CNN
F 3 "" H 7150 4100 50  0001 C CNN
	1    7150 4100
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x04 J_SWIM1
U 1 1 606C29D8
P 5550 3700
F 0 "J_SWIM1" H 5600 3300 50  0000 C CNN
F 1 "Conn_01x04" H 5650 3400 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x04_P2.54mm_Vertical" H 5550 3700 50  0001 C CNN
F 3 "~" H 5550 3700 50  0001 C CNN
	1    5550 3700
	-1   0    0    -1  
$EndComp
Wire Wire Line
	5750 3600 5850 3600
Wire Wire Line
	5850 3600 5850 3500
$Comp
L power:+3.3V #PWR027
U 1 1 606CB1F3
P 5850 3500
F 0 "#PWR027" H 5850 3350 50  0001 C CNN
F 1 "+3.3V" H 5865 3673 50  0000 C CNN
F 2 "" H 5850 3500 50  0001 C CNN
F 3 "" H 5850 3500 50  0001 C CNN
	1    5850 3500
	1    0    0    -1  
$EndComp
Text GLabel 5750 3700 2    50   Input ~ 0
STM8_SWIM
Text GLabel 5750 3900 2    50   Input ~ 0
STM8_NRST
Wire Wire Line
	5750 3800 5850 3800
$Comp
L power:GND #PWR028
U 1 1 606CCC07
P 5850 3800
F 0 "#PWR028" H 5850 3550 50  0001 C CNN
F 1 "GND" V 5855 3672 50  0000 R CNN
F 2 "" H 5850 3800 50  0001 C CNN
F 3 "" H 5850 3800 50  0001 C CNN
	1    5850 3800
	0    -1   -1   0   
$EndComp
$Comp
L Device:Crystal_GND24_Small Y1
U 1 1 606D465B
P 5750 5100
F 0 "Y1" H 5700 5300 50  0000 L CNN
F 1 "16MHz" H 5550 5400 50  0000 L CNN
F 2 "Crystal:Crystal_SMD_3225-4Pin_3.2x2.5mm" H 5750 5100 50  0001 C CNN
F 3 "~" H 5750 5100 50  0001 C CNN
F 4 " C13738" H 5750 5100 50  0001 C CNN "LCSC Part #"
	1    5750 5100
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C9
U 1 1 606DA701
P 6000 5300
F 0 "C9" H 6092 5346 50  0000 L CNN
F 1 "12p" H 6092 5255 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 6000 5300 50  0001 C CNN
F 3 "~" H 6000 5300 50  0001 C CNN
F 4 "C1547" H 6000 5300 50  0001 C CNN "LCSC Part #"
	1    6000 5300
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C8
U 1 1 606DABAE
P 5500 5300
F 0 "C8" H 5350 5350 50  0000 L CNN
F 1 "12p" H 5300 5250 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 5500 5300 50  0001 C CNN
F 3 "~" H 5500 5300 50  0001 C CNN
F 4 "C1547" H 5500 5300 50  0001 C CNN "LCSC Part #"
	1    5500 5300
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR025
U 1 1 606E02A7
P 5750 5550
F 0 "#PWR025" H 5750 5300 50  0001 C CNN
F 1 "GND" H 5755 5377 50  0000 C CNN
F 2 "" H 5750 5550 50  0001 C CNN
F 3 "" H 5750 5550 50  0001 C CNN
	1    5750 5550
	1    0    0    -1  
$EndComp
Wire Wire Line
	5500 5200 5500 5100
Wire Wire Line
	5500 5100 5650 5100
Wire Wire Line
	5850 5100 6000 5100
Wire Wire Line
	6000 5100 6000 5200
Wire Wire Line
	5500 5400 5500 5500
Wire Wire Line
	5500 5500 5750 5500
Wire Wire Line
	6000 5500 6000 5400
Wire Wire Line
	5750 5500 5750 5550
Connection ~ 5750 5500
Wire Wire Line
	5750 5500 6000 5500
Wire Wire Line
	5750 5000 5750 4950
Wire Wire Line
	5750 4950 5600 4950
Wire Wire Line
	5600 4950 5600 5300
Wire Wire Line
	5600 5300 5750 5300
Wire Wire Line
	5750 5300 5750 5200
Wire Wire Line
	5750 5300 5750 5500
Connection ~ 5750 5300
$Comp
L Device:R_Small R12
U 1 1 606F8F9E
P 6000 4900
F 0 "R12" H 6059 4946 50  0000 L CNN
F 1 "47" H 6059 4855 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" H 6000 4900 50  0001 C CNN
F 3 "~" H 6000 4900 50  0001 C CNN
F 4 "C25118" H 6000 4900 50  0001 C CNN "LCSC Part #"
	1    6000 4900
	1    0    0    -1  
$EndComp
Wire Wire Line
	6000 5000 6000 5100
Connection ~ 6000 5100
Wire Wire Line
	6000 4800 6000 4700
Wire Wire Line
	6000 4700 6150 4700
Text GLabel 6150 4700 2    50   Input ~ 0
RCC_OSC_OUT
Text GLabel 6150 4600 2    50   Input ~ 0
RCC_OSC_IN
Wire Wire Line
	6150 4600 5500 4600
Wire Wire Line
	5500 4600 5500 5100
Connection ~ 5500 5100
$Comp
L Connector_Generic:Conn_01x10 J3
U 1 1 6074F64D
P 10550 5450
F 0 "J3" H 10550 4750 50  0000 L CNN
F 1 "Conn_01x10" H 10350 4850 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x10_P2.54mm_Vertical" H 10550 5450 50  0001 C CNN
F 3 "~" H 10550 5450 50  0001 C CNN
	1    10550 5450
	1    0    0    -1  
$EndComp
Text GLabel 10350 5050 0    50   Input ~ 0
TIM2_CH1
Text GLabel 10350 5250 0    50   Input ~ 0
TIM3_CH1
Text GLabel 10350 5150 0    50   Input ~ 0
TIM2_CH2
Text GLabel 10350 5450 0    50   Input ~ 0
GPIO_PB3
Text GLabel 10350 5550 0    50   Input ~ 0
GPIO_PB4
Text GLabel 10350 5650 0    50   Input ~ 0
GPIO_PB5
Text GLabel 10350 5750 0    50   Input ~ 0
GPIO_PB6
Text GLabel 10350 5850 0    50   Input ~ 0
GPIO_PB7
Text GLabel 10350 5950 0    50   Input ~ 0
GPIO_PC4
Text GLabel 10350 5350 0    50   Input ~ 0
TIM3_CH2
$Comp
L Connector:TestPoint TP_SDA1
U 1 1 60766227
P 10550 3400
F 0 "TP_SDA1" H 10608 3518 50  0000 L CNN
F 1 "TestPoint" H 10608 3427 50  0000 L CNN
F 2 "TestPoint:TestPoint_Loop_D3.80mm_Drill2.0mm" H 10750 3400 50  0001 C CNN
F 3 "~" H 10750 3400 50  0001 C CNN
	1    10550 3400
	1    0    0    -1  
$EndComp
$Comp
L Connector:TestPoint TP_SCL1
U 1 1 6076622D
P 10550 3700
F 0 "TP_SCL1" H 10608 3818 50  0000 L CNN
F 1 "TestPoint" H 10608 3727 50  0000 L CNN
F 2 "TestPoint:TestPoint_Loop_D3.80mm_Drill2.0mm" H 10750 3700 50  0001 C CNN
F 3 "~" H 10750 3700 50  0001 C CNN
	1    10550 3700
	1    0    0    -1  
$EndComp
Wire Wire Line
	10450 3700 10550 3700
Wire Wire Line
	10450 3400 10550 3400
Text GLabel 10450 3400 0    50   Input ~ 0
I2C_SDA
Text GLabel 10450 3700 0    50   Input ~ 0
I2C_SCL
Text GLabel 9000 4000 0    50   Input ~ 0
I2C_SDA
Text GLabel 9000 4100 0    50   Input ~ 0
I2C_SCL
Wire Wire Line
	9000 4000 9150 4000
Wire Wire Line
	9000 4100 9250 4100
$Comp
L Device:R_Small R15
U 1 1 6077B4E5
P 9250 3700
F 0 "R15" H 9309 3746 50  0000 L CNN
F 1 "2k2" H 9309 3655 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric" H 9250 3700 50  0001 C CNN
F 3 "~" H 9250 3700 50  0001 C CNN
F 4 "C4190" H 9250 3700 50  0001 C CNN "LCSC Part #"
	1    9250 3700
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small R14
U 1 1 6077BB78
P 9150 3700
F 0 "R14" H 8950 3750 50  0000 L CNN
F 1 "2k2" H 8950 3650 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric" H 9150 3700 50  0001 C CNN
F 3 "~" H 9150 3700 50  0001 C CNN
F 4 "C4190" H 9150 3700 50  0001 C CNN "LCSC Part #"
	1    9150 3700
	1    0    0    -1  
$EndComp
Wire Wire Line
	9150 3800 9150 4000
Wire Wire Line
	9250 3800 9250 4100
Wire Wire Line
	9150 3600 9150 3500
Wire Wire Line
	9250 3600 9250 3500
$Comp
L power:+3V3 #PWR032
U 1 1 60784AFC
P 9150 3500
F 0 "#PWR032" H 9150 3350 50  0001 C CNN
F 1 "+3V3" H 9050 3650 50  0000 C CNN
F 2 "" H 9150 3500 50  0001 C CNN
F 3 "" H 9150 3500 50  0001 C CNN
	1    9150 3500
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR033
U 1 1 60784C66
P 9250 3500
F 0 "#PWR033" H 9250 3350 50  0001 C CNN
F 1 "+3V3" H 9300 3650 50  0000 C CNN
F 2 "" H 9250 3500 50  0001 C CNN
F 3 "" H 9250 3500 50  0001 C CNN
	1    9250 3500
	1    0    0    -1  
$EndComp
Wire Wire Line
	6100 6900 6100 6950
Wire Wire Line
	6100 7250 6100 7300
$Comp
L power:GND #PWR029
U 1 1 607909F3
P 6100 7300
F 0 "#PWR029" H 6100 7050 50  0001 C CNN
F 1 "GND" H 6105 7127 50  0000 C CNN
F 2 "" H 6100 7300 50  0001 C CNN
F 3 "" H 6100 7300 50  0001 C CNN
	1    6100 7300
	1    0    0    -1  
$EndComp
$Comp
L Device:R R13
U 1 1 607909F9
P 6100 7100
F 0 "R13" H 6030 7146 50  0000 R CNN
F 1 "1k2" H 6030 7055 50  0000 R CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 6030 7100 50  0001 C CNN
F 3 "~" H 6100 7100 50  0001 C CNN
F 4 "C17379" H 6100 7100 50  0001 C CNN "LCSC Part #"
	1    6100 7100
	-1   0    0    -1  
$EndComp
$Comp
L Device:LED LED3
U 1 1 607909FF
P 6100 6750
F 0 "LED3" H 6150 6850 50  0000 R CNN
F 1 "RED" H 6200 6600 50  0000 R CNN
F 2 "LED_SMD:LED_0805_2012Metric" H 6100 6750 50  0001 C CNN
F 3 "~" H 6100 6750 50  0001 C CNN
F 4 "C84256" H 6100 6750 50  0001 C CNN "LCSC Part #"
	1    6100 6750
	0    -1   -1   0   
$EndComp
Wire Wire Line
	5750 6900 5750 6950
Wire Wire Line
	5750 7250 5750 7300
$Comp
L power:GND #PWR026
U 1 1 607A5B18
P 5750 7300
F 0 "#PWR026" H 5750 7050 50  0001 C CNN
F 1 "GND" H 5755 7127 50  0000 C CNN
F 2 "" H 5750 7300 50  0001 C CNN
F 3 "" H 5750 7300 50  0001 C CNN
	1    5750 7300
	1    0    0    -1  
$EndComp
$Comp
L Device:R R11
U 1 1 607A5B1E
P 5750 7100
F 0 "R11" H 5680 7146 50  0000 R CNN
F 1 "1k2" H 5680 7055 50  0000 R CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 5680 7100 50  0001 C CNN
F 3 "~" H 5750 7100 50  0001 C CNN
F 4 "C17379" H 5750 7100 50  0001 C CNN "LCSC Part #"
	1    5750 7100
	-1   0    0    -1  
$EndComp
$Comp
L Device:LED LED2
U 1 1 607A5B24
P 5750 6750
F 0 "LED2" H 5800 6850 50  0000 R CNN
F 1 "RED" H 5850 6650 50  0000 R CNN
F 2 "LED_SMD:LED_0805_2012Metric" H 5750 6750 50  0001 C CNN
F 3 "~" H 5750 6750 50  0001 C CNN
F 4 "C84256" H 5750 6750 50  0001 C CNN "LCSC Part #"
	1    5750 6750
	0    -1   -1   0   
$EndComp
Wire Wire Line
	5400 6900 5400 6950
Wire Wire Line
	5400 7250 5400 7300
$Comp
L power:GND #PWR022
U 1 1 607A836B
P 5400 7300
F 0 "#PWR022" H 5400 7050 50  0001 C CNN
F 1 "GND" H 5405 7127 50  0000 C CNN
F 2 "" H 5400 7300 50  0001 C CNN
F 3 "" H 5400 7300 50  0001 C CNN
	1    5400 7300
	1    0    0    -1  
$EndComp
$Comp
L Device:R R7
U 1 1 607A8371
P 5400 7100
F 0 "R7" H 5330 7146 50  0000 R CNN
F 1 "1k2" H 5330 7055 50  0000 R CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 5330 7100 50  0001 C CNN
F 3 "~" H 5400 7100 50  0001 C CNN
F 4 "C17379" H 5400 7100 50  0001 C CNN "LCSC Part #"
	1    5400 7100
	-1   0    0    -1  
$EndComp
$Comp
L Device:LED LED1
U 1 1 607A8377
P 5400 6750
F 0 "LED1" H 5450 6850 50  0000 R CNN
F 1 "RED" H 5450 6650 50  0000 R CNN
F 2 "LED_SMD:LED_0805_2012Metric" H 5400 6750 50  0001 C CNN
F 3 "~" H 5400 6750 50  0001 C CNN
F 4 "C84256" H 5400 6750 50  0001 C CNN "LCSC Part #"
	1    5400 6750
	0    -1   -1   0   
$EndComp
$Comp
L power:+5V #PWR037
U 1 1 607B68E1
P 10550 1250
F 0 "#PWR037" H 10550 1100 50  0001 C CNN
F 1 "+5V" H 10565 1423 50  0000 C CNN
F 2 "" H 10550 1250 50  0001 C CNN
F 3 "" H 10550 1250 50  0001 C CNN
	1    10550 1250
	1    0    0    -1  
$EndComp
Text GLabel 5400 6600 1    50   Input ~ 0
TIM2_CH1
Text GLabel 5750 6600 1    50   Input ~ 0
GPIO_PB7
Text GLabel 6100 6600 1    50   Input ~ 0
GPIO_PB6
Text Notes 4900 3200 0    50   ~ 0
STM8L051F3P6
$Comp
L power:+5V #PWR039
U 1 1 6086B35C
P 10550 2550
F 0 "#PWR039" H 10550 2400 50  0001 C CNN
F 1 "+5V" H 10565 2723 50  0000 C CNN
F 2 "" H 10550 2550 50  0001 C CNN
F 3 "" H 10550 2550 50  0001 C CNN
	1    10550 2550
	1    0    0    -1  
$EndComp
Text GLabel 950  1500 0    50   Input ~ 0
REG_VIN
Text GLabel 900  1250 2    50   Input ~ 0
REG_VIN
$Comp
L Power_Protection:USBLC6-2SC6 U4
U 1 1 6087A679
P 3450 4000
F 0 "U4" H 3750 3550 50  0000 C CNN
F 1 "USBLC6-2SC6" H 3800 3650 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-23-6" H 3450 3500 50  0001 C CNN
F 3 "https://www.st.com/resource/en/datasheet/usblc6-2.pdf" H 3650 4350 50  0001 C CNN
F 4 "C7519" H 3450 4000 50  0001 C CNN "LCSC Part #"
	1    3450 4000
	1    0    0    -1  
$EndComp
Wire Wire Line
	3450 3550 3450 3600
Text GLabel 3850 3900 2    50   Input ~ 0
USB_D+
Text GLabel 3050 3900 0    50   Input ~ 0
USB_D-
Text GLabel 3850 4100 2    50   Input ~ 0
USB_CON_D+
Text GLabel 3050 4100 0    50   Input ~ 0
USB_CON_D-
$Comp
L power:GND #PWR016
U 1 1 608A0AD0
P 3450 4450
F 0 "#PWR016" H 3450 4200 50  0001 C CNN
F 1 "GND" H 3455 4277 50  0000 C CNN
F 2 "" H 3450 4450 50  0001 C CNN
F 3 "" H 3450 4450 50  0001 C CNN
	1    3450 4450
	1    0    0    -1  
$EndComp
Wire Wire Line
	3450 4400 3450 4450
$Comp
L power:+5V #PWR015
U 1 1 6089164B
P 3450 3550
F 0 "#PWR015" H 3450 3400 50  0001 C CNN
F 1 "+5V" H 3465 3723 50  0000 C CNN
F 2 "" H 3450 3550 50  0001 C CNN
F 3 "" H 3450 3550 50  0001 C CNN
	1    3450 3550
	1    0    0    -1  
$EndComp
Wire Wire Line
	600  1250 900  1250
$Comp
L Device:C_Small C2
U 1 1 608E3453
P 1000 1700
F 0 "C2" H 1092 1746 50  0000 L CNN
F 1 "470u" H 1092 1655 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D8.0mm_P3.50mm" H 1000 1700 50  0001 C CNN
F 3 "~" H 1000 1700 50  0001 C CNN
	1    1000 1700
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C4
U 1 1 608E3459
P 1450 1700
F 0 "C4" H 1542 1746 50  0000 L CNN
F 1 "100n" H 1542 1655 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 1450 1700 50  0001 C CNN
F 3 "~" H 1450 1700 50  0001 C CNN
F 4 "C49678" H 1450 1700 50  0001 C CNN "LCSC Part #"
	1    1450 1700
	1    0    0    -1  
$EndComp
Wire Wire Line
	1000 1950 1450 1950
Wire Wire Line
	1000 1950 1000 2000
Connection ~ 1000 1950
$Comp
L power:GND #PWR04
U 1 1 608E346F
P 1000 2000
F 0 "#PWR04" H 1000 1750 50  0001 C CNN
F 1 "GND" H 1005 1827 50  0000 C CNN
F 2 "" H 1000 2000 50  0001 C CNN
F 3 "" H 1000 2000 50  0001 C CNN
	1    1000 2000
	1    0    0    -1  
$EndComp
Wire Wire Line
	950  1500 1000 1500
Wire Wire Line
	1000 1600 1000 1500
Connection ~ 1000 1500
Wire Wire Line
	1000 1500 1450 1500
Wire Wire Line
	1450 1600 1450 1500
Wire Wire Line
	1450 1800 1450 1950
Wire Wire Line
	1000 1800 1000 1950
Wire Notes Line
	4850 4850 500  4850
Text Notes 500  3200 0    50   ~ 0
USB Connector and ESD Protection
Text Notes 500  4950 0    50   ~ 0
USB to UART
Text Notes 500  550  0    50   ~ 0
3V3 Regulator
$Comp
L Device:R_Small R10
U 1 1 6094C3B3
P 5800 2250
F 0 "R10" H 5859 2296 50  0000 L CNN
F 1 "1k" H 5859 2205 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" H 5800 2250 50  0001 C CNN
F 3 "~" H 5800 2250 50  0001 C CNN
F 4 "C11702" H 5800 2250 50  0001 C CNN "LCSC Part #"
	1    5800 2250
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR023
U 1 1 60983212
P 5800 1200
F 0 "#PWR023" H 5800 1050 50  0001 C CNN
F 1 "+3V3" H 5815 1373 50  0000 C CNN
F 2 "" H 5800 1200 50  0001 C CNN
F 3 "" H 5800 1200 50  0001 C CNN
	1    5800 1200
	1    0    0    -1  
$EndComp
Wire Wire Line
	5800 2350 5800 2500
$Comp
L power:GND #PWR024
U 1 1 6098AEDD
P 5800 2500
F 0 "#PWR024" H 5800 2250 50  0001 C CNN
F 1 "GND" H 5805 2327 50  0000 C CNN
F 2 "" H 5800 2500 50  0001 C CNN
F 3 "" H 5800 2500 50  0001 C CNN
	1    5800 2500
	1    0    0    -1  
$EndComp
Text GLabel 5650 2050 0    50   Input ~ 0
REG_FEEDBACK
Wire Wire Line
	5800 2050 5650 2050
Connection ~ 5800 2050
Wire Wire Line
	5800 2050 5800 2150
$Comp
L Device:C_Small C10
U 1 1 609B1B6F
P 6200 1600
F 0 "C10" H 6292 1646 50  0000 L CNN
F 1 "20n" H 6292 1555 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 6200 1600 50  0001 C CNN
F 3 "~" H 6200 1600 50  0001 C CNN
F 4 "C21120" H 6200 1600 50  0001 C CNN "LCSC Part #"
	1    6200 1600
	1    0    0    -1  
$EndComp
$Comp
L richiegreen:XL1509 U1
U 1 1 608428E4
P 2400 1750
F 0 "U1" H 2400 2615 50  0000 C CNN
F 1 "XL1509" H 2400 2524 50  0000 C CNN
F 2 "Package_SO:HSOP-8-1EP_3.9x4.9mm_P1.27mm_EP2.41x3.1mm" H 2350 2100 50  0001 C CNN
F 3 "" H 2350 2100 50  0001 C CNN
F 4 "C74192" H 2400 1750 50  0001 C CNN "LCSC Part #"
	1    2400 1750
	1    0    0    -1  
$EndComp
Wire Wire Line
	2150 2050 2150 2150
Wire Wire Line
	2150 2150 2300 2150
Wire Wire Line
	2300 2150 2300 2050
Wire Wire Line
	2500 2050 2500 2150
Wire Wire Line
	2500 2150 2650 2150
Wire Wire Line
	2650 2150 2650 2050
Wire Wire Line
	2500 2150 2400 2150
Connection ~ 2500 2150
Connection ~ 2300 2150
Wire Wire Line
	2400 2150 2400 2250
Connection ~ 2400 2150
Wire Wire Line
	2400 2150 2300 2150
$Comp
L power:GND #PWR012
U 1 1 60854922
P 2400 2250
F 0 "#PWR012" H 2400 2000 50  0001 C CNN
F 1 "GND" H 2405 2077 50  0000 C CNN
F 2 "" H 2400 2250 50  0001 C CNN
F 3 "" H 2400 2250 50  0001 C CNN
	1    2400 2250
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR09
U 1 1 6085D08D
P 1800 1700
F 0 "#PWR09" H 1800 1450 50  0001 C CNN
F 1 "GND" H 1805 1527 50  0000 C CNN
F 2 "" H 1800 1700 50  0001 C CNN
F 3 "" H 1800 1700 50  0001 C CNN
	1    1800 1700
	1    0    0    -1  
$EndComp
Wire Wire Line
	1850 1550 1800 1550
Wire Wire Line
	1800 1550 1800 1700
Text GLabel 2950 1550 2    50   Input ~ 0
REG_OUT
Text GLabel 2950 1200 2    50   Input ~ 0
REG_FEEDBACK
Text GLabel 1850 1250 0    50   Input ~ 0
REG_VIN
Wire Wire Line
	1550 3700 1350 3700
$Comp
L Device:R_Small R3
U 1 1 60A4096A
P 3850 5700
F 0 "R3" V 3654 5700 50  0000 C CNN
F 1 "0R" V 3750 5700 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" H 3850 5700 50  0001 C CNN
F 3 "~" H 3850 5700 50  0001 C CNN
F 4 "C17477" H 3850 5700 50  0001 C CNN "LCSC Part #"
	1    3850 5700
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small R4
U 1 1 60A41092
P 3850 5800
F 0 "R4" V 4050 5800 50  0000 C CNN
F 1 "0R" V 3950 5800 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" H 3850 5800 50  0001 C CNN
F 3 "~" H 3850 5800 50  0001 C CNN
F 4 "C17477" H 3850 5800 50  0001 C CNN "LCSC Part #"
	1    3850 5800
	0    1    1    0   
$EndComp
Wire Wire Line
	4100 5700 3950 5700
Wire Wire Line
	4100 5800 3950 5800
Wire Wire Line
	3750 5700 3600 5700
Wire Wire Line
	3750 5800 3600 5800
Text GLabel 4050 5150 0    50   Input ~ 0
STM8_RX
Text GLabel 4050 5250 0    50   Input ~ 0
STM8_TX
$Comp
L Connector_Generic:Conn_01x02 J2
U 1 1 60A772C9
P 4300 5150
F 0 "J2" H 4250 5250 50  0000 L CNN
F 1 "Conn_01x02" H 4000 4950 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x02_P2.54mm_Vertical" H 4300 5150 50  0001 C CNN
F 3 "~" H 4300 5150 50  0001 C CNN
	1    4300 5150
	1    0    0    -1  
$EndComp
Wire Wire Line
	4050 5250 4100 5250
Wire Wire Line
	4050 5150 4100 5150
$Comp
L power:GND #PWR020
U 1 1 609F6E87
P 4650 2150
F 0 "#PWR020" H 4650 1900 50  0001 C CNN
F 1 "GND" H 4655 1977 50  0000 C CNN
F 2 "" H 4650 2150 50  0001 C CNN
F 3 "" H 4650 2150 50  0001 C CNN
	1    4650 2150
	1    0    0    -1  
$EndComp
Wire Wire Line
	4650 1950 4650 2150
Wire Wire Line
	4650 1550 4900 1550
Wire Wire Line
	4650 1750 4650 1550
$Comp
L Device:C_Small C7
U 1 1 609ED5AA
P 4650 1850
F 0 "C7" H 4742 1896 50  0000 L CNN
F 1 "330u" H 4742 1805 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D8.0mm_P3.50mm" H 4650 1850 50  0001 C CNN
F 3 "~" H 4650 1850 50  0001 C CNN
	1    4650 1850
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR017
U 1 1 6096DFC3
P 4050 2150
F 0 "#PWR017" H 4050 1900 50  0001 C CNN
F 1 "GND" H 4055 1977 50  0000 C CNN
F 2 "" H 4050 2150 50  0001 C CNN
F 3 "" H 4050 2150 50  0001 C CNN
	1    4050 2150
	1    0    0    -1  
$EndComp
Wire Wire Line
	4050 1950 4050 2150
Wire Wire Line
	4050 1550 3900 1550
Connection ~ 4050 1550
Wire Wire Line
	4050 1750 4050 1550
$Comp
L Device:D_Schottky_Small D1
U 1 1 60966325
P 4050 1850
F 0 "D1" V 4004 1920 50  0000 L CNN
F 1 "SS54" H 3950 1750 50  0000 L CNN
F 2 "Diode_SMD:D_SMA" V 4050 1850 50  0001 C CNN
F 3 "" V 4050 1850 50  0001 C CNN
F 4 "C22452" H 4050 1850 50  0001 C CNN "LCSC Part #"
	1    4050 1850
	0    1    1    0   
$EndComp
$Comp
L power:+3V3 #PWR021
U 1 1 60958A46
P 4900 1450
F 0 "#PWR021" H 4900 1300 50  0001 C CNN
F 1 "+3V3" H 4915 1623 50  0000 C CNN
F 2 "" H 4900 1450 50  0001 C CNN
F 3 "" H 4900 1450 50  0001 C CNN
	1    4900 1450
	1    0    0    -1  
$EndComp
Wire Wire Line
	4900 1550 4900 1450
Text GLabel 3900 1550 0    50   Input ~ 0
REG_OUT
$Comp
L Device:L_Small L1
U 1 1 6086F8CD
P 4350 1550
F 0 "L1" V 4535 1550 50  0000 C CNN
F 1 "22u" V 4444 1550 50  0000 C CNN
F 2 "Inductor_SMD:L_7.3x7.3_H4.5" H 4350 1550 50  0001 C CNN
F 3 "~" H 4350 1550 50  0001 C CNN
F 4 "C216197" H 4350 1550 50  0001 C CNN "LCSC Part #"
	1    4350 1550
	0    -1   -1   0   
$EndComp
$Comp
L Device:R_Small R9
U 1 1 6094C6AB
P 5800 1750
F 0 "R9" H 5859 1796 50  0000 L CNN
F 1 "680R" H 5850 1700 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" H 5800 1750 50  0001 C CNN
F 3 "~" H 5800 1750 50  0001 C CNN
F 4 "C25130" H 5800 1750 50  0001 C CNN "LCSC Part #"
	1    5800 1750
	1    0    0    -1  
$EndComp
Wire Wire Line
	4050 1550 4250 1550
Wire Wire Line
	4450 1550 4650 1550
Connection ~ 4650 1550
$Comp
L Device:R_Small R8
U 1 1 60AF87B2
P 5800 1450
F 0 "R8" H 5859 1496 50  0000 L CNN
F 1 "1k" H 5850 1400 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" H 5800 1450 50  0001 C CNN
F 3 "~" H 5800 1450 50  0001 C CNN
F 4 "C11702" H 5800 1450 50  0001 C CNN "LCSC Part #"
	1    5800 1450
	1    0    0    -1  
$EndComp
Wire Wire Line
	5800 1650 5800 1550
Wire Wire Line
	5800 1200 5800 1250
Wire Wire Line
	5800 1850 5800 1950
Wire Wire Line
	5800 1950 6200 1950
Wire Wire Line
	6200 1950 6200 1700
Connection ~ 5800 1950
Wire Wire Line
	5800 1950 5800 2050
Wire Wire Line
	6200 1500 6200 1250
Wire Wire Line
	6200 1250 5800 1250
Connection ~ 5800 1250
Wire Wire Line
	5800 1250 5800 1350
Wire Wire Line
	4550 7100 4550 7150
Wire Wire Line
	4550 7450 4550 7500
$Comp
L power:GND #PWR019
U 1 1 60B7A07E
P 4550 7500
F 0 "#PWR019" H 4550 7250 50  0001 C CNN
F 1 "GND" H 4555 7327 50  0000 C CNN
F 2 "" H 4550 7500 50  0001 C CNN
F 3 "" H 4550 7500 50  0001 C CNN
	1    4550 7500
	1    0    0    -1  
$EndComp
$Comp
L Device:R R6
U 1 1 60B7A084
P 4550 7300
F 0 "R6" H 4480 7346 50  0000 R CNN
F 1 "1k2" H 4480 7255 50  0000 R CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 4480 7300 50  0001 C CNN
F 3 "~" H 4550 7300 50  0001 C CNN
F 4 "C17379" H 4550 7300 50  0001 C CNN "LCSC Part #"
	1    4550 7300
	-1   0    0    -1  
$EndComp
$Comp
L Device:LED LED_RX1
U 1 1 60B7A08A
P 4550 6950
F 0 "LED_RX1" H 4600 7050 50  0000 R CNN
F 1 "RED" H 4650 6850 50  0000 R CNN
F 2 "LED_SMD:LED_0805_2012Metric" H 4550 6950 50  0001 C CNN
F 3 "~" H 4550 6950 50  0001 C CNN
F 4 "C84256" H 4550 6950 50  0001 C CNN "LCSC Part #"
	1    4550 6950
	0    -1   -1   0   
$EndComp
Wire Wire Line
	4200 7100 4200 7150
Wire Wire Line
	4200 7450 4200 7500
$Comp
L power:GND #PWR018
U 1 1 60B7A092
P 4200 7500
F 0 "#PWR018" H 4200 7250 50  0001 C CNN
F 1 "GND" H 4205 7327 50  0000 C CNN
F 2 "" H 4200 7500 50  0001 C CNN
F 3 "" H 4200 7500 50  0001 C CNN
	1    4200 7500
	1    0    0    -1  
$EndComp
$Comp
L Device:R R5
U 1 1 60B7A098
P 4200 7300
F 0 "R5" H 4130 7346 50  0000 R CNN
F 1 "1k2" H 4130 7255 50  0000 R CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 4130 7300 50  0001 C CNN
F 3 "~" H 4200 7300 50  0001 C CNN
F 4 "C17379" H 4200 7300 50  0001 C CNN "LCSC Part #"
	1    4200 7300
	-1   0    0    -1  
$EndComp
$Comp
L Device:LED LED_TX1
U 1 1 60B7A09E
P 4200 6950
F 0 "LED_TX1" H 4250 7050 50  0000 R CNN
F 1 "RED" H 4250 6850 50  0000 R CNN
F 2 "LED_SMD:LED_0805_2012Metric" H 4200 6950 50  0001 C CNN
F 3 "~" H 4200 6950 50  0001 C CNN
F 4 "C84256" H 4200 6950 50  0001 C CNN "LCSC Part #"
	1    4200 6950
	0    -1   -1   0   
$EndComp
Text GLabel 3600 6700 2    50   Input ~ 0
CBUS0
Text GLabel 3600 6800 2    50   Input ~ 0
CBUS1
Text GLabel 4200 6800 1    50   Input ~ 0
CBUS0
Text GLabel 4550 6800 1    50   Input ~ 0
CBUS1
Wire Wire Line
	2800 5350 2900 5350
Wire Wire Line
	2700 5350 2800 5350
Connection ~ 2800 5350
Wire Wire Line
	2800 5350 2800 5250
$Comp
L power:+3V3 #PWR013
U 1 1 608618F0
P 2800 5250
F 0 "#PWR013" H 2800 5100 50  0001 C CNN
F 1 "+3V3" H 2815 5423 50  0000 C CNN
F 2 "" H 2800 5250 50  0001 C CNN
F 3 "" H 2800 5250 50  0001 C CNN
	1    2800 5250
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small R1
U 1 1 60BC121D
P 600 6250
F 0 "R1" V 404 6250 50  0000 C CNN
F 1 "4k7" V 500 6250 50  0000 C CNN
F 2 "Resistor_SMD:R_0402_1005Metric" H 600 6250 50  0001 C CNN
F 3 "~" H 600 6250 50  0001 C CNN
F 4 "C25900" H 600 6250 50  0001 C CNN "LCSC Part #"
	1    600  6250
	-1   0    0    1   
$EndComp
$Comp
L Device:R_Small R2
U 1 1 60BC1527
P 600 6550
F 0 "R2" V 404 6550 50  0000 C CNN
F 1 "10k" V 500 6550 50  0000 C CNN
F 2 "Resistor_SMD:R_0402_1005Metric" H 600 6550 50  0001 C CNN
F 3 "~" H 600 6550 50  0001 C CNN
F 4 "C25744" H 600 6550 50  0001 C CNN "LCSC Part #"
	1    600  6550
	-1   0    0    1   
$EndComp
$Comp
L power:+5V #PWR02
U 1 1 60BD290F
P 600 6050
F 0 "#PWR02" H 600 5900 50  0001 C CNN
F 1 "+5V" H 615 6223 50  0000 C CNN
F 2 "" H 600 6050 50  0001 C CNN
F 3 "" H 600 6050 50  0001 C CNN
	1    600  6050
	1    0    0    -1  
$EndComp
Wire Wire Line
	600  6350 600  6400
Wire Wire Line
	600  6650 600  6800
$Comp
L power:GND #PWR03
U 1 1 60BE3A49
P 600 6800
F 0 "#PWR03" H 600 6550 50  0001 C CNN
F 1 "GND" H 605 6627 50  0000 C CNN
F 2 "" H 600 6800 50  0001 C CNN
F 3 "" H 600 6800 50  0001 C CNN
	1    600  6800
	1    0    0    -1  
$EndComp
Wire Wire Line
	600  6050 600  6150
Text GLabel 2000 6400 0    50   Input ~ 0
FT232_nRESET
Text GLabel 700  6400 2    50   Input ~ 0
FT232_nRESET
Wire Wire Line
	700  6400 600  6400
Connection ~ 600  6400
Wire Wire Line
	600  6400 600  6450
$Comp
L Device:C_Small C3
U 1 1 60C03654
P 1100 5500
F 0 "C3" H 1192 5546 50  0000 L CNN
F 1 "100n" H 1192 5455 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 1100 5500 50  0001 C CNN
F 3 "~" H 1100 5500 50  0001 C CNN
F 4 "C49678" H 1100 5500 50  0001 C CNN "LCSC Part #"
	1    1100 5500
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C5
U 1 1 60C0365A
P 1450 5500
F 0 "C5" H 1542 5546 50  0000 L CNN
F 1 "4.7u" H 1542 5455 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 1450 5500 50  0001 C CNN
F 3 "~" H 1450 5500 50  0001 C CNN
F 4 "C19666" H 1450 5500 50  0001 C CNN "LCSC Part #"
	1    1450 5500
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR07
U 1 1 60C03663
P 1100 5800
F 0 "#PWR07" H 1100 5550 50  0001 C CNN
F 1 "GND" H 1105 5627 50  0000 C CNN
F 2 "" H 1100 5800 50  0001 C CNN
F 3 "" H 1100 5800 50  0001 C CNN
	1    1100 5800
	1    0    0    -1  
$EndComp
Wire Wire Line
	1100 5400 1100 5300
$Comp
L Device:C_Small C1
U 1 1 60C099D6
P 750 5500
F 0 "C1" H 842 5546 50  0000 L CNN
F 1 "100n" H 842 5455 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 750 5500 50  0001 C CNN
F 3 "~" H 750 5500 50  0001 C CNN
F 4 "C49678" H 750 5500 50  0001 C CNN "LCSC Part #"
	1    750  5500
	1    0    0    -1  
$EndComp
Wire Wire Line
	1100 5600 1100 5700
Wire Wire Line
	1100 5300 750  5300
Wire Wire Line
	750  5300 750  5400
Wire Wire Line
	750  5600 750  5700
Wire Wire Line
	750  5700 1100 5700
Connection ~ 1100 5700
Wire Wire Line
	1100 5700 1100 5800
Wire Wire Line
	1100 5700 1450 5700
Wire Wire Line
	1450 5700 1450 5600
Wire Wire Line
	1450 5400 1450 5300
Wire Wire Line
	1450 5300 1100 5300
Connection ~ 1100 5300
$Comp
L power:+3V3 #PWR06
U 1 1 60C24E57
P 1100 5200
F 0 "#PWR06" H 1100 5050 50  0001 C CNN
F 1 "+3V3" H 1115 5373 50  0000 C CNN
F 2 "" H 1100 5200 50  0001 C CNN
F 3 "" H 1100 5200 50  0001 C CNN
	1    1100 5200
	1    0    0    -1  
$EndComp
Wire Wire Line
	1100 5200 1100 5300
Wire Notes Line
	4850 3100 4850 7800
$EndSCHEMATC
