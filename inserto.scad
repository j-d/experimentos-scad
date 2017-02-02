
inserto(20, 15);

//// 
module inserto(ancho, alto, vacio = true) {
    if (vacio) {
        ancho_pieza = 8;
        largo_saliente = 2;
        alto_saliente = 2;

        inserto2(ancho, alto, ancho_pieza, largo_saliente, alto_saliente, vacio);
    } else {
        dif = 0.25;
        ancho_pieza = 8 - dif;
        largo_saliente = 2 - dif;
        alto_saliente = 2 - dif;

        inserto2(ancho, alto, ancho_pieza, largo_saliente, alto_saliente, vacio);
    }
}

module inserto2(ancho, alto, ancho_pieza, largo_saliente, alto_saliente, vacio) {
    translate([-ancho/2, -(ancho_pieza/2), 0]) 
            cube([ancho, ancho_pieza, alto]);
        translate([-(ancho + largo_saliente * 2)/2, -(ancho_pieza - 4)/2, 0]) 
            cube([ancho + largo_saliente * 2, ancho_pieza - 4, alto_saliente]);
}