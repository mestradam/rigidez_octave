
% -------------------------------------------------------------------
% Ejemplo 15-2 (Hibbeler - Análisis estructural)
% -------------------------------------------------------------------


% -------------------------------------------------------------------
% Definir el modelo estructural (pre-proceso)

% Agregar nodos al modelo (coordenadas)
nod.xyz = {
    [ 0  20 ] * 12;
    [ 20 20 ] * 12;
    [ 20 0 ] * 12;
};

% Agregar restricciones en los nodos
%   dof: grado de libertad restringido
%       1: desplazamiento x
%       2: desplazamiento y
%       3: desplazamiento z
%       4: rotación x
%       5: rotación y
%       6: rotación z
%       0: fixed (no value)
nod.restr = {
    [ 1 2 0 ];
    [ 3 0 ];
};

% Agregar materiales al modelo
ele.mat = {
    [ 29e3 ];
};

% Agregar secciones transversales de elementos
ele.sec = {
    % A     I
    [ 10 , 500 ];
};

% Agregar tipos de elemento
ele.typ = {
    'frame2d';
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
    [ 2 1 5 ];
};
