% https://docs.google.com/document/d/1SLYz4txoLYAE4b2jM_vc-U_1L2FMYg-p1zdxjKtVTU0/edit#heading=h.6rnhl8528rg3

% Created by Maria Musante

%------------------------------
%-----------Punto 1------------
%------------------------------

puestoDeComida(hamburguesa , 2000).
puestoDeComida(panchitoConPapas , 1500).
puestoDeComida(lomitoCompleto , 2500).


atraccion(autitosChocadores , tranquila(chicosYAdultos)).
atraccion(casaEmbrujada , tranquila(chicosYAdultos)).
atraccion(laberinto , tranquila(chicosYAdultos)).
atraccion(tobogan , tranquila(chicos)).
atraccion(calesita , tranquila(chicos)).

atraccion(barcoPirata , intensa(14)).
atraccion(tazasChinas , intensa(6)).
atraccion(simulador3D , intensa(2)).

atraccion(abismoMortalRecargada , montanaRusa(3 , 134)).
atraccion(paseoPorElBosque , montanaRusa(0 , 45)).

atraccion(elTorpedoSalpicon , acuatica).
atraccion(esperoQueHayasTraidoUnaMudaDeRopa , acuatica).

visitante(eusebio , 80 , 3000).
sentimientos(eusebio , 50 , 0).
integrante(eusebio , viejitos).

visitante(carmela , 80 , 0).
sentimientos(carmela , 0 , 25).
integrante(carmela , viejitos).

grupo(viejitos).
grupo(lopez).
grupo(promocion23).

%modelar dos personas que hayan venido solas

visitante(maria , 21 , 3500).
sentimientos(maria , 10 , 10).

visitante(luca , 22 , 5000).
sentimientos(luca , 50 , 20).

%------------------------------
%-----------Punto 2------------
%------------------------------

visitante(Visitante):-
    visitante(Visitante , _ , _).

estadoDeBienestar(Visitante , felicidadPlena):-
    visitante(Visitante),
    not(vinoSolo(Visitante)),
    sentimientos(Visitante , 0 , 0).

estadoDeBienestar(Visitante , podriaEstarMejor):-
    sumaSentimientos(Visitante , 1 , 50).

estadoDeBienestar(Visitante , podriaEstarMejor):-
    vinoSolo(Visitante),
    sumaSentimientos(Visitante , 0 , 0).

estadoDeBienestar(Visitante , necesitaEntretenerse):-
    sumaSentimientos(Visitante , 51 , 99).

estadoDeBienestar(Visitante , quiereIrseACasa):-
    sentimientos(Visitante , Hambre , Aburrimiento),
    Suma is Hambre + Aburrimiento,
    Suma >= 100.

sumaSentimientos(Visitante , ExtremoMenor , ExtremoMenor):-
    sentimientos(Visitante , Hambre , Aburrimiento),
    Suma is Hambre + Aburrimiento,
    between(ExtremoMenor , ExtremoMayor , Suma).


vinoSolo(Visitante):-
    visitante(Visitante),
    not(integrante(Visitante , _)).

%------------------------------
%-----------Punto 3------------
%------------------------------

satisfaceHambreDelGrupoFamiliar(Comida , Grupo):-
    grupo(Grupo),
    puestoDeComida(Comida , _),
    forall(integrante(Integrante , Grupo), puedeComprarYSatisfaceElHambre(Comida , Integrante)).


puedeComprarYSatisfaceElHambre(Comida , Visitante):-
    puedeComprar(Comida , Visitante),
    satisfaceHambre(Comida , Visitante).

puedeComprar(Comida , Visitante):-
    puestoDeComida(Comida , Precio),
    visitante(Visitante , _ , Dinero),
    Dinero >= Precio.

satisfaceHambre(hamburguesa , Visitante):-
    sentimientos(Visitante , Hambre , _),
    Hambre < 50.

satisfaceHambre(panchitoConPapas , Visitante):-
    esChico(Visitante).

satisfaceHambre(lomitoCompleto , _ ).

satisfaceHambre(caramelos , Visitante):-
    visitante(Visitante),
    forall(puestoDeComida(Comida , _) , not(puedeComprar(Comida , Visitante))).


esChico(Visitante):-
    visitante(Visitante , Edad , _ ),
    Edad < 13.

%------------------------------
%-----------Punto 4------------
%------------------------------

