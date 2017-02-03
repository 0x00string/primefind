#!/usr/bin/python
i = 1
while i < 10001:
        for c in range(i - 1,0,-1):
                r = i % c
                if r is 0:
                        if c is 1:
                                print str(i)
                        else:
                                break
	i = i + 1
