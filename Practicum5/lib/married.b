%%% Intelligente Systemen practicum 5 %%%
% Thijs klaver      3711633
% Bas Meesters      3700569

%% Found predicates
% parent(A,B) :- mother(A,B).
% parent(A,B) :- father(A,B).
% married(A,B) :- parent(A,C), parent(B,C).

%%% Mode declarations
% "Why can Aleph not derive married/2 when only parent(+X,-Y) is defined?"
% Because otherwise Aleph could not see the relationship between the child having the same parents as the people that are married.
% It will only look at the input of parents and cannot see that the binding factor is the input of the child and not the other way around.

% The two to be derived predicates married and parrent can be used in the head of a predicate
:- modeh(*,married(+person,-person)).
:- modeh(*,parent(+person,-person)).

% The predicates that may be used in the body
:- modeb(*,greatgrandfather(+person,-person)).
:- modeb(*,grandfather(+person,-person)).
:- modeb(*,father(+person,-person)).
:- modeb(*,mother(+person,-person)).
:- modeb(*,male(+person)).
:- modeb(*,female(+person)).

% Also, as the exercise explained, the parent predicate may be used in the married predicate
:- modeb(*,parent(+person,-person)).
:- modeb(*,parent(-person,+person)).

% To derive the married and parent predicates all the other predicates may be used
:-determination(married/2,parent/2).
:-determination(married/2,greatgrandfather/2).
:-determination(married/2,grandfather/2).
:-determination(married/2,person/1).
:-determination(married/2,father/2).
:-determination(married/2,mother/2).
:-determination(married/2,male/1).
:-determination(married/2,female/1).

:-determination(parent/2, married/2).
:-determination(parent/2,greatgrandfather/2).
:-determination(parent/2,grandfather/2).
:-determination(parent/2,person/1).
:-determination(parent/2,father/2).
:-determination(parent/2,mother/2).
:-determination(parent/2,male/1).
:-determination(parent/2,female/1).

%%% Taken from grandparent.b %%%
% Types
person(george).
person(mum).
person(spencer).
person(kydd).
person(elizabeth).
person(philip).
person(margaret).
person(diana).
person(charles).
person(anne).
person(mark).
person(andrew).
person(sarah).
person(edward).
person(sophie).
person(william).
person(harry).
person(peter).
person(zara).
person(beatrice).
person(eugenie).
person(louise).
person(james).

% Background knowledge
grandfather(A,B) :- father(A,C), father(C,B).
grandfather(A,B) :- father(A,C), mother(C,B).

father(george,elizabeth).
father(george,margaret).
father(spencer,diana).
father(philip,charles).
father(philip,anne).
father(philip,andrew).
father(philip,edward).
father(charles,william).
father(charles,harry).
father(mark,peter).
father(mark,zara).
father(andrew,beatrice).
father(andrew,eugenie).
father(edward,louise).
father(edward,james).

mother(mum,elizabeth).
mother(mum,margaret).
mother(kydd,diana).
mother(elizabeth,charles).
mother(elizabeth,anne).
mother(elizabeth,andrew).
mother(elizabeth,edward).
mother(diana,william).
mother(diana,harry).
mother(anne,peter).
mother(anne,zara).
mother(sarah,beatrice).
mother(sarah,eugenie).
mother(sophie,louise).
mother(sophie,james).

male(george).
male(philip).
male(edward).

female(elizabeth).
female(diana).
female(sarah).