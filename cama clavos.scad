$fn = 20;

hueco = 2.1;
separacion = 4;
x = 3;
y = 3;
alto = 0.5;
extra = 0.5;

for (i=[0:x-1]) {
    for (j=[0:y-1]) {
        translate([i * separacion ,j * separacion , 0])
            difference() {
                translate([0, 0, alto/2]) cube([separacion + extra, separacion + extra, alto], true);
                cylinder(alto, d=hueco);
            }
    }
}