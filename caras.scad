$fn = 20;

lado       = 15;
alto       = 1.5;
/// 

lado2       = lado / 2;
alto2       = alto / 2;
alto4       = alto / 4;

for (i = [0:2])
    for (j = [0:2])
        translate([i * (lado/2 + 20), j * (lado/2 + 15)]) 
            angulo(i * 10 + j * 30 + 90 );

module angulo(grados) {
    rotate([90, 0, -15]) {
        translate([-lado2, 0]) cube([lado, lado, alto], true);
        rotate([90]) cylinder(lado, d=alto, center=true);
        rotate([0, grados]) translate([-lado2, 0]) cube([lado, lado, alto], true);
    }
}
