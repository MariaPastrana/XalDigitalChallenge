-- 1. ¿Cuál es el nombre aeropuerto que ha tenido mayor movimiento durante el año?

select aeropuertos.Nombre_aeropuerto 
from vuelos 
join aeropuertos on vuelos.Id_aeropuerto = aeropuertos.Id_aeropuerto
group by aeropuertos.Nombre_aeropuerto
having count(*) = (
select max(a.c) 
  from (select count(*) as c
    from vuelos 
    join aeropuertos on vuelos.Id_aeropuerto = aeropuertos.Id_aeropuerto
    group by aeropuertos.Nombre_aeropuerto)
  as a);


-- 2. ¿Cuál es el nombre aerolínea que ha realizado mayor número de vuelos durante el año?
-- Nota: se tomó que las salidas son los vuelos

select aerolineas.Nombre_aerolinea 
from vuelos 
join aerolineas on vuelos.Id_aerolinea = aerolineas.Id_aerolinea
where vuelos.Id_movimiento = 1
group by aerolineas.Nombre_aerolinea
having count(*) = (
select max(a.c) 
  from (select count(*) as c
    from vuelos 
    join aeropuertos on vuelos.Id_aeropuerto = aeropuertos.Id_aeropuerto
	where vuelos.Id_movimiento = 1
    group by aeropuertos.Nombre_aeropuerto)
  as a);


-- 3. ¿En qué día se han tenido mayor número de vuelos?
-- Nota: se tomó que las salidas son los vuelos

select count(*) as cantidad_vuelos, dia
from vuelos 
where Id_movimiento = 1
group by dia;


-- 4. ¿Cuáles son las aerolíneas que tienen mas de 2 vuelos por día?
-- Nota: se tomó que las salidas son los vuelos

select aerolineas.Nombre_aerolinea, COUNT(*) numero_vuelos
from vuelos INNER JOIN aerolineas 
on(vuelos.Id_aerolinea = aerolineas.Id_aerolinea)
where vuelos.Id_movimiento = 1
group by aerolineas.Nombre_aerolinea, vuelos.dia
having count(*)>2;
