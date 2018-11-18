:- use_module(library(lists)).


%%%%% matrix utilities


createEmptyRow(BoardWith,Row):-
	createEmptyRow(BoardWith, [], Row).
createEmptyRow(0,Row,Row).
createEmptyRow(BoardWidth,Row,NewRow):-
	BoardWidth \= 0,
	NewBoardWidth is BoardWidth - 1,
	append(Row,[e],Aux),
	write(Aux),nl,
	createEmptyRow(NewBoardWidth,Aux,NewRow).

%stretchBoard(Board).

appendEmptyRowTop(Board, NewBoard):-
	get_width(Board,HorizontalLength),
	createEmptyRow(HorizontalLength, EmptyRow),
	append([EmptyRow], Board, NewBoard).

appendEmptyRowBottom(Board, NewBoard):-
	get_width(Board,HorizontalLength),
	createEmptyRow(HorizontalLength, EmptyRow),
	append(Board, [EmptyRow], NewBoard).

appendEmptyRowLeft([], []).
appendEmptyRowLeft([H|T], [Hnew|Tnew]):-
	append([e], H, Hnew),
	appendEmptyRowLeft(T, Tnew).

appendEmptyRowRight([], []).
appendEmptyRowRight([H|T], [Hnew|Tnew]):-
	append(H, [e], Hnew),
	appendEmptyRowRight(T, Tnew).
	
%stretchBoardVertically(Board):-
	%(/+ isRowEmpty(Board, 0) -> proper_length(Board,VerticalLength), insert_vertical(Board,VerticalLength,0,FinalBoard)).

isRowEmpty([H|T], N):-
	% find the row in the matrix %
	nth0(N, [H|T], Row),
	% check if all vals are 'e' %
	isRowEmpty(Row).

isRowEmpty([]).

isRowEmpty([H|T]):-
	H = e,
	isRowEmpty(T).

isColumnEmpty([], _).
isColumnEmpty([H|T], N):-
	% H is a list, the first matrix row %
	nth0(N, H, Tile),
	Tile = e,
	isColumnEmpty(T, N).

%%%%%%%%%%% until here

%%% insert coords

insert_Coords(Board,NewBoard):-
    proper_length(Board,VerticalLength),
    insert_vertical(Board,VerticalLength,0,FinalBoard),
    last(FinalBoard,List),
    proper_length(List,HorizontalLength),
    create_hindex_list([],HorizontalLength,0,FinalList),
    nth0(0,NewBoard,FinalList,FinalBoard).


test_insertBoard:-
  insert_Coords([
          [e,e,e,e],
          [e,b-20,w-20,e],
          [e,e,e,e]
      ],X1),
  write(X1).

test_insert:-
  create_hindex_list([],5,0,FinalList),
  write(FinalList).

test_insertVertical:-
  insert_vertical([
          [e,e,e,e],
          [e,b-20,w-20,e],
          [e,e,e,e]
      ],3,0,FinalBoard),
      write(FinalBoard).


insert_vertical(FinalBoard,Size,Size,FinalBoard).
insert_vertical(Board,Size,Index,FinalBoard):-
  Index < Size,
  nth0(Index,Board,Elem),
  nth0(0,NewElem,Index,Elem),
  replace_item(Board,Index,NewElem,NewBoard),
  Index1 is Index+1,
  insert_vertical(NewBoard,Size,Index1,FinalBoard).




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


%%% para ter um elemento de uma certa posição numa list
get_elem(Board,Index,Elem):-
  nth0(Index,Board,Elem).
%%% n esta a ser usada atm, semelhante à anterior
cicle_throw_pos([H|T],Number,CurrentEl):-
    Number \= 0 ->
    Number1 is Number - 1,
    cicle_throw_pos(T,Number1,CurrentEl);
    CurrentEl = H.
%%%% primeiro arg coordenadas segundo board e terceiro peça, com as coord obtemos peça e com a peça obtemos as coordenadas
take_piece(X1-Y1,Board,Piece):-
  get_elem(Board,Y1,Element),
  get_elem(Element,X1,Piece).

%% devolve uma peça dando outra
createPiece(X-Y,NewPiece):-
    NewPiece = X-Y.

%% substitui um itme numa lista
replace_item([_|T],0,Element,[Element|T]).
replace_item([H|T],Index,Element,[H|R]):-
  Index > -1,
  NewIndex is Index-1,
  replace_item(T,NewIndex,Element,R).

%%% substitui uma lista numa matrix e retorna o novo board com a nova peça (Element) na posição x-y
replace_in_matrix(X1-Y1,Board,Element,NewBoard):-
  get_elem(Board,Y1,ElemList),
  replace_item(ElemList,X1,Element,NewList),
  replace_item(Board,Y1,NewList,NewBoard).

test_move:-
  midBoard(X),
  move_piece(3-1,1-2,2,X,Y),
  write(Y).

%%%move um determinado Number peça da pos x1-y1 para x2-y2  e retorna no final board
move_piece(X1-Y1,X2-Y2,Number,Board,FinalBoard):-
  take_piece(X1-Y1,Board,PiecePlayer-PieceNumber),
  NewPieceNumber is PieceNumber-Number,
  replace_in_matrix(X1-Y1,Board,PiecePlayer-NewPieceNumber,NewBoard),
  take_piece(X2-Y2,Board,Piece),
  Piece = e,
  replace_in_matrix(X2-Y2,NewBoard,PiecePlayer-Number,FinalBoard).

move_piece(X1-Y1,X2-Y2,Number,Board,FinalBoard):-
  take_piece(X1-Y1,Board,PiecePlayer-PieceNumber),
  NewPieceNumber is PieceNumber-Number,
  replace_in_matrix(X1-Y1,Board,PiecePlayer-NewPieceNumber,NewBoard),
  take_piece(X2-Y2,Board,Piece),
  Piece \= e,
  take_piece(X2-Y2,Board,X-Y),
  FinalNumber is Y + Number,
  replace_in_matrix(X2-Y2,NewBoard,PiecePlayer-FinalNumber,FinalBoard).

%%% retorna width e height de uma matrix
get_list_size(List,Width,Height):-
  proper_length(List,Height),
  last(List,Last),
  proper_length(Last,Width).


%%% retorna a width de uma matrix
get_width(List,Width):-
  get_list_size(List,Width,_).

%%% retorna a height de uma matrix
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

%%% verifica qual é a peça adjacent à one
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
