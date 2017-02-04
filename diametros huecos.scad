use <funciones.scad>

$fn = 50;

alto       = 10;
separacion = 6;

///


difference() {
    translate([-3 * separacion/4, -separacion/4]) cube([separacion * 5 + separacion/2, separacion * 10 + separacion/2, alto]);

    for (i = [0:1:4]) {
        for (j = [1:1:10]) {
            translate([i * separacion, -separacion/2 + j * separacion, -1]) cylinder(alto + 2, d = i + j/10);
        }
    }
}
 