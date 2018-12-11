% Clears the console
clear_console:-
	clear_console(30),!.

clear_console(0).
clear_console(X):-
	nl,
	X1 is X-1,
	clear_console(X1).

enterContinue:-
    write('Press Enter'), nl,
    continue, !.

continue:-
    get_char(_).



% Gets a single character from stream

getChar(Input):-
    get_char(Input),
    get_char(_).


% Gets a single digit from stream. This predicate ensures the input is a digit between 0 and 9
getInt(Input):-
	get_code(TempInput),
	% compute the decimal digit by subtracting 48, the ASCII code for number 0 %
	Input is TempInput - 48.