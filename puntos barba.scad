$fn = 20;

use <funciones_puntos.scad>

diametro_vertice = 1;//3.5;
diametro_arista  = diametro_vertice;
grosor_lado      = 1;
tamano_texto     = 3;
separacion_texto = 0.25;
offcentro        = 0; // La cantidad que se aniade a cada lado para que solape con los de al lado

// Cuadrado inicial
p1  = [-17,     0,  0];
p2  = [ 17,     0,  0];
p3  = [-17, -22.5,  0];
p4  = [ 17, -22.5,  0];

// Dentro boca
p5  = [-17, 0, 15]; 
p6  = [ 17, 0, 15];

// Laterales cuadrado inicial. 28 mm a 150 grados
p7  = rotar_punto(p2 + [ 28, 0, 0], p2, 30);
p8  = rotar_punto(p4 + [ 28, 0, 0], p4, 30) + [0, 0, 1];
p9  = rotar_punto(p1 + [-28, 0, 0], p1, 180 - 30);
p10 = rotar_punto(p3 + [-28, 0, 0], p3, 180 - 30) + [0, 0, 1];

// Bigote
p11 = p7 + [0, 8, 0];
p12 = p2 + [0, 24.5, 0];
p13 = p9 + [0, 8, 0];
p14 = p1 + [0, 24.5, 0];

// 
p15 = rotar_punto(p7 + [18, 0, 0], p7, 45) + [0, 0, 3];
p30 = rotar_punto(p9 + [18, 0, 0], p9, 180 - 45) + [0, 0, 3];

// Barbilla
p16 = rotar_punto(p4 + [6, 0, 0], p4, 30);
p17 = p4  + [0, -33, 0];
p18 = p16 + [0, -28, 0];
p19 = rotar_punto(p3 + [-6, 0, 0], p3, 180 - 30);
p20 = p3  + [0, -33, 0];
p21 = p19 + [0, -28, 0];
p22 = p20 + [0, 2, 0];
p23 = p17 + [0, 2, 0];
p24 = p20 + [0, 0, 30];
p25 = p17 + [0, 0, 30];

p26 = p12 + [ 1.5, 6.5, 11];
p27 = p14 + [-1.5, 6.5, 11];
p28 = p12 + [  -7, 2.5,  0];
p29 = p14 + [   7, 2.5,  0];

// Debajo barbilla 
p44 = p25 + [20, 13, 0];
p45 = p44 + [0, 2, 20];
p46 = p45 + [10, 10, 24];
p47 = p24 + [-20, 13, 0];
p48 = p47 + [0, 2, 20];
p49 = p48 + [-10, 10, 24];

// Patillas
p31 = [83.93 -20 , 52.93 , 64.38 + 9];
p32 = p31 + [0,   0, 32];
p33 = p32 + [0, -34, 0];
p34 = [-83.93 , 52.93 , 64.38];
p35 = p34 + [0,   0, 30];
p36 = p35 + [0, -34, 0];

// Lateral derecho

p37 = p15 + [3, 35, 9];
p38 = (p15 + p7) / 2 + [0, 35, 0];
p39 = vector(p11, p26) / 3 + p11;
p40 = p15 + [7, 0, 20];
p41 = (p37 + p31) / 2 + [0, 0, 0];
p43 = [63, 9.5, p31[2]];

// Lateral derecho barbilla
p42 = p8 + [0, -13.5, 5];
p50 = p10 + [0, -13.5, 5];
p51 = [50, -27.4, 51];
p52 = vector(p42, p51) + p51 + [3, 13, -82+73.38];

p59 = (p10 + p50) / 2 + [-6, 3, 8]; p53 = (p42 + p8) / 2 + [6, 3, 8]; 

p54 = p53 + [4, 5, 20];
p55 = [58.7513, -18.8, 105.38];
p56 = [54, -23.5, 102.38];
p57 = [49.2487, -28.2, 99.38];
p58 = p25 + 0.66 * vector(p25, p45);

p = [[], p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24, p25, p26, p27, p28, p29, p30, p31, p32, p33, p34, p35, p36, p37, p38, p39, p40, p41, p42, p43, p44, p45, p46, p47, p48, p49, p50, p51, p52, p53, p54, p55, p56, p57 , p58, p59];

