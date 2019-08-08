function [nod, ele, gen] = set_variables(nod, ele, gen)
    % Function to initialize some variables for the analysis
    %   - nod: properties, parameters, and vaiables on nodes
    %   - ele: properties, parameters, and variables on structural elements
    %   - gen: general model properties, and variables
    %
    %

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
        error('The model does not have any loads!');
    end


    % ---------------------------------------------------------------
    % Compute general dof numbers

    % number of dof per node
    for i = 1 : size(ele.typ, 1)
        if tolower(ele.typ{i}(1:7)) == 'truss2d' && gen.ndofn < 2
            gen.ndofn = 2;
        elseif tolower(ele.typ{i}(1:7)) == 'truss3d' && gen.ndofn < 3
            gen.ndofn = 3;
        elseif tolower(ele.typ{i}(1:4)) == 'beam' && gen.ndofn < 2
            gen.ndofn = 2;
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

end
