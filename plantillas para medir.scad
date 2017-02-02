use <funciones.scad>

$fn = 50;
altura = 1.2;
ancho = 7;
largo = 50;
alto_texto = ancho - 1;

module curva(radio) {
    _radio = radio + ancho;
    alto_texto = alto_texto - 1;
    
    cuartocylinder_hueco(altura, 2 * _radio, ancho);
    translate([_radio - 2, -3, 0]) cylinder_hueco(altura, 10, 2);
    translate([_radio - ancho,-3.5,0])cube([2, 5, altura]);
    
    translate([_radio - (ancho/2 - alto_texto/2+0.5), 1, 0]) linear_extrude(altura + 1) rotate(90) text(str(radio), alto_texto);
}

curva(34);
//angulo(150);


module angulo(angulo_) {
    translate([-3, 2, 0]) cylinder_hueco(altura, 10, 2);
    translate([-3.5,ancho-2,0])cube([5, 2, altura]);
    
     cube([largo, ancho, altura]);
    
     minkowski() {
         if (angulo_ <= 90) {
            translate([largo, ancho]) rotate(180-angulo_) cube([largo, 0.01, 0.01]);
         } else {
            translate([largo, 0]) rotate(180-angulo_) cube([largo, 0.01, 0.01]);
         }
         rotate(180-angulo_) cube([0.01, ancho, grosor]) ;
     }
    
    translate([1, (ancho/2 - alto_texto/2), 0]) linear_extrude(altura  + 1) text(str(angulo_), alto_texto);
}