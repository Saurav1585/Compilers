#include<stdio.h>
#include<stdlib.h>

int main(){
	int i=0,j=0,k=0,m=0;
	for(i=0;i<=5;i++)
	{	
		printf( "%d\n", i);
		for(j=0;j<=4;j++)
		{
			do{
				k++;
				do{
					m++;
				}while(m<3);
				do{
					k++;
				}while(k<10);
			}while(k<5);
			
			
		}
	}
}
