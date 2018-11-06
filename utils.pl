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

replace_in_matrix(X1-Y1,Board,Element):-
  get_elem(Board,Y1,ElemList),
  replace_item(ElemList,X1,Element,NewList),
  replace_item(Board,Y1,NewList,NewBoard),
  write(NewBoard).




move_piece(X1-Y1,X2-Y2,Number,Board,NewBoard):-
  take_piece(X1-Y1,Board,PiecePlayer-PieceNumber),
  CurrPieceNum is PieceNumber-Number1,
  createPiece(PiecePlayer,CurrPieceNum,NewPiece).
