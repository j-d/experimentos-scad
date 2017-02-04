use <funciones.scad>

$fn = 50;

diametro = 4.8 + 0.3; 
diametroz = diametro + 0.2;
cubo     = 18;
trim     = 0.85;

///

cubo2 = cubo / 2;
cubo1 = cubo + 1;

///

difference() {
    sphere(d=cubo, true);
    
    cil();
    rotate([0, 90, 0]) cil();
    rotate([90, 0, 0]) cil();
    
    // Trim
    translate([0, 0, -cubo + trim]) cube(cubo, true);
}

module cil() {
    h = (cubo1 - diametro) / 2 - 1;
    
    translate([0, 0, h / 2 + diametro/2 + 0.5]) cylinder(h, d = diametro, center = true);
    translate([0, 0, -h / 2 - diametro/2 - 0.5]) cylinder(h, d = diametro, center = true);
}
 