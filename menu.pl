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

play:-
  clear_console,
  write('---------------------------------------'),nl,
  write('---------------------------------------'),nl,
  write('-          KnightLine Line            -'),nl,
  write('-        Option 1: Play Game          -'),nl,
  write('-       Option 2: Read Instructions   -'),nl,
  write('-       Option 3: Exit Game           -'),nl,
  write('---------------------------------------'),nl,
  write('---------------------------------------'),nl.








printGameMenu:-
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

create_move(Player,InitialCoords,FinalCoords,Number,Move):-
  Move = [Player,InitialCoords,FinalCoords,Number,Number].


make_move(Board,Player):-
  write('From?'),
  nl,
  read(X1),
  read(Y1),
  nl,
  valid_moves(Board,Player,ValidMoves),
  write(ValidMoves),
  nl,
  write('Where to?'),
  nl,
  read(X2),
  read(Y2),
  nl,
  write('How Many Pieces?'),
  nl,
  read(Number),
  create_move(b,X1-Y1,X2-Y2,Number,Move),
  move(Move,Board,NewBoard),
  display_game(NewBoard).
