use <funciones.scad>

$fn = 50;
diametro_corona = 6;
ancho = 22;
alto = 25; // 25 - 12
grosor = 2.5;
angulo = 150;
profundo = 31;
separacion_coronas = 10;
separacion_material = 0.8; // a distribuir por todos lados
separacion = 4; // a distribuir por todos lados

/////

_profundo = (profundo - ancho) / 2;

interior();
//exterior();

module exterior() {
    difference() {
        union () {
            hull() {
                    translate([0, _profundo, 0]) cylinder(grosor, d=ancho + separacion + (diametro_corona - grosor));
                    translate([0, -(_profundo), 0]) cylinder(grosor, d=ancho + separacion + (diametro_corona - grosor));
                }
                
            cylinder(grosor * 2 + 0.5, d = ancho / 2 - separacion_material);
        }
        cylinder (grosor * 2 + 0.5, d = ancho/2 - separacion_material - grosor * 2);
    }

    translate([0, _profundo])  rotate(90)  semicylinder_hueco(alto + grosor, ancho + separacion + (diametro_corona - grosor), grosor);
    translate([0, -_profundo]) rotate(-90) semicylinder_hueco(alto + grosor, ancho + separacion + (diametro_corona - grosor), grosor);

    translate([(ancho + (diametro_corona - grosor) + separacion - grosor) / 2, 0, (alto + grosor)/2]) cube([grosor, profundo - ancho, alto + grosor], true);
    translate([-(ancho + (diametro_corona - grosor) + separacion - grosor) / 2, 0, (alto + grosor)/2]) cube([grosor, profundo - ancho, alto + grosor], true);

    //cube([ancho + (diametro_corona - grosor) + separacion, profundo + (diametro_corona - grosor) + separacion, 2], true);
}

module interior() {
    translate([0, _profundo, 0])
        vertical();

    translate([0, -_profundo, 0])
        rotate([0, 0, 180])
            vertical();

    difference() {
        hull() {
            translate([0, _profundo, 0]) cylinder(grosor, d=ancho);
            translate([0, -_profundo, 0]) cylinder(grosor, d=ancho);
        }
        cylinder(grosor, d = ancho / 2 + grosor);
        //translate([ancho/2-grosor/2, 0, grosor/2]) talla_cuartocirculo(grosor, profundo-ancho+sin(angulo)*ancho/2-grosor);
        //translate([-(ancho/2-grosor/2), 0, grosor/2]) rotate(180) talla_cuartocirculo(grosor, profundo-ancho+sin(angulo)*ancho/2-grosor);
    }
    
    translate([0, 0, grosor/2]) toro(ancho/2 + grosor * 2, grosor);
}

module vertical() {
    angulo_giro = (180-angulo)/2;
            
    rotate([0, 0, angulo_giro])
        translate([0, 0, alto - diametro_corona/2])
            rotate_extrude(angle=angulo)
                union() {
                    translate([ancho/2 - grosor/2, 0])
                        difference() {
                            circle(d=diametro_corona);
                            translate([-diametro_corona/4, 0]) square([diametro_corona/2, diametro_corona], true);
                        }
                    
                    color("blue") translate([ancho/2 - grosor/2, -alto/2+diametro_corona/4]) rotate([0, 0, 90]) square([alto - diametro_corona/2, grosor], true);
                        
                    color("pink") translate([ancho/2 - grosor/2, diametro_corona/2 - grosor/2]) circle(d = grosor);
                    
                    color("red") translate([ancho/2 - grosor/2, diametro_corona/4 - grosor/4]) square([grosor, diametro_corona/2 - grosor/2], true);
                    
                    color("black")
                    translate([ancho/2 - grosor/2, -separacion_coronas])
                        difference() {
                            circle(d=diametro_corona);
                            translate([-diametro_corona/4, 0]) square([diametro_corona/2, diametro_corona], true);
                        }
                }

    distancia_redondos = ancho/2 - grosor/2;
            
    translate_giro(distancia_redondos, 15)     cylinder(alto - grosor/2, d=grosor);
    translate_giro(distancia_redondos, 180-15) cylinder(alto - grosor/2, d=grosor);

    minkowski() { raise(alto - diametro_corona/2) translate_giro(distancia_redondos, angulo_giro) rotate([90, 0, 0]) semicylinder(0.001, diametro_corona-grosor); sphere(d=grosor); }
    minkowski() { raise(alto - diametro_corona/2) translate_giro(distancia_redondos, 180 - angulo_giro) rotate([90, 0, 0]) semicylinder(0.001, diametro_corona-grosor); sphere(d=grosor); }
    minkowski() { raise(alto - diametro_corona/2 - separacion_coronas) translate_giro(distancia_redondos, angulo_giro) rotate([90, 0, 0]) semicylinder(0.001, diametro_corona-grosor); sphere(d=grosor); }
    minkowski() { raise(alto - diametro_corona/2 - separacion_coronas) translate_giro(distancia_redondos, 180 - angulo_giro) rotate([90, 0, 0]) semicylinder(0.001, diametro_corona-grosor); sphere(d=grosor); }
}


