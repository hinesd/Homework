#include "gtest/gtest.h"
#include "Parser.h"



/* ------------------------------------------------ */
TEST(eval, 0){
  Parser s;
  EXPECT_EQ( s.eval(" 5"), 5);
}

TEST(eval, 1){
  Parser s;
  EXPECT_EQ( s.eval(" 5 + 6"), 11);
  EXPECT_EQ( s.eval(" 5 + 6 - 1"), 10);
}

TEST(eval, 2){
  Parser s;
  EXPECT_EQ( s.eval(" 10 * 2 - 1"), 19);
}

TEST(eval, 3){
  Parser s;
  EXPECT_EQ( s.eval(" (3 + 5) * 2 / 4"), 4);
}

TEST(eval, 4){
  Parser s;
  EXPECT_EQ( s.eval(" 1 + 5 * 7 - 3 * 9 + (34)"), 43);
}

TEST(eval, 5){
  Parser s;
  EXPECT_EQ( s.eval(" 9 / 2"), 4);
}

TEST(eval, 6){
  Parser s;
  EXPECT_EQ( s.eval(""), 0);
}

TEST(eval, 7){
  Parser s;
  EXPECT_EQ( s.eval("(6"), 0);
}

TEST(eval, 8){
  Parser s;
  EXPECT_EQ( s.eval("(1 + (3 * 2)) * (8-2)"), 42);
}

TEST(eval, 9){
  Parser s;
  EXPECT_EQ( s.eval("(1 + (3 * 2)) * (8-2)"), 42);
}



TEST(assignment, 1){
  Parser s;
  EXPECT_EQ( s.eval("a = 5"), 5);
}

TEST(assignment, 2){
  Parser s;
  s.parse("a=6");
  EXPECT_EQ( s.eval(), 6);
}

TEST(assignment, 3){
  Parser s;
  EXPECT_EQ( s.eval("a = 5"), 5);
  EXPECT_EQ( s.eval("a + 1"), 6);
}

TEST(assignment, 4){
  Parser s;
  EXPECT_EQ( s.eval("a = 5"), 5);
  EXPECT_EQ( s.eval("b = 50"), 50);
  EXPECT_EQ( s.eval("a + b + 1"), 56);
}

TEST(assignment, 5){
  Parser s;
  EXPECT_EQ( s.eval("a = 4 + 1"), 5);
  EXPECT_EQ( s.eval("a + 1"), 6);
  EXPECT_EQ( s.eval("a = 6"), 6);
  EXPECT_EQ( s.eval("a + 1"), 7);
}

TEST(assignment, 6){
  Parser s;
  EXPECT_EQ( s.eval("a = 4 + 1"), 5);
  EXPECT_EQ( s.eval("a * a"), 25);
  EXPECT_EQ( s.eval("a = 6"), 6);
  EXPECT_EQ( s.eval("a + 1"), 7);
}

TEST(assignment, 7){
  Parser s;
  EXPECT_EQ( s.eval("a = 4 + 1"), 5);
  EXPECT_EQ( s.eval("b + 1"), 1);
}

TEST(assignment, 8){
  Parser s;
  EXPECT_EQ( s.eval("3 + (cab = 2) * 2"), 7);
  EXPECT_EQ( s.eval("cab * 3"), 6);
}

TEST(varClear, 1){
  Parser s;
  EXPECT_EQ( s.eval("a = 6"), 6);
  s.varClear();
  EXPECT_EQ( s.eval("a"), 0);
}

TEST(varDump, 1){
  Parser s;
  EXPECT_EQ( s.eval("a = 1"), 1);
  EXPECT_EQ( s.eval("b = 2"), 2);
  EXPECT_EQ( s.eval("c = 3"), 3);
  s.varDump();
}