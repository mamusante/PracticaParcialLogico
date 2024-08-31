% https://docs.google.com/document/d/1VPvQQQJwVH20ziLA-96Hy1mKXHOQZpCJ9SW2rWOL2Zg/edit#heading=h.yiku9wnu1sl1

destino(pehuenia).
destino(sanMartin).
destino(esquel).
destino(sarmiento).
destino(camarones).
destino(playasDoradas).
destino(bariloche).
destino(elBolson).
destino(marDelPlata).
destino(calafate).

vacaciones(dodain , [pehuenia , sanMartin , esquel , sarmiento , camarones , playasDoradas]).
vacaciones(alf , [bariloche , sanMartin , elBolson]).
vacaciones(nico , [marDelPlata]).
vacaciones(vale , [calafate , elBolson]).
vacaciones(martu , Destinos):-
    vacaciones(nico , DestinosNico),
    vacaciones(alf , DestinosAlf),
    append(DestinosNico , DestinosAlf , Destinos).

atraccion(esquel , parqueNacional(losAlerces)).
atraccion(esquel , excursion(trochita)).
atraccion(esquel , excursion(trevelin)).

atraccion(marDelPlata , playa(4)).

atraccion(pehuenia , cerro(bateaMutida , 2000)).
atraccion(pehuenia , cuerpoDeAgua(moqueue , pescaSi , 14)).
atraccion(pehuenia , cuerpoDeAgua(alumine , pescaSi , 19)).

atraccionCopada(cerro( _ , Altura)):- 
    Altura > 2000.

atraccionCopada(cuerpoDeAgua( _ , pescaSi , _)).

atraccionCopada(cuerpoDeAgua( _ , _ , Temperatura)):-
    Temperatura > 20.

atraccionCopada(playa(DiferenciaDeMareas)):-
    DiferenciaDeMareas < 5.

atraccionCopada(excursion(Nombre)):-
    cantidadDeLetras(Nombre , CantidadDeLetras),
    CantidadDeLetras > 6.

atraccionCopada(parqueNacional(_)).

cantidadDeLetras(Palabra , CantidadDeLetras):-
    string_length(Palabra , CantidadDeLetras).
    

atraccionCopadaEnDestino(Destino):-
    atraccion(Destino , Atraccion),
    atraccionCopada(Atraccion).

vacacionesCopadas(Pasajero , Vacaciones):-
    % vacaciones(Pasajero , Vacaciones),
    % forall(member(Destino , Vacaciones) , atraccionCopadaEnDestino(Destino)).
    seCumpleParaTodosLosDestinos(Pasajero , atraccionCopadaEnDestino , Vacaciones).

noFue(Persona , Destino):-
    vacaciones(Persona , Vacaciones),
    destino(Destino),
    not(member(Destino , Vacaciones)).

noSeCruzaron(UnaPersona , OtraPersona):-
    % vacaciones(UnaPersona , Vacaciones),
    % vacaciones(OtraPersona , _),
    % forall(member(Destino , Vacaciones) , noFue(OtraPersona , Destino)).
    vacaciones(OtraPersona , _),
    seCumpleParaTodosLosDestinos(UnaPersona , noFue(OtraPersona) , _).

costoDeVida(sarmiento , 100).
costoDeVida(esquel , 150).
costoDeVida(pehuenia , 180).
costoDeVida(sanMartin , 150).
costoDeVida(camarones , 135).
costoDeVida(playasDoradas , 170).
costoDeVida(bariloche , 140).
costoDeVida(elBolson , 145).
costoDeVida(marDelPlata , 140).
costoDeVida(calafate , 240).

destinoGasolero(Destino):-
    costoDeVida(Destino , Costo),
    Costo < 160.

vacacionesGasoleras(Persona , Vacaciones):-
    % vacaciones(Persona , Vacaciones),
    % forall(member(Destino , Vacaciones) , destinoGasolero(Destino)).
    seCumpleParaTodosLosDestinos(Persona , destinoGasolero , Vacaciones).

seCumpleParaTodosLosDestinos(Persona , Condicion, Vacaciones):-
    vacaciones(Persona , Vacaciones),
    forall(member(Destino , Vacaciones) , aplicarCondicion(Condicion, Destino)).

aplicarCondicion(destinoGasolero , Destino):-
    destinoGasolero(Destino).

aplicarCondicion(atraccionCopadaEnDestino, Destino):-
    atraccionCopadaEnDestino(Destino).

aplicarCondicion(noFue(OtraPersona) , Destino):-
    noFue(OtraPersona , Destino).




