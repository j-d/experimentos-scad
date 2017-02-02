$fn = 50;

ancho = 34;
profundo = 31;
alto = 17.5;
grosor = 2.5;
profundo_cortado = 15;

intersection () {
    union() {
        translate([-ancho/2, 0, profundo_cortado/2]) rotate([0, 90, 0]) cylinder(ancho, d = profundo_cortado);
        translate([0, 0, 3*alto/4]) cube([ancho, profundo_cortado, alto/2], true);
    }

    intersection() {
        cilindro_estirado_hueco(ancho, profundo, alto, grosor);
        translate([-ancho/2, -profundo_cortado/2]) cube([ancho, profundo_cortado, alto]);
    }
}

module cilindro_estirado_hueco(ancho, profundo, alto, grosor) {
    difference() {
        cilindro_estirado (ancho, profundo, alto);
        cilindro_estirado (ancho - 2 * grosor, profundo - 2 * grosor, alto );
    }
}


module cilindro_estirado (ancho, profundo, alto) {
    resize([ancho, profundo, alto]) cylinder(10, d = 10);
}

