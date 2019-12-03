%--------------------------------------------------------------------------------
% Script to solve the linear estic static problem with the stiffness method
%
% Data:
%
%   - ele: estructure with elemental data
%       - cat: element categories (typ, mat, sec)
%       - conec: element conectivities
%       - incid: element incidences
%       - mat: element materials properties
%       - pload: element point loads
%       - sec: element cross section properties
%       - typ: element types
%       - wload: element distributed loads
%
%   - gen: structure with general data of the problem
%       - ndof: number of dof (total)
%       - ndofn: numbr of dof per node
%       - ndofp: number of dof with prescribed displacement (restrained)
%       - nnod: number of nodes
%       - dims: dimensions of the problem
%       - dofa: list of dof with prescribed displacements
%       - dofb: list of dof with free movement
%
%   - nod: structure with properties, parameters, and vaiables on nodes
%       - xyz: node coordinates
%       - restr: node prescribed displacements
%       - nload: node point loads and moments
%       - dofn: list of dof per node
%--------------------------------------------------------------------------------


% -------------------------------------------------------------------------
% Initialize and set some variables of the model

set_variables;

% -------------------------------------------------------------------------
% Get nodal (gen.fnb) and fixed end element (gen.fea , gen.feb) load vectors

[fnb] = get_nload(nod, gen);
%[fea, feb] = get_eload(ele, gen); <------ IMPLEMENTAR ESTA FUNCIÓN !!!!!

% -------------------------------------------------------------------------
% Get prescribed displacement vector (gen.dna)

[dna] = get_ndisp(nod, gen);

% -------------------------------------------------------------------------
% Compute stiffness matrix

k = zeros(gen.ndof, gen.ndof);
%k = sparse(gen.ndof, gen.ndof);

for i = 1 : size(ele.conec, 1)
    ni = ele.conec{i}(1);
    nj = ele.conec{i}(2);
    xyze = [nod.xyz{ni} ; nod.xyz{nj}];
    icat = ele.conec{i}(3);
    itype = ele.cat{icat}(1);
    imat = ele.cat{icat}(2);
    isec = ele.cat{icat}(3);

    % Compute element stiffness matrix
    ke = get_ke(ele.typ{itype}, ele.mat{imat}, ele.sec{isec}, xyze);

    % Assemble into structure stiffness matrix
    k( ele.incid{i} , ele.incid{i} ) += ke;

end

% -------------------------------------------------------------------------
% Solve the equation system

% separate submatrices
kaa = k( gen.dofa , gen.dofa );
kab = k( gen.dofa , gen.dofb );
kba = k( gen.dofb , gen.dofa );
kbb = k( gen.dofb , gen.dofb );

% solution
dnb = kbb \ (fnb - kba * dna);
fna = kaa * dna + kab * dnb;

% set complete nload and displacement vectors
fn(gen.dofa) = fna;
fn(gen.dofb) = fnb;

dn(gen.dofa) = dna;
dn(gen.dofb) = dnb;
