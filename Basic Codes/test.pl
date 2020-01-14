remove_at([_|T],1,T).
remove_at([H|T],K,[H|L]):-
	K>0,
	K1 is K - 1,
	remove_at(T,K1,L).
