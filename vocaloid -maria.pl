vocaloid(megurineLuka , cancion(nightFever , 4)).
vocaloid(megurineLuka , cancion(foreverYoung , 5)).
vocaloid(hatsuneMiku , cancion(tellYourWorld , 3)).
vocaloid(gumi , cancion(foreverYoung , 4)).
vocaloid(gumi , cancion(tellYourWorld , 5)).
vocaloid(seeU , cancion(novemberRain , 6)).
vocaloid(seeU , cancion(nightFever , 5)).

%kaito no sabe cantar ninguna cancion, no lo reflejamos por el principio de universo cerrado
vocaloid(Vocaloid):-
    vocaloid(Vocaloid , _).

novedoso(Vocaloid):-
    vocaloid(Vocaloid),
    cantaMasDeUnaCancion(Vocaloid),
    tiempoTotalCanciones(Vocaloid , TiempoTotal),
    TiempoTotal < 15.

cantaMasDeUnaCancion(Vocaloid):-
    vocaloid(Vocaloid , cancion(Cancion1 , _)),
    vocaloid(Vocaloid , cancion(Cancion2 , _)),
    Cancion1 \= Cancion2.

tiempoTotalCanciones(Vocaloid , TiempoTotal):-
    findall(Tiempo , vocaloid(Vocaloid , cancion(_ , Tiempo)) , Tiempos),
    sumlist(Tiempos , TiempoTotal).


acelerado(Vocaloid):-
    vocaloid(Vocaloid),
    not(cantaCancionDeMasDe4Minutos(Vocaloid)).

cantaCancionDeMasDe4Minutos(Vocaloid):-
    vocaloid(Vocaloid , cancion(_ , Tiempo)),
    Tiempo > 4.

% concierto(Nombre , Pais , CantidadDeFama).
% tipoDeConcierto(Nombre , gigante(minimoDeCanciones , minimoDeTiempoTotal)).
% tipoDeConcierto(Nombre , mediano(maximoDeTiempoTotal)).
% tipoDeConcierto(Nombre , pequenio(minimoDeMinutosDeAlMenosUnaCancion)).


concierto(mikuExpo , estadosUnidos , 2000).
concierto(magicalMirai , japon , 3000).
concierto(vocalektVisions , estadosUnidos , 1000).
concierto(mikuFest , argentina , 100).

tipoDeConcierto(magicalMirai , gigante(3 , 10)).
tipoDeConcierto(mikuExpo , gigante(2 , 6)).
tipoDeConcierto(vocalektVisions , mediano(9)).
tipoDeConcierto(mikuFest , pequenio(4)).


puedeParticiparEnConcierto(Vocaloid , Concierto):-
    vocaloid(Vocaloid),
    concierto(Concierto , _ , _),
    tipoDeConcierto(Concierto , TipoDeConcierto),
    cumpleCondiciones(Vocaloid , TipoDeConcierto).

puedeParticiparEnConcierto(hatsuneMiku , _).

cumpleCondiciones(Vocalid , gigante(MinimoDeCanciones, MinimoDeTiempoTotal)):-
    vocaloid(Vocalid),
    cantidadDeCanciones(Vocalid , CantidadDeCanciones),
    tiempoTotalCanciones(Vocalid , TiempoTotal),
    CantidadDeCanciones >= MinimoDeCanciones,
    TiempoTotal >= MinimoDeTiempoTotal.

cumpleCondiciones(Vocalid , mediano(MaximoDeTiempoTotal)):-
    vocaloid(Vocalid),
    tiempoTotalCanciones(Vocalid , TiempoTotal),
    TiempoTotal =< MaximoDeTiempoTotal.

cumpleCondiciones(Vocalid , pequenio(MinimoDeMinutosDeAlMenosUnaCancion)):-
    vocaloid(Vocalid),
    vocaloid(Vocalid , cancion(_ , Tiempo)),
    Tiempo >= MinimoDeMinutosDeAlMenosUnaCancion.

cantidadDeCanciones(Vocaloid , CantidadDeCanciones):-
    vocaloid(Vocaloid),
    findall(Cancion , vocaloid(Vocaloid , cancion(Cancion , _)) , Canciones),
    length(Canciones , CantidadDeCanciones).

    
elMasFamoso(Vokaloid):-
    vocaloid(Vokaloid),
    forall(otroVokaloid(Vokaloid , OtroVokaloid), tieneFamaMayorQue(Vokaloid , OtroVokaloid)).

tieneFamaMayorQue(Vokaloid , OtroVokaloid):-
    famaTotal(Vokaloid , FamaTotal),
    famaTotal(OtroVokaloid , OtraFamaTotal),
    FamaTotal > OtraFamaTotal.

otroVokaloid(VokaloidOriginal , OtroVokaloid):-
    vocaloid(OtroVokaloid) , 
    OtroVokaloid \= VokaloidOriginal.


famaTotal(Vokaloid , FamaTotal):-
    vocaloid(Vokaloid),
    famaPorConciertos(Vokaloid , FamaTotal),
    cantidadDeCanciones(Vokaloid , CantidadDeCanciones),
    FamaTotal is FamaTotal * CantidadDeCanciones.

famaPorConciertos(Vokaloid , FamaTotal):-
    vocaloid(Vokaloid),
    findall(Fama ,  famaDeLosConciertosQuePuedeParticipar(Vokaloid , Fama), Famas),
    sumlist(Famas , FamaTotal).

famaDeLosConciertosQuePuedeParticipar(Vokaloid , Fama):-
    puedeParticiparEnConcierto(Vokaloid , Concierto) , 
    concierto(Concierto , _ , Fama).

conoce(megurineLuka , hatsuneMiku).
conoce(megurineLuka , gumi).
conoce(gumi , seeU).
conoce(seeU , kaito).

unicoQueParticipa(Vokaloid , Concierto):-
    vocaloid(Vokaloid),
    puedeParticiparEnConcierto(Vokaloid , Concierto),
    not((conocido(Vokaloid , OtroVokaloid) , puedeParticiparEnConcierto(OtroVokaloid , Concierto))).
    

conocido(Vokaloid , Conocido):-
    conoce(Vokaloid , Conocido).

conocido(Vokaloid , Conocido):-
    conoce(Vokaloid , OtroVokaloid),
    conocido(OtroVokaloid , Conocido).
