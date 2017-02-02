$fn = 20;

media_capa_cilindrica(10, 5, 1);


module media_capa_cilindrica(alto, diametro, grosor) {
    difference() {
        difference() {
            cylinder(alto, d = diametro);
            cylinder(alto, d = diametro - grosor * 2);
        }
        translate([-diametro/2, -diametro/2, 0]) cube([diametro, diametro/2, alto]);
    }
}