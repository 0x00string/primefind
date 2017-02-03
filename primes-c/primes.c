#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(void){
	unsigned int i;
	unsigned int count;
	i = 2;
	while (i < 10001) {
		for (count = i - 1; count > 0; count--) {
			if (i % count == 0) {
				if (count == 1) {
					printf("%d\n",i);
				} else {
					break;
				}
			}
		}
		i++;
	}
	exit(0);
}
