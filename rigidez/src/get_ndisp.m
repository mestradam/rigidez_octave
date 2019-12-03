function [dna] = get_ndisp(nod, gen)
    %--------------------------------------------------------------------------------
    % Assemble the vector of nodal prescribed displacements
    %
    %   [dna] = get_ndisp(nod, gen)
    %
    % Input:
    %   - nod: structure with the nodal information (nod.xyz, nod.restr, etc.)
    %   - gen: structure with general model info (ndof, ndof per node, etc.)
    %
    % Output:
    %   - dna: subvector of nodal prescribed displacemens
    %--------------------------------------------------------------------------------

    dn = zeros(gen.ndof, 1);

    for i = 1 : size(nod.restr, 1)
        inod = nod.restr{i}(1);
        dof = nod.restr{i}(2);

        if dof == 0 % Fixed node (all dofs at node inode)
            nn = size( nod.dofn{inod}, 2 );
            dn(nod.dofn{inod}) = zeros(1, nn);
        else % Fixed dof
            dn( nod.dofn{inod}(dof) ) = nod.restr{i}(3);
        end

    end

    dna = dn( 1 : gen.ndofp );

end
