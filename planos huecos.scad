$fn = 20;

lado          = 15;
alto          = 3.2;
hueco         = 1;
margen_hueco  = 0.2;
hueco_a_borde = 2;

/// 

lado2       = lado / 2;
alto2       = alto / 2;
alto4       = alto / 4;

///

angulo(120, lado, lado);

//cara(lado, lado);

module angulo(grados, lado1, lado2) {
    lado2_2 = lado2 / 2;
    
    rotate([-90]) {
        translate([-lado2_2, 0]) cara(lado1, lado2);
        rotate([90]) cylinder(lado2, d=alto, center=true);
        rotate([0, grados]) translate([-lado2_2, 0]) cara(lado1, lado1);
    }
}

module cara(lado1, lado2) {
    difference() {
        cube([lado, lado2, alto], true);
        cube([lado - 2 * hueco_a_borde, lado2 + 1, hueco + margen_hueco], true);
        cube([lado + 1, lado2 - 2 * hueco_a_borde, hueco + margen_hueco], true);
    }
}