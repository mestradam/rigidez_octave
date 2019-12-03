%--------------------------------------------------------------------------------
% Script to initialize some variables for the analysis
%
% Data:
%
%   - ele: estructure with data on elements
%   - gen: structure with general problem data
%   - nod: structure with data on nodes
%--------------------------------------------------------------------------------

% ---------------------------------------------------------------
% Initialize all needed variables as void cells if not present at input file

if isfield(nod, "xyz") ~= 1   nod.xyz = {};  end % node coordinates
if isfield(nod, "restr") ~= 1 nod.restr = {};end % node restrictrions (prescribed displacements)
if isfield(nod, "nload") ~= 1 nod.nload = {};end % node loads (forces and moments)

if isfield(ele, "mat") ~= 1   ele.mat = {};  end % element materials
if isfield(ele, "sec") ~= 1   ele.sec = {};  end % element sections
if isfield(ele, "typ") ~= 1   ele.typ = {};  end % element types
if isfield(ele, "cat") ~= 1   ele.cat = {};  end % element categories
if isfield(ele, "conec") ~= 1 ele.conec = {};end % element conectivities
if isfield(ele, "pload") ~= 1 ele.pload = {};end % element concentrated loads (forces and moments)
if isfield(ele, "wload") ~= 1 ele.wload = {};end % element uniform distributed loads

gen.ndof = 0;   % number of degrees of freedom (dof)
gen.ndofn = 0; % number of dof per node
gen.ndofp = 0;  % number of dof with prescribed displacemens

% ---------------------------------------------------------------
% Check data from user input file

if size(nod.xyz, 1) < 2
    error('The geometry must have at least 2 nodes!');
end

if size(nod.restr, 1) < 1
    error('The geometry must have at least 1 nodes with prescribed displacements!');
end

if size(ele.conec, 1) < 1
    error('The geometry must have at least 1 element!');
end

if size(nod.nload, 1) == 0 && size(ele.pload, 1) == 0 && size(ele.wload, 1) == 0
    warning('The model does not have any loads!');
end


% ---------------------------------------------------------------
% Compute general dof numbers

% number of dof per node
for i = 1 : size(ele.typ, 1)
    
    if tolower(ele.typ{i}(1:4)) == 'beam' && gen.ndofn < 2
        gen.ndofn = 2;
    elseif tolower(ele.typ{i}(1:7)) == 'truss2d' && gen.ndofn < 2
        gen.ndofn = 2;
    elseif tolower(ele.typ{i}(1:7)) == 'truss3d' && gen.ndofn < 3
        gen.ndofn = 3;
    elseif tolower(ele.typ{i}(1:7)) == 'frame2d' && gen.ndofn < 3
        gen.ndofn = 3;
    elseif tolower(ele.typ{i}(1:7)) == 'frame3d' && gen.ndofn < 6
        gen.ndofn = 6;
    else
        error('Element types must be defined!')
    end
end

% number of nodes and dimension of the problem
[gen.nnod] = size(nod.xyz, 1);
[gen.dims] = size(nod.xyz{1}, 2);

% number of dof (total)
gen.ndof = gen.ndofn * gen.nnod;


% ---------------------------------------------------------------
% Set dof per node and dof per element (incidences)
% (prescribed dofs first, free dofs last)

[nod, ele, gen] = get_dof(nod, ele, gen);
