:-[graph].
:-[helper_functions].

main :-
	writeln('The towns included in the dataset are named a, b, c, d, e, f, g, h, i'),
	writeln('Please enter the starting town of the journey.'),
	read(From),
	writeln('Please enter the destination town of the journey'),
	read(To),
	setof([Path,Total_Cost],shortest_path(From,To,Path,Total_Cost),X),
	write_path_set(X).
