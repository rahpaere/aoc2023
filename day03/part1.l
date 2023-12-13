	#include <stdbool.h>
	#include <stdio.h>
	#include <stdlib.h>

	struct number {
		struct number *next;
		int value;
		int row;
		int col;
		int width;
	};

	struct special {
		struct special *next;
		int row;
		int col;
	};

	struct number *numbers = NULL;
	struct special *specials = NULL;

	int row = 0;
	int col = 0;

	bool adjacent(struct number *n, struct special *s);

%%

[0-9]+	{
		struct number *n = malloc(sizeof(*n));
		n->next = numbers;
		n->value = atoi(yytext);
		n->row = row;
		n->col = col;
		n->width = yyleng;
		col += yyleng;
		numbers = n;
	}

\.	col++;
\n	row++; col = 0;

.	{
		struct special *s = malloc(sizeof(*s));
		s->next = specials;
		s->row = row;
		s->col = col;
		col++;
		specials = s;
	}

%%

int main()
{
	struct number *n;
	struct special *s;
	int sum = 0;

	yylex();

	for (n = numbers; n; n = n->next) {
		for (s = specials; s; s = s->next) {
			if (adjacent(n, s)) {
				sum += n->value;
				break;
			}
		}
	}

	while (numbers) {
		n = numbers->next;
		free(numbers);
		numbers = n;
	}

	while (specials) {
		s = specials->next;
		free(specials);
		specials = s;
	}

	printf("%d\n", sum);
}

bool adjacent(struct number *n, struct special *s)
{
        return abs(s->row - n->row) <= 1
		&& s->col + 1 >= n->col && n->col + n->width >= s->col;
}
