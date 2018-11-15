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
  write('3 - Computer VS Computer'),
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

test_move:-
  initialBoard(X),
  display_game(X),
  make_move(X,b).

create_move(Player,InitialCoords,FinalCoords,Number,Move):-
  Move = [Player,X1-Y1,X2-Y2,Number].


make_move(Board,Player):-
  write('From?'),
  getInt(X1),
  getInt(Y1),
  nl,
  valid_moves(Board,Player,ValidMoves),
  write(ValidMoves),
  nl,
  write('Where to?'),
  getInt(X2),
  getInt(Y2),
  nl,
  write('How Many Pieces?'),
  getInt(Number),
  create_move(Player,X1-Y1,X2-Y2,Number,Move),
  move(Move,Board,NewBoard),
  display_game(NewBoard,Player).
