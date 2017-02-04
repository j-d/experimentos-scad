use <funciones.scad>

$fn = 100;
diametro_corona = 6;
separacion_coronas = 10;
ancho = 31;
grosor = 2.5;
bottom_trim = 0.25;
angulo_hueco = 12;
diametro_hueco = 4.7;
incremento_resta = 30;

/////

ancho_cuadrado = diametro_corona/4;
diametro_justo_exterior = ancho + 2 * ancho_cuadrado;
diametro_resta = diametro_justo_exterior + incremento_resta;


difference() {
//union() {
    anillo();
    color("red") translate([-(diametro_resta - diametro_justo_exterior) / 2, 0]) cylinder_hueco(16, diametro_resta, ancho_cuadrado);
}

module anillo() {
    rotate_extrude() {
        union () {
            translate([ancho/2 - ancho_cuadrado, separacion_coronas+diametro_corona/2 - bottom_trim]) semicircle_redondeado(diametro_corona);
            color("red") translate([ancho/2 - ancho_cuadrado, diametro_corona/2 - bottom_trim]) square([ancho_cuadrado, separacion_coronas]);
            difference() {
                translate([ancho/2 - ancho_cuadrado, diametro_corona/2 - bottom_trim]) semicircle_redondeado(diametro_corona);
                translate([ancho/2 - ancho_cuadrado, - bottom_trim]) square([diametro_corona/2, bottom_trim]);
            }
        }
    }
}
