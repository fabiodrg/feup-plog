:- use_module(library(lists)).


%%%%% matrix utilities

get_elem(Board,Index,Elem):-
  nth0(Index,Board,Elem).

cicle_throw_pos([H|T],Number,CurrentEl):-
    Number \= 0 ->
    Number1 is Number - 1,
    cicle_throw_pos(T,Number1,CurrentEl);
    CurrentEl = H.

take_piece(X1-Y1,Board,Piece):-
  get_elem(Board,Y1,Element),
  get_elem(Element,X1,Piece).

createPiece(X-Y,NewPiece):-
    NewPiece = X-Y.

replace_item([_|T],0,Element,[Element|T]).

replace_item([H|T],Index,Element,[H|R]):-
  Index > -1,
  NewIndex is Index-1,
  replace_item(T,NewIndex,Element,R).

replace_in_matrix(X1-Y1,Board,Element,NewBoard):-
  get_elem(Board,Y1,ElemList),
  replace_item(ElemList,X1,Element,NewList),
  replace_item(Board,Y1,NewList,NewBoard).

move_piece(X1-Y1,X2-Y2,Number,Board,FinalBoard):-
  take_piece(X1-Y1,Board,PiecePlayer-PieceNumber),
  NewPieceNumber is PieceNumber-Number,
  replace_in_matrix(X1-Y1,Board,PiecePlayer-Number,NewBoard),
  replace_in_matrix(X2-Y2,NewBoard,PiecePlayer-Number,FinalBoard).

get_list_size(List,Width,Height):-
  proper_length(List,Height),
  last(List,Last),
  proper_length(Last,Width).

get_width(List,Width):-
  get_list_size(List,Width,_).

get_height(List,Height):-
  get_list_size(List,_,Height).

%%%valid_moves(Board,Player,ListOfMoves):-

%%%% verify is a certain piece as another as adjacent

verify_left(X-Y,Board,Piece):-
  X1 is X-1,
  take_piece(X1-Y,Board,Piece).

verify_right(X-Y,Board,Piece):-
  X1 is X+1,
  take_piece(X1-Y,Board,Piece).

verify_up(X-Y,Board,Piece):-
  Y1 is Y-1,
  take_piece(X-Y1,Board,Piece).

verify_down(X-Y,Board,Piece):-
  Y1 is Y+1,
  take_piece(X-Y1,Board,Piece).

verify_downright(X-Y,Board,Piece):-
  Y1 is Y+1,
  X1 is X+1,
  take_piece(X1-Y1,Board,Piece).

verify_downleft(X-Y,Board,Piece):-
  Y1 is Y+1,
  X1 is X-1,
  take_piece(X1-Y1,Board,Piece).

verify_topleft(X-Y,Board,Piece):-
  Y1 is Y-1,
  X1 is X-1,
  take_piece(X1-Y1,Board,Piece).

verify_topright(X-Y,Board,Piece):-
  Y1 is Y-1,
  X1 is X+1,
  take_piece(X1-Y1,Board,Piece).

check_adjacent(Board,PieceOne,PieceTwo):-
  take_piece(X-Y,Board,PieceOne),
  verify_left(X-Y,Board,Piece),
  Piece = PieceTwo,
  write('Left').

check_adjacent(Board,PieceOne,PieceTwo):-
  take_piece(X-Y,Board,PieceOne),
  verify_right(X-Y,Board,Piece),
  Piece = PieceTwo,
  write('Right').

check_adjacent(Board,PieceOne,PieceTwo):-
  take_piece(X-Y,Board,PieceOne),
  verify_up(X-Y,Board,Piece),
  Piece = PieceTwo,
  write('UP').

check_adjacent(Board,PieceOne,PieceTwo):-
  take_piece(X-Y,Board,PieceOne),
  verify_down(X-Y,Board,Piece),
  Piece = PieceTwo,
  write('DOWN').

check_adjacent(Board,PieceOne,PieceTwo):-
  take_piece(X-Y,Board,PieceOne),
  verify_downright(X-Y,Board,Piece),
  Piece = PieceTwo,
  write('DOWN_RIGHT').

check_adjacent(Board,PieceOne,PieceTwo):-
  take_piece(X-Y,Board,PieceOne),
  verify_downleft(X-Y,Board,Piece),
  Piece = PieceTwo,
  write('DOWN_LEFT').

check_adjacent(Board,PieceOne,PieceTwo):-
  take_piece(X-Y,Board,PieceOne),
  verify_topleft(X-Y,Board,Piece),
  Piece = PieceTwo,
  write('TOP_LEFT').

check_adjacent(Board,PieceOne,PieceTwo):-
  take_piece(X-Y,Board,PieceOne),
  verify_topright(X-Y,Board,Piece),
  Piece = PieceTwo,
  write('TOP_RIGHT').

%%%% verificar por coordenadas

check_adjacent_coords(Board,X-Y,Piece):-
  verify_right(X-Y,Board,Piece).

check_adjacent_coords(Board,X-Y,Piece):-
  verify_up(X-Y,Board,Piece).

check_adjacent_coords(Board,X-Y,Piece):-
  verify_down(X-Y,Board,Piece).

check_adjacent_coords(Board,X-Y,Piece):-
  verify_downright(X-Y,Board,Piece).

check_adjacent_coords(Board,X-Y,Piece):-
  verify_downleft(X-Y,Board,Piece).

check_adjacent_coords(Board,X-Y,Piece):-
  verify_topleft(X-Y,Board,Piece).

check_adjacent_coords(Board,X-Y,Piece):-
  verify_topright(X-Y,Board,Piece).


%%%%%%%% console utilities

clear_console:-
  clear_console(30),!.

clear_console(0).
clear_console(X):-
  nl,
  X1 is X-1,
  clear_console(X1).

continue:-
  get_char(_).

getChar(Input):-
  get_char(Input),
	get_char(_).

getInt(Input):-
	get_code(TempInput),
	Input is TempInput - 48.
