:-use_module(library(clpfd)).
:-use_module(library(lists)).

/**/
example(
	[
		[0,0], [1,0], 
		[0,1], [2,1]
	]).

example1(
	[
		[0,0], [2,0], [3,0],
		[2,1], [3,1],
		[2,2],
		[0,3], [3,3] 
	]).

example2(
	[
		[0,0], [0,1], [0,3],
		[2,0], [2,3],
		[3,1]
	]).

example3([
	[0,0], [0,1], [1,0], [1,1]
	]).
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

solver(ListHouses, PuzzleSize):-
	% a list with the two possible distances (distinct) %
	MaxDistance is PuzzleSize*PuzzleSize,
	domain([D1,D2], 1, MaxDistance),
	all_distinct([D1,D2]),
	% create an auxiliar list with indexes for the list of houses %
	% the elements in list of houses are lists with a pair of values X and Y %
	% the predicate element only works with indexes, thus we need list of houses %
	length(ListHouses, NumHouses),
	length(Indexes, NumHouses),
	domain(Indexes, 1, NumHouses),
	all_distinct(Indexes),
	labeling([],Indexes),
	% find the distances %
	findDistances(Indexes, ListHouses, D1, D2),
	labeling([],[D1,D2]),
	write(D1), write('-'),
	write(D2).

findDistances([], _, _, _).
% The plog  %
findDistances(Indexes, ListHouses, D1, D2):-
	% get the minimum and maximum %
	%domain([IndexHouse1, IndexHouse2], 1, NumHouses),
	% pick one house %
	element(_, Indexes, IndexHouse1),
	nth1(IndexHouse1, ListHouses, P1),
	% pick second house %
	element(_, Indexes, IndexHouse2),
	nth1(IndexHouse2, ListHouses, P2),
	% ensure both index are different %
	IndexHouse1 #\= IndexHouse2,
	% compute distance %
	distance(P1, P2, D),
	D #= D1 #\ D #= D2, % attempt to link D to D1 or D2
	% remove the indexes from list %
	delete(Indexes, IndexHouse1, Aux1),
	delete(Aux1, IndexHouse2, Aux2),
	findDistances(Aux2, ListHouses, D1, D2).