// RUN: %clang_cc1 -fsyntax-only -verify %s

// This file contains literal null characters, be careful not to remove them
// accidentally.

char a = ' '; // expected-warning {{null character(s) preserved in char literal}}
char b = '\ '; // expected-warning {{null character(s) preserved in char literal}}
              // expected-warning@-1 {{unknown escape sequence '\x0'}}

char *c = "null character"; // expected-warning {{null character(s) preserved in string literal}}
char *d = "null\ character"; // expected-warning {{null character(s) preserved in string literal}}
                            // expected-warning@-1 {{unknown escape sequence '\x0'}}

// Put broken include in the end because it suppresses subsequent warnings.
#include <null\ character> // expected-warning {{null character(s) preserved in string literal}}
                          // expected-error@-1 {{'null\<U+0000>character' file not found}}
