	#include <stdio.h>
	#include <stdbool.h>

	bool valid = true;
	int sum = 0;
	int id = 1;

%%

[0-9]+[ \t]+red		valid &= atoi(yytext) <= 12;
[0-9]+[ \t]+green	valid &= atoi(yytext) <= 13;
[0-9]+[ \t]+blue	valid &= atoi(yytext) <= 14;

\n	{
		if (valid)
			sum += id;
		id++;
		valid = true;
	}

.	;

%%

int main()
{
	yylex();
	printf("%d\n", sum);
}
