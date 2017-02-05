$fn = 20;

diametro_vertice = 1;
diametro_arista  = 1;
grosor_lado      = 1;
tamano_texto     = 3;
separacion_texto = 0.25;

// Cuadrado inicial
p1  = [-17,     0,  0];
p2  = [ 17,     0,  0];
p3  = [-17, -22.5,  0];
p4  = [ 17, -22.5,  0];

// Dentro boca
p5  = [-17,     0, 19]; 
p6  = [ 17,     0, 19];

// Laterales cuadrado inicial. 28 mm a 150 grados
p7  = rotar_punto(v_sum(p2, [28, 0, 0]), p2, 30);
p8  = rotar_punto(v_sum(p4, [28, 0, 0]), p4, 30);
p9  = rotar_punto(v_sum(p1, [-28, 0, 0]), p1, 180 - 30);
p10 = rotar_punto(v_sum(p3, [-28, 0, 0]), p3, 180 - 30);

// Bigote
p11 = v_sum(p7, [0, 8, 0]);
p12 = v_sum(p2, [0, 26, 0]);
p13 = v_sum(p9, [0, 8, 0]);
p14 = v_sum(p1, [0, 26, 0]);

// 
p15 = rotar_punto(v_sum(p7, [18, 0, 0]), p7, 45);

// Barbilla
p16 = rotar_punto(v_sum(p4, [6, 0, 0]), p4, 30);
p17 = v_sum(p4,  [0, -32, 0]);
p18 = v_sum(p16, [0, -28, 0]);
p19 = rotar_punto(v_sum(p3, [-6, 0, 0]), p3, 180 - 30);
p20 = v_sum(p3,  [0, -32, 0]);
p21 = v_sum(p19, [0, -28, 0]);
p22 = v_sum(p20, [0, 1, 0]);
p23 = v_sum(p17, [0, 1, 0]);
p24 = v_sum(p20, [0, 0, 12]);
p25 = v_sum(p17, [0, 0, 12]);

p = [[], p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24, p25];

 // Cuadrado inicial
lado4(1, 2, 4, 3);

// Soporte boca
lado4(1, 2, 6, 5);

// Laterales cuadrado inicial
lado4(2, 7,  8, 4); 
lado4(1, 9, 10, 3); 
lado3(7, 8, 15);

// Bigote
lado4(9, 13, 14, 1);
lado4(14, 12, 2, 1);
lado4(2, 12, 11, 7);

// Barbilla
lado4(4, 16, 18, 17);
lado4(3, 20, 21, 19);
lado4(20, 22, 23, 17);
lado4(20, 24, 25, 17);

function vector(p1, p2) = [p2[0] - p1[0], p2[1] - p1[1], p2[2] - p1[2]];

function rotar_punto(p, respecto_a, grados) = 
    let(q = vector(p, respecto_a), m = modulo(q)) 
    v_sum(respecto_a, [m * cos(grados), 0, m * sin(grados)]);

function modulo(p) = sqrt(p[0] * p[0] + p[1] * p[1]+ p[2] * p[2]);

for (i = [1:len(p) - 1]) {
    vertice(i);
}

module lado4(p1, p2, p3, p4) {
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
    
    polyhedron(
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

module lado3(p1, p2, p3) {
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
    
    polyhedron(
        [
            [p[p1][0] - i1, p[p1][1] - i2, p[p1][2] - i3],  // 0
            [p[p2][0] - i1, p[p2][1] - i2, p[p2][2] - i3],  // 1
            [p[p3][0] - i1, p[p3][1] - i2, p[p3][2] - i3],  // 2
            [p[p1][0] + i1, p[p1][1] + i2, p[p1][2] + i3],  // 3
            [p[p2][0] + i1, p[p2][1] + i2, p[p2][2] + i3],  // 4
            [p[p3][0] + i1, p[p3][1] + i2, p[p3][2] + i3],  // 5
        ], 
        [
            [0,1,2],
            [3,4,5],
            [0,1,4,3],
            [1,2,5,4],
            [5,3,0,2]            
        ]
    );
}

function v_sum(p, q) = [p[0] + q[0], p[1] + q[1], p[2] + q[2]];

function punto_medio_3(p1, p2, p3) = [
    (p1[0] + p2[0] + p3[0])/3,
    (p1[1] + p2[1] + p3[1])/3,
    (p1[2] + p2[2] + p3[2])/3,
];

module vertice(p1) {
    translate(p[p1]) %sphere(d = diametro_vertice);
    texto_en_coordenada(p1);
}

module vertices(p1, p2 = false, p3 = false, p4 = false) {
    translate(p[p1]) %sphere(d = diametro_vertice);
    texto_en_coordenada(p1);
    
    if (p2 != false) {
        translate(p[p2]) %sphere(d = diametro_vertice);
        texto_en_coordenada(p2);
    }

    if (p3 != false) {
        translate(p[p3]) %sphere(d = diametro_vertice);
        texto_en_coordenada(p3);
    }

    if (p4 != false) {
        translate(p[p4]) %sphere(d = diametro_vertice);
        texto_en_coordenada(p4);
    }
}

module texto_en_coordenada(c) {
    %translate([p[c][0] + separacion_texto, p[c][1] + separacion_texto, p[c][2]])
        linear_extrude(3)
            text(str(c), tamano_texto);
}