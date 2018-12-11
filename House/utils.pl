:- use_module(library(between)).


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

translate(h,'H').
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
