:-['utils'].

%%%% Main menu


main_menu:-
  print_MainMenu,
  getChar(Input),
  (
  Input = '1' -> start_puzzle,main_menu;
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