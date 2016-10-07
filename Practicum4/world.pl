%%%% Intelligente Systemen Practicum3 %%%%
% Thijs Klaver	3711633
% Bas Meesters	3700569

% World:
kamer(X,Y) :- tussen(1,4,X), tussen(1,4,Y).

tussen(N1,_,X) :- X is N1.
tussen(N1,N2,X) :- N1<N2,tussen(N1+1,N2,X).

rechts(X,Y,U,V) :- kamer(X,Y), kamer(U,V), U is X-1, Y=V.
links(X,Y,U,V) :- kamer(X,Y), kamer(U,V), U is X+1, Y=V.
boven(X,Y,U,V) :- kamer(X,Y), kamer(U,V), X=U, V is Y-1.
onder(X,Y,U,V) :- kamer(X,Y), kamer(U,V), X=U, V is Y+1.

glitter(X,Y) :- gold(X,Y).

breeze(X,Y) :- pit(U,V), rechts(X,Y,U,V).
breeze(X,Y) :- pit(U,V), links(X,Y,U,V).
breeze(X,Y) :- pit(U,V), boven(X,Y,U,V).
breeze(X,Y) :- pit(U,V), onder(X,Y,U,V).

stench(X,Y) :- wumpus(U,V), rechts(X,Y,U,V).
stench(X,Y) :- wumpus(U,V), links(X,Y,U,V).
stench(X,Y) :- wumpus(U,V), boven(X,Y,U,V).
stench(X,Y) :- wumpus(U,V), onder(X,Y,U,V).

% Example world:
gold(2,3).

pit(3,1).
pit(3,3).
pit(4,3).

wumpus(1,3).

% Example world2:
%gold(4,2).

%pit(3,1).
%pit(3,3).
%pit(4,4).

%wumpus(1,3).

% Example world3:
%gold(1,3).
%wumpus(2,2).
%pit(_,_) :- false.