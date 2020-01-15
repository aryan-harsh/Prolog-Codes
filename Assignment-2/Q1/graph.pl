transport(transport1,a,b).
transport(transport1,b,d).
transport(transport2,a,c).
transport(transport2,c,d).
transport(transport3,a,e).
transport(transport3,e,d).
transport(transport4,a,d).
transport(transport5,b,e).
transport(transport5,e,c).
transport(transport6,a,b).
transport(transport6,b,e).
transport(transport6,e,c).
transport(transport6,c,d).
transport(transport7,f,g).
transport(transport8,c,h).
transport(transport8,h,i).
transport(transport8,i,b).

mileage(15). % Chosen mileage

route(a,b,200,20,34,37).
route(a,c,400,10,54,76).
route(a,e,100,30,45,43).
route(a,d,400,20,12,13).
route(b,e,100,40,45,65).
route(b,d,300,50,12,23).
route(c,e,200,60,56,65).
route(c,d,500,30,12,12).
route(d,e,200,10,45,65).
route(f,g,1000,40,65,31).
route(c,h,300,50,67,54).
route(h,i,400,20,12,13).
route(i,b,700,30,54,65).

reach(Start,Finish,Distance,RC,Grad,Fuel) :-
	route(Start,Finish,Distance,RC,Grad,Fuel); route(Finish,Start,Distance,RC,Grad,Fuel).
