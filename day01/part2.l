	#include <assert.h>
	#include <stdbool.h>
	#include <stdio.h>

	bool first = false;
	int digit;
	int calibration = 0;
	void seen(int d);

%%

0	seen(0); /* is 0 a digit in this input? */
1|one	seen(1);
2|two	seen(2);
3|three	seen(3);
4|four	seen(4);
5|five	seen(5);
6|six	seen(6);
7|seven	seen(7);
8|eight	seen(8);
9|nine	seen(9);

		/* forwards and backwards cases can overlap! */
oneight		seen(1); seen(8);
twone		seen(2); seen(1);
threeight	seen(3); seen(8);
fiveight	seen(5); seen(8);
sevenine	seen(7); seen(9);
eightwo		seen(8); seen(2);
eighthree	seen(8); seen(3);
nineight	seen(9); seen(8);

\n	{
		assert(first); /* can a line have no digits? */
		calibration += digit;
		first = false;
	}

.	/* ignore other characters */

%%

int main()
{
	yylex();
	printf("%d\n", calibration);
}

void seen(int d)
{
	digit = d;
	if (!first) {
		first = true;
		calibration += digit * 10;
	}
}
