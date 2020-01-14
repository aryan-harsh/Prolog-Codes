main :-
    open('/home/placements2020/Downloads/prolog/myFile.txt', read, Str),
    read_file(Str,Lines),
    close(Str),
    write(Str,Lines), nl.

read_file(Stream,[]) :-
    at_end_of_stream(Stream).

read_file(Stream,[X|L]) :-
    \+ at_end_of_stream(Stream),
    read(Stream,X),
    read_file(Stream,L).
