%{
#include<stdio.h>
#include<string.h>
%}

KEYWORD auto|double|int|struct|break|else|long|switch|case|enum|register|typedef|char|extern|return|union|continue|for|signed|void|do|if|static|while|default|goto|sizeof|const|float|short|unsigned

%%
{KEYWORD}		{printf("\n%s : Keyword",yytext);}
[a-zA-Z][a-zA-Z0-9_]*	{printf("\n%s : Identifier",yytext);}
.
%%

int main()
{
	yyin=fopen("file4.txt","r");
	yylex();
}
