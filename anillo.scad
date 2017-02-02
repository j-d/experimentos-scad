use <funciones.scad>

$fn = 50;
diametro_corona = 6;
separacion_coronas = 10;
ancho = 29;
grosor = 2.5;
angulo = 305;
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

//anillo();
//translate([-25, 0]) travesanio(0.2, 0);
tapa();

module tapa() {
    cylinder(grosor/2, d=ancho_tapa);
    cylinder_hueco(separacion_coronas - bottom_trim + diametro_corona + grosor/2, ancho_tapa, grosor/2);
}

module anillo() {
    difference() {
        rotate(angulo_apertura)
            rotate_extrude(angle=angulo) {
                translate([ancho/2 - ancho_cuadrado, separacion_coronas+diametro_corona/2 - bottom_trim]) semicircle_redondeado(diametro_corona);
                
                color("red") translate([ancho/2 - ancho_cuadrado, diametro_corona/2 - bottom_trim]) square([ancho_cuadrado, separacion_coronas]);
                difference() {
                    translate([ancho/2 - ancho_cuadrado, diametro_corona/2 - bottom_trim]) semicircle_redondeado(diametro_corona);
                    translate([ancho/2 - ancho_cuadrado, - bottom_trim]) square([diametro_corona/2, bottom_trim]);
                }
                
            }
        raise(-alto_cubo / 2 + separacion_coronas - bottom_trim + diametro_corona) cube([ancho_cubo, 1 + ancho - 2 * ancho_cuadrado, alto_cubo], true);
        raise(-alto_inner_cubo / 2 + separacion_coronas - bottom_trim + diametro_corona) cube([ancho_inner_cubo, diferencia_inner_cubo + ancho - 2 * ancho_cuadrado, alto_inner_cubo], true);
    }

    translate_giro(ancho/2 - ancho_cuadrado, angulo_apertura) raise(separacion_coronas+diametro_corona/2 - bottom_trim) semiesfera_redondeada(diametro_corona);
    translate_giro(ancho/2 - ancho_cuadrado + ancho_cuadrado/2, angulo_apertura) raise(diametro_corona/2 - bottom_trim)  cylinder(separacion_coronas, d=ancho_cuadrado);
    translate_giro(ancho/2 - ancho_cuadrado, angulo_apertura) difference () {
        raise(diametro_corona/2 - bottom_trim) semiesfera_redondeada(diametro_corona); 
        translate([diametro_corona/4, 0, -bottom_trim/2]) cube([diametro_corona / 2, diametro_corona, bottom_trim], true);
    }

    translate_giro(ancho/2 - ancho_cuadrado, -angulo_apertura) raise(separacion_coronas+diametro_corona/2 - bottom_trim) semiesfera_redondeada(diametro_corona);
    translate_giro(ancho/2 - ancho_cuadrado + ancho_cuadrado/2, -angulo_apertura) raise(diametro_corona/2 - bottom_trim)  cylinder(separacion_coronas, d=ancho_cuadrado);
    translate_giro(ancho/2 - ancho_cuadrado, -angulo_apertura) difference () {
        raise(diametro_corona/2 - bottom_trim) semiesfera_redondeada(diametro_corona); 
        translate([diametro_corona/4, 0, -bottom_trim/2]) cube([diametro_corona / 2, diametro_corona, bottom_trim], true);
    }
}

module travesanio(holgura, diferencia_expansora) {
    ajuste = holgura + diferencia_expansora;
    ancho_travesanio = ancho - 2 * ancho_cuadrado - ajuste + 1;

    difference() {
        union () {
            raise(alto_cubo / 2)       cube([ancho_cubo, ancho_travesanio, alto_cubo - holgura], true);
            raise(alto_inner_cubo / 2) cube([ancho_inner_cubo, diferencia_inner_cubo + ancho - 2 * ancho_cuadrado - ajuste, alto_inner_cubo - holgura], true);
        }
        resize([0, 0, 10]) translate([- ancho_cubo/2 - 0.5, 0, (ancho_travesanio - 2 * grosor)/2 + 2 * grosor]) rotate([0, 90]) cylinder(ancho_cubo + 1, d = ancho_travesanio -  grosor);
    }
}
