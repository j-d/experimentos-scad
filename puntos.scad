$fn = 20;

use <funciones_puntos.scad>

diametro_vertice = 2;
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
p5  = [-17,     0, 19]; 
p6  = [ 17,     0, 19];

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

// Patillas
p31 = [83.93 , 52.93 , 64.38];
p32 = p31 + [0,   0, 30];
p33 = p32 + [0, -34, 0];
p34 = [-83.93 , 52.93 , 64.38];
p35 = p34 + [0,   0, 30];
p36 = p35 + [0, -34, 0];

// Lateral derecho

p37 = p15 + [0, 35, 9];
p38 = (p15 + p7) / 2 + [0, 35, 0];
p39 = vector(p11, p26) / 3 + p11;
p40 = p15 + [10, 0, 20];
p41 = (p37 + p31) / 2 + [0, 0, -3];

// Lateral derecho barbilla
p42 = p8 + [0, -13.5, 5];


p = [[], p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24, p25, p26, p27, p28, p29, p30, p31, p32, p33, p34, p35, p36, p37, p38, p39, p40, p41, p42];

difference() {
    union () {
        // Cuadrado inicial
        lado_n([1, 2, 4, 3]);

        // Soporte boca
        //lado_n([1, 2, 6, 5]);

        // Laterales cuadrado inicial
        lado_n([2, 7,  4]); 
        lado_n([7,  8, 4]); 
        lado_n([1, 9, 3]); 
        lado_n([9, 10, 3]); 
        lado_n([7, 8, 15]);
        lado_n([10, 9, 30]);

        // Bigote
        lado_n([9, 13, 14, 1]);
        lado_n([14, 12, 2, 1]);
        lado_n([2, 12, 11, 7]);

        // Debajo nariz
        lado_n([14, 29, 28, 12]);
        lado_n([12, 26, 28]);
        lado_n([14, 29, 27]);
        lado_n([12, 26, 11]);
        lado_n([27, 14, 13]);

        // Barbilla
        lado_n([4, 16, 18, 17]);
        lado_n([3, 20, 21, 19]);
        lado_n([20, 22, 23, 17]);
        lado_n([20, 24, 25, 17]); // Limite inferior
        lado_n([10, 19, 21]);
        lado_n([18, 8, 16]);
        
        // Lateral derecho
        lado_n([7, 11, 38, 15]);
        lado_n([37, 15, 38]);
        lado_n([39, 11, 38]);
        lado_n([15, 40, 8]);
        lado_n([37, 15, 40]);
        
        // Lateral derecho barbilla
        lado_n([42, 18, 8]);
    }
    translate([0, 0, -5.51]) cube([300, 300, 10], true);
    //translate([-150 + 15, 0]) cube(300, true);
}



for (i = [1:len(p) - 1]) {
    %texto_en_coordenada(i);
}

module lado_n(numeros) {
    n_vertices = len(numeros);
    
    lado([ for(i = [0:n_vertices - 1]) p[numeros[i]] ], offcentro, grosor_lado);
        
    /*for(i = [0:n_vertices - 1]) {
        arista(p[numeros[i]], p[numeros[(i + 1) % n_vertices]], diametro_arista);
        vertice(p[numeros[i]], diametro_vertice);
    }*/
}

module texto_en_coordenada(c) {
    translate([p[c][0] + separacion_texto, p[c][1] + separacion_texto, p[c][2]])
        rotate([5, 0])
            linear_extrude(4)
                text(str(c), tamano_texto);
}