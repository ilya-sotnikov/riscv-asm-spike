#include <stdint.h>

extern int print_hex_ln(uint64_t n);
extern int print_str_ln(const char *s);

void c_function(void);

void c_function(void) {
  print_str_ln("calling an asm function from C");
  print_hex_ln(0xDEADC0DED15EA5ED);
}
