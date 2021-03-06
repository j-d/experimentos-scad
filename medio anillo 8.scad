$fn = 50;

radio1 = 22 / 2;
altura = 15;
grosor = 2;
radio2 = 5 / 2;
ancho_total = 32;

///////////////

desplazamiento_horizontal = ancho_total - radio1 * 2;


semianillo(
    radio1, 
    altura, 
    grosor, 
    radio2, 
    0,
    0
);

translate([-radio1/2+4, 0, -4]) cube([3, 3, 12], true);

module semianillo(
    radio1, 
    altura,
    grosor,
    radio2,
    translado,
    giro
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

                    // Anillo
                    translate([0, 0, altura])
                    rotate_extrude(convexity=10)
                    translate([radio1 - grosor/2, 0, 0])
                    circle(radio2);
                }

                // Cubo que se le quita para quedarse con la mitad
                translate([0, - radio1 - radio2, 0])
                cube([radio1 + radio2, 2 * (radio1 + radio2), altura + radio2]);
            }
            
         
        }
            
     
}