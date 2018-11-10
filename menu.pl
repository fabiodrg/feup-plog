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



printMainMenu:-
  clear_console,
  write('1 - Player VS Player'),
  nl,
  write('2 - Payer VS Computer '),
  nl,
  write('3 - Computer VS Computer')
  nl,
  write('Choose an option:  '),nl,
  getChar(Input),
  getMenuInput(Input).


getMenuInput(Input):-
  Input = '2',
  startPlayerVPlayer.

getMenuInput(Input):-
  Input = '3',
  startPlayerVComputer.

getMenuInput(Input):-
  Input = '4',
  startComputerVComputer.


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
