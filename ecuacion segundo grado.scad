$fn = 20;

use <funciones_puntos.scad>

grosor = 2;
trim   = 0.2;
ancho_etiqueta = 8;

difference() {
    union () {
        for (a = [0.01:0.005:0.04]) {
            translate([0, a * 600, 0]) {
                for (i = [-45:5:50]) {
                    arista([i - 5, fx(a, i - 5), 0], [i, fx(a, i), 0], grosor);
                }
                
                q = [50, fx(a, 50), 0];
                s = [50 + ancho_etiqueta, fx(a, 50), 0];
                r = [50 + ancho_etiqueta, fx(a, 50) - ancho_etiqueta, 0];
                t = [fy(a, fx(a, 50) - ancho_etiqueta), fx(a, 50) - ancho_etiqueta, 0]; 
                
                lado([q, s, r, t], 0, grosor);
            }
        }
        
        a = 0.005;
        
        translate([0, a * 600, 0]) {
                for (i = [-45:5:50]) {
                    arista([i - 5, fx(a, i - 5), 0], [i, fx(a, i), 0], grosor);
                }
                
                q = [50, fx(a, 50), 0];
                s = [50 + ancho_etiqueta, fx(a, 50), 0];
                r = [50 + ancho_etiqueta, fx(a, 50) - ancho_etiqueta, 0];
                t = [fy(a, fx(a, 50) - ancho_etiqueta), fx(a, 50) - ancho_etiqueta, 0]; 
                
                lado([q, s, r, t], 0, grosor);
            }
    }
        
    translate([0, 0, -5 - grosor / 2+ trim]) cube([150, 150, 10], true);
}

function fx (a, x) = a * x * x;
function fy (a, y) = sqrt(y/a);

