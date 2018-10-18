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


finalBoard([
    [e,e,e,b-4,e,e],
    [e,e,w-4,b-4,b-4,b-1],
    [e,e,b-3,w-3,w-3,e],
    [b-2,w-2,w-2,w-2,b-2,e],
    [e,e,w-2,w-2,e,e],
    [e,w-2,e,b-2,e,e]
    ]).


%% print board %%


print_board([],P):-
    write(' -'),
    translate(P,W),
    write(W).


print_board([H|T],P):-
    print_line(H),
    nl,
    print_board(T,P).

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





