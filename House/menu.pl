:-['utils'].
:- use_module(library(lists)).
%%%% Main menu


main_menu:-
  print_MainMenu,
  getChar(Input),
  (
  Input = '1' -> startPuzzle,main_menu;
  Input = '2';
  nl,
  write('Please choose a valid option.'), nl,
  enterContinue, nl,
  main_menu
  ).



print_MainMenu:-
  clear_console,
  write('---------------------------------------'),nl,
  write('---------------------------------------'),nl,
  write('-            House Puzzles            -'),nl,
  write('-        Option 1: Solve Puzzle       -'),nl,
  write('-        Option 2: Exit Puzzle        -'),nl,
  write('---------------------------------------'),nl,
  write('---------------------------------------'),nl.





startPuzzle:-
  write('Select the size of the board.'), nl,
  getInt(Size),
  createBoard(Size,Board),
  clear_console,
  display_withcoords(Board),
  fillBoard(Board,NewBoard).




fillBoard(Board,NewBoard):-
 write('Where do you want to put the House'),nl,
 write('Row:  '), nl,
 getInt(Ypos),
 write('Collumn:  '),nl,
 getInt(Xpos),
 %%% ver se é um numero
 %%% restrições ve se esta out of the bounds
 replace_in_matrix(Xpos-Ypos,Board,h,CurrentBoard).
