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
  skip_line,
  createBoard(Size,Board),
  clear_console,
  display_withcoords(Board),
  getCoords([],Size,0,NewList),
  sort(NewList,SortedList),
  write(SortedList), nl,
  write(NewBoard), nl.


checkInput(Xpos,Ypos,Size):-
  number(Ypos),
  between(0, Size,Ypos),
  number(Xpos),
  between(0, Size,Xpos).

%%getCoords(FinalList,_,_,FinalList).
getCoords(List,Size,Counter,FinalList):-
  write('Where do you want to put the House'),nl,
  askCoords(Ypos-Xpos), 
  checkInput(Xpos,Ypos,Size),
  nth0(Counter,NewList,Ypos-Xpos,List),
  Counter1 is Counter + 1,
 %% write('Continue:  '),
  %%read(State),
  %%State = 'y',
  getCoords(NewList,Size,Counter1,FinalList),!.

getCoords(FinalList,_,_,FinalList):-
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


