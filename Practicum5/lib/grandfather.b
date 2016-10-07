%%% Intelligente Systemen practicum 5 %%%
% Thijs klaver      3711633
% Bas Meesters      3700569

% Found predicates:
% greatgrandfather(A,B) :- grandfather(A,C), father(C,B).
% greatgrandfather(A,B) :- grandfather(A,C), mother(C,B).

% Mode declarations

% De modeh-declaration is changed so a greatgrandfather can be derived
:- modeh(*, greatgrandfather(+person, -person)).

% De modeb-declarations is remained the same but  the first line is added since grandfather may be used in the greatgrandfather predicate
:- modeb(*,grandfather(+person,-person)).
:- modeb(*,father(+person,-person)).
:- modeb(*,mother(+person,-person)).
:- modeb(*,male(+person)).
:- modeb(*,female(+person)).

% The determination rules are changed so greatgrandfather can be derived
% These are just replacements of grandfather/2 by greatgrandfather/2
:- determination(greatgrandfather/2,person/1).
:- determination(greatgrandfather/2,father/2).
:- determination(greatgrandfather/2,mother/2).
:- determination(greatgrandfather/2,male/1).
:- determination(greatgrandfather/2,female/1).

% The only new rule for derivations, using grandfather is possible in the greatgrandfather predicate
:- determination(greatgrandfather/2, grandfather/2).

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
% grandfather/2 is added since it may be used by greatgrandfather/2
grandfather(A,B) :- father(A,C), mother(C,B).
grandfather(A,B) :- father(A,C), father(C,B).

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