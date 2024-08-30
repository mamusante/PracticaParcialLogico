% https://docs.google.com/document/d/1XCwQt3f93h_uFzFlTFwf1YFAFglmQg84FyHIM5_Vp0Y/edit#heading=h.1orajatmx606

%Steam Summer Sale, by Maria Musante

juego(callOfDuty , accion).
juego(petSociety , rol).
juego(candyCrush , puzzle).

detallesJuego(petSociety , rol(5)).
detallesJuego(candyCrush , puzzle(10000, facil)). 


%precio(juego, precio).
precio(callOfDuty , 50).
precio(petSociety , 10).
precio(candyCrush , 25).

%oferta(juego, porcentajeDeDescuento).
oferta(candyCrush , 20).

cuantoSale(Juego , Precio):-
    juego(Juego , _),
    not(oferta(Juego , _)),
    precio(Juego , Precio).

cuantoSale(Juego , Precio):-
    juego(Juego , _),
    precioConDescuento(Juego , Precio).

precioConDescuento(Juego , Precio):-
    oferta(Juego , Porcentaje),
    precio(Juego , PrecioOriginal),
    Precio is PrecioOriginal - (PrecioOriginal * Porcentaje / 100).

tieneUnBuenDescuento(Juego):-
    oferta(Juego, Porcentaje),
    Porcentaje >= 50.

popular(Juego):-
    juego(Juego , accion).

popular(Juego):-
    detallesJuego(Juego, rol(UsuariosActivos)),
    UsuariosActivos > 1000000.

popular(Juego):-
    detallesJuego(Juego, puzzle( _, facil)).

popular(Juego):-
    detallesJuego(Juego , puzzle( 25, _)).

popular(minecraft).

popular(counterStrike).


%usuario(nombreDeUsuario).
usuario(mariaMusante).

%juegoComprado(comprador , juego).
juegoComprado(mariaMusante, callOfDuty).

futuraAdquisicion(mariaMusante , petSociety , compra).
futuraAdquisicion(mariaMusante , sims4 , regalo(luquita)).


adictoALosDescuentos(Usuario):-
    usuario(Usuario),
    forall(futuraAdquisicion(Usuario, Juego , _), tieneUnBuenDescuento(Juego)).

fanaticoDeGenero(Usuario, Genero):-
    usuario(Usuario),
    findall(Juego , juegoCompradoDeUnGenero(Juego, Genero, Usuario), Juegos),
    length(Juegos, Cantidad),
    Cantidad >= 2.

juegoCompradoDeUnGenero(Juego, Genero, Usuario):-
   juegoComprado(Usuario, Juego) ,
   juego(Juego, Genero).

monotematico(Usuario, Genero):-
    usuario(Usuario),
    forall(juegoComprado(Usuario, Juego), juego(Juego, Genero)).

buenosAmigos(UnUsuario , OtroUsuario):-
    quiereRegalarJuegoPopularA(UnUsuario, OtroUsuario),
    quiereRegalarJuegoPopularA(OtroUsuario, UnUsuario).

quiereRegalarJuegoPopularA(UnUsuario, OtroUsuario):-
    futuraAdquisicion(UnUsuario, Juego , regalo(OtroUsuario)),
    popular(Juego).

cuantoGastara(Usuario , Dinero) :-
    usuario(Usuario),
    findall(Precio , precioDeFuturaAdquisicion(Usuario , Precio) , Precios),
    sum_list(Precios, Dinero).

precioDeFuturaAdquisicion(Usuario , Precio):-
    futuraAdquisicion(Usuario, Juego,_) , 
    cuantoSale(Juego, Precio).





