use <funciones.scad>

$fn = 50;

diametro             = 4.8;
come_circulo         = 0.25;
margen_circulo       = 3;
largo_inserto        = 5;
trim                 = 0.15;
margen               = 0.10;
a1                   = 140;
a2                   = 80;
longitud_segmento    = largo_inserto + 5;
inserccion_en_esfera = 1.6;

/// 

PI                    = 3.14159;
semiangulo            = a1 / 2;
alto                  = diametro;
ancho                 = diametro + margen_circulo;
lado_inserto          = diametro * PI / 4; // sqrt(diametro * diametro / 2);
diametro2             = diametro / 2;
largo_inserto2        = largo_inserto / 2;
lado_inserto          = PI * diametro / 4 - margen;
diagonal_inserto      = sqrt(2 * lado_inserto * lado_inserto);
diagonal_inserto2     = diagonal_inserto / 2;
diagonal_inserto4     = diagonal_inserto / 4;
lado_inserto2         = lado_inserto / 2;
margen_circulo2       = margen_circulo / 2;
margen_circulo4       = margen_circulo / 4;
come_circulo2         = come_circulo / 2;
centro_al_lado_a_cubo = diametro2 + margen_circulo2;
centro_al_lado_b_cubo = diametro2 - come_circulo;
centro_al_alto_cubo   = alto / 2;
largo_cubo            = centro_al_lado_a_cubo * 2;
d_esfera              = diagonal_inserto2 - margen_circulo2;

///

// conector();
/*
difference() {
    angulo2(a1, a2);
    platea();
    
}*/
/*
rotate(270) rotate([0, 90, 0]) inserto_para_girar();
*/


//rama();

perfil();


//borde();

module borde() {
    tubo(72.5);
    translate([-d_esfera, 0]) rotate(-40) {
        rotate([0, 90]) inserto_para_girar();
        rotate([0, -90]) inserto_para_girar();
        rotate(180) angulo2(140);
        translate([-11 - d_esfera, 0]) {
            tubo(11);
            translate([-d_esfera, 0]) rotate(-50) {
                rotate([0, 90]) inserto_para_girar();
                rotate([0, -90]) inserto_para_girar();
                rotate(180) angulo2(130);
                translate([-25 - d_esfera, 0]) {
                    tubo(25);
                    translate([-d_esfera, 0]) {
                        rotate([90, 0, 0]) angulo2(90);
                        rotate([0, 90]) inserto_para_girar();
                    }
                }
            }
        }
    }
}

