function [nod, ele, gen] = get_dof(nod, ele, gen)
    % Set general dof numbers, dof per node and per element (incidences)
    %
    % Input:
    %   - nod: nodes information
    %       - nod.restr: restrictions or nodes with prescribed displacemens
    %   - ele: elements information
    %       - ele.conec: conectivities for all structural elements
    %   - gen: general problem information
    %       - gen.type: type of problem (string)
    %       - gen.nnod: number of nodes
    %       - gen.ndof: total number of dofs
    %       - gen.ndofn: numer of dof per node
    %
    % Output:
    %   - nod.dofn: cell with a list of assigned dof per nodes
    %   - gen.dofa: list of dofs with prescribed displacements
    %   - gen.dofb: list of free dofs
    %   - ele.incid: element incidences
    %


    % Set dof per node (prescribed first)
    % -----------------------------------

    for i = 1 : gen.nnod
        nod.dofn{i} = zeros(1, gen.ndofn);
    end

    idof = 1;
    gen.dofa = [];
    gen.dofb = [];

    % dofs with prescribed displacements
    for i = 1 : size(nod.restr, 1)
        if nod.restr{i}(2) == 0
            nod.dofn{ nod.restr{i}(1) }( 1:gen.ndofn ) = [idof : idof+gen.ndofn-1];
            gen.dofa = [gen.dofa ; [idof : idof+gen.ndofn-1]'];
            idof += gen.ndofn;
        else
            nod.dofn{ nod.restr{i}(1) }( nod.restr{i}(2) ) = idof;
            gen.dofa = [gen.dofa ; idof];
            idof += 1;
        end
    end

    gen.ndofp = idof - 1;

    % free dofs
    for i = 1 : gen.nnod
        for j = 1 : gen.ndofn
            if nod.dofn{i}(j) == 0
                nod.dofn{i}(j) = idof;
                gen.dofb = [gen.dofb ; idof];
                idof += 1;
            end
        end
    end

    % Set dof per element (incidences)
    % --------------------------------

    for i = 1 : size(ele.conec, 1)
        ele.incid{i} = [nod.dofn{ele.conec{i}(1)} nod.dofn{ele.conec{i}(2)}];
    end

end
