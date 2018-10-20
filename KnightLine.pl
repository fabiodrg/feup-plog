%%%%%%%% Pecas %%%%%%

tile(e).

tile(b-X):-
    X \= 0,
    integer(X).

tile(w-X):-
    X \= 0,
    integer(X).

player(b).

player(w).


%%% Boards %%%%%

initialBoard([
        [e,e,e,e],
        [e,b-20,w-20,e],
        [e,e,e,e]    
    ]).


midBoard([
        [e,e,e,e,e,e],
        [e,e,e,b-9,w-15,e],
        [e,b-1,w-5,e,e,e],
        [e,e,b-10,e,e,e],
        [e,e,e,e,e,e]
    ]).


finalBoard([
    [e,e,e,b-4,e,e],
    [e,e,w-4,b-4,b-4,b-1],
    [e,e,b-3,w-3,w-3,e],
    [b-2,w-2,w-2,w-2,b-2,e],
    [e,e,w-2,w-2,e,e],
    [e,w-2,e,b-2,e,e]
    ]).


%% print board %%

print_initial_board(Y):-
    initialBoard(X),
    display_game(X,Y).

print_final_board(Y):-
    finalBoard(X),
    display_game(X,Y).


print_mid_board(Y):-
    midBoard(X),
    display_game(X,Y).

display_game([],P):-
    write(' -'),
    translate(P,W),
    write(W).


display_game([H|T],P):-
    print_line(H),
    nl,
    display_game(T,P).

print_line([]).
print_line([H|T]):-
    print_cell(H),
    print_line(T).

print_cell(X-Y):-
    translate(X,W),
    write(W),
    write('-'),
    write(Y),
    write(' ').

print_cell(X):-
    translate(X,W),
    write(W-0),    
    write(' ').

translate(b,'B').
translate(w,'W').
translate(e,'E').