module perfil() {
    tubo(12);
    rotate([0, 90, 0]) inserto_para_girar();
    rotate([30]) rotate([0, -90, 0]) inserto_para_girar();
    translate([-d_esfera, 0]) rotate(-90) { 
        rotate(180) angulo2(90);
        translate([-18 - d_esfera, 0]) {
            tubo(18);
            translate([-d_esfera, 0]) rotate(-10) { 
                rotate([0, 90, 0]) inserto_para_girar();
                rotate([0, -90, 0]) inserto_para_girar();
                rotate(180) angulo2(170);
                translate([-23 - d_esfera, 0]) {
                    tubo(23);
                    translate([-d_esfera, 0]) rotate(-20) { 
                        rotate([0, 90, 0]) inserto_para_girar();
                        rotate([0, -90, 0]) inserto_para_girar();
                        rotate(180) angulo2(160);
                        translate([-56.5 - d_esfera, 0]) {
                            tubo(56.5);
                            translate([-d_esfera, 0]) rotate(-30) {
                                rotate([0, 90, 0]) inserto_para_girar();
                                rotate([0, -90, 0]) inserto_para_girar();
                                rotate(180) angulo2(150);
                                translate([-34 - d_esfera, 0]) union() {
                                    tubo(34);
                                    translate([-d_esfera, 0]) rotate(-30) {
                                        rotate([0, 90, 0]) inserto_para_girar();
                                        rotate([0, -90, 0]) inserto_para_girar();
                                        rotate(180) angulo2(150);
                                        translate([-23 - d_esfera, 0]) union() {
                                            tubo(23);
                                            rotate([180]) translate([-d_esfera, 0]) {
                                                rotate([0, 270, 0]) inserto_para_girar();
                                                rotate([0, 90, 0]) inserto_para_girar();
                                                angulo2(150);
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

module tubo(longitud, soporte = false) {
    translate([longitud / 2, 0]) 
        intersection() {
            rotate([45, 0, 0]) cube([longitud, lado_inserto, lado_inserto], true);
            rotate([0, 90]) cylinder(longitud * 2, d=diagonal_inserto - 2 * trim, center=true);
        }
        
    translate([longitud / 2, 0, -diagonal_inserto +0.7]) cube([longitud - diagonal_inserto + 2, 0.4, largo_inserto + 3], true);
}

module rama() {
    translate([-largo_inserto2, 0]) inserto("I");
    translate([centro_al_lado_a_cubo, 0]) gancho();
}

module angulo3(angulo1, angulo2) {
    inserto_para_girar();
    
    sphere(d=diagonal_inserto);
    
    rotate(angulo1) inserto_para_girar();
    rotate([360 - angulo2, (180-angulo1)/2 , 0]) rotate([0, 0, a1/2]) inserto_para_girar();
}

module angulo2(angulo) {
    rotate(180 - angulo) {
        inserto_para_girar();
        sphere(d=diagonal_inserto);
        rotate(angulo) inserto_para_girar();
    }
}

module inserto(pico = "") {
    factor_pico  = 3;
    recorte_pico = 4;
    
    intersection() {
        union() {
            rotate([45, 0, 0]) cube([largo_inserto, lado_inserto, lado_inserto], true);
            
            if (pico == "I") {
                translate([-diagonal_inserto * factor_pico / 4 - largo_inserto2, 0]) 
                    intersection() {
                        rotate([0, 90]) 
                            cylinder(diagonal_inserto2 * factor_pico, r1=0, r2=diagonal_inserto2, $fn=4, center = true);
                        translate([recorte_pico, 0]) 
                            cube([diagonal_inserto2 * factor_pico, diagonal_inserto, diagonal_inserto], true);
                    }
            } else if (pico == "D") {
                translate([diagonal_inserto4 * factor_pico + largo_inserto2, 0]) 
                    intersection() {
                        rotate([0, 270]) 
                            cylinder(diagonal_inserto2 * factor_pico, r1=0, r2=diagonal_inserto2, $fn=4, center = true);
                        translate([-recorte_pico, 0]) 
                            cube([diagonal_inserto2 * factor_pico, diagonal_inserto, diagonal_inserto], true);
                    }
            }
        }
        rotate([0, 90]) cylinder(largo_inserto * 2, d=diagonal_inserto - 2 * trim, center=true);
    }
}

module inserto_para_girar() {
    translate([-largo_inserto2 - diagonal_inserto2 + inserccion_en_esfera, 0, 0]) inserto("I");
}

module gancho() {
    difference() {
        translate([0, margen_circulo4 + come_circulo2]) cube([ancho, ancho - margen_circulo2 - come_circulo, alto], true);
        cylinder(1 + alto, d=diametro, center=true);
    }
}

module cara_atras_cubo() {
    square([alto, largo_cubo], true);
}

module conector() {
    pe = longitud_segmento + centro_al_alto_cubo * 2; // punto exterior
    pi = pe - alto; // punto interior
    peh = sqrt(pow(centro_al_lado_a_cubo, 2) + pow(pe, 2));
    pealpha = acos(pe / peh);
    pih = sqrt(pow(centro_al_lado_a_cubo, 2) + pow(pi, 2));
    pialpha = acos(pi / pih);
    
    semiangulo = 90 - a1/2;
    
    rotate([0, -semiangulo]) translate([-longitud_segmento - centro_al_alto_cubo, 0]) rotate([270, 0, 90]) gancho();
    rotate([0, semiangulo]) translate([longitud_segmento + centro_al_alto_cubo, 0]) rotate([270, 0, 90]) gancho();
    
    CubePoints = [
      [ cos(semiangulo + pealpha) * -peh,  -centro_al_lado_a_cubo, sin(semiangulo + pealpha) * -peh ],  //0
      [ cos(semiangulo + pealpha) * peh,  -centro_al_lado_a_cubo,  sin(semiangulo + pealpha) * -peh ],  //1
      [ cos(semiangulo + pealpha) * peh,  centro_al_lado_a_cubo,   sin(semiangulo + pealpha) * -peh ],  //2
      [ cos(semiangulo + pealpha) * -peh,  centro_al_lado_a_cubo,  sin(semiangulo + pealpha) * -peh ],  //3
      [ cos(semiangulo + pialpha) * -pih,  -centro_al_lado_a_cubo, sin(semiangulo + pialpha) * -pih ],  //4
      [ cos(semiangulo + pialpha) * pih,  -centro_al_lado_a_cubo,  sin(semiangulo + pialpha) * -pih ],  //5
      [ cos(semiangulo + pialpha) * pih,  centro_al_lado_a_cubo,   sin(semiangulo + pialpha) * -pih ],  //6
      [ cos(semiangulo + pialpha) * -pih,  centro_al_lado_a_cubo,  sin(semiangulo + pialpha) * -pih ]]; //7
  
    altura_union = sin(semiangulo + pealpha) * peh - sin(semiangulo + pialpha) * pih;
  
    if (altura_union < 2) {
        translate([0, 0, sin(semiangulo + pealpha) * -peh - (2 - altura_union)/2]) cube([cos(semiangulo + pealpha) * peh * 2, ancho, 2 - altura_union], true);
    }
    
    CubeFaces = [
      [0,1,2,3],  // bottom
      [4,5,1,0],  // front
      [7,6,5,4],  // top
      [5,6,2,1],  // right
      [6,7,3,2],  // back
      [7,4,0,3]]; // left
      
    polyhedron( CubePoints, CubeFaces );

}

module platea() {
    raise(-diagonal_inserto2 + trim/2) cube([300, 300, trim], true);
}