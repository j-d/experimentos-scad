$fn = 20;

use <funciones_puntos.scad>

diametro_vertice = 1;
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
p8  = rotar_punto(p4 + [ 28, 0, 0], p4, 30);
p9  = rotar_punto(p1 + [-28, 0, 0], p1, 180 - 30);
p10 = rotar_punto(p3 + [-28, 0, 0], p3, 180 - 30);

// Bigote
p11 = p7 + [0, 8, 0];
p12 = p2 + [0, 24.5, 0];
p13 = p9 + [0, 8, 0];
p14 = p1 + [0, 24.5, 0];

// 
p15 = rotar_punto(p7 + [18, 0, 0], p7, 45);

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

p = [[], p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24, p25, p26, p27, p28, p29];

intersection() {
    union () {
        // Cuadrado inicial
        lado_n([1, 2, 4, 3]);

        // Soporte boca
        lado_n([1, 2, 6, 5]);

        // Laterales cuadrado inicial
        lado_n([2, 7,  8, 4]); 
        lado_n([1, 9, 10, 3]); 
        lado_n([7, 8, 15]);

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
        lado_n([20, 24, 25, 17]);
    }
    //translate([0, 0.1 + grosor_lado/2]) cube(40);
}


for (i = [1:len(p) - 1]) {
    vertice(p[i], diametro_vertice);
    texto_en_coordenada(i);
}

module lado_n(numeros) {
    n_vertices = len(numeros);
    
    //lado([ for(i = [0:n_vertices - 1]) p[numeros[i]] ], offcentro, grosor_lado);
        
    for(i = [0:n_vertices - 1]) {
        arista(p[numeros[i]], p[numeros[(i + 1) % n_vertices]], diametro_arista);
    }
}


module texto_en_coordenada(c) {
    %translate([p[c][0] + separacion_texto, p[c][1] + separacion_texto, p[c][2]])
        rotate([5])
            linear_extrude(3)
                text(str(c), tamano_texto);
}