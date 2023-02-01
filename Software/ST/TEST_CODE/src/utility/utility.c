#include "utility.h"

void hsi_configure () {
    while ((CLK_ICKR & BIT1) == 0); // HSRDY

    while((CLK_SWCR & BIT0));
    CLK_SWR    = 0xE1; // select HSI for Master CLK
    CLK_CKDIVR = 0;

    while((CLK_SWCR & BIT0));
    CLK_SWCR |= BIT1;
    while((CLK_SWCR & BIT0));
    CLK_SWCR &= ~BIT1;
}

void clk_out_enable() {
    /* Configure PD0 as output */
    PD_DDR |= BIT0;
    /* Push-pull mode, 10MHz output speed */
    PD_CR1 |= BIT0;
    PD_CR2 |= BIT0;
    /* Clock output on PD0 */
    CLK_CCOR |= (BIT0 | (0b1011 << 1));
}

// a mess
void opt_write() {
    /* new value for OPT5 (default is 0x00) */
    uint8_t opt0 = BIT2 | BIT5;
    /* unlock EEPROM */

    #define FLASH_DUKR_KEY1 0xAE
    #define FLASH_DUKR_KEY2 0x56

    FLASH_DUKR = FLASH_DUKR_KEY1;
    FLASH_DUKR = FLASH_DUKR_KEY2;
    while (!(FLASH_IAPSR & BIT3));
    /* unlock option bytes */
    FLASH_CR2 |= BIT7;
    FLASH_NCR2 &= ~BIT7;
    /* write option byte and it's complement */
    //*((uint8_t*) 0x4800) = opt0;
    *((uint8_t*) 0x4803) = opt0;
    *((uint8_t*) 0x4804) = ~opt0;
    //NOPT5 = ~opt5;
    /* wait until programming is finished */
    while (!(FLASH_IAPSR & BIT2));
    /* lock EEPROM */
    FLASH_IAPSR &= ~BIT3;
}
