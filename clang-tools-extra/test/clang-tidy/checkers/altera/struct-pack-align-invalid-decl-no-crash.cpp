// RUN: %check_clang_tidy -expect-clang-tidy-error %s altera-struct-pack-align %t -- -header-filter=.*

struct Foo {
  member; // no-crash
};
// CHECK-MESSAGES: :[[@LINE-2]]:3: error: a type specifier is required for all declarations [clang-diagnostic-error]
