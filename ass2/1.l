%{
#include<string.h>
#include<stdio.h>
int a1=0,a2=0,a3=0,a4=0;
char stack[100];
char stack_do[200];
int top=-1,top_do=-1;
int x=0,y=0,z=0;
int doo=0;
int dollar=0;
%}

op "++"|"--"
rop "<"|">"|"<="|">="|"=="|"!="
id [a-zA-Z_][a-zA-Z0-9_]*
no [0-9]*
pp [\n\t" "]

%%
for\(({id}=({no}|{id}))?\;{id}{rop}({id}|{no})\;{id}{op}\){pp}*\{ {
		
		if(doo>0){
			for(int i=0;i<yyleng;i++){
				stack_do[++top_do]=yytext[i];
			}	
		}
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
		fprintf(yyout,"){");
		stack[++top]='{';
		for (int i=a3+1;i<a4;i++){
			stack[++top]=yytext[i];
			//printf("%c ",stack[top]);
		}
		stack[++top]=';';
	}

do{pp}*\{ {
		doo++;
		stack_do[++top_do]='$';
	}

\}{pp}*\while\({id}{rop}({id}|{no})\)\; {
		//fprintf(yyout,"%d",doo);
		doo--;
		for(int i=1;i<yyleng-1;i++){
			fprintf(yyout,"%c",yytext[i]);
			//stack_do[++top_do]=yytext[i];
		}
		
		fprintf(yyout,"{\n");
		x=top_do;
		y=top_do+1;
		while (stack_do[x] != '$'){
		//fprintf(yyout,"%c",stack[x]);
		x--;
		}
		/*if(doo==0){
			top_do=-1;
		}*/
		//top_do=x-1;
		stack_do[x] = '@';
		x++;
		//x=1;
		for(int i=1;i<yyleng-1;i++){
			//fprintf(yyout,"%c",yytext[i]);
			stack_do[++top_do]=yytext[i];
		}
		stack_do[++top_do]='{';
		
		while(x!=y){
			if(stack_do[x]!='@')			
				fprintf(yyout,"%c",stack_do[x]);
			if(stack_do[x]!='\t')
				stack_do[++top_do]=stack_do[x];
			x++;
		}
		fprintf(yyout,"\n}");
		stack_do[++top_do]='}';
		if(doo==0){
			top_do=-1;
		}
		dollar=0;
		int z=0;
		while(z<=top_do && dollar != doo+1){
			if(stack_do[z]=='$' )
				dollar++;
			z++;
		}
		top_do=z-1;
	}

\{	{	
		if(doo>0){
			for(int i=0;i<yyleng;i++){
				stack_do[++top_do]=yytext[i];
			}	
		}
		fprintf(yyout,"%s",yytext);
		stack[++top]='{';
	}

\}	{
		if(doo>0){
			for(int i=0;i<yyleng;i++){
				stack_do[++top_do]=yytext[i];
			}	
		}
		x=top;
		y=top;
		while (stack[x] != '{'){
		//fprintf(yyout,"%c",stack[x]);
		x--;
		}
		top=x-1;
		x++;
		while (stack[y] != ';'){
		//fprintf(yyout,"%c",stack[x]);
		y--;
		}
		while(x<=y){
			fprintf(yyout,"%c",stack[x]);
			x++;
		}
		fprintf(yyout,"}");
	}
.	{
		if(doo>0){
			for(int i=0;i<yyleng;i++){
				stack_do[++top_do]=yytext[i];
			}	
		}
		fprintf(yyout,"%s",yytext);
	}
%%

int yywrap(){}
int main(){
	//extern FILE *yyin, *yyout;  
 	yyin=fopen("1.c","r");
 	yyout=fopen("11.c","w");
 	yylex();
 	
}
