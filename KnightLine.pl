:-[utils].
:- use_module(library(lists)).
%%%%%%%% Pecas %%%%%%

tile(e).

tile(b-X):-
    X \= 0,
    integer(X).

tile(w-X):-
    X \= 0,
    integer(X).

player(b).

player(w).


%%% Boards %%%%%

initialBoard([
        [e,e,e,e],
        [e,b-20,w-20,e],
        [e,e,e,e]
    ]).


midBoard([
        [e,e,e,e,e,e],
        [e,e,e,b-9,w-15,e],
        [e,b-1,w-5,e,e,e],
        [e,e,b-10,e,e,e],
        [e,e,e,e,e,e]
    ]).


finalBoard([
    [e,e,e,b-4,e,e],
    [e,e,w-4,b-4,b-4,b-1],
    [e,e,b-3,w-3,w-3,e],
    [b-2,w-2,w-2,w-2,b-2,e],
    [e,e,w-2,w-2,e,e],
    [e,w-2,e,b-2,e,e]
    ]).


%% print board %%

print_initial_board(Y):-
    initialBoard(X),
    display_game(X,Y).

print_final_board(Y):-
    finalBoard(X),
    display_game(X,Y).

print_mid_board(Y):-
    midBoard(X),
    display_game(X,Y).

display_game([],P):-
    write(' -'),
    translate(P,W),
    write(W).


display_game([H|T],P):-
    print_line(H),
    nl,
    display_game(T,P).


print_line([]).
print_line([H|T]):-
        print_cell(H),
        print_line(T).

% print cells where Y < 10 %
print_cell(X-Y):-
    Y < 10,
    translate(X,W),
    write(W),
    write(Y),
    write(' |').

% print cells where Y > 10 %
print_cell(X-Y):-
    Y >= 10,
    translate(X,W),
    write(W),
    write(Y),
    write('|').

print_cell(X):-
    translate(X,W),
    write(W),
    write('|').

translate(b,'B').
translate(w,'W').
translate(e,'   ').

%%% validate moves

%%valid_move(Board,Piece,Move):-
test:-
  initialBoard(Board),
  findall(X,(move(1-1,X,Board), X \=e), Results),
  write(Results).

test2:-
  midBoard(Board),
  valid_moves(Board,b,ListOfMoves),
  write(ListOfMoves).

test3:-
  initialBoard(Board),
  move([b,1-1,3-0,5],Board,NewBoard),
  write(NewBoard),
  nl,
  display_game(NewBoard,b).


testBoard([
[e,e,e,b-4,e,e],
[e,e,w-4,b-4,b-4,b-1],
[e,e,b-3,w-3,w-3,e],
[b-2,w-2,w-2,w-2,b-2,e],
[e,e,w-2,w-2,e,e],
[e,w-2,e,w-2,e,e]
]).

test4:-
  finalBoard(Board),
  game_over(Board,Winner),
  nl,
  write(Winner).

test5:-
  midBoard(Board),
  value(Board,b,_).

%%%value group of functions
%%% esta nã consegui implementar ainda mas tinha que dá um valor mediante a posição das peças num tabuleiro
/* a minha ideia tinha sido verificar todas a peças de um determinado jogador
cada peça verificava quantas tem nas diferentes posições possiveis de vitoria
cada vez que houvesse uma peça seguida somava um ao valor que era inicializado a 0
o valor usado era o maior entre todas as direcções.
Por exemplo se o maior numero de peças pretas seguidas fosse para baixo,
supondo que havia 2 peças seguidas para o lado direito e 3 para baizo o value era 3
*/
/*Notas do professor contar melhor jogada o numero de filas de peças seguidas maiores que uma*/
value(Board,Player,Value):-
  findall(X,take_piece(X,Board,Player-_),Results),
  check_all_pieces(Results,Board,Value,Player).

check_all_pieces([],Board,Value,Player).
check_all_pieces([H|T], Board,Value,Player):-
  check_down(H,Board,Value,Player,NewValue),
  check_right(H,Board,Value,Player,NewValue2),
  check_rightdiagonal(H,Board,Value,Player),
  check_leftdiagonal(H,Board,Value,Player),
  check_all_pieces(T,Board,Value,Player).

