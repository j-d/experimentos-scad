use <funciones.scad>

$fn = 50;

diametro      = 4.8;
largo_inserto = 8;
trim          = 0.15;
angulo        = 90;

/// 

PI             = 3.14159;
alto           = diametro;
ancho          = diametro + 3;
lado_inserto   = diametro * PI / 4; // sqrt(diametro * diametro / 2);
diametro2      = diametro / 2;
largo_inserto2 = largo_inserto / 2;

dt = (ancho-diametro)/2;

/*
difference() {
    cube([ancho, ancho, alto], true);
    color("red") translate([0  * ancho, -dt - 0.2]) cylinder(1 + alto, d=diametro, center=true);
    color("red") translate([0, 6]) cube([1 + ancho * 5, ancho, 1 + alto], true);
}*/


lado_inserto = 3.65;
diagonal_inserto  = sqrt(2 * lado_inserto * lado_inserto);
diagonal_inserto2 = diagonal_inserto / 2;
diagonal_inserto4 = diagonal_inserto / 4;
lado_inserto2     = lado_inserto / 2;

difference() {
    union() {
        translate([-largo_inserto2 , diagonal_inserto2, 0]) inserto("I");
        toro_parcial(2 * diagonal_inserto, diagonal_inserto, angulo);
        rotate(360 - angulo) translate([largo_inserto2, diagonal_inserto2, 0])  inserto("D");
    }
    raise(-diagonal_inserto2 + trim/2) cube([largo_inserto * 3, largo_inserto * 3, trim], true);
}

module inserto(pico = "") {
    rotate([45, 0, 0]) cube([largo_inserto, lado_inserto, lado_inserto], true);
    
    if (pico == "I") 
        translate([-diagonal_inserto4 - largo_inserto2, 0]) 
            rotate([0, 90]) 
                cylinder(diagonal_inserto2, r1=0, r2=diagonal_inserto2, $fn=4, center = true);
    else if (pico == "D")
        translate([diagonal_inserto4 + largo_inserto2, 0]) 
            rotate([0, 270]) 
                cylinder(diagonal_inserto2, r1=0, r2=diagonal_inserto2, $fn=4, center = true);
}