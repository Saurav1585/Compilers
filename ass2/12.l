%{
#include<string.h>
#include<stdio.h>
int a1=0,a2=0,a3=0,a4=0;
char stack[100];
int top=-1;
int x=0,y=0,z=0;
%}

op "++"|"--"
rop "<"|">"|"<="|">="|"=="|"!="
id [a-zA-Z_][a-zA-Z0-9_]*
no [0-9]*
pp [\n\t" "]

%%
for\(({id}=({no}|{id}))?\;{id}{rop}({id}|{no})\;{id}{op}\) {
	a1=0;a2=0;a3=0;a4=0;
	for (int i=0;i<yyleng;i++){
		if(yytext[i]=='(')
			a1=i;
		if(yytext[i]==';' && a2==0) 
			a2=i;
		if(yytext[i]==';' && a2!=0)
			a3=i;
		if(yytext[i]==')')
			a4=i;
	}
	for (int i=a1+1;i<a2;i++){
		fprintf(yyout,"%c",yytext[i]);
	}
	fprintf(yyout,";\nwhile(");
	for (int i=a2+1;i<a3;i++){
		fprintf(yyout,"%c",yytext[i]);
	}
	fprintf(yyout,")");
	for (int i=a3+1;i<a4;i++){
		stack[++top]=yytext[i];
		//printf("%c ",stack[top]);
		}
}
\{	{	fprintf(yyout,"%s",yytext);
		stack[++top]='{';
	}
\}	{
		x=top;
		y=top+1;
		while (stack[x] != '{' && top !=0){
		//fprintf(yyout,"%c",stack[x]);
		x--;
		}
		top=x-1;
		x++;
		z=0;
		if(x==y){
			z=1;
		}
		while(x!=y){
			fprintf(yyout,"%c",stack[x]);
			x++;
		}
		if(z==0){
			fprintf(yyout,";");
		}
		fprintf(yyout,"}");
	}
.	{fprintf(yyout,"%s",yytext);}
%%

int yywrap(){}
int main(){
	extern FILE *yyin, *yyout;  
 	yyin=fopen("1.c","r");
 	yyout=fopen("11.c","w");
 	yylex();
 	
 }
 
 