check_down(X-Y,Board,Value,Player,NewValue):-
  Y1 is Y+1,
  take_piece(X-Y1,Board,PieceColor-_),
  PieceColor = Player,
  Value1 is Value+1,
  check_down(X-Y1,Board,Value1,Player),
  NewValue = Value1.

check_right(X-Y,Board,Value,Player,NewValue):-
  X1 is X+1,
  take_piece(X1-Y,Board,PieceColor-_),
  PieceColor = Player,
  Value1 is Value+1,
  check_right(X1-Y,Board,Value1,Player),
  NewValue = Value1.

check_rightdiagonal(X-Y,Board,Value,Player,NewValue):-
  X1 is X+1,
  Y1 is Y+1,
  take_piece(X1-Y1,Board,PieceColor-_),
  PieceColor = Player,
  Value1 is Value+1,
  check_ightdiagonal(X1-Y1,Board,Value1,Player),
  NewValue = Value1.

check_leftdiagonal(X-Y,Board,Value,Player,NewValue):-
  X1 is X-1,
  Y1 is Y+1,
  take_piece(X1-Y1,Board,PieceColor-_),
  PieceColor = Player,
  Value1 is Value+1,
  check_leftdiagonal(X1-Y1,Board,Value1,Player),
  NewValue = Value1.

%%% Verifica se algum dos jogadores retorna a cor do jogador que venceu, VER TEST EXEMPLO 4

game_over(Board,Winner):-
  take_piece(X-Y,Board,Color-_),
  X1 is X+1,
  take_piece(X1-Y,Board,ColorHorizontal-_),
  Color = ColorHorizontal,
  check_horizontal_win(X1-Y,Board,ColorHorizontal-_,Winner).

game_over(Board,Winner):-
  take_piece(X-Y,Board,Color-_),
  X1 is X+1,
  Y1 is Y+1,
  take_piece(X1-Y1,Board,ColorHorizontal-_),
  Color = ColorHorizontal,
  check_diagonal_win(X1-Y1,Board,ColorHorizontal-_,Winner).

game_over(Board,Winner):-
  take_piece(X-Y,Board,Color-_),
  X1 is X-1,
  Y1 is Y+1,
  take_piece(X1-Y1,Board,ColorHorizontal-_),
  Color = ColorHorizontal,
  check_otherdiagonal_win(X1-Y1,Board,ColorHorizontal-_,Winner).

game_over(Board,Winner):-
  take_piece(X-Y,Board,Color-_),
  Y1 is Y+1,
  take_piece(X-Y1,Board,ColorHorizontal-_),
  Color = ColorHorizontal,
  check_vertical_win(X-Y1,Board,ColorHorizontal-_,Winner).

check_vertical_win(X-Y,Board,Color-_,ColorWon):-
  Y1 is Y+1,
  take_piece(X-Y1,Board,ColorCheck-_),
  Color = ColorCheck,
  Y2 is Y+1,
  take_piece(X-Y2,Board,ColorCheck2-_),
  Color = ColorCheck2,
  write('Vertical'),
  ColorWon is Color.

check_diagonal_win(X-Y,Board,Color-_,ColorWon):-
  X1 is X+1,
  Y1 is Y+1,
  take_piece(X1-Y1,Board,ColorCheck-_),
  Color = ColorCheck,
  X2 is X1+1,
  Y2 is Y1+1,
  take_piece(X2-Y2,Board,ColorCheck2-_),
  Color = ColorCheck2,
  write('Diagonal'),
  ColorWon is Color.

check_otherdiagonal_win(X-Y,Board,Color-_,ColorWon):-
  X1 is X-1,
  Y1 is Y+1,
  take_piece(X1-Y1,Board,ColorCheck-_),
  Color = ColorCheck,
  X2 is X1-1,
  Y2 is Y1+1,
  take_piece(X2-Y2,Board,ColorCheck2-_),
  Color = ColorCheck2,
  write('Other Diagonal'),
  ColorWon = Color.

