use <funciones.scad>

$fn = 50;
diametro_corona = 6;
separacion_coronas = 7;
ancho = 28.5;
grosor = 2.5;
angulo = 360;
bottom_trim = 0.25;
angulo_hueco = 12;
diametro_hueco = 4.7;

ancho_cubo = 8;
alto_cubo = diametro_corona - 0.5;
ancho_inner_cubo = 4;
alto_inner_cubo = 4;
diferencia_inner_cubo = 3;

/////

ancho_tapa = ancho + diametro_corona/2 + 5;
ancho_cuadrado = diametro_corona/4;
redondeo = 1;
angulo_apertura = (360-angulo)/2;


difference() {
    anillo();
    resize([20, 100]) translate([ancho/2 + 2.7, 0, diametro_corona/2]) rotate(45) cube([10, 10, diametro_corona], true);
}

module anillo() {
    rotate(angulo_apertura)
        rotate_extrude(angle=angulo) {
            
            color("red") translate([ancho/2 - ancho_cuadrado, diametro_corona/2 - bottom_trim]) square([ancho_cuadrado, separacion_coronas]);
            difference() {
                translate([ancho/2 - ancho_cuadrado, diametro_corona/2 - bottom_trim]) semicircle_redondeado(diametro_corona);
                translate([ancho/2 - ancho_cuadrado, - bottom_trim]) square([diametro_corona/2, bottom_trim]);
            }
            
        }
}


