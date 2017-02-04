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

alto = 5;
radio_arco = 14;


/////

diametro_corona2 = diametro_corona / 2;
ancho_cuadrado   = diametro_corona / 4;
alto2            = alto / 2;
grosor2          = grosor / 2;
radio_arco_medio = radio_arco - grosor2;
arco             = 2 * asin(alto2 / radio_arco_medio);
arco2            = arco / 2;
ancho2           = ancho / 2;

anillo();
x = 6;

module anillo() {
    rotate_extrude(angle=angulo)
        difference() {
            union () {
                translate([x/2 - ancho_cuadrado + ancho/2, x/2 + alto]) rotate(90 + 45 + 7.5) arco_redondeado(x, ancho_cuadrado, 75, true);
                translate([-ancho_cuadrado + ancho/2, x/2]) square([ancho_cuadrado, alto]);
                translate([x/2 - ancho_cuadrado + ancho/2, x/2]) rotate(180 + 45 - 7.5) arco_redondeado(x, ancho_cuadrado, 75, true);
            }
            translate([0, -1 + bottom_trim]) square([ancho, 1]);            
        }
}
