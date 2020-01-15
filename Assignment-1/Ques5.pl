%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Ques 5 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% 1.
class(Number, positive) :- Number > 0, !.
class(0, zero) :- !.
class(Number, negative) :- Number < 0, !.


%%% 2 without cuts
%split([], [], []).

%split([Pos_Head | Tail], [Pos_Head | Pos_Tail], Neg) :-
%  Pos_Head >= 0,
%  split(Tail, Pos_Tail, Neg).

%split([Neg_Head | Tail], Pos, [Neg_Head | Neg_Tail]) :-
%  Neg_Head < 0,
%  split(Tail, Pos, Neg_Tail).


%%% 2 with cuts
split([], [], []).

split([HP | TL], [HP | TP], N) :-
  HP >= 0, !, 
  split(TL, TP, N).

split([HN | TL], P, [HN | TN]) :-
  HN < 0, !,
  split(TL, P, TN).
