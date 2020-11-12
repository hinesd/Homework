#include <iostream>

#include "Parser.h"

using namespace std;

int main(){

  string input;
  Parser p;

  cout << "Type exit to exit." << endl;

  cout << ">";
  getline(cin, input);
  while(input != "exit"){
    if(p.parse(input)){
      cout << "ACCEPTED" << endl;
      //cout << p.numNodes() << " nodes in the tree." << endl;
      cout << "Value: " << p.eval() << endl;
    }else{
      cout << "Not accepted.";
    }
    cout << ">";
    getline(cin, input);
  }
  cout << "Exiting!" << endl;
}