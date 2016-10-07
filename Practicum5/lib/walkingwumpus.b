%%% Intelligente Systemen practicum 5 %%%
% Thijs klaver      3711633
% Bas Meesters      3700569

%%% Found predicates
% We did not find the wumpus/3 predicate. We did however find the four different walking rules, but somehow could not have Aleph
% find the wumpus predicate out of those. Also we did add negative examples of the walking rules to walkingwumpus.n. Otherwise
% the walking rules would be too general and therefore wrong.

% walkingRule1(A,B,A,C) :- doubleStep(A,B,A,C), black(A,B).
% walkingRule2(A,B,C,B) :- doubleStep(A,B,C,B), white(A,B).
% walkingRule3(A,B,A,C) :- adjacent(A,C,A,B), black(A,B).
% walkingRule4(A,B,C,B) :- adjacent(A,B,C,B), white(A,B).

%%% Mode declarations
% Wumpus predicate and the four rules can be in the header
:- modeh(*,wumpus(+time,-xcoord,-ycoord)).
:- modeh(*,wumpus(-time,+xcoord,+ycoord)).
:- modeh(*,walkingRule1(+xcoord,+ycoord,-xcoord,-ycoord)).
:- modeh(*,walkingRule2(+xcoord,+ycoord,-xcoord,-ycoord)).
:- modeh(*,walkingRule3(+xcoord,+ycoord,-xcoord,-ycoord)).
:- modeh(*,walkingRule4(+xcoord,+ycoord,-xcoord,-ycoord)).

% The walking rules can be in the body
:- modeb(*,wumpus(+time,-xcoord,-ycoord)).
:- modeb(*,walkingRule1(+xcoord,+ycoord,-xcoord,-ycoord)).
:- modeb(*,walkingRule2(+xcoord,+ycoord,-xcoord,-ycoord)).
:- modeb(*,walkingRule3(+xcoord,+ycoord,-xcoord,-ycoord)).
:- modeb(*,walkingRule4(+xcoord,+ycoord,-xcoord,-ycoord)).

% The rules about the Wumpus world can also be in the body
:- modeb(*,adjacent(-xcoord,-ycoord,+xcoord,+ycoord)).
:- modeb(*,pit(+xcoord, +ycoord)).
:- modeb(*,breeze(+xcoord,+ycoord)).
:- modeb(*,nobreeze(+xcoord,+ycoord)).
:- modeb(*,doubleStep(+xcoord,+ycoord,-xcoord,-ycoord)).
:- modeb(*,black(+xcoord,+ycoord)).
:- modeb(*,white(+xcoord,+ycoord)).

% The wumpus rule can be declared recursively and using one or more of the walkingRules
:-determination(wumpus/3, wumpus/3).
:-determination(wumpus/3,walkingRule1/4).
:-determination(wumpus/3,walkingRule2/4).
:-determination(wumpus/3,walkingRule3/4).
:-determination(wumpus/3,walkingRule4/4).

:-determination(walkingRule1/4,adjacent/4).
:-determination(walkingRule1/4,pit/2).
:-determination(walkingRule1/4,breeze/2).
:-determination(walkingRule1/4,nobreeze/2).
:-determination(walkingRule1/4,doubleStep/4).
:-determination(walkingRule1/4,black/2).
:-determination(walkingRule1/4,white/2).

:-determination(walkingRule2/4,adjacent/4).
:-determination(walkingRule2/4,pit/2).
:-determination(walkingRule2/4,breeze/2).
:-determination(walkingRule2/4,nobreeze/2).
:-determination(walkingRule2/4,doubleStep/4).
:-determination(walkingRule2/4,black/2).
:-determination(walkingRule2/4,white/2).

:-determination(walkingRule3/4,adjacent/4).
:-determination(walkingRule3/4,pit/2).
:-determination(walkingRule3/4,breeze/2).
:-determination(walkingRule3/4,nobreeze/2).
:-determination(walkingRule3/4,doubleStep/4).
:-determination(walkingRule3/4,black/2).
:-determination(walkingRule3/4,white/2).

:-determination(walkingRule4/4,adjacent/4).
:-determination(walkingRule4/4,pit/2).
:-determination(walkingRule4/4,breeze/2).
:-determination(walkingRule4/4,nobreeze/2).
:-determination(walkingRule4/4,doubleStep/4).
:-determination(walkingRule4/4,black/2).
:-determination(walkingRule4/4,white/2).

%%% Types
% There are 24 x coordinates and 24 y coordinates
xcoord(1).
xcoord(2).
xcoord(3).
xcoord(4).
xcoord(5).
xcoord(6).
xcoord(7).
xcoord(8).
xcoord(9).
xcoord(10).
xcoord(11).
xcoord(12).
xcoord(13).
xcoord(14).
xcoord(15).
xcoord(16).
xcoord(17).
xcoord(18).
xcoord(19).
xcoord(20).
xcoord(21).
xcoord(22).
xcoord(23).
xcoord(24).

ycoord(1).
ycoord(2).
ycoord(3).
ycoord(4).
ycoord(5).
ycoord(6).
ycoord(7).
ycoord(8).
ycoord(9).
ycoord(10).
ycoord(11).
ycoord(12).
ycoord(13).
ycoord(14).
ycoord(15).
ycoord(16).
ycoord(17).
ycoord(18).
ycoord(19).
ycoord(20).
ycoord(21).
ycoord(22).
ycoord(23).
ycoord(24).

%%% Background knowledge
% Wumpus world
room(X,Y) :- xcoord(X), ycoord(Y).

adjacent(X,Y,A,B) :- room(X,Y), room(A,B), X is A + 1, B == Y.
adjacent(X,Y,A,B) :- room(X,Y), room(A,B), X is A - 1, B == Y.
adjacent(X,Y,A,B) :- room(X,Y), room(A,B), Y is B + 1, A == X.
adjacent(X,Y,A,B) :- room(X,Y), room(A,B), Y is B - 1, A == X.

breeze(X,Y) :- pit(A,B), adjacent(X,Y,A,B).
nobreeze(X,Y) :- not(pit(A,B)), adjacent(X,Y,A,B).

% All black squares have even Xs in even Y rows and uneven Xs in uneven Y rows.
black(1,1).
black(X,Y) :- 0 is mod(X,2), 0 is mod(Y,2).
black(X,Y) :- 1 is mod(X,2), 1 is mod(Y,2).
white(X,Y) :- \+ black(X,Y).

% Since the Wumpus only walks north-east it will also only jump to east or north
doubleStep(X,Y,NewX,Y) :- pit(A,B), adjacent(X,Y,A,B), NewX is X + 2.
doubleStep(X,Y,X,NewY) :- pit(A,B), adjacent(X,Y,A,B), NewY is Y + 2.

% Pit locations
pit(2,2).
pit(6,4).
pit(10,3).
pit(12,7).
pit(11,10).
pit(13,15).