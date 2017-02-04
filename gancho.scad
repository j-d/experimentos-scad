use <funciones.scad>

$fn = 50;

diametro = 12;
grosor   = 2.5;
angulo   = 240;
largo    = 20;
trim     = 0.04;

///

diametro2 = diametro / 2;
grosor2   = grosor / 2;
medio2    = diametro2 - grosor2;

///

difference() {
    union () {
        toro_parcial(diametro, grosor, angulo);
        translate_giro(medio2, angulo) sphere(d= grosor);
        translate([medio2, 0]) sphere(d= grosor);
        translate([medio2, 0]) rotate([0, 90, 0]) cylinder(largo, d=grosor);
        translate([medio2 + largo, 0]) sphere(d= grosor);
    }
    translate([0, 0, -grosor2 - 0.5 + trim]) cube([largo * 3, largo, 1], true); 
}