play(N) :-
   move(N,t1,t2,t3).
   

move(1,X,Y,_) :-  
         
         write('Move disk 1 from '), 
         write(X), 
         write(' to '), 
         write(Y), 
         nl. 
     move(N,X,Y,Z) :- 
         N>1, 
         M is N-1, 
         move(M,X,Z,Y),
         write('Move disk '), 
         write(N),
         write(' from '),
         write(X), 
         write(' to '), 
         write(Y), 
         nl,
          
         move(M,Z,Y,X).  