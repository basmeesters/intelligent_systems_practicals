% Intelligente Systemen Practicum2
% Thijs Klaver	3711633
% Bas Meesters	3700569

%%%%% Exercise 1 %%%%%
% Example words
word(astante,a,s,t,a,n,t,e).
word(astoria,a,s,t,o,r,i,a).
word(baratto,b,a,r,a,t,t,o).
word(cobalto,c,o,b,a,l,t,o).
word(pistola,p,i,s,t,o,l,a).
word(statale,s,t,a,t,a,l,e).

% Let the letters at certain positions for the horizontal words be the same as the corresponding letters at the vertical positions
% Thereafter make sure that words are unique
crossword(V1, V2, V3, H1, H2, H3) :- 
    word(V1,_,H12V12,_,H22V14,_,H32V16,_),
    word(V2,_,H14V22,_,H24V24,_,H34V26,_),
    word(V3,_,H16V32,_,H26V34,_,H36V36,_),
    
    word(H1,_,H12V12,_,H14V22,_,H16V32,_),
    word(H2,_,H22V14,_,H24V24,_,H26V34,_),
    word(H3,_,H32V16,_,H34V26,_,H36V36,_),

    dif(V1,V2),
    dif(V1,V3),
    dif(V1,H1),
    dif(V1,H2),
    dif(V1,H3),
    dif(V2,V3),
    dif(V2,H1),
    dif(V2,H2),
    dif(V2,H3),
    dif(V3,H1),
    dif(V3,H2),
    dif(V3,H3),
    dif(H1,H2),
    dif(H1,H3),
    dif(H2,H3).
    
%%%%% Exercise 2 %%%%%
% Just literally translated to Prolog from the first assignment
room(X,Y) :- X > 0, Y > 0, X =< 4, Y =< 4.
adjacent(X,Y,A,B) :- room(X,Y), room(A,B), X =:= A, Y =:= (B - 1).
adjacent(X,Y,A,B) :- room(X,Y), room(A,B), X =:= A, Y =:= (B + 1).
adjacent(X,Y,A,B) :- room(X,Y), room(A,B), X =:= (A + 1), Y =:= B.
adjacent(X,Y,A,B) :- room(X,Y), room(A,B), X =:= (A - 1), Y =:= B.

%%%%% Exercise 3 %%%%%
% Example field:
pit(3,1).
pit(3,3).
pit(4,4).
wumpus(1,3).
gold(2,3).

% Again, literally translated to Prolog from the first assignment
breeze(X,Y) :- pit(A,B), adjacent(X,Y,A,B).    
glitter(X,Y) :- gold(X,Y).
stench(X,Y) :- wumpus(A,B), adjacent(X,Y,A,B).

%%%%% Exercise 4 %%%%%
% Given KB
byCar(auckland,hamilton).
byCar(hamilton,raglan).
byCar(valmont,saarbruecken).
byCar(valmont,metz).

byTrain(metz,frankfurt).
byTrain(saarbruecken,frankfurt).
byTrain(metz,paris).
byTrain(saarbruecken,paris).

byPlane(frankfurt,bangkok).
byPlane(frankfurt,singapore).
byPlane(paris,losAngeles).
byPlane(bangkok,auckland).
byPlane(singapore,auckland).
byPlane(losAngeles,auckland).

% You can go from A to B using car, train or plain
go(A,B) :- byCar(A,B).
go(A,B) :- byTrain(A,B).
go(A,B) :- byPlane(A,B).

% To travel you can go direct or via another city
travel(S,D,go(S,D)) :- go(S,D).
travel(S,D,go(S,M,R)) :- go(S,M), travel(M,D,R).

%%%%% Exercise 5 %%%%%
% First the empty case is defined, which has sum 0
% For all other cases is the sum the sum of the head and that of the tail

somlijst([], 0).
somlijst([H|T], P) :- somlijst(T, S), P is H + S.

%%%%% Exercise 6 %%%%%
% The remove predicate, as the name suggests, removes the element X from the list
% All permutations of an empty list is the empty list
% The second definition states that a permutation of a list is a permutation of the list without its head

remove(X, [X|T], T).
remove(X, [H|T], [H|T2]) :- remove(X, T, T2).

permutatie([], []).
permutatie(L, [H|T]) :- remove(H, L, R), permutatie(R, T).

%%%%% Exercise 7 %%%%%
% The empty list is a sublist of the empty list
% If the head of the A is the same as the head of B, check if the tail of A is a sublist of the tail of B
% If first of the first list is not the same as the first of the second list check if A is a sublist of he tail of B

sublijst([],[]).
sublijst([Ah|At], [Bh|Bt]) :- Ah=Bh,sublijst(At,Bt).
sublijst(A, [_|Bt]) :- sublijst(A,Bt).

%%%%% Exercise 8 %%%%%
% We can use the previous predicates to check if a sumlist of a sublist is the same as the number given
subsom(B, N, A) :- sublijst(A,B),somlijst(A,N).

%%%%% Exercise 9 %%%%%
% If X is the same as Z and X is smaller or equal to Y, then Z is between X and Y
% Or increase the lower bound if X < Y and check if Z is between X + 1 and Y
tussen(X, Y, Z) :- Z is X, X =< Y.
tussen(X, Y, Z) :- X < Y, tussen(X + 1, Y, Z).