lluviaDeHamburguesas(Visitante , Atraccion):-
    puedeComprar(hamburguesa , Visitante),
    causaLluviaDeHamburguesas(Atraccion , Visitante).
    
causaLluviaDeHamburguesas(Atraccion , _):-
    intensaConCoeficienteMayorADiez(Atraccion).

causaLluviaDeHamburguesas(Atraccion , Visitante):-
    montanaRusaPeligrosa(Atraccion , Visitante).

causaLluviaDeHamburguesas(tobogan , _).

intensaConCoeficienteMayorADiez(Atraccion):-
    atraccion(Atraccion, intensa(CoeficienteDeLanzamiento)),
    CoeficienteDeLanzamiento > 10.

montanaRusaPeligrosa(Atraccion , Visitante):-
    esAdulto(Visitante),
    not(estadoDeBienestar(Visitante , necesitaEntretenerse)),
    montanaRusaConMasGiros(Atraccion).

montanaRusaPeligrosa(Atraccion , Visitante):-
    esChico(Visitante),
    montanaRusaConRecorridoDeMasDeUnMinuto(Atraccion).

montanaRusaConRecorridoDeMasDeUnMinuto(Atraccion):-
    atraccion(Atraccion , montanaRusa(_ , Duracion)),
    Duracion > 60.

esAdulto(Visitante):-
    visitante(Visitante),
    not(esChico(Visitante)).

montanaRusaConMasGiros(Atraccion):-
    atraccion(Atraccion , montanaRusa(Giros , _)),
    forall(atraccion(OtraMontanaRusa , montanaRusa(GirosDeLaOtra ,  _ )) , (Giros > GirosDeLaOtra)).

%------------------------------
%-----------Punto 5------------
%------------------------------

opcionesDeEntretenimiento(Visitante , Mes , Opciones):-
    findall(Opcion , opcionParticularDeEntretenimiento(Visitante , Mes , Opcion) , Opciones).

opcionParticularDeEntretenimiento(Visitante , _ , Comida):-
    puestoDeComida(Comida , _),
    puedeComprar(Comida , Visitante).

opcionParticularDeEntretenimiento(Visitante , _ , AtraccionTranquila):-
    atraccion(AtraccionTranquila , tranquila(_)),
    puedeAcceder(AtraccionTranquila , Visitante).

opcionParticularDeEntretenimiento(Visitante , _ , MontanaRusa):-
    atraccion(Atraccion , montanaRusa(_ , _)),
    montanaRusaNoPeligrosa(MontanaRusa , Visitante).

opcionParticularDeEntretenimiento(_ , Mes , AtraccionAcuatica):-
    acuatica(AtraccionAcuatica),
    acuaticaAbierta(AtraccionAcuatica , Mes).
    
acuaticaAbierta(Atraccion , Mes):-
    acuatica(Atraccion), 
    abiertaEn(Mes , Atraccion).

acuatica(Atraccion):-
    atraccion(Atraccion , acuatica).

abiertaEn(_ , Atraccion):-
    not(acuatica(Atraccion)).

abiertaEn(Mes , Atraccion):-
    acuatica(Atraccion),
    mesDeAperturaDeAcuatica(Mes).

mesDeAperturaDeAcuatica(Mes):-
    mes(Mes),
    not(between(4 , 8 , Mes)).

mes(NroDeMes):-
    between(1 , 12 , NroDeMes).

montanaRusaNoPeligrosa(Atraccion , Visitante):-
    montanaRusa(Atraccion),
    not(montanaRusaPeligrosa(Atraccion , Visitante)).



intensa(Atraccion):-
    atraccion(Atraccion , intensa(_)).

montanaRusa(Atraccion):-
    atraccion(Atraccion , montanaRusa(_ , _)).

puedeAcceder(Atraccion , Visitante):-
    esChico(Visitante),
    atraccion(Atraccion , tranquila(chicos)).

puedeAcceder(Atraccion , Visitante):-
    esAdulto(Visitante) , 
    atraccion(Atraccion , tranquila(chicos)),
    acompanadoPorUnNinio(Visitante).

puedeAcceder(Atraccion , Visitante):-
    esAdulto(Visitante),
    atraccion(Atraccion , tranquila(chicosYAdultos)).
    

acompanadoPorUnNinio(Visitante):-
    integrante(Visitante , Grupo),
    integrante(Ninio , Grupo),
    visitante(Ninio , Edad , _),
    Edad < 13.







