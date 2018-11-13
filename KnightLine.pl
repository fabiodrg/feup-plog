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
  midBoard(Board),
  move([b,2-3,4-2,5],Board,NewBoard),
  write(NewBoard).


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




move(Move,Board,NewBoard):-
  nth0(0,Move,PlayerColor),
  valid_moves(Board,PlayerColor,List),
  nth0(2,Move,Destiny),
  member(Destiny,List),
  nth0(1,Move,Source),
  nth0(3,Move,Number),
  move_piece(Source,Destiny,Number,Board,NewBoard).

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
