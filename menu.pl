%%%%imports
:-['KnightLine'].
:-['utils'].
:- use_module(library(lists)).
:- use_module(library(random)).

%% code

main_menu:-
  print_MainMenu,
  getChar(Input),
  (
  Input = '1' -> select_mode,main_menu;
  Input = '2';
  nl,
  write('Please choose a valid option.'), nl,
  enter_toContinue, nl,
  main_menu
  ).


print_MainMenu:-
  clear_console,
  write('---------------------------------------'),nl,
  write('---------------------------------------'),nl,
  write('-          KnightLine Line            -'),nl,
  write('-        Option 1: Play Game          -'),nl,
  write('-        Option 2: Exit Game          -'),nl,
  write('---------------------------------------'),nl,
  write('---------------------------------------'),nl.



select_mode:-
  printGameMenu,
  getChar(Input),
  (
  Input = '1' -> startPlayerVPlayer;
  Input = '2' -> startPlayerVComputer;
  Input = '3';
  nl,
  write('Please choose a valid option.'), nl,
  enter_toContinue, nl,
  select_mode
  ).



printGameMenu:-
  clear_console,
  write('---------------------------------------'),nl,
  write('---------------------------------------'),nl,
  write('-          Select Mode                -'),nl,
  write('-      Option 1: Player Vs Computer   -'),nl,
  write('-      Option 2: Computer Vs Computer -'),nl,
  write('-      Option 3: Go Back to Menu      -'),nl,
  write('---------------------------------------'),nl,
  write('---------------------------------------'),nl.

startPlayerVComputer:-
      clear_console,
      initialBoard(Board),
      display_withcoords(Board,x),
      gamePlayerVComputer(Board).


gamePlayerVComputer(Board):-
  gameWhitePlayer(Board,NewBoard),
  gameBlackComputerEasy(NewBoard,NewNewBoard),
  gamePlayerVComputer(NewNewBoard).

choose_move(Board,Level,Move):-
  Level = 1,
  create_randomMove(Board,NewMove,b),
  nth0(0,NewNewMove,b,NewMove),
  random_pieceNumber(Board,NewNewMove,Number),
  nth0(3,Move,Number,NewNewMove).


test_choose:-
  initialBoard(Board),
  choose_move(Board,1,Move),
  move(Move,Board,NewBoard),
  display_withcoords(NewBoard,X),
  display_game(X,b).


test_blackComputer:-
  initialBoard(Board),
  gameBlackComputerEasy(Board,NewBoard),
  display_withcoords(NewBoard,X),
  display_game(X,b).

gameBlackComputerEasy(Board,NewBoard):-
  choose_move(Board,1,Move),
  move(Move,Board,NewBoard).

test_random:-
  midBoard(X),
  valid_moves(X,b,ListOfMoves),
  get_width(X,Width),
  nl,
  create_randomMove(X,Move,b),
  write(Move),
  nl.

random_pieceNumber(Board,Move,Number):-
  nth0(1,Move,Elem),
  take_piece(Elem,Board,_-PieceNumber),
  random(1,PieceNumber,Number).


create_randomMove(Board,Move,Player):-
    findall(X,take_piece(X,Board,Player-_),Results),
    proper_length(Results,Length),
    random(0,Length,RandomStart),
    nth0(RandomStart,Results,Elem),
    findall(X,(moves(Elem,X,Board), X \=e), NewResults),
    proper_length(NewResults,NewLength),
    random(0,Length,RandomEnd),
    nth0(RandomEnd,NewResults,NewElem),
    nth0(0,InitialMove,Elem,[]),
    nth0(1,Move,NewElem,InitialMove).

create_move(Player,InitialCoords,FinalCoords,Number,Move):-
  Move = [Player,InitialCoords,FinalCoords,Number].
