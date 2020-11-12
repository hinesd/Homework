#ifndef PARSER_H
#define PARSER_H  

//i worked with Davis Chan in zoom and got the solution figured out

#include <string>
#include <map> 



using namespace std;


class Node{
public:
  virtual unsigned nodeCount() = 0;
  virtual int stepper(map<string,int> &Var) = 0;
  virtual string stringy() = 0;
};

class Op: public Node{
public:
  Op(string op, Node* left, Node* right);
  // ~Op
  Node* left;
  Node* right;
  string op;
  

  unsigned nodeCount();
  int stepper(map<string,int> &Var);
  string stringy();
};

class Leaf: public Node{
public:
  Leaf(string st);
  // ~Leaf
  string st;

  unsigned nodeCount();
  int stepper(map<string,int> &Var);
  string stringy();
};


class Parser{
public:
  Parser();
  
  map<string, int> Var; 

  bool parse(string s);
  unsigned nodeCount();
  int eval();
  int eval(string s);
  void varDump();
  void varClear();
private:
  void trimL(string &s);
  void trimR(string &s);
  Node* expr(string s);
  Node* digit(string s);
  Node* variable(string s);

  Node* root;
};


  
#endif