difference() {
    union () {
        // Cuadrado inicial
        lado_n([1, 2, 4, 3]);

        // Soporte boca
        lado_n([1, 2, 6, 5]);

        // Laterales cuadrado inicial
        lado_n([2, 7,  4]); 
        lado_n([7,  8, 4]); 
        //lado_n([1, 9, 3]); 
        //lado_n([9, 10, 3]); 
        //lado_n([7, 8, 15]);
        //lado_n([10, 9, 30]);

        // Bigote
        lado_n([14, 12, 2, 1]);
        /*lado_n([9, 13, 14, 1]);*/ lado_n([2, 12, 11, 7]);
        
        // Debajo nariz
        lado_n([14, 29, 28, 12]);
        lado_n([12, 26, 28]);
        //lado_n([14, 29, 27]);
        lado_n([12, 26, 11]);
        //lado_n([27, 14, 13]);

        // Barbilla
        lado_n([4, 16, 18, 17]);
        //lado_n([3, 20, 21, 19]);
        lado_n([20, 22, 23, 17]);
        lado_n([20, 24, 25, 17]); // Limite inferior
        //lado_n([10, 19, 21]);
        lado_n([18, 8, 16]);
        
        // Debajo barbilla 
        /*lado_n([24, 47, 20]);*/     lado_n([17, 25, 44]);
        /*lado_n([10, 59, 21]);*/     lado_n([42, 18, 53]);
        /*lado_n([50, 47, 21]);*/     lado_n([42, 18, 44]);
        /*lado_n([24, 48, 47]);*/     lado_n([45, 25, 44]);
        /*lado_n([20, 47, 21]);*/     lado_n([17, 44, 18]);
        /*lado_n([47, 49, 48]);*/ lado_n([46, 45, 44]);
        /* falta */               lado_n([44, 46, 51]);
        /* falta */               lado_n([44, 42, 51]);
        /* falta */               lado_n([56, 51, 52]);
        /*lado_n([50, 59, 21]);*/     lado_n([18, 53, 8]);
        /* falta */               lado_n([53, 54, 51]);
        /* falta */               lado_n([53, 42, 51]);
        ///* falta */               lado_n([53, 54, 40]);
        ///* falta */               lado_n([53,  8, 40]);
        /* falta */               lado_n([52, 51, 54]);
        ///* falta */               lado_n([43, 40, 54]);
        ///* falta */               lado_n([52, 43, 54]);
        /* falta */               lado_n([52, 43, 33]);
        /* falta */               lado_n([52, 55, 33]);
        /* falta */               lado_n([52, 55, 56]);
        /* falta */               lado_n([51, 56, 46]);
        /* falta */               lado_n([57, 56, 46]);
        /* falta */               lado_n([58, 57, 46]);
        /* falta */               lado_n([58, 45, 46]);
        lado_n([54, 8, 53]);
        
        lado_n([45, 44, 46]);
        
        // Lateral derecho
        //lado_n([7, 11, 38, 15]);
        //lado_n([37, 15, 38]);
        //lado_n([39, 11, 38]);
        //lado_n([15, 40, 8]);
        //lado_n([37, 15, 40]);
        
        // Lateral derecho barbilla
        lado_n([32, 31, 33]);
        lado_n([31, 33, 43]);
        //lado_n([31, 43, 41]);
        //lado_n([40, 43, 41]);
        //lado_n([37, 40, 41]);
    }
    translate([0, 0, -5.51]) cube([300, 300, 10], true);
    //translate([-150 + 15, 0]) cube(300, true);
    translate([0, -55, 15]) cube([26, 10, 22], true);
    translate([0, -12, 0]) cube([30, 16, 10], true);   
    translate([0, 13, 0]) cube([30, 18, 10], true);
    //rotate([15]) translate([-150 + 90, 70, -110]) cube(300, true);
    //rotate([20]) translate([-150 + 90, 70, -130]) cube(300, true);
}




for (i = [1:len(p) - 1]) {
    %texto_en_coordenada(i);
}

module lado_n(numeros) {
    n_vertices = len(numeros);
    
    lado([ for(i = [0:n_vertices - 1]) p[numeros[i]] ], offcentro, grosor_lado);
        
    for(i = [0:n_vertices - 1]) {
        arista(p[numeros[i]], p[numeros[(i + 1) % n_vertices]], diametro_arista);
        vertice(p[numeros[i]], diametro_vertice);
    }
}

module texto_en_coordenada(c) {
    translate([p[c][0] + separacion_texto, p[c][1] + separacion_texto, p[c][2]])
        rotate([5, 0])
            linear_extrude(4)
                text(str(c), tamano_texto);
}