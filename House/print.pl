showPairedHouses(ListHouses, PuzzleSize, ListPairedHouses):-
	createBoard(EmptyBoard, PuzzleSize),
	getPuzzleBoard(ListHouses, ListPairedHouses, EmptyBoard, FinalBoard, 1),
	printPuzzleBoard(FinalBoard).


printPuzzleBoardLine([]):- write(' |').
printPuzzleBoardLine([H|T]):-
	H \= 0,
	CharCode is 64+H,
	write(' | '), put_code(CharCode), printPuzzleBoardLine(T).
printPuzzleBoardLine([H|T]):-
	H = 0,
	write(' |  '), printPuzzleBoardLine(T).

printPuzzleBoard([]).
printPuzzleBoard([H|T]):-
	printPuzzleBoardLine(H), nl,
	printPuzzleBoard(T).