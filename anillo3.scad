use <funciones.scad>

$fn = 50;
diametro_corona = 6;
separacion_coronas = 7;
ancho = 29;
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

anillo();

module anillo() {
    difference() {
        rotate(angulo_apertura)
            rotate_extrude(angle=angulo) {
                //translate([ancho/2 - ancho_cuadrado, separacion_coronas+diametro_corona/2 - bottom_trim]) semicircle_redondeado(diametro_corona);
                difference() {
                    color("red") translate([ancho/2 - ancho_cuadrado, diametro_corona/2 - bottom_trim]) square([ancho_cuadrado, separacion_coronas]);
                    translate([10.6, -1 + separacion_coronas]) rotate(45) square(10);
                }
                
                difference() {
                    translate([ancho/2 - ancho_cuadrado, diametro_corona/2 - bottom_trim]) semicircle_redondeado(diametro_corona);
                    translate([ancho/2 - ancho_cuadrado, - bottom_trim]) square([diametro_corona/2, bottom_trim]);
                }
                
                color("green") translate([ancho/2 - ancho_cuadrado/2 - ancho_cuadrado + diametro_corona/2, separacion_coronas+diametro_corona -ancho_cuadrado/2 - bottom_trim]) circle(d=ancho_cuadrado);
                
                difference() {
                    translate([19, 1.3 + separacion_coronas]) color("pink") rotate(90) cuartocircle(diametro_corona * 2);
                    translate([19 + 1, 1.3 - 1 + separacion_coronas]) color("pink") rotate(90) cuartocircle(diametro_corona * 2);
                    translate([20.5, separacion_coronas]) rotate(45) square(10);
                }
                
                
  
            }
    }

}
