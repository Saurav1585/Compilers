%{ 
	int positive_integer=0; 
	int negative_integer=0; 
	int positive_fraction=0;
	int negative_fraction=0;
%} 

%% 
[+]?[0-9]+ {positive_integer++;} 
[+]?[0-9]*\.[0-9]+ {positive_fraction++;} 
-[0-9]+ {negative_integer++;} 
-[0-9]*[.][0-9]+ {negative_fraction++;}
.	{}
%%

int main() 
{ 
	yyin=fopen("file2.txt","r");
	//printf("Enter Numbers:"); 
	yylex(); 
	printf("Number of positive integer are: %d\n", positive_integer); 
	printf("Number of positive fraction are: %d\n", positive_fraction); 
	printf("Number of negative integer are: %d\n", negative_integer); 
	printf("Number of negative fraction are: %d\n", negative_fraction); 
	return 0; 
} 

