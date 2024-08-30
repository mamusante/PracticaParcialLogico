%https://docs.google.com/document/u/1/d/e/2PACX-1vR9SBhz2J3lmqcMXOBs1BzSt7N1YWPoIuubAmQxPIOcnbn5Ow9REYt4NXQzOwXXiUaEQ4hfHNEt3_C7/pub

mago(harry , sangreMestiza , [coraje, amistad, orgullo, inteligencia]).
mago(draco , sangrePura , [inteligencia, orgullo]).
mago(hermione , sangreImpura , [inteligencia, orgullo, responsabilidad]).

caracterMago(harry , coraje).
caracterMago(harry , amistad).
caracterMago(harry , orgullo).
caracterMago(harry , inteligencia).
caracterMago(draco , orgullo).
caracterMago(draco , inteligencia).
caracterMago(hermione , responsabilidad).
caracterMago(hermione , orgullo).
caracterMago(hermione , inteligencia).

casa(gryffindor , coraje).
casa(hufflepuff , amistad).
casa(ravenclaw , responsabilidad).
casa(ravenclaw , inteligencia).
casa(slytherin , orgullo).
casa(slytherin , inteligencia).

odia(harry , slytherin).
odia(draco , hufflepuff).


permiteEntrar(slytherin , Mago):-
    mago(Mago , _ , _ ),
    not(mago(Mago , sangreImpura , _)).

permiteEntrar(Casa , Mago):-
    casa(Casa , _),
    mago(Mago , _ , _),
    Casa \= slytherin.

tieneCaracterApropiado( Mago ,  Casa ):-
    mago(Mago , _ , _),
    casa(Casa , _),
    forall(casa(Casa , CaracterPedido) , caracterMago(Mago , CaracterPedido)).

posibleCasa(Mago , Casa):-
    permiteEntrar(Casa , Mago),
    tieneCaracterApropiado(Mago , Casa),
    not(odia(Mago , Casa)).

posibleCasa(hermione , gryffindor).

accion(harry , andarDeNocheFueraDeLaCama).
accion(hermione , irA(tercerPiso)).
accion(harry , irA(bosque)).
accion(harry , irA(tercerPiso)).
accion(draco , irA(mazmorras)).
accion(ron , ganarAjedrezMagico).
accion(hermione , usarIntelecto).
accion(harry , ganarleAVoldemort).
accion(hermione , irA(seccionRestringidaDeLaBiblioteca)).

lugarProhibido(bosque).
lugarProhibido(tercerPiso).
lugarProhibido(seccionRestringidaDeLaBiblioteca).


puntaje( andarDeNocheFueraDeLaCama , -50).
puntaje( irA(tercerPiso) , -75).
puntaje( irA(bosque) , -50).
puntaje( irA(seccionRestringidaDeLaBiblioteca) , -10).

puntaje( ganarAjedrezMagico , 50).
puntaje( usarIntelecto , 50).
puntaje( ganarleAVoldemort , 60).

puntaje( irA(Lugar) , 0):-
    not(lugarProhibido(Lugar)).

puntaje(responderPregunta(Pregunta, snape) , Puntaje):-
    pregunta(Pregunta , Puntaje),
    Puntaje is Puntaje / 2.

puntaje(responderPregunta(Pregunta, Profesor) , Puntaje):-
    pregunta(Pregunta , Puntaje),
    Profesor \= snape.

esDe(hermione , gryffindor).
esDe(harry , gryffindor).
esDe(draco , slytherin).
esDe(ron , gryffindor).
esDe(luna , ravenclaw).

buenAlumno(Mago):-
    accion(Mago , _),
    forall(accion(Mago , Accion) , buenaAccion(Accion)).

buenaAccion(Accion):-
    puntaje(Accion , Puntaje),
    Puntaje > 0.

accionRecurrente(Accion):-
    accion(Mago , Accion),
    accion(OtroMago , Accion),
    Mago \= OtroMago.

puntajeTotalDeCasa(Casa , Puntaje):-
    casa(Casa , _),
    findall(Puntaje , puntajeTotalQueAportaAUnaCasa( Mago , Casa , Puntaje) , Puntajes),
    sumlist(Puntajes , Puntaje).

puntajeTotalQueAportaAUnaCasa( Mago , Casa , Puntaje):-
    esDe(Mago , Casa),
    accion(Mago , _),
    findall(PuntajeAccion , (accion(Mago , Accion) , puntaje(Accion , PuntajeAccion)) , Puntajes),
    sumlist(Puntajes , Puntaje).

casaGanadora(Casa):-
    puntajeTotalDeCasa(Casa , Puntaje),
    forall((puntajeTotalDeCasa(OtraCasa , OtroPuntaje) , Casa \= OtraCasa) , Puntaje > OtroPuntaje).


pregunta(dondeSeEncuentraUnBezoar , 20).
pregunta(comoHacerLevitarUnaPluma , 25).

accion(hermione , responderPregunta(dondeSeEncuentraUnBezoar , snape)).
accion(hermione , responderPregunta(comoHacerLevitarUnaPluma , flitwick)).


    