	#include <stdio.h>
	#include <stdbool.h>

	#define MAX(a, b) ((a) < (b) ? (b) : (a))

	int red = 0;
	int green = 0;
	int blue = 0;
	int sum = 0;

%%

[0-9]+[ \t]+red		red = MAX(red, atoi(yytext));
[0-9]+[ \t]+green	green = MAX(green, atoi(yytext));
[0-9]+[ \t]+blue	blue = MAX(blue, atoi(yytext));

\n	{
		sum += red * green * blue;
		red = green = blue = 0;
	}

.	;

%%

int main()
{
	yylex();
	printf("%d\n", sum);
}
