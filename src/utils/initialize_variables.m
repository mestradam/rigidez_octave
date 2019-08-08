function [nod, ele, gen] = initialize_variables()
    % Function to initialize all needed variables as void cells.
    % The user should know that all variables are stored in three structures
    % named as follows:
    %   - nod: properties, parameters, and vaiables on nodes
    %   - ele: properties, parameters, and variables on structural elements
    %   - gen: general model properties, and variables
    %

    nod.xyz = {};   % node coordinates
    nod.restr = {}; % node restrictrions (prescribed displacements)
    nod.nload = {}; % node loads (forces and moments)

    ele.mat = {};   % element materials
    ele.sec = {};   % element sections
    ele.typ = {};   % element types
    ele.cat = {};   % element categories
    ele.conec = {}; % element conectivities
    ele.pload = {}; % element concentrated loads (forces and moments)
    ele.wload = {}; % element uniform distributed loads

    gen.ndof = 0;   % number of degrees of freedom (dof)
    gen.ndofn = 0;  % number of dof per node
    gen.ndofp = 0;  % number of dof with prescribed displacemens

end
