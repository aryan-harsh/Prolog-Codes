%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% LIST HELPER FUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

len(List,L) :- len(List,0,L).
len([],L,L).
len([_|T],Current,L) :-
	Current_new is Current + 1,
	len(T,Current_new,L).

element_at(Element, List, Pos) :-
    element_at(Element, List, 1, Pos).
element_at(H, [H|_], Pos, Pos):-!.
element_at(H, [_|T], Current_Pos, Pos) :-
    New_Current_Pos is Current_Pos + 1,
    element_at(H, T, New_Current_Pos, Pos).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PATH FUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

get_transport(Transport,From,To):-
	setof(Transport,transport_reach(Transport,From,To),Transport).

transport_reach(Transport,X,Y) :-
	transport(Transport,X,Y);transport(Transport,Y,X).

path(From,To,Path,Total_Cost) :-
	path(From,To,[From],Queue,Total_Distance,Total_RC,Total_Grad,Total_Fuel), 
	mileage(Mileage),
	Total_Cost is Total_Distance-Total_RC-Mileage+Total_Grad-Total_Fuel,
	reverse(Queue,Path).

path(From,To,Path,[To|Path],Distance,RC,Grad,Fuel) :- 
	reach(From,To,Distance,RC,Grad,Fuel).
path(From,To,Visited,Path,Total_Distance,Total_RC,Total_Grad, Total_Fuel) :-
	reach(From,Intermedia,Distance,RC,Grad,Fuel), 
	Intermedia \== To,
	\+member(Intermedia,Visited),
	path(Intermedia,To,[Intermedia|Visited],Path,Distance_Sub,RC_Sub,Grad_Sub,Fuel_Sub),
	Total_Distance is Distance_Sub+Distance,
	Total_RC is RC_Sub+RC,
	Total_Grad is Grad_Sub+Grad,
	Total_Fuel is Fuel_Sub+Fuel.
	   


shortest_path(From,To,Path,Length) :-
   setof([P,L],path(From,To,P,L),Pairs),
   Pairs = [_|_],
   minimal(Pairs,[Path,Length]).
minimal([H|T],Min_Set) :- min(T,H,Min_Set).

write_path_transport([H|T]):-
	len([H|T],Length),
	Length=<1.
	
write_path_transports([H|T]) :-
	len([H|T],Length),
	Length>1,
	element_at(Second,T,1),
	get_transport(Transport,H,Second),
	write(H),write(' -> '),write(Second),
	write(' Available Transports: '),writeln(Transport),
	write_path_transports(T).

write_path_set([]).
write_path_set([H|T]) :-
	element_at(Path_List,H,1),
	write(Path_List),
	writeln('Path:'),
	write_path_list(Path_List),
	writeln(''),
	element_at(Distance,H,2),!,
	write('Cost/Time: '),writeln(Distance),
	write_path_transports(Path_List),
	writeln(''),
	write_path_set(T).
write_path_list(List) :-
	len(List,Length),
	write_path_list_help(Length,List).
write_arrow(N) :-
	N>0,!,
	write('->').
write_arrow(0).
write_path_list_help(0, _) :- !.
write_path_list_help(_, []).
write_path_list_help(N, [H|T]) :- 
	write(H),
	N1 is N - 1,
	write_arrow(N1),
	write_path_list_help(N1, T).
min([],Min_Set,Min_Set).
min([[Path|Distance]|T],[_,Current_Min_Distance],Min_Set) :-
	Distance < Current_Min_Distance,
	!,
	min(T,[Path,Distance],Min_Set).
min([_|T],Current_Min_Set,Min_Set) :-
	min(T,Current_Min_Set,Min_Set).
	
direct_transports(From,To,Transports) :-
	setof(Transport,transport(Transport,From,To),Transports).
transport_routes(Transport,Routes) :-
	setof([From,To],transport(Transport,From,To),Routes).
