
% -------------------------------------------------------------------
% Ejercicio 2 P2 (2019-2S)
% -------------------------------------------------------------------

% Limpiar pantalla, línea de comandos, variables, etc.
clear; clc;

% Cargar librería
addpath ("../src")

% -------------------------------------------------------------------
% Definir el modelo estructural (pre-proceso)

% Agregar nodos al modelo (coordenadas)
nod.xyz = {
    [ 0 ];
    [ 3 ];
    [ 6 ];
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
    [ 1 0 0 ];
    [ 2 2 0 ];
    [ 3 2 0 ];
};

% Agregar materiales al modelo
ele.mat = {
    [ 20e6 ];
};

% Agregar secciones transversales de elementos
ele.sec = {
    [ 0.3*0.3 0.3^4/12 ] * 2;
};

% Agregar los tipos de elemento que se utilizaran
%   type: [string] tipo de estructura
%       'truss2d'
%       'truss3d'
%       'beam'
%       'frame2d'
%       'frame3d'
ele.typ = {
    'beam';
};

% Agregar categorías de elementos
ele.cat = {
    [ 1 1 1 ];
};

% Agregar elementos estructurales
ele.conec = {
    [ 1 2 1 ];
    [ 2 3 1 ];
};

% Agregar acciones en los nodos
nod.nload = {
    [ 2 1 -100 ];
    [ 3 1 -150 ];
};

% Solve
solve;
show_results;