% Intelligente Systemen Practicum3
% Thijs Klaver	3711633
% Bas Meesters	3700569

%%%%%% 1. %%%%%%
% Rules from previous practical to check if a room is valid
room(X,Y) :- X > 0, Y > 0, X =< 4, Y =< 4.
adjacent(X,Y,A,B) :- room(X,Y), room(A,B), X =:= A, Y =:= (B - 1).
adjacent(X,Y,A,B) :- room(X,Y), room(A,B), X =:= A, Y =:= (B + 1).
adjacent(X,Y,A,B) :- room(X,Y), room(A,B), X =:= (A + 1), Y =:= B.
adjacent(X,Y,A,B) :- room(X,Y), room(A,B), X =:= (A - 1), Y =:= B. 

glitter(X,Y) :- gold(X,Y).
breeze(X,Y) :- pit(A,B), adjacent(X,Y,A,B).
stench(X,Y) :- wumpus(A,B), adjacent(X,Y,A,B).

%%%%%% 1a. %%%%%%

plan(X,Y,L) :-
	X >= 1, X =< 4, Y >= 1, Y =< 4,
	subplan(X,Y,[coord(X,Y)],Z), reverse(Z,L).

subplan(1,1,_,[]).
subplan(X,Y,Visited,[goEast|Rest]) :-
	X > 1,
	A is X - 1,
	\+ member(coord(A,Y),Visited),
	subplan(A,Y,[coord(A,Y)|Visited],Rest).
subplan(X,Y,Visited,[goWest|Rest]) :-
	X < 4,
	A is X + 1,
	\+ member(coord(A,Y),Visited),
	subplan(A,Y,[coord(A,Y)|Visited],Rest).
subplan(X,Y,Visited,[goNorth|Rest]) :-
	Y > 1,
	B is Y - 1,
	\+ member(coord(X,B),Visited),
	subplan(X,B,[coord(X,B)|Visited],Rest).
subplan(X,Y,Visited,[goSouth|Rest]) :-
	Y < 4,
	B is Y + 1,
	\+ member(coord(X,B),Visited),
	subplan(X,B,[coord(X,B)|Visited],Rest).

%%%%%% 1b. %%%%%%
% Definitions from the assignment

veilig(X,Y) :- no_wumpus(X,Y), no_pit(X,Y).
no_wumpus(X,Y) :- \+ wumpus(X,Y).
no_pit(X,Y) :- \+ pit(X,Y).

pit(3,1).
pit(3,3).
pit(4,4).
wumpus(1,3).

planSafe(X,Y,L) :-
	veilig(X,Y),
	X >= 1, X =< 4, Y >= 1, Y =< 4,
	subplanSafe(X,Y,[coord(X,Y)],Z), reverse(Z,L).

subplanSafe(1,1,_,[]).
subplanSafe(X,Y,Visited,[goEast|Rest]) :-
	veilig(X,Y),
	X > 1,
	A is X - 1,
	\+ member(coord(A,Y),Visited),
	subplanSafe(A,Y,[coord(A,Y)|Visited],Rest).
subplanSafe(X,Y,Visited,[goWest|Rest]) :-
	veilig(X,Y),
	X < 4,
	A is X + 1,
	\+ member(coord(A,Y),Visited),
	subplanSafe(A,Y,[coord(A,Y)|Visited],Rest).
subplanSafe(X,Y,Visited,[goNorth|Rest]) :-
	veilig(X,Y),
	Y > 1,
	B is Y - 1,
	\+ member(coord(X,B),Visited),
	subplanSafe(X,B,[coord(X,B)|Visited],Rest).
subplanSafe(X,Y,Visited,[goSouth|Rest]) :-
	veilig(X,Y),
	Y < 4,
	B is Y + 1,
	\+ member(coord(X,B),Visited),
	subplanSafe(X,B,[coord(X,B)|Visited],Rest).

%%%%%% 2. %%%%%%
% colourSort works almost the same as bubbleSort, except that coloursort expects an order which it gives to swapColour
% swapColour replaces the X > Y by checkOrd
% checkOrd checks if Y becomes before X by checking if Y or X is the head (which succeeds or fails) or otherwise search on
 
