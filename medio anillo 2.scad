$fn = 50;

radio1 = 23 / 2;
altura = 15;
grosor = 3;
radio2 = 6 / 2;
ancho_total = 32;
separacion_anillos = 7;

///////////////

desplazamiento_horizontal = ancho_total - radio1 * 2;

semianillo(
    radio1, 
    altura, 
    grosor, 
    radio2, 
    [-desplazamiento_horizontal / 2, 0, 0],
    0,
    separacion_anillos
);

semianillo(
    radio1, 
    altura, 
    grosor, 
    radio2, 
    [desplazamiento_horizontal / 2, 0, 0],
    180,
    separacion_anillos
);

difference() {
    translate([0, 0, grosor/2])
        cube([ancho_total - radio1 * 2, radio1 * 2, grosor], center = true);
    
    cylinder(grosor, r = radio1/2);
}

module semianillo(
    radio1, 
    altura,
    grosor,
    radio2,
    translado,
    giro,
    separacion_anillos
    ) {
    translate(translado)
        rotate(giro) {
            difference() {
                union() {
                    // Borde del cilindro
                    difference() {
                        cylinder(altura, r = radio1);
                        translate([0, 0, grosor]) 
                            cylinder(altura - grosor, r = radio1 - grosor);
                    }

                    // Anillo 1
                    translate([0, 0, altura])
                    rotate_extrude(convexity=10)
                    translate([radio1 - grosor/2, 0, 0])
                    circle(radio2);
                    
                    translate([0, 0, altura - separacion_anillos])
                    rotate_extrude(convexity=10)
                    translate([radio1 - grosor/2, 0, 0])
                    circle(radio2);

                }

                // Cubo que se le quita para quedarse con la mitad
                translate([0, - radio1 - radio2, 0])
                cube([radio1 + radio2, 2 * (radio1 + radio2), altura + radio2]);
            }
            
            translate([0, radio1 - grosor/2, altura])
                sphere(r = radio2);
            
            translate([0, -(radio1 - grosor/2), altura])
                sphere(r = radio2);
            
            translate([0, radio1 - grosor/2, 0])
                cylinder(altura, r = grosor/2);

            translate([0, -(radio1 - grosor/2), 0])
                cylinder(altura, r = grosor/2);
        }
            
     
}