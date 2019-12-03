
% -------------------------------------------------------------------
% Ejemplo 14-4 (Hibbeler - Análisis estructural)
% Cercha de 6 elementos, (resolver una parte a mano y después en PC)
% -------------------------------------------------------------------

% Limpiar pantalla, línea de comandos, variables, etc.
clear; clc;

% Cargar librería
addpath ("../src")

% -------------------------------------------------------------------
% Definir el modelo estructural (pre-proceso)

% Agregar nodos al modelo (coordenadas)
nod.xyz = {
    [ 0 0 ];
    [ 10 0 ];
    [ 10 10 ];
    [ 0 10 ];
};

% Agregar restricciones en los nodos
%   dof: grado de libertad restringido
%       truss2d --> 1: dx, 2: dy
%       truss3d --> 1: dx, 2: dy, 3: dz
%       beam    --> 1: dy, 2: rz
%       frame2d --> 1: dx, 2: dy, 3: rz
%       frame3d --> 1: dx, 2: dy, 3: dz, 4: rx, 5: ry, 6: rz
%       0: fixed
nod.restr = {
    [ 3 1 0 ];
    [ 3 2 0 ];
    [ 2 1 0 ];
};

% Agregar materiales al modelo
ele.mat = {
    [ 1 ];
};

% Agregar secciones transversales de elementos
ele.sec = {
    [ 1 ];
};

% Agregar los tipos de elemento que se utilizaran
%   type: [string] tipo de estructura
%       'truss2d'
%       'truss3d'
%       'beam'
%       'frame2d'
%       'frame3d'
ele.typ = {
    [ 'truss2d' ];
};

% Agregar categorías de elementos [type, mat, sec]
ele.cat = {
    [ 1 1 1 ];
};

% Agregar elementos estructurales
ele.conec = {
    [ 1 2 1 ];
    [ 1 3 1 ];
    [ 1 4 1 ];
    [ 4 3 1 ];
    [ 4 2 1 ];
    [ 2 3 1 ];
};

% Agregar acciones en los nodos
nod.nload = {
    [ 4 1 2 ];
    [ 4 2 -4 ];
};


% Solucionar el problema lineal elástico
solve;

% Mostrar resultados en consola
show_results;