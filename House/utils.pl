:- use_module(library(between)).

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

% Clears the console
clear_console:-
	clear_console(30),!.

clear_console(0).
clear_console(X):-
	nl,
	X1 is X-1,
	clear_console(X1).

enterContinue:-
    write('Press Enter'), nl,
    continue, !.

continue:-
    get_char(_).

%% print board %%

display_withcoords(Board):-
  insert_Coords(Board,X1),
  display_game(X1).

display_game([]):-
    nl.

display_game([H|T]):-
    print_line(H),
    nl,
    display_game(T).

print_line([]).
print_line([H|T]):-
        print_cell(H),
        print_line(T).

print_cell(X):-
    translate(X,W),
    write(W),
    write('|').

print_cell(X):-
  write(X),
  write('  |').

translate(h,'H  ').
translate(e,'   ').




% Gets a single character from stream

getChar(Input):-
    get_char(Input),
    get_char(_).


% Gets a single digit from stream. This predicate ensures the input is a digit between 0 and 9
getInt(Input):-
	get_code(TempInput),
	% compute the decimal digit by subtracting 48, the ASCII code for number 0 %
	Input is TempInput - 48.


% Gets numbers from the user. It reads numbers until a non-digit character is found
% Thus, if the input users types 123abc, it parses 123, reads 'a' which is invalid, but 'bc' remains in the buffer
getNumber(Number):-
	getInt(Input) -> (
		getNumber(RemainderNumber) -> (
			getNumberLen(RemainderNumber, L),
			Aux = integer(Input*exp(10,L)),
			Number is Aux + RemainderNumber
		) ; (
			Number = Input	
		)
	).

/* Computes how many digits a number has */
getNumberLen(Number, Size):-
	getNumberLen_(Number, 0, Size).
getNumberLen_(Number, CurrentSize, Size):-
	Number < 10, Number >= 0,
	Size is CurrentSize + 1.
getNumberLen_(Number, CurrentSize, Size):-
	Number > 9,
	Aux is Number / 10,
	NewSize is CurrentSize + 1,
	getNumberLen_(Aux, NewSize, Size).



askCoords(RowDst-ColDst):-
	% ask the destination coordinates %
	write('[To] Row ? '),nl,  read(RowDst), continue,
	write('[To] Column ? '),nl, read(ColDst), continue.

%%%% Board Predicates


createBoard(Size,Board):-
    findall(e, between(1, Size, _), List),
	findall(List, between(1, Size, _), Board).

insert_Coords(Board,NewBoard):-
    proper_length(Board,VerticalLength),
    insert_vertical(Board,VerticalLength,0,FinalBoard),
    last(FinalBoard,List),
    proper_length(List,HorizontalLength),
    create_hindex_list([],HorizontalLength,0,FinalList),
    nth0(0,NewBoard,FinalList,FinalBoard).

insert_vertical(FinalBoard,Size,Size,FinalBoard).
insert_vertical(Board,Size,Index,FinalBoard):-
  Index < Size,
  nth0(Index,Board,Elem),
  nth0(0,NewElem,Index,Elem),
  replace_item(Board,Index,NewElem,NewBoard),
  Index1 is Index+1,
  insert_vertical(NewBoard,Size,Index1,FinalBoard).

replace_item([_|T],0,Element,[Element|T]).
replace_item([H|T],Index,Element,[H|R]):-
  Index > -1,
  NewIndex is Index-1,
  replace_item(T,NewIndex,Element,R).

replace_in_matrix(X1-Y1,Board,Element,NewBoard):-
  get_elem(Board,Y1,ElemList),
  replace_item(ElemList,X1,Element,NewList),
  replace_item(Board,Y1,NewList,NewBoard).

get_elem(Board,Index,Elem):-
    nth0(Index,Board,Elem).

create_hindex_list(FinalList,Size,Size,FinalList).
create_hindex_list(List,Size,Index,FinalList):-
    Index < Size,
    Index = 0 ->
    nth0(Index,Newlist,e,List),
    Index1 is Index+1,
    create_hindex_list(Newlist,Size,Index1,FinalList);
    Index2 is Index-1,
    nth0(Index,Newlist,Index2,List),
    Index1 is Index+1,
    create_hindex_list(Newlist,Size,Index1,FinalList),
    FinalList = NewList.
