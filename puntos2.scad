$fn = 20;

use <funciones_puntos.scad>

diametro_vertice = 2;
diametro_arista  = diametro_vertice;
grosor_lado      = 1;
tamano_texto     = 3;
separacion_texto = 0.25;
offcentro        = 0; // La cantidad que se aniade a cada lado para que solape con los de al lado

// Cuadrado inicial
p1  = [382.4 - 400, 50 - 35.8,  135 - 135  ];
p2  = [401.7 - 400, 50 - 30,    135 - 135  ];
p3  = [382.4 - 400, 50 - 57,    135 - 137  ];
p4  = [382.4 - 400, 50 - 83,    135 - 141.6];
p5  = [382.4 - 400, 50 - 104,   135 - 149.3];
p6  = [395.3 - 400, 50 - 114.9, 135 - 156.3];
p7  = [420.1 - 400, 50 - 126.6, 135 - 164.7];
p8  = [450.1 - 400, 50 - 137.8, 135 - 179.1];
p9  = [500   - 400, 50 - 57.4,  135 - 187.1];
p10 = [500   - 400, 50 - 83.0,  135 - 187.1];
p11 = [500   - 400, 50 - 108.1, 135 - 187.1];
p12 = [500   - 400, 50 - 134.6, 135 - 187.1];
p13 = [488.2 - 400, 50 - 143.9, 135 - 186.9];
p14 = [419.2 - 400, 50 - 42.2,  135 - 145  ];
p15 = [450.3 - 400, 50 - 51.0,  135 - 155.8];
p16 = [478.1 - 400, 50 - 69.7,  135 - 164.9];
p16 = [493.9 - 400, 50 - 62.1,  135 - 172.5];


p = [[], p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20];

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
        rotate([0, 0])
            linear_extrude(4)
                text(str(c), tamano_texto);
}