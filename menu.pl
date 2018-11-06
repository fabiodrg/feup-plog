%%%%imports
:-['KnightLine'].
:-['utils'].
:- use_module(library(lists)).


%% code

menu:-
    write('Who starts: '),
    read(X),
    validate_start(X),
    print_initial_board(X).


validate_start(X):-
  X = 'b',
  write('Valid'),
  nl.


  validate_start(X):-
    X = 'w',
    write('Valid'),
    nl.



  move(Move,Board,NewBoard):-
    write('From to?'),
    nl,
    write('X: '),
    read(X1),
    write('Y: '),
    read(Y1),
    write('Where to?'),
    nl,
    write('X: '),
    read(X2),
    write('Y: '),
    read(Y2).
    take_piece(X1-Y1,Board,Piece).
