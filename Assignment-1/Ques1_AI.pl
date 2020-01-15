%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Ques 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

evenlength([]).
evenlength([_,_|List]):-
    evenlength(List).

oddlength([_]).
oddlength([_,_|List]):-
    oddlength(List).