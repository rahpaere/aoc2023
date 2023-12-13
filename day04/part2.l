	#include <stdbool.h>
	#include <stdio.h>

	#define MAXWINNING 16
	#define MAXCARDS 250

	int numbers[MAXWINNING];
	int copies[MAXCARDS];
	int cur = 0;
	int num_winning;
	int num_winners;
	int cards = 0;

%s winning checking

%%

:	num_winning = 0; BEGIN winning;
\|	num_winners = 0; BEGIN checking;
\n	{
		int i;

		copies[cur]++;
		cards += copies[cur];

		for (i = 1; i <= num_winners; i++)
			copies[cur + i] += copies[cur];
		
		cur++;
		BEGIN INITIAL;
	}

<winning>[0-9]+	 numbers[num_winning++] = atoi(yytext);

<checking>[0-9]+ {
		int n = atoi(yytext);
		int i;
		for (i = 0; i < num_winning; i++) {
			if (n == numbers[i]) {
				num_winners++;
				break;
			}
		}
	}

.	;

%%

int main()
{
	yylex();
	printf("%d\n", cards);
}
