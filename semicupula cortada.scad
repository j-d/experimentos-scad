$fn = 50;

ancho = 34;
profundo = 31;
alto = 20;
grosor = 2.5;
profundo_cortado = 20;

intersection() {
    semicupula_hueca(ancho, profundo, alto, grosor);
    translate([-ancho/2, -profundo_cortado/2]) cube([ancho, profundo_cortado, alto]);
}

module semicupula_hueca(ancho, profundo, alto, grosor) {
    difference() {
        semicupula (ancho, profundo, alto);
        semicupula (ancho - 2 * grosor, profundo - 2 * grosor, alto - 2 * grosor);
    }
}

module semicupula (ancho, profundo, alto) {
    resize([ancho, profundo, alto]) 
        difference() {
            sphere(d = 10);
            translate([0, 0, -5]) cube(10, true);
        }
}

