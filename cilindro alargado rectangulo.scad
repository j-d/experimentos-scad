$fn = 25;

diametro = 10;
ancho = 50;
altura = 25;

////////////////

union() {
    translate([(ancho - diametro)/2, 0, 0]) cylinder(altura, d=diametro);
    translate([-(ancho - diametro)/2, 0, 0]) cylinder(altura, d=diametro);
    translate([-(ancho-diametro)/2, -diametro/2, 0]) cube([ancho-diametro, diametro, altura]);
}