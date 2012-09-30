#include <iostream>
#include<string.h>
#include <ql/quantlib.hpp>

using namespace std;
using namespace QuantLib;

void DateTesting1 (){
  Date myDate (12 , Aug ,2009);
  std :: cout << myDate << std :: endl ;
  myDate ++;
  std :: cout << myDate << std :: endl ;
  myDate +=12* Days ;
  std :: cout << myDate << std :: endl ;
  myDate -=2* Months ;
  std :: cout << myDate << std :: endl ;
  myDate --;
  std :: cout << myDate << std :: endl ;
  Period myP (10 , Weeks );
  myDate += myP ;
  std :: cout << myDate << std :: endl ;
}


int main(){
  cout << "Hello World!" <<endl;
  //char response;
  //cin >> response;
  DateTesting1 ();
  double x =0.1;
  string longvariablename;
  QL_REQUIRE ( x!=0 , " Zeronumber !");
  return 0;
}


















