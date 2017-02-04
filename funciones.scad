   
module translate_giro(d, angulo) {
    translate([-d * cos(180-angulo), d * sin(180-angulo), 0])
        rotate(angulo)
            children();
}

module raise(z) {
    translate([0, 0, z]) children();
}

module semiesfera(di) {
    intersection() {
        sphere(d=di);
        translate([di/4, 0]) cube([di/2, di, di], true);
    }
}


module semiesfera_redondeada(diametro, diametro_redondeo = 0) {
    diametro_redondeo = diametro_redondeo == 0 ? diametro / 4 : diametro_redondeo;
    
    diametro2 = diametro / 2;
    diametro_redondeo2 = diametro_redondeo / 2;
    ddr2 = diametro2 - diametro_redondeo2;
    
    union () {
        translate([diametro_redondeo2, 0, 0]) resize([ddr2, diametro, diametro]) semiesfera(diametro);
        
        intersection() {
            translate([diametro_redondeo2, 0, 0]) rotate([0, 90]) toro(diametro, diametro_redondeo);
            translate([diametro_redondeo2 /2, 0, 0]) cube([diametro_redondeo2, diametro, diametro], true);
        }
        
        rotate([0, 90]) cylinder(diametro_redondeo2, d=diametro - diametro_redondeo);
    }
}

module cuartoesfera(di) {
    intersection() {
        sphere(d=di);
        translate([di/4, di/4]) cube([di/2, di/2, di], true);
    }
}

module cuartoesfera_aplastada(di, ancho, x = true) {
    if (x)
        resize([ancho/2, di/2, di]) cuartoesfera(di);
    else
        rotate(90) resize([di/2, ancho/2, di]) cuartoesfera(di);
}

module semicircle(diametro) {
    intersection() {
        circle(d=diametro);
        translate([diametro/4, 0]) square([diametro/2, diametro], true);
    }
}

module semicircle_redondeado(diametro, diametro_redondeo = 0) {
    diametro_redondeo = diametro_redondeo == 0 ? diametro / 4 : diametro_redondeo;
    
    translate([diametro_redondeo/2, 0]) resize([diametro/2 - diametro_redondeo/2, diametro]) semicircle(diametro);
    translate([diametro_redondeo/2, diametro/2 - diametro_redondeo/2]) rotate(90) cuartocircle(diametro_redondeo);
    translate([diametro_redondeo/2, -(diametro/2 - diametro_redondeo/2)]) rotate(180) cuartocircle(diametro_redondeo);
    translate([diametro_redondeo/4, 0]) square([diametro_redondeo/2, diametro - diametro_redondeo], true);
}

module cuartocircle(diametro) {
    intersection() {
        circle(d=diametro);
        translate([diametro/4, diametro/4]) square([diametro/2, diametro/2], true);
    }
}

module talla_cuartocircle(radio) {
    difference() {
        square(radio);
        circle(radio);
    }
}

module semicylinder(altura, diametro) {
    intersection() {
        cylinder(altura, d=diametro);
        translate([0, -diametro/2, 0]) cube([diametro/2, diametro, altura]);
    }
}

module semicylinder_hueco(altura, diametro, grosor) {
    // Queda feo en la previsualizacion
    //
    // difference() {
    //     semicylinder(altura, diametro);
    //     semicylinder(altura, diametro-grosor);
    // }
    
    rotate(-90) rotate_extrude(angle=180) translate([diametro/2 - grosor, 0]) square([grosor, altura]);
}

module cuartocylinder_hueco(altura, diametro, grosor) {
    rotate(0) rotate_extrude(angle=90) translate([diametro/2 - grosor, 0]) square([grosor, altura]);
}

module cylinder_hueco(altura, diametro, grosor) {
    rotate_extrude(angle=360) translate([diametro/2 - grosor, 0]) square([grosor, altura]);
}

module toro_parcial(diametro_grande, diametro_pequeno, angulo) {
    rotate_extrude(angle=angulo)
        translate([diametro_grande / 2 - diametro_pequeno / 2, 0])
            circle(d=diametro_pequeno);
}

function radio_horizontal(radio, altura_desde_arriba) = radio*sin(acos((radio-altura_desde_arriba)/radio));

module toro(diametro_grande, diametro_pequeno) {
    rotate_extrude()
        translate([diametro_grande/2 - diametro_pequeno / 2, 0])
            circle(d=diametro_pequeno);
}

module talla_semicilindro(ancho, largo) {
    difference() {
        cube([ancho/2, largo, ancho], true);
        translate([-ancho/4, largo/2, 0]) rotate([90, 0]) cylinder(largo, d=ancho);
    }
}

module talla_cuartocirculo(ancho, largo) {
    difference() {
        cube([ancho, largo, ancho], true);
        translate([-ancho/2, largo/2, -ancho/2]) rotate([90, 0]) cylinder(largo, d=ancho*2);
    }
}

module sector_circular(diametro, angulo) {
    angulo2 = angulo / 2;
    
    if (0 == angulo) {
        // Nothing
    } else if (360 <= angulo) {
        circle(d = diametro);
    } else if (180 <= angulo) {
        union () {
            difference() {
                circle(d = diametro);
                color("red") rotate(angulo2) translate([0, diametro/4]) square([diametro, diametro/2], true);
            }
            
            difference() {
                circle(d = diametro);
                color("purple") rotate(360-angulo2) translate([0, -diametro/4]) square([diametro, diametro/2], true);
            }
        }
    } else {
        difference() {
            circle(d = diametro);
            color("red") rotate(angulo2) translate([0, diametro/4]) square([diametro, diametro/2], true);
            color("purple") rotate(360-angulo2) translate([0, -diametro/4]) square([diametro, diametro/2], true);
        }
    }
}

module talla_semicirculo(diametro, rotacion = 0, sobresaliente = 0) {
    rotate(rotacion) 
        difference() {
            square([diametro / 2 + sobresaliente * 2, diametro + sobresaliente], true);
            translate([-diametro / 4, 0]) circle(d = diametro);
            translate([-sobresaliente/2 -diametro/4 - 0.5, 0]) square([sobresaliente + 1, diametro], true);
        }
}

module arco_redondeado(diametro, grosor, angulo, bolas_en_exterior = true) {
    diametro2         = diametro / 2;
    grosor2           = grosor / 2;
    diametro_medio    = diametro2 - grosor2;
    diametro_interior = diametro - 2 * grosor;
    alpha             = asin(grosor2 / diametro_medio);
    angulo            = bolas_en_exterior ? angulo : angulo - 2 * alpha;
    angulo2           = angulo / 2;
    
    union() {
        difference() {
            sector_circular(diametro, angulo);
            sector_circular(diametro_interior, angulo + 10);
        }
        
        color("red") translate_giro(diametro_medio, angulo2)  circle(d=grosor);
        color("red") translate_giro(diametro_medio, -angulo2) circle(d=grosor);
    }
}