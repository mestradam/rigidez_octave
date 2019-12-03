
% -------------------------------------------------------------------
% Ayuda para archivos de entrada
% -------------------------------------------------------------------

% Cargar la librería "rigidez"
addpath ("../src")

% -------------------------------------------------------------------
% Definir el modelo estructural (pre-proceso)

% Agregar nodos al modelo (coordenadas)
nod.xyz = {
    [ <x> ];
    [ <x> ];
    [ <x> <y> ];
    [ <x> <y> ];
    [ <x> <y> <z> ];
    [ <x> <y> <z> ];
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
    [ <inod> <dof> <value> ];
    [ <inod> <dof> <value> ];
    [ <inod> <dof> <value> ];
};

% Agregar materiales al modelo
ele.mat = {
    [ <E> ];
    [ <E> ];
    [ <E> <G> ];
    [ <E> <G> ];
    [ <E> <G> <nu> ];
    [ <E> <G> <nu> ];
    [ <E> <G> <nu> <gamma> ];
    [ <E> <G> <nu> <gamma> ];
};

% Agregar secciones transversales de elementos
ele.sec = {
    [ <A> <I> ];
    [ <A> <I> <alpha> ];
    [ <A> <I2> <I3> <J> <alpha> ];
};

% Agregar los tipos de elemento que se utilizaran
%   type: [string] tipo de estructura
%       'truss2d'
%       'truss3d'
%       'beam'
%       'frame2d'
%       'frame3d'
ele.typ = {
    <type>;
    <type>;
};

% Agregar categorías de elementos
ele.cat = {
    [ <itype> <imat> <isec> ];
    [ <itype> <imat> <isec> ];
    [ <itype> <imat> <isec> ];
};

% Agregar elementos estructurales
ele.conec = {
    [ <nod_i> <nod_j> <cat> ];
    [ <nod_i> <nod_j> <cat> ];
};

% Agregar acciones en los nodos
nod.nload = {
    [ <inod> <dof> <valor> ];
    [ <inod> <dof> <valor> ];
    [ <inod> <dof> <valor> ];
};

% Agregar acciones concentradas en elementos
ele.pload = {
    [ <iele> <dof> <value> <dist> ];
    [ <iele> <dof> <value> <dist> ];
    [ <iele> <dof> <value> <dist> ];
};

% Agregar acciones distribuidas en elementos
ele.wload = {
    [ <iele> <dof> <value_i> ];
    [ <iele> <dof> <value_i> ];
    [ <iele> <dof> <value_i> <value_j> <dist_i> <dist_j> ];
    [ <iele> <dof> <value_i> <value_j> <dist_i> <dist_j> ];
};
