//this program turns on red, blue and green LEDs and lets them flash continously

#include <stdint.h>


int main()
{
  *((unsigned int *)0x400FE608U) = 0x20U; // enable port F GPIO
  *((unsigned int *)0x40025400U) = 0x0EU; // set port F as outputs
  *((unsigned int *)0x4002551CU) = 0x0EU; // clear all port F
  
  while (1) 
  {
    *((unsigned int *)0x400253FCU) = 0x02U; // turn on red LED
      
    int counter = 0;
    while (counter < 1000000) {
      ++counter;
    }
    
    *((unsigned int *)0x400253FCU) = 0x00U;
    counter = 0;
    while(counter < 1000000) {
      ++counter;
    }
    
     *((unsigned int *)0x400253FCU) = 0x04U; // turn on blue LED
      
    counter = 0;
    while (counter < 1000000) {
      ++counter;
    }
    
    *((unsigned int *)0x400253FCU) = 0x00U;
    counter = 0;
    while(counter < 1000000) {
      ++counter;
    }
    
     *((unsigned int *)0x400253FCU) = 0x08U; // turn on green LED
      
    counter = 0;
    while (counter < 1000000) {
      ++counter;
    }
    
    *((unsigned int *)0x400253FCU) = 0x00U;
    counter = 0;
    while(counter < 1000000) {
      ++counter;
    }
  }
  return 0;
}