colourSort(List, Ord, Sorted) :- swapColour(List, List1, Ord), !, colourSort(List1, Ord, Sorted).
colourSort(Sorted,_, Sorted).

swapColour([X, Y|Rest], [Y, X|Rest], Ord) :- checkOrd(X, Y, Ord).
swapColour([Z|Rest], [Z|Rest1], Ord) :- swapColour(Rest, Rest1, Ord).

checkOrd(X, _, [H|_]) :- X = H, !, fail.
checkOrd(_, Y, [Y|_]).
checkOrd(X, Y, [_|Rest]) :- checkOrd(X, Y, Rest).

%%%%%% 3. %%%%%%
% quickSort divides the list in a greater and smaller list compared to the first elemenent which it does recursively
% divide simply checks the head of the remaining list, compares it to the greater and smaller lists and does this for all elements
quickSort([X|Rest], Sorted) :- 
        divide(X, Rest, Lesser, Greater),
        quickSort(Lesser, LSorted),
        quickSort(Greater, GSorted),
        append(LSorted, [X|GSorted], Sorted).
quickSort([], []).

divide(Pivot, [H|Tail], [H|Lesser], Greater) :- H =< Pivot, divide(Pivot, Tail, Lesser, Greater).
divide(Pivot, [H|Tail], Lesser, [H|Greater]) :- H >  Pivot, divide(Pivot, Tail, Lesser, Greater).
divide(_, [], [], []).

%%%%%% 4. %%%%%%
% subSolution is called with the total amount it should have(8) and recursively decreases and checks if that also is a valid (sub)solution.
% It checks if the given answer is between 1 and 8, if it is not used before with the help of member and if it is valid
% valid checks in the diagonal directions if a subsolution is valid

solution(L) :- subSolution(8, L).
subSolution(0, []).
subSolution(N, [H|T]) :- N > 0, M is N -1, subSolution(M, T), tussen(1, 8, H), \+ member(H, T), valid(H, T, 1).

valid(_,[],_). 
valid(X, [H|T], N) :- \+ H =:= X - N, \+ H =:= X + N, M is N + 1, valid(X, T, M).

% Previous practical predicate:
tussen(X, Y, Z) :- Z is X, X =< Y.
tussen(X, Y, Z) :- X < Y, tussen(X + 1, Y, Z). 

%%%%%% 5. %%%%%%
% Sudoku is only partly finished.
% row, otherRows, nth_element all seem to do what they have to, sudoku however does not seem to terminate. 
% Probably because it is inefficient.

% The idea is that a row checks if all numbers in that row are unique and if on each position the number is not
% the same as in the previous rows on that position.

% A number in a row is valid when it is between 1 and 9 and if it did not appear before in the same row or in the rows above on the same position
row(0,[],_,_).
row(N, [H|T], PreviousList, A) :- 
    N > 0, 
    M is N -1, 
    row(M, T, PreviousList, A), 
    tussen(1, 9, H), 
    otherRows(N, PreviousList, H, A),
    \+ member(H, T).
 
% otherRows checks if element X is different from the nth element (+9) of each previous row 
otherRows(_,_,_,0).
otherRows(_,[],_,_).
otherRows(N, L, X, A) :- 
    M is N + 9, 
    C is A - 1, 
    nth_element(N, L, B), 
    \+ B =:= X, 
    otherRows(M, L, X, C).
       
% nth_element gives the nth element of the list
nth_element(1, [H|T], H).
nth_element(N, [H|T], X) :- 
    N > 1, M is N - 1, 
    nth_element(M, T, X).

% sudoku does row 9 times and concatenates the previous rows so they can be checked in otherRows
sudoku(L) :-
    L = [A,B,C,D,E,F,G],
    row(9, A, [],1),
    row(9, B, A ,2),
    row(9, C, L1,3),
    row(9, D, L2,4),
    row(9, E, L3,5),
    row(9, F, L4,6),
    row(9, G, L5,7),
    
    append(A, B, L1),
    append(L1, C, L2),
    append(L2, D, L3),
    append(L3, E, L4),
    append(L4, F, L5).
    
    
