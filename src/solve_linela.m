% General script to solve the LINear ELAstic static problem
%
% Input:
%   - nod: structure with nodal data
%   - ele: estructure with elemental data
%   - gen: structure with general data of the problem
%
% Output:
%   - dnb: displacements at free dofs
%   - fna: reactions at restricted dofs (with prescribed displacements)
%

tic;

% -------------------------------------------------------------------------
% Set nodal (gen.fnb) and fixed end element (gen.fea , gen.feb) load vectors

[fnb] = get_nload(nod, gen);
%[fea, feb] = get_eload(ele);

% -------------------------------------------------------------------------
% Set prescribed displacement vector (gen.dna)
[dna] = get_ndisp(nod, gen);

% -------------------------------------------------------------------------
% Compute stiffness matrix

k = zeros(gen.ndof, gen.ndof);
% k = sparse(gen.ndof, gen.ndof);

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

% print computation time
tocSolve = toc;
fprintf('%-35s','  Solving linear elastic analysis');
fprintf(' --> %10.4g seconds.\n', tocSolve)
