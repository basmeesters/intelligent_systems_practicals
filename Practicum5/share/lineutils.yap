:- module(line_utils,
	  [search_for/3,
	   scan_natural/3,
	   scan_integer/3,
	   split/3,
	   glue/3,
	   filter/3,
	   file_filter/3,
	   process/2,
	   copy_line/2,
	   file_filter/3
	  ]).

:- meta_predicate filter(+,+,:), file_filter(+,+,:), process(+,:).

:- use_module(library(lists),
	      [member/2,
	       append/3]).

:- use_module(library(readutil),
	      [read_line_to_codes/2]).


search_for(C) --> [C], !.
search_for(C) --> [_],
	search_for(C).

scan_integer(N) -->
	"-", !,
	scan_natural(0, N0),
	N is -N0.
scan_integer(N) -->
	scan_natural(0, N).

scan_natural(N0,N) -->
	[C],
	{C >= 0'0, C =< 0'9 }, !,
	{ N1 is N0*10+(C-0'0) },
	get_natural(N1,N).
scan_natural(N,N) --> [].

split(String, SplitCodes, Strings) :-
	split_at_blank(SplitCodes, Strings, String, []).

split_at_blank(SplitCodes, More) -->
	[C],
	{ member(C, SplitCodes) }, !,
	split_at_blank(SplitCodes, More).
split_at_blank(SplitCodes, [[C|New]| More]) -->
	[C], !,
	split(SplitCodes, New, More).
split_at_blank(_, []) --> [].

split(SplitCodes, [], More) -->
	[C],
	{ member(C, SplitCodes) }, !,
	split_at_blank(SplitCodes, More).
split(SplitCodes, [C|New], Set) -->
	[C], !,
	split(SplitCodes, New, Set).
split(_, [], []) --> [].

glue([], _, []).
glue([A], _, A) :- !.
glue([H|T], [B|_], Merged) :-
	append(H, [B|Rest], Merged),
	glue(T, [B], Rest).

copy_line(StreamInp, StreamOut) :-
	read_line_to_codes(StreamInp, Line),
	format(StreamOut, '~s~n', [Line]).

filter(StreamInp, StreamOut, Command) :-
	repeat,
	read_line_to_codes(StreamInp, Line),
	(
	 Line == end_of_file
	->
	 true
	;
	 call(Command, Line, NewLine),
	 format(StreamOut, '~s~n', [NewLine]),
	 fail
	).


process(StreamInp, Command) :-
	repeat,
	read_line_to_codes(StreamInp, Line),
	(
	 Line == end_of_file
	->
	 true
	;
	 call(Command, Line),
	 fail
	).


file_filter(Inp, Out, Command) :-
	open(Inp, read, StreamInp),
	open(Out, write, StreamOut),
	filter(StreamInp, StreamOut, Command),
	close(StreamInp),
	close(StreamOut).


