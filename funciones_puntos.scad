function vector(p1, p2) = [p2[0] - p1[0], p2[1] - p1[1], p2[2] - p1[2]];

function rotar_punto(p, respecto_a, grados) = 
    let(q = vector(p, respecto_a), m = modulo(q)) 
    v_sum(respecto_a, [m * cos(grados), 0, m * sin(grados)]);

function modulo(p) = sqrt(p[0] * p[0] + p[1] * p[1]+ p[2] * p[2]);


function producto_escalar(u, v) = [u[1] * v[2] - u[2] * v[1], u[0] * v[2] - u[2] * v[0], u[0] * v[1] - u[1] * v[0]];

module lado(vertices, offcentro = 0, grosor_lado = 1) {
    n_vertices = len(vertices);
    punto_medio = punto_medio(vertices);
    
    //translate(punto_medio) sphere(d = 3);
    
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
            [i, n_vertices + i, n_vertices + (i+1) % n_vertices, (i+1) % n_vertices]
    ];
        
    caras_pol2 = [
        [for (i=[0:n_vertices - 1]) i],
        [for (i=[0:n_vertices - 1]) 2 * n_vertices - i - 1]
    ];
    
    polyhedron(
        vertices_pol, 
        concat(caras_pol, caras_pol2)
    );
}

function punto_medio(vertices, i, n_vertices) = 
    n_vertices == undef 
        ? (
            len(vertices) == 0 
                ? undef 
                : punto_medio(vertices, 0, len(vertices))
        ) 
        : (
            i == n_vertices 
                ? [0, 0, 0] 
                : v_sum(vertices[i] / n_vertices, punto_medio(vertices, i + 1, n_vertices))
        );

function suma_lista(lista, l = -1) = 
    l == -1 
        ? (
            len(lista) == 1 
                ? lista[0] 
                : lista[len(lista) - 1] + suma_lista(lista, len(lista) - 2)
        ) 
        : (
            l == 0 
                ? lista[0] 
                : lista[l] + suma_lista(lista, l - 1)
        );

function v_sum(p, q) = [p[0] + q[0], p[1] + q[1], p[2] + q[2]];

module vertice(p, diametro = 1) {
    translate(p) %sphere(d = diametro);
}

module vertices(vertices, diametro = 1) {
    for (i = [0:len(vertices) - 1]) {
        vertice(vertices[i]);
    }
}