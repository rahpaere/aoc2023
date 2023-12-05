#include <assert.h>
#include <ctype.h>
#include <stdbool.h>
#include <stdio.h>

int main()
{
	bool first = false;
	int digit;
	int total = 0;
	char c;

	while ((c = getchar()) != EOF) {
		if (c == '\n') {
			assert(first); /* can a line have no digits? */
			total += digit;
			first = false;
		} else if (isdigit(c)) {
			digit = c - '0';
			if (!first) {
				first = true;
				total += digit * 10;
			}
		}
	}

	printf("%d\n", total);
}
