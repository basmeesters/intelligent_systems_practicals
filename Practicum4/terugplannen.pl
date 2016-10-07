run(L) :- explore(1,1,noGold,Explored), last(Explored,(X,Y)), planSafe(X,Y,Path,Explored), append(Explored,[grab|Path],L).

planSafe(X,Y,Path,Explored) :- subplanSafe(X,Y,[coord(X,Y)],Path,Explored).

subplanSafe(1,1,_,[],_).
subplanSafe(X,Y,Visited,[goEast|Path],Explored) :-
	X > 1,
	A is X - 1,
	\+ member(coord(A,Y),Visited),
	member((A,Y),Explored),
	subplanSafe(A,Y,[coord(A,Y)|Visited],Path,Explored).
subplanSafe(X,Y,Visited,[goWest|Path],Explored) :-
	X < 4,
	A is X + 1,
	\+ member(coord(A,Y),Visited),
	member((A,Y),Explored),
	subplanSafe(A,Y,[coord(A,Y)|Visited],Path,Explored).
subplanSafe(X,Y,Visited,[goNorth|Path],Explored) :-
	Y > 1,
	B is Y - 1,
	\+ member(coord(X,B),Visited),
	member((X,B),Explored),
	subplanSafe(X,B,[coord(X,B)|Visited],Path,Explored).
subplanSafe(X,Y,Visited,[goSouth|Path],Explored) :-
	Y < 4,
	B is Y + 1,
	\+ member(coord(X,B),Visited),
	member((X,B),Explored),
	subplanSafe(X,B,[coord(X,B)|Visited],Path,Explored).