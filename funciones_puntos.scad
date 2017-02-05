function vector(p1, p2) = [p2[0] - p1[0], p2[1] - p1[1], p2[2] - p1[2]];

function rotar_punto(p, respecto_a, grados) = 
    let(q = vector(p, respecto_a), m = norm(q)) 
        respecto_a + [m * cos(grados), 0, m * sin(grados)];

function producto_escalar(u, v) = [u[1] * v[2] - u[2] * v[1], - u[0] * v[2] + u[2] * v[0], u[0] * v[1] - u[1] * v[0]];

module lado(vertices, offcentro = 0, grosor_lado = 1) {
    n_vertices = len(vertices);
    punto_medio = punto_medio(vertices);
    
    //vertice(punto_medio);
    
    off_vertices = [    
        for (i=[0:n_vertices - 1])
            let (vector = vector(punto_medio, vertices[i]))
                vertices[i] + vector * offcentro / norm(vector)
    ];
        
    //vertices(off_vertices);
        
    u = vector(off_vertices[1], off_vertices[0]);
    v = vector(off_vertices[2], off_vertices[0]);
        
    //dibujar_vector(off_vertices[1], off_vertices[0]);
    //dibujar_vector(off_vertices[2], off_vertices[0]);
        
    producto_escalar = producto_escalar(u, v);
        
    //dibujar_vector(punto_medio, producto_escalar);
        
    incremento = grosor_lado * producto_escalar / (2 * norm(producto_escalar));
    
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
                : (vertices[i] / n_vertices) + punto_medio(vertices, i + 1, n_vertices)
        );

function punto_medio_2(u, v) = (u + v) / 2;

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

module vertice(p, diametro = 1) {
    translate(p) sphere(d = diametro);
}

module vertices(vertices, diametro = 1) {
    for (i = [0:len(vertices) - 1]) {
        vertice(vertices[i]);
    }
}

module arista(a, b, diametro = 1) {
    vector = vector(a, b);
    
    translate(punto_medio_2(a, b))
        rotate(angulos_vector(vector))
            cylinder(norm(vector), d=diametro, center=true);
}

function angulos_vector(v) = 
    v[0] != 0
    ? [
        0,
        v[0] > 0 ? acos(v[2]/norm(v)) : 360 - acos(v[2]/norm(v)),
        atan(v[1] / v[0])
    ]
    : (
        v[1] != 0
        ? [v[2] == 0 ? (/* Punto sobre el eje y */ v[1] < 0 ? 90 : 270 ) : (v[1] > 0 ? -90 : 90) + atan(v[2] / v[1]), 0, 0]
        : (
            v[2] == 0 // Es un punto en el eje z, y como ya estaba en el eje z no hay que hacer nada
                ? undef 
                : [v[2] > 0 ? 0 : 180, 0, 0]
        )
    );

module dibujar_vector(a, b, diametro = 1, diametro_cono = 2.5) {
    ratio          = 0.8;
    vector         = vector(a, b);
    punto_division = a + vector * ratio;
    
    arista(a, punto_division, diametro); 
    //vertices([a, b]);
    
    translate(punto_medio_2(punto_division, b))
        rotate(angulos_vector(vector))
            cylinder(norm(vector) * (1 - ratio), d1=diametro_cono, d2=0, center=true);
}