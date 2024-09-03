%https://docs.google.com/document/d/1_B3EWYrNSmxOmfMxH8Gtpi3ViG5lWfQgwSq_dSWxTOk/edit

%----------------------------------
%-----------Parte 1----------------
%----------------------------------


pokemon(pikachu , electrico).
pokemon(charizard , fuego).
pokemon(venasaur , planta).
pokemon(blastoise , agua).
pokemon(totodile , agua).
pokemon(snorlax , normal).
pokemon(rayquaza , dragon).
pokemon(rayquaza , volador).

%arceus no se conoce su tipo, por el principio de universo cerrado no lo reflejamos en la base de conocimiento

entrenador(ash , pikachu).
entrenador(ash , charizard).

entrenador(brock , snorkax).

entrenador(misty , blastoise).
entrenador(misty , venasaur).
entrenador(misty , arceus).

%1
tipoMultiple(Pokemon):-
    pokemon(Pokemon , Tipo1),
    pokemon(Pokemon , Tipo2),
    Tipo1 \= Tipo2.

%2
legendario(Pokemon):-
    pokemon(Pokemon , _),
    tipoMultiple(Pokemon),
    not(entrenador(_ , Pokemon)).

%3
misterioso(Pokemon):-
    pokemon(Pokemon , _),
    unicoDeSuTipo(Pokemon).

misterioso(Pokemon):-
    not(entrenador(_ , Pokemon)).

unicoDeSuTipo(Pokemon):-
    pokemon(Pokemon , Tipo),
    not((pokemon(OtroPokemon , Tipo), OtroPokemon \= Pokemon)).


%----------------------------------
%-----------Parte 2----------------
%----------------------------------

movimiento(mordedura , fisico(95)).
movimiento(impactrueno , especial(electrico , 40)).
movimiento(garraDragon , especial(dragon , 100)).
movimiento(proteccion , defensivo(10)).
movimiento(placaje , fisico(50)).
movimiento(alivio , defensivo(100)).

movimientoDe(pikachu , mordedura).
movimientoDe(pikachu , impactrueno).

movimientoDe(charizard , garraDragon).
movimientoDe(charizard , mordedura).

movimientoDe(blastoise , proteccion).
movimientoDe(blastoise , placaje).

movimientoDe(arceus , impactrueno).
movimientoDe(arceus , alivio).
movimientoDe(arceus , garraDragon).
movimientoDe(arceus , proteccion).
movimientoDe(arceus , placaje).

%1
danioDeAtaque(Movimiento , Danio):-
    movimiento(Movimiento , ClaseDeMovimiento),
    danioSegunClaseDeMovimiento(ClaseDeMovimiento , Danio).

tipoClasico(fuego).
tipoClasico(planta).
tipoClasico(agua).
tipoClasico(normal).

danioSegunClaseDeMovimiento(defensivo(_) , 0).
danioSegunClaseDeMovimiento(fisico(Danio) , Danio).

danioSegunClaseDeMovimiento(especial(Tipo , Potencia) , Danio):-
    tipoClasico(Tipo),
    Danio is Potencia * (1.5).

danioSegunClaseDeMovimiento(especial( dragon , Potencia) , Danio):-
    Danio is Potencia * 3.

%si no entra en las otras dos reglas entrara en esta, por eso no aclaro que no debe ser de tipo clasico ni de dragon, ya que seria redundante
danioSegunClaseDeMovimiento(especial( _ , Potencia) , Potencia).



%2
capacidadOfensiva(Pokemon , CapacidadOfensiva):-
    pokemon(Pokemon , _),
    findall(Danio , danioDeUnPokemon(Pokemon , Danio) , Danios),
    sumlist(Danios , CapacidadOfensiva).

danioDeUnPokemon(Pokemon , Danio):-
    movimientoDe(Pokemon , Movimiento) ,
    danioDeAtaque(Movimiento , Danio).

%3
entrenadorPicante(Entrenador):-
    entrenador(Entrenador , _),
    forall(entrenador(Entrenador , Pokemon) , capacidadOfensivaSuperiorADoscientosOMisterioso(Pokemon)).

capacidadOfensivaSuperiorADoscientosOMisterioso(Pokemon):-
    capacidadOfensiva(Pokemon , CapacidadOfensiva),
    CapacidadOfensiva > 200.

capacidadOfensivaSuperiorADoscientosOMisterioso(Pokemon):-
    misterioso(Pokemon).