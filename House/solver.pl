:-use_module(library(clpfd)).
example(X):-
	[
		[0,0], [2,0], [3,0],
		[2,1], [3,1],
		[2,2],
		[0,3], [3,3] 
	].


/*
 * P1 - List [X1, Y1]
 * P2 - List [X2, Y2]
 * D? - The computed distance between the two points D1 and D2
*/
distance(P1, P2, D):-
	% element is ~ nth1
	element(1, P1, X1),
	element(2, P1, Y1),
	element(1, P2, X2),
	element(2, P2, Y2),
	D #= abs(X2-X1) * abs(X2-X1) + abs(Y2-Y1) * abs(Y2-Y1).

