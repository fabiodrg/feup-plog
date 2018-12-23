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
    domain(H,0,Size),
    defineDomain(T,Size),!.

labelingHouses([]).
labelingHouses([H|T]):-
    labeling([middle],H),
    labelingHouses(T).

calculateDistance([],ListFinal,ListFinal).
calculateDistance([X,Y| T],ListAux, ListFinal):-
    distance(X, Y, D),
    append(ListAux,[D],NewList),
    calculateDistance(T,NewList,ListFinal),!.

createSubList([]).
createSubList([H|T]):-
    length(SubList,2),
    append(SubList,[],H),
    createSubList(T),!.
    
createList(Lenght,List):-
    length(List, Lenght).

generator(Size,Houses,Number):-
    createList(Number,Houses),
    createSubList(Houses),
    NewSize is Size - 1,
    defineDomain(Houses,NewSize),
    generateDistinct(Houses),
    labelingHouses(Houses),
    calculateDistance(Houses,[],DistanceList),
    sort(DistanceList,NewDistanceList),
    length(NewDistanceList, N),
    N #=2.
    





   
