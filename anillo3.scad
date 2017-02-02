use <funciones.scad>

$fn = 100;
diametro_corona = 6;
separacion_coronas = 4;
ancho = 28.5;
grosor = 2.5;
angulo = 360;
bottom_trim = 0.15;
angulo_hueco = 12;
diametro_hueco = 4.7;

ancho_cubo = 8;
alto_cubo = diametro_corona - 0.5;
ancho_inner_cubo = 4;
alto_inner_cubo = 4;
diferencia_inner_cubo = 3;

alto = 10;
radio_arco = 14;


/////

diametro_corona2 = diametro_corona / 2;
ancho_cuadrado   = diametro_corona / 4;
alto2            = alto / 2;
grosor2          = grosor / 2;
radio_arco_medio = radio_arco - grosor2;
arco             = 2 * asin(alto2 / radio_arco_medio);
radio_arco2      = radio_arco / 2;
arco2            = arco / 2;
ancho2           = ancho / 2;

anillo();

module anillo() {
    rotate_extrude(angle=angulo)
        difference() {
            translate([radio_arco - ancho_cuadrado + ancho2, alto2 + 1 - bottom_trim]) rotate(180) arco_redondeado(radio_arco * 2, ancho_cuadrado, arco);
            translate([0, -1]) square([ancho, 1]);
        }
}
