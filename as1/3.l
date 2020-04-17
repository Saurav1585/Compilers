%{ 
	int count=-1; 
%} 

%% 
[^a-zA-Z] {count++;} 
.
%% 

int main() 
{ 
	yyin=fopen("file3.txt","r");
	//printf("Enter the string:"); 
	yylex(); 
	printf("Number of non Alphabatic Character are: %d\n", count); 
	return 0; 
} 

