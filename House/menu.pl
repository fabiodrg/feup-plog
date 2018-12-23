:-use_module(library(lists)).
:-use_module(library(clpfd)).
:-use_module(library(between)).
:-['solver'].
:-['utils'].
:-['generator'].
:-['puzzles'].

%
% Displays main menu
%
start:-
	print_MainMenu,
	getChar(Input),
	(
		Input = '1' -> solveUserPuzzle;
		Input = '2' -> solvePuzzle3x3;
		Input = '3' -> solvePuzzle4x4;
		Input = '4' -> solvePuzzle5x5;
		Input = '5' -> solvePuzzle6x6;
		Input = '6' -> generatePuzzle;
		nl,
		write('Please choose a valid option.'), nl,
		enterContinue, nl,
		start
	).


print_MainMenu:-
	clear_console,
	write('---------------------------------------'),nl,
	write('---------------------------------------'),nl,
	write('-            House Puzzles            -'),nl,
	write('-    Option 1: Solve Custom Puzzle    -'),nl,
	write('-  Option 2: Solve Puzzle 3x3 (fail)  -'),nl,
	write('-      Option 3: Solve Puzzle 4x4     -'),nl,
	write('-      Option 4: Solve Puzzle 5x5     -'),nl,
	write('-      Option 5: Solve Puzzle 6x6     -'),nl,
	write('-   Option 6: Solve Generated Puzzle  -'),nl,
	write('-        Option : Exit Puzzle         -'),nl,
	write('---------------------------------------'),nl,
	write('---------------------------------------'),nl.

getUserPuzzle(PuzzleList,Lenght):-
	write('Select the size of the board.'), nl,
	read(Size),
	skip_line,
	createBoard(Board,Size),
	clear_console,
	write('To stop entering coordinates enter "f." in both row and collumn'), nl,
	display_withcoords(Board),
	getCoords([],Board,Size,0,NewList),
	sort(NewList,SortedList),
	verify_list(SortedList),
	Lenght = Size,
	PuzzleList = SortedList.

solveUserPuzzle:-
	getUserPuzzle(ListHouses,Size),
	clear_console,
	write('---------------------------------------'),nl,
	write('Original board:'), nl,
	write('---------------------------------------'),nl,
	showHousesOnly(ListHouses, Size),
	% run solver %
	solver(ListHouses, Size, ListPairedHouses),
	write('---------------------------------------'),nl,
	write('Final board:'), nl,
	write('---------------------------------------'),nl,
	showPairedHouses(ListHouses, Size, ListPairedHouses).

verify_list(List):-
	length(List, Size),
	Size >= 4,!.
verify_list(_):-
	clear_console,
	write('Invalid Input'), nl,
	write('Create a new Board'),nl,
	startPuzzle.


checkInput(Xpos,Ypos,Size):-
	number(Ypos),
	between(0, Size,Ypos),
	number(Xpos),
	between(0, Size,Xpos).
		

%%getCoords(FinalList,_,_,FinalList).
getCoords(List,Board,Size,Counter,FinalList):-
	write('Where do you want to put the House'),nl,
	askCoords(Ypos-Xpos), 
	checkInput(Xpos,Ypos,Size),
	nth0(Counter,NewList,[Xpos,Ypos],List),
	Counter1 is Counter + 1,
	replace_in_matrix(Xpos-Ypos,Board,h,NewBoard),
	display_withcoords(NewBoard),
	getCoords(NewList,NewBoard,Size,Counter1,FinalList),!.

getCoords(FinalList,_,_,_,FinalList):-
	write('List Built'),nl.

fillBoard(Board,Size,NewBoard,Points,List):-
	write('Where do you want to put the House'),nl,
	askCoords(Ypos-Xpos), 
	checkInput(Xpos,Ypos,Size),
	write(Board),
	replace_in_matrix(Xpos-Ypos,Board,h,NewBoard),
	display_withcoords(NewBoard),
	append(Points,Xpos-Ypos,List),
	fillBoard(NewBoard,Size,_,List,_).


solveDefaultPuzzle(ListHouses, Size):-
	clear_console,
	write('---------------------------------------'),nl,
	write('Original board:'), nl,
	write('---------------------------------------'),nl,
	showHousesOnly(ListHouses, Size),
	% run solver %
	solver(ListHouses, Size, ListPairedHouses),
	write('---------------------------------------'),nl,
	write('Final board:'), nl,
	write('---------------------------------------'),nl,
	showPairedHouses(ListHouses, Size, ListPairedHouses).

solvePuzzle3x3:-
	puzzle_3x3_fail(ListHouses),
	solveDefaultPuzzle(ListHouses,3).

solvePuzzle4x4:-
	puzzle_4x4_2(ListHouses),
	solveDefaultPuzzle(ListHouses,4).

solvePuzzle5x5:-
	% takes some time, like 30 seconds %
	puzzle_5x5_2(ListHouses),
	solveDefaultPuzzle(ListHouses,5).

solvePuzzle6x6:-
	puzzle_6x6_2(ListHouses),
	solveDefaultPuzzle(ListHouses,6).

generatePuzzle:-
	clear_console,
	write('---------------------------------------'),nl,
	write('Generated board:'), nl,
	write('---------------------------------------'),nl,
	BoardSize = 5,
	generator(BoardSize, ListHouses, 6),
	showHousesOnly(ListHouses, BoardSize),
	% run solver %
	solver(ListHouses, BoardSize, ListPairedHouses),
	write('---------------------------------------'),nl,
	write('Solved board:'), nl,
	write('---------------------------------------'),nl,
	showPairedHouses(ListHouses, BoardSize, ListPairedHouses).