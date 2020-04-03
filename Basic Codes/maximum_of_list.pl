greaterthan(X,Y,Z):-X>Y,Z is X;Z is Y.
maxx([X|[]],X). 
maxx([H|T],F) :-  
   maxx(T,L), 
   greaterthan(H,L,F).

/*
 * maxx([1,3,5,2,3],T).
 * T = 5
 * 
 * /
