%{/*sourabh*/
#include<stdio.h>
#include<string.h>
%}
TYPE1 main|printf|scanf|include[ .<>a-zA-Z]*|%[a-z]|\\[nt]|[a-zA-Z(]
TYPE2 auto|double|int|struct|break|else|long|switch|case|enum|register|typedef|char|extern|return|union|continue|for|signed|void|do|if|static|while|default|goto|sizeof|volatile|const|float|short|unsigned

%%
{TYPE2}				{fprintf(yyout,"%s<KW>",yytext);}
{TYPE1}				{fprintf(yyout,"%s",yytext);}
[a-zA-Z][a-zA-Z0-9_]*		{fprintf(yyout,"%s<ID>",yytext);}
.				{fprintf(yyout,"%s",yytext);}
%%

int yywrap(){}
int main(){
	extern FILE *yyin, *yyout;  
	yyin=fopen("1.c","r");
	yyout=fopen("2.c","w");
	yylex();
}
