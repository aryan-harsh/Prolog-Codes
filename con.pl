con([],L,L).
con([X|L],L2,[X|L3]):-con(L,L2,L3).