check_horizontal_win(X-Y,Board,Color-_,ColorWon):-
  X1 is X+1,
  take_piece(X1-Y,Board,ColorCheck-_),
  Color = ColorCheck,
  X2 is X1+1,
  take_piece(X2-Y,Board,ColorCheck2-_),
  Color = ColorCheck2,
  write('Horizontal'),
  ColorWon = Color.

%%% faz os moves e retorna o new board o move tem que ser do tipo [cor,pos inicial,pos final, num de peças] VER TEST EXEMPLO 3
move(Move,Board,NewBoard):-
  nth0(0,Move,PlayerColor),
  valid_moves(Board,PlayerColor,List),
  nth0(2,Move,Destiny),
  member(Destiny,List),
  nth0(1,Move,Source),
  nth0(3,Move,Number),
  move_piece(Source,Destiny,Number,Board,NewBoard).

%%% retorna lista de valid_moves, VER  TEST EXEMPLO 2
valid_moves(Board,Player,ListOfMoves):-
  findall(X,take_piece(X,Board,Player-_),Results),
  check_forall(Results,Board,ListOfMoves,[]).

check_forall([], _, Acc, Acc).
check_forall([H|T], Board, ListOfMoves, Acc):-
    	findall(X,(moves(H,X,Board), X \=e), Results),
    	append(Results, Acc, Acc1),
    	check_forall(T, Board, ListOfMoves, Acc1).

  moves(X1-Y1,X2-Y2,Board):-
    X2 is X1+2,
    Y2 is Y1-1,
    findall(X,(check_adjacent_coords(Board,X2-Y2,X), X \=e), Results),
    Results \= [].

  moves(X1-Y1,X2-Y2,Board):-
    X2 is X1+2,
    Y2 is Y1+1,
    findall(X,(check_adjacent_coords(Board,X2-Y2,X), X \=e), Results),
    Results \= [].

  moves(X1-Y1,X2-Y2,Board):-
    X2 is X1-1,
    Y2 is Y1-2,
    findall(X,(check_adjacent_coords(Board,X2-Y2,X), X \=e), Results),
    Results \= [].

  moves(X1-Y1,X2-Y2,Board):-
    X2 is X1-2,
    Y2 is Y1-1,
    findall(X,(check_adjacent_coords(Board,X2-Y2,X), X \=e), Results),
    Results \= [].

  moves(X1-Y1,X2-Y2,Board):-
    X2 is X1-2,
    Y2 is Y1+1,
    findall(X,(check_adjacent_coords(Board,X2-Y2,X), X \=e), Results),
    Results \= [].

  moves(X1-Y1,X2-Y2,Board):-
    X2 is X1-1,
    Y2 is Y1+2,
    findall(X,(check_adjacent_coords(Board,X2-Y2,X), X \=e), Results),
    Results \= [].

  moves(X1-Y1,X2-Y2,Board):-
    X2 is X1+1,
    Y2 is Y1+2,
    findall(X,(check_adjacent_coords(Board,X2-Y2,X), X \=e), Results),
    Results \= [].

  moves(X1-Y1,X2-Y2,Board):-
    X2 is X1+1,
    Y2 is Y1-2,
    findall(X,(check_adjacent_coords(Board,X2-Y2,X), X \=e), Results),
    Results \= [].


askPlayerInput(RowSrc-ColSrc, Num, RowDst-ColDst):-
	% ask the source stack coordinates %
	write('Player X, write the row and col coordinates for stack source'), nl,
	write('Row ? '), getInt(RowSrc), getInt(_),
	write('Column ? '), getInt(ColSrc), getInt(_),
	% ask how many tiles to be moved %
	write('How many tiles ? '), getInt(Num), getInt(_),
	% ask the destination coordinates %
	write('Write the row and col for stack destination'), nl,
	write('Row ? '), getInt(RowDst), getInt(_),
	write('Column ? '), getInt(ColDst), getInt(_).