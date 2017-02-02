$fn = 50;

cubo_redondeado(7, 10, 4, 2.5);


module cubo_redondeado(
    ancho, 
    profundo,
    alto,
    diametro = 3
) {
    minkowski() {
        cube([ancho - diametro, profundo - diametro, alto - diametro], true);
        sphere(d = diametro);
    }
}