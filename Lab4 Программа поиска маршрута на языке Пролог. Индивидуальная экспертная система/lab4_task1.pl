DOMAINS

room = r1_entry; r2_food; r3_fountain; r4_gold_treasure; r5_paradise; r6_exit;

roomlist = room*

PREDICATES

% коридор между двумя пещерами
nondeterm gallery(room, room)
% предикат позвол¤ет разрешить проход по коридору в обе стороны
nondeterm neighborroom(room, room)
avoid(roomlist)
nondeterm go(room, room)
nondeterm route(room, room, roomlist)
% предикат определяет путь, по которому следует идти.
% roomlist - это список уже пройденных пещер.
nondeterm member(room, roomlist)

CLAUSES

% объявление коридоров
gallery(r1_entry, r3_fountain).
gallery(r3_fountain, r4_gold_treasure).
gallery(r4_gold_treasure, r5_paradise).
gallery(r5_paradise, r2_food).
gallery(r2_food, r6_exit).


neighborroom(X, Y) :- gallery(X, Y).
neighborroom(X, Y) :- gallery(Y, X).

% объявление списка запрещённых комнат
avoid([r7_monsters,r8_robbers]).

go(Here, There) :- route(Here, There, [Here]).

route(Room, Room, VisitedRooms):- 
	member(r4_gold_treasure, VisitedRooms), 
	write(VisitedRooms), nl.
	
route(Room, Way_out, VisitedRooms):- 
	neighborroom(Room, Nextroom), 
	avoid(DangerousRooms),
	not(member(NextRoom, DangerousRooms)),
	not(member(NextRoom, VisitedRooms)),
	route(NextRoom, Way_out, [NextRoom | VisitedRooms]).
	
member(X, [X | _]).
member(X, [_ | H]) :- member(X , H).

GOAL

go(r1_entry, r6_exit).
