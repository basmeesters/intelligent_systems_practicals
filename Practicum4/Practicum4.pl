%%%% Intelligente Systemen Practicum3 %%%%
% Thijs Klaver	3711633
% Bas Meesters	3700569

%%%% Import the world %%%%
:- [world].

%%%% THE predicate %%%%
run(L) :- explore([],[(1,1)],[],[],SubL), last(SubL,(X,Y)), glitter(X,Y), planSafe(X,Y,Path,SubL), append(SubL,[grab|Path],L).

%%%% Explore the world %%%%
%% explore predicate uses depth first search to check squares and saves the information recieved from exploring to plan a safe path to the gold.

% The end explore situation, on the current position a glitter is percieved and the exploring for the gold can stop.
explore(Explored,_,_,_,_) :- Explored = [(X,Y)|_], glitter(X,Y).

% The actual search, it checks the head of the queue, if it is not explored, check if it is safe. Thereafter explore the spot to revieve information
% such as breezes, stenches and glitter. Drop the head of the queue and use all the new information to call explore again with the remaining queue.
explore(Explored, Queue, Breezes, Stenches, Path) :- 
        Queue = [(X,Y)|TailQueue], 
        \+ member((X,Y),Explored), 
        checkSafe(X,Y,Explored, Breezes, Stenches),
        exploreSpot(X,Y,Breezes, Stenches, NewBreezes, NewStenches),
        findNewNeighbours(X,Y,Explored, NewSquares), 
        append([(X,Y)], Explored, NewExplored), 
        append( [(X,Y)], NewPath, Path),
        append(NewSquares, TailQueue, NewQueue),
        explore(NewExplored, NewQueue, NewBreezes, NewStenches, NewPath).

% When the above fails drop the head of the queue and explore again
explore(Explored, Queue, Breezes, Stenches, Path) :- Queue = [_|NewQueue], explore(Explored, NewQueue, Breezes, Stenches, Path).

%% exploreSpot checks if a spot has a breeze and/or a stenches and returns the new lists of breezes and stenches
exploreSpot(X,Y, Breezes, Stenches, Breezes, Stenches) :- \+ breeze(X,Y), \+stench(X,Y).
exploreSpot(X,Y,Breezes, Stenches, NewBreezes, Stenches) :- NewBreezes = [(X,Y)|Breezes], breeze(X,Y), \+ stench(X,Y).       
exploreSpot(X,Y,Breezes, Stenches, Breezes, NewStenches) :- NewStenches = [(X,Y)|Stenches], \+ breeze(X,Y), stench(X,Y).
exploreSpot(X,Y,Breezes, Stenches, NewBreezes, NewStenches) :- NewBreezes = [(X,Y)|Breezes], NewStenches = [(X,Y)|Stenches], breeze(X,Y), stench(X,Y).

%% Find all the unexplored neighbours of a square
findNewNeighbours(X,Y, Explored, L) :- findall((A,B), (neighbour(X,Y,A,B), \+ member((A,B), Explored)), L).
neighbour(X,Y,A,B) :- rechts(X,Y,A,B), kamer(X,Y), kamer(A,B).
neighbour(X,Y,A,B) :- links(X,Y,A,B), kamer(X,Y), kamer(A,B).
neighbour(X,Y,A,B) :- boven(X,Y,A,B), kamer(X,Y), kamer(A,B).
neighbour(X,Y,A,B) :- onder(X,Y,A,B), kamer(X,Y), kamer(A,B).

%%% checkSafe uses the information from breezes and stenches to derive if a spot is safe
% The start is safe
checkSafe(1,1,_,_,_).

% If there are no stenches percieved check if the explored neighbours don't contain breezes
checkSafe(X, Y, Explored, Breezes, Stenches) :- 
        length(Stenches, 0),!, 
        neighbour(X,Y,A,B), 
        member((A,B), Explored), 
        \+ member((A,B), Breezes).
        
% If one stench is percieved the spot is only 100% safe if explored neighbours don't contain stenches or breezes
checkSafe(X, Y, Explored, Breezes, Stenches) :- 
        length(Stenches, 1),!, 
        neighbour(X,Y,U,V), 
        member((U,V), Explored), 
        \+ member((U,V), Breezes), 
        neighbour(X,Y,M,N), member((M,N),Explored), \+ member((M,N), Stenches).
        
% If two stenches are percieved check if explored neighbours don't contain breezes and that the current spot does not neighbour
% both of the stench spots. Since there is only one Wumpus you know for sure that the current location cannot contain one. 
checkSafe(X,Y,Explored,Breezes,Stenches) :- 
        neighbour(X,Y,U,V), 
        member((U,V), Explored), 
        \+ member((U,V), Breezes), 
        Stenches = [(Ax,Ay),(Bx,By)|_], 
        neighbour(Ax,Ay, P, Q), 
        neighbour(Bx,By,P,Q),
        \+ member((P,Q), Explored), 
        \+ (X,Y) = (P,Q).
    
 
%%%% The way back to the start%%%%
planSafe(X,Y,Path,Explored) :- subplanSafe(X,Y,[coord(X,Y)],Path,Explored).

subplanSafe(1,1,_,[],_).
subplanSafe(X,Y,Visited,[goEast|Path],Explored) :-
        X < 4,
        A is X + 1,
        \+ member(coord(A,Y),Visited),
        member((A,Y),Explored),
        subplanSafe(A,Y,[coord(A,Y)|Visited],Path,Explored).
subplanSafe(X,Y,Visited,[goWest|Path],Explored) :-
        X > 1,
        A is X - 1,
        \+ member(coord(A,Y),Visited),
        member((A,Y),Explored),
        subplanSafe(A,Y,[coord(A,Y)|Visited],Path,Explored).
subplanSafe(X,Y,Visited,[goNorth|Path],Explored) :-
        Y < 4,
        B is Y + 1,
        \+ member(coord(X,B),Visited),
        member((X,B),Explored),
        subplanSafe(X,B,[coord(X,B)|Visited],Path,Explored).
subplanSafe(X,Y,Visited,[goSouth|Path],Explored) :-
        Y > 1,
        B is Y - 1,
        \+ member(coord(X,B),Visited),
        member((X,B),Explored),
        subplanSafe(X,B,[coord(X,B)|Visited],Path,Explored).   