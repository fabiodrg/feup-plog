:-use_module(library(clpfd)).
:-use_module(library(lists)).
:-['utils'].
:-['puzzles'].
:-['print'].

%
% Attempts to solve the house puzzle
% +ListHouses : A list of house's coordinates, where each element is a list of two values, X and Y
% +PuzzleSize : The puzzle's size
% -PairedHouses : The list of paired houses. It returns a list of lists, where the last contains two values which are the indexes of the paired houses. A value of 1 means the first element from ListHouses, and so forth
solver(ListHouses, PuzzleSize, PairedHouses):-
	% a list with the two possible distances (distinct) %
	% the maximum distance is between top left corner and bottom right corner %
	MaxDistance is PuzzleSize*PuzzleSize,
	length(Distances, 2),
	domain(Distances, 1, MaxDistance),

	% create an auxiliar list with indexes for the list of houses %
	% the elements in list of houses are lists with a pair of values X and Y %
	% the predicate element only works with indexes, thus we need list of houses %
	length(ListHouses, NumHouses), % instantiate the number of houses %
	length(Indexes, NumHouses), % create list with 'number of houses' placeholders %
	domain(Indexes, 1, NumHouses), % set domain as 1..'number of houses'%
	all_distinct(Indexes), % each index must be unique %
	labeling([],Indexes), % fill Indexes list %

	% prepare statistics %
	statistics(walltime, _),

	% find distances %
	findDistances(Indexes, ListHouses, [], PairedHouses, Distances),
	labeling([middle], Distances),

	% ensure there are exactly two different distances between paired houses %
	exactlyTwoDistances(PairedHouses, ListHouses),

	% end statistics %
	statistics(walltime, [_, ElapsedTime | _]),

	% display statistics %
	format('Time: ~3d', ElapsedTime), nl,
	fd_statistics, nl.

	% display board %
	

%
% Attempts to create pairs of houses enforcing two common distances for all pairs
% +Indexes: List of indexes for the houses [1,2,...,N]. This list is auxiliar and each index maps to a house, i.e, a value 1 is mapped to the first house in ListHouses
% +ListHouses: A list of houses, where each element is a list of two elements, the house coordinates [X,Y]
% +AuxPairedHouses: Should start empty. It records already mapped houses
% -AllPairedHouses: The final list of paired houses. This is a list of lists, where the inner lists have two values, the indexes of the paired houses
% +ListDistances: A list of domain variables to be unified with the paired houses distances
findDistances(Indexes, ListHouses, AllPairedHouses, ListDistances):-
	findDistances(Indexes, ListHouses, [], AllPairedHouses, ListDistances).

findDistances([], _, X, X, _).
findDistances(Indexes, ListHouses, AuxPairedHouses, AllPairedHouses, ListDistances):-
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
	element(_, ListDistances, D), % attempt to link D to D1 or D2
	% remove the indexes from list %
	delete(Indexes, IndexHouse1, Aux1),
	delete(Aux1, IndexHouse2, Aux2),
	findDistances(Aux2, ListHouses, [ [IndexHouse1, IndexHouse2] | AuxPairedHouses], AllPairedHouses, ListDistances).

%
% Ensures there are exactly two different distances between the paired houses
% +ListPairedHouses
% +ListHouses
%
exactlyTwoDistances(ListPairedHouses, ListHouses):-
	% get a list with all paired houses distances %
	getAllDistances(ListPairedHouses, ListHouses, L),
	
	% sort and remove duplicates %
	sort(L, LSorted),
	
	% ensure length two %
	length(LSorted, ListSize),
	ListSize #= 2.

%
% Gets all distances between paired houses
% +ListPairedHouses
% +ListHouses
% -ListAllDistances
getAllDistances(ListPairedHouses, ListHouses, ListAllDistances):-
	getAllDistances([], ListAllDistances, ListPairedHouses, ListHouses).
getAllDistances(L, L, [], _).
getAllDistances(ListDistances, L, [H|T], ListHouses):-
	nth0(0, H, House1),
	nth0(1, H, House2),
	nth1(House1, ListHouses, P1),
	nth1(House2, ListHouses, P2),
	distance(P1, P2, D),
	append(ListDistances, [D], NewListDistaces),
	getAllDistances(NewListDistaces, L, T, ListHouses).

% Generates board
getPuzzleBoard(_, [], Board, Board, _).
getPuzzleBoard(ListHouses, [[Index1,Index2 | []] | T], Board, FinalBoard, PairNum):-
	% get houses coordinates %
	nth1(Index1, ListHouses, HouseCoord1),
	nth1(Index2, ListHouses, HouseCoord2),
	getCoordX(X1, HouseCoord1), getCoordY(Y1, HouseCoord1),
	getCoordX(X2, HouseCoord2), getCoordY(Y2, HouseCoord2),
	% fill board %
	replace_in_matrix(X1-Y1, Board, PairNum, Board1),
	replace_in_matrix(X2-Y2, Board1, PairNum, Board2),
	% inc %
	NextPairNum is PairNum + 1,
	getPuzzleBoard(ListHouses, T, Board2, FinalBoard,NextPairNum).

getPuzzleBoardHousesOnly([], Board, Board).
getPuzzleBoardHousesOnly([[X,Y | []] | T], Board, FinalBoard):-
	% fill board %
	replace_in_matrix(X-Y, Board, 8, Board1),
	getPuzzleBoardHousesOnly(T, Board1, FinalBoard).