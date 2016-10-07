%%% Intelligente Systemen practicum 5 %%%
% Thijs klaver      3711633
% Bas Meesters      3700569

%%% Found predicate
% breeze(A,B,C) :- wind(A,D), pit(A,E,F), adjacent(D,B,C,E,F).

%% Explanation of how the examples influence Aleph:
%% Since the wind influences on which squares a breeze can be percieved and there are four wind directions there should be at least
%% four worlds in which of each the wind blows different. The way Alpeh tries to find a predicate is by checking an example and creating 
%% a predicate that matches the example. It tries the tweak the predicate until all examples fit the rule. So, in this case it is best if 
%% squares are more in the middle, since then Aleph can derive more accurately that the breeze can only be felt at the square next to the
%% pit from which the wind is coming.

%%% Mode declarations
:- modeh(*,breeze(+world,-xcoord,-ycoord)).

:- modeb(*,wind(+world,-direction)).
:- modeb(*,pit(+world,-xcoord,-ycoord)).
:- modeb(*,adjacent(+direction,-xcoord,-ycoord,+xcoord,+ycoord)).

:-determination(breeze/3,wind/2).
:-determination(breeze/3,adjacent/5).
:-determination(breeze/3,pit/3).

%%% Types
world(1).
world(2).
world(3).
world(4).

direction(north).
direction(west).
direction(south).
direction(east).

xcoord(1).
xcoord(2).
xcoord(3).
xcoord(4).

ycoord(1).
ycoord(2).
ycoord(3).
ycoord(4).

%%% Background knowledge
room(X,Y) :- xcoord(X), ycoord(Y).
adjacent(W,X,Y,A,B) :- room(X,Y), room(A,B), X is A + 1, W = east.
adjacent(W,X,Y,A,B) :- room(X,Y), room(A,B), X is A - 1, W = west.
adjacent(W,X,Y,A,B) :- room(X,Y), room(A,B), Y is B + 1, W = north.
adjacent(W,X,Y,A,B) :- room(X,Y), room(A,B), Y is B - 1, W = south.

% World 1
pit(1,3,1).
pit(1,3,3).
pit(1,4,4).
wind(1, west).

% World 2
pit(2,3,1).
pit(2,3,3).
pit(2,2,4).
wind(2, east).

% World 3
pit(3,1,2).
pit(3,2,1).
pit(3,3,3).
pit(3,4,2).
wind(3, north).

% World 4
pit(4,1,1).
pit(4,2,2).
pit(4,2,4).
wind(4,south).