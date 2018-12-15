:-['utils'].
:- use_module(library(lists)).
%%%% Main menu


start:-
  print_MainMenu,
  getChar(Input),
  (
  Input = '1' -> startPuzzle,main_menu;
  Input = '2';
  nl,
  write('Please choose a valid option.'), nl,
  enterContinue, nl,
  start
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
  skip_line,
  createBoard(Size,Board),
  clear_console,
  display_withcoords(Board),
  getCoords([],Board,Size,0,NewList),
  sort(NewList,SortedList),
  verify_list(SortedList),
  write('List you created:  '),
  write(SortedList), nl.

verify_list(List):-
  length(List, Size),
  Size >= 4,!.
verify_list(_):-
  clear_console,
  write('Invalid Input'), nl,
  write('Create a new Board'),nl,
  startPuzzle.


checkInput(Xpos,Ypos,Size):-
  number(Ypos),
  between(0, Size,Ypos),
  number(Xpos),
  between(0, Size,Xpos).
  

%%getCoords(FinalList,_,_,FinalList).
getCoords(List,Board,Size,Counter,FinalList):-
  write('Where do you want to put the House'),nl,
  askCoords(Ypos-Xpos), 
  checkInput(Xpos,Ypos,Size),
  nth0(Counter,NewList,Ypos-Xpos,List),
  Counter1 is Counter + 1,
  replace_in_matrix(Xpos-Ypos,Board,h,NewBoard),
  display_withcoords(NewBoard),
  getCoords(NewList,NewBoard,Size,Counter1,FinalList),!.

getCoords(FinalList,_,_,_,FinalList):-
  write('List Built'),nl.

fillBoard(Board,Size,NewBoard,Points,List):-
 write('Where do you want to put the House'),nl,
 askCoords(Ypos-Xpos), 
 checkInput(Xpos,Ypos,Size),
 write(Board),
 replace_in_matrix(Xpos-Ypos,Board,h,NewBoard),
 display_withcoords(NewBoard),
 append(Points,Xpos-Ypos,List),
 fillBoard(NewBoard,Size,_,List,_).


