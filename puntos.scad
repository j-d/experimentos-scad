$fn = 20;

diametro_vertice = 1;
diametro_arista  = 1;
grosor_lado      = 1;
tamano_texto     = 3;
separacion_texto = 0.25;
offcentro        = 0.2; // La cantidad que se aniade a cada lado para que solape con los de al lado

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
p12 = v_sum(p2, [0, 24.5, 0]);
p13 = v_sum(p9, [0, 8, 0]);
p14 = v_sum(p1, [0, 24.5, 0]);

// 
p15 = rotar_punto(v_sum(p7, [18, 0, 0]), p7, 45);

// Barbilla
p16 = rotar_punto(v_sum(p4, [6, 0, 0]), p4, 30);
p17 = v_sum(p4,  [0, -33, 0]);
p18 = v_sum(p16, [0, -28, 0]);
p19 = rotar_punto(v_sum(p3, [-6, 0, 0]), p3, 180 - 30);
p20 = v_sum(p3,  [0, -33, 0]);
p21 = v_sum(p19, [0, -28, 0]);
p22 = v_sum(p20, [0, 2, 0]);
p23 = v_sum(p17, [0, 2, 0]);
p24 = v_sum(p20, [0, 0, 30]);
p25 = v_sum(p17, [0, 0, 30]);

p26 = v_sum(p12, [ 1.5, 6.5, 11]);
p27 = v_sum(p14, [-1.5, 6.5, 11]);
p28 = v_sum(p12, [  -7, 2.5,  0]);
p29 = v_sum(p14, [   7, 2.5,  0]);

p = [[], p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24, p25, p26, p27, p28, p29];

 // Cuadrado inicial
lado([1, 2, 4, 3]);

// Soporte boca
lado([1, 2, 6, 5]);

// Laterales cuadrado inicial
lado([2, 7,  8, 4]); 
lado([1, 9, 10, 3]); 
lado([7, 8, 15]);

// Bigote
lado([9, 13, 14, 1]);
lado([14, 12, 2, 1]);
lado([2, 12, 11, 7]);

// Debajo nariz
lado([14, 29, 28, 12]);
lado([12, 26, 28]);
lado([14, 29, 27]);
lado([12, 26, 11]);
lado([27, 14, 13]);

// Barbilla
lado([4, 16, 18, 17]);
lado([3, 20, 21, 19]);
lado([20, 22, 23, 17]);
lado([20, 24, 25, 17]);

function vector(p1, p2) = [p2[0] - p1[0], p2[1] - p1[1], p2[2] - p1[2]];

function rotar_punto(p, respecto_a, grados) = 
    let(q = vector(p, respecto_a), m = modulo(q)) 
    v_sum(respecto_a, [m * cos(grados), 0, m * sin(grados)]);

function modulo(p) = sqrt(p[0] * p[0] + p[1] * p[1]+ p[2] * p[2]);

for (i = [1:len(p) - 1]) {
    vertice(i);
}

function producto_escalar(u, v) = [u[1] * v[2] - u[2] * v[1], u[0] * v[2] - u[2] * v[0], u[0] * v[1] - u[1] * v[0]];

module lado(numeros) {
    lado_n([ for(i=[0:len(numeros) - 1]) p[numeros[i]] ]);
}

module lado_n(vertices) {
    n_vertices = len(vertices);
    punto_medio = punto_medio(vertices);
    
    //translate(punto_medio) sphere(d = diametro_vertice + 2);
    
    off_vertices = [    
        for (i=[0:n_vertices - 1])
            let (vector = vector(punto_medio, vertices[i]))
                v_sum(vertices[i], vector * offcentro / modulo(vector))
    ];
        
    u = vector(off_vertices[1], off_vertices[0]);
    v = vector(off_vertices[2], off_vertices[0]);
        
    producto_escalar = producto_escalar(u, v);
        
    incremento = grosor_lado * producto_escalar / (2 * modulo(producto_escalar));
    
    vertices_pol = [
        for (i = [0:2 * n_vertices - 1])
            i < n_vertices
                ? off_vertices[i]              - incremento
                : off_vertices[i - n_vertices] + incremento
    ];
        
    caras_pol = [
        for (i = [0:n_vertices - 1])
            [i, (i+1) % n_vertices, n_vertices + (i+1) % n_vertices, n_vertices + i]
    ];
        
    caras_pol2 = [
        [for (i=[0:n_vertices - 1]) i],
        [for (i=[n_vertices:n_vertices + n_vertices - 1]) i]
    ];
    
    polyhedron(
        vertices_pol, 
        concat(caras_pol, caras_pol2)
    );
}

function punto_medio(vertices, i, n_vertices) = n_vertices == undef ? (len(vertices) == 0 ? undef : punto_medio(vertices, 0, len(vertices))) : (i == n_vertices ? [0, 0, 0] : v_sum(vertices[i] / n_vertices, punto_medio(vertices, i + 1, n_vertices)));

function suma_lista(lista, l = -1) = l == -1 ? (len(lista) == 1 ? lista[0] : lista[len(lista) - 1] + suma_lista(lista, len(lista) - 2)) : (l == 0 ? lista[0] : lista[l] + suma_lista(lista, l - 1));

function v_sum(p, q) = [p[0] + q[0], p[1] + q[1], p[2] + q[2]];
function punto_medio_3(p1, p2, p3) = [(p1[0] + p2[0] + p3[0])/3, (p1[1] + p2[1] + p3[1])/3, (p1[2] + p2[2] + p3[2])/3];

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
        rotate([5])
            linear_extrude(3)
                text(str(c), tamano_texto);
}