	#include <stdbool.h>
	#include <stdio.h>

	#define MAXWINNING 16

	int numbers[MAXWINNING];
	int num_winning;
	int num_winners;
	int score = 0;

%s winning checking

%%

:	num_winning = 0; BEGIN winning;
\|	num_winners = 0; BEGIN checking;
\n	score += (1 << num_winners) / 2; BEGIN INITIAL;

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
	printf("%d\n", score);
}
