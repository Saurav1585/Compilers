
%{
#include<stdio.h> 
#include<string.h> 
%}

%%
[a-zA-Z0-9]*	{if(yyleng >=3 && yyleng <=5) printf("\n%s : %d(length)",yytext,yyleng);}
.
%%

int yywrap(){}

int main(){
	yyin=fopen("file5.txt","r");
	//printf("Enter the string:"); 
	printf("\n set of string having 3 to 5 alphabets:");
	yylex();
	
}
