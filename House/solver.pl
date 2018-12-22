:-use_module(library(clpfd)).
:-use_module(library(lists)).
:-['utils'].
:-['puzzles'].


solver(ListHouses, PuzzleSize, PairedHouses):-
	% a list with the two possible distances (distinct) %
	MaxDistance is PuzzleSize*PuzzleSize,
	domain([D1,D2], 1, MaxDistance),
	% create an auxiliar list with indexes for the list of houses %
	% the elements in list of houses are lists with a pair of values X and Y %
	% the predicate element only works with indexes, thus we need list of houses %
	length(ListHouses, NumHouses),
	length(Indexes, NumHouses),
	domain(Indexes, 1, NumHouses),
	all_distinct(Indexes),
	labeling([],Indexes),
	% find the distances %
	findDistances(Indexes, ListHouses, [], PairedHouses, D1, D2),
	statistics(walltime, _),
	labeling([enum],[D1,D2]),
	statistics(walltime, [_, ElapsedTime | _]),
	% ensure all distances are different %
	secondCheck([], L, PairedHouses, ListHouses),
	sort(L, LSorted),
	length(LSorted, ListSize), ListSize #= 2,
	write(D1), write('-'),write(D2),
	format('Time: ~3d', ElapsedTime), nl,
	fd_statistics.

findDistances([], _, X, X, _, _).
% The plog  %
findDistances(Indexes, ListHouses, AuxPairedHouses, AllPairedHouses, D1, D2):-
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
	findDistances(Aux2, ListHouses, [ [IndexHouse1, IndexHouse2] | AuxPairedHouses], AllPairedHouses, D1, D2).

secondCheck(L, L, [], _).
secondCheck(ListDistances, L, [H|T], ListHouses):-
	nth0(0, H, House1),
	nth0(1, H, House2),
	nth1(House1, ListHouses, P1),
	nth1(House2, ListHouses, P2),
	distance(P1, P2, D),
	append(ListDistances, [D], NewListDistaces),
	secondCheck(NewListDistaces, L, T, ListHouses).