$fn = 50;

ancho = 34;
profundo = 20;
alto = 40;
grosor = 2.5;

semicupula_hueca(ancho, profundo, alto, grosor);

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

