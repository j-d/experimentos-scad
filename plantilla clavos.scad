$fn = 20;

use <funciones_puntos.scad>

ancho_cubo       = 9;
ancho_hueco      = 4.4;
alto_cubo        = 12;
margen_cubo_palo = 0.4;
alto_marcas_palo = 0.6;

///

alto_cubo2  = alto_cubo / 2;
ancho_palo  = 3.6;
ancho_palo2 = ancho_palo / 2;

///

//cubo(ancho_hueco);

cubo_reglado(100);


module cubo_reglado(longitud) {
    longitud2 = longitud / 2;
    corte_esquina = ancho_palo2 / 2;
    d = ancho_palo * 1.41;
    
    rotate(90)  {
        difference() {
            union () {
                cube([longitud, ancho_palo, ancho_palo]);
                rotate(-90) translate([-ancho_palo2, 0, ancho_palo2]) rotate([90]) rotate([0, 0, 45]) cylinder(ancho_palo2, d1 = d, d2 = 0, $fn=4);
                rotate(-90)  translate([-ancho_palo2, longitud, ancho_palo2]) rotate([-90]) rotate([0, 0, 45]) cylinder(ancho_palo2, d1 = d, d2 = 0, $fn=4);
            }
            
            translate([longitud2, 0])                      rotate([45]) cube([longitud+20, corte_esquina, corte_esquina], true);
            translate([longitud2, ancho_palo])             rotate([45]) cube([longitud+20, corte_esquina, corte_esquina], true);
            translate([longitud2, ancho_palo, ancho_palo]) rotate([45]) cube([longitud+20, corte_esquina, corte_esquina], true);
            translate([longitud2, 0, ancho_palo])          rotate([45]) cube([longitud+20, corte_esquina, corte_esquina], true);
            translate([-ancho_palo * 1.25, 0]) cube(ancho_palo); 
            translate([longitud + ancho_palo * 0.25, 0]) cube(ancho_palo); 
            
            for (i=[10:20:longitud - 1]) {
                translate([i, 0, ancho_palo - alto_marcas_palo]) 
                    cube([10, ancho_palo, alto_marcas_palo]);
            }
        }
    }
}

module cubo(ancho_hueco) {
    ancho_piramide = ancho_hueco + 5;
    ancho_piramide2 = ancho_piramide / 2;
    alto_piramide = 3;
    alto_piramide2 = alto_piramide / 2;
    
    translate([0, 0, alto_cubo2]) 
        difference() {
            cube([ancho_cubo, ancho_cubo, alto_cubo], true);
            union() {
                cube([ancho_hueco, ancho_hueco, alto_cubo + 1], true);
                translate([0, 0, -alto_cubo2 + alto_piramide2]) rotate(45) cylinder(alto_piramide, d1=ancho_piramide, d2=0, $fn=4, center=true);
                translate([0, 0, alto_cubo2 - alto_piramide2]) rotate(45) cylinder(alto_piramide, d2=ancho_piramide, d1=0, $fn=4, center=true);
            }
        }
}