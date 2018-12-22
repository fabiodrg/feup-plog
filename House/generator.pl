:-use_module(library(clpfd)).

populateHouses(Houses,Houses,0).
populateHouses(Houses,ListAux,NumberOfPieces):-
    append(ListAux, [A1], ListResul),
    NumberOfPieces1 is NumberOfPieces -1;
    populateHouses(Houses,ListResul,NumberOfPieces1).
    
inLoop(_,[]).
inLoop(Value, [H|T]):-
    element(1, Value, X1),
    element(1,H, X2),
    element(2,Value,Y1), 
    element(2,H,Y2),
    X1 #\= X2 #\/ Y1 #\= Y2,
    inLoop(Value,T),!.
    
    
generateDistinct([]).
generateDistinct([H|T]):-
    inLoop(H,T),
    generateDistinct(T),!.


defineDomain([],_).
defineDomain([H|T], Size):-
    domain(H,1,Size),
    defineDomain(T,Size),!.

labelingHouses([]).
labelingHouses([H|T]):-
    labeling([],H),
    labelingHouses(T).

distance()

generator(Size,Houses):-
    Houses = [[A1,A2],[B1,B2],[C1,C2],[D1,D2],[E1,E2],[F1,F2],[G1,G2]], 
    defineDomain(Houses,Size),
    generateDistinct(Houses),

    labelingHouses(Houses).
    





   