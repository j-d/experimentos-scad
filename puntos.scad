$fn = 20;

diametro_vertice = 0.6;
diametro_arista  = 0.6;
grosor_lado      = 0.6;
tamano_texto     = 2;
separacion_texto = 1;

p = [[],
     [-10,     0,  0], // 1-4 Cuadrado inicial
     [ 10,     0,  0],
     [-10, -24.5,  0],
     [ 10, -24.5,  0],
     [-10,     0, 23], // 5-6 Dentro boca
     [ 10,     0, 23],
[]];


lado4(1, 2, 4, 3);
lado4(1, 2, 6, 5);



module lado4(p1, p2, p3, p4) {
    vertices(p1, p2, p3, p4);
    
    u1 = p[p1][0] - p[p2][0];
    u2 = p[p1][1] - p[p2][1];
    u3 = p[p1][2] - p[p2][2];
    v1 = p[p3][0] - p[p2][0];
    v2 = p[p3][1] - p[p2][1];
    v3 = p[p3][2] - p[p2][2];
    
    n1 = u2 * v3 - u3 * v2;
    n2 = u1 * v3 - u3 * v1;
    n3 = u1 * v2 - u2 * v1;
    
    modulo = sqrt(n1 * n1 + n2 * n2 + n3 * n3);
    
    i1 = grosor_lado * n1 / (modulo * 2);
    i2 = grosor_lado * n2 / (modulo * 2);
    i3 = grosor_lado * n3 / (modulo * 2);
    
    #polyhedron(
        [
            [p[p1][0] - i1, p[p1][1] - i2, p[p1][2] - i3],  // 0
            [p[p2][0] - i1, p[p2][1] - i2, p[p2][2] - i3],  // 1
            [p[p3][0] - i1, p[p3][1] - i2, p[p3][2] - i3],  // 2
            [p[p4][0] - i1, p[p4][1] - i2, p[p4][2] - i3],  // 3
            [p[p1][0] + i1, p[p1][1] + i2, p[p1][2] + i3],  // 4
            [p[p2][0] + i1, p[p2][1] + i2, p[p2][2] + i3],  // 5
            [p[p3][0] + i1, p[p3][1] + i2, p[p3][2] + i3],  // 6
            [p[p4][0] + i1, p[p4][1] + i2, p[p4][2] + i3]   // 7
        ], 
        [
            [0,1,2,3],  // bottom
            [4,5,1,0],  // front
            [7,6,5,4],  // top
            [5,6,2,1],  // right
            [6,7,3,2],  // back
            [7,4,0,3]   // left
        ]
    );
}

function punto_medio_3(p1, p2, p3) = [
    (p1[0] + p2[0] + p3[0])/3,
    (p1[1] + p2[1] + p3[1])/3,
    (p1[2] + p2[2] + p3[2])/3,
];

module vertices(p1, p2 = false, p3 = false, p4 = false) {
    translate(p[p1]) sphere(d = diametro_vertice);
    texto_en_coordenada(p1);
    
    if (p2 != false) {
        translate(p[p2]) sphere(d = diametro_vertice);
        texto_en_coordenada(p2);
    }

    if (p3 != false) {
        translate(p[p3]) sphere(d = diametro_vertice);
        texto_en_coordenada(p3);
    }

    if (p4 != false) {
        translate(p[p4]) sphere(d = diametro_vertice);
        texto_en_coordenada(p4);
    }
}

module texto_en_coordenada(c) {
    translate([p[c][0] + separacion_texto, p[c][1] + separacion_texto, p[c][2]]) text(str(c), tamano_texto);
}