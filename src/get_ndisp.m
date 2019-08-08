function [dna] = get_ndisp(nod, gen)
    % Function to arrange (assemble) the vector of nodal prescribed
    % displacements
    %
    % Input:
    %   - nod: structure with the nodal information (nod.xyz, nod.restr, etc.)
    %   - gen: structure with general model info (ndof, ndof per node, etc.)
    %
    % Output:
    %   - dna: subvector of nodal prescribed displacemens
    %

    dn = zeros(gen.ndof, 1);

    for i = 1 : size(nod.restr, 1)
        inod = nod.restr{i}(1);
        dof = nod.restr{i}(2);

        if dof == 0 % Fixed node (all dofs at node inode)
            nn = size( nod.dofn{inod}, 2 );
            nod.dofn{inod} = zeros(1, nn);
        else % Fixed dof
            gen.dn( nod.dofn{inod}(dof) ) = nod.restr{i}(3);
        end

    end

    dna = dn( 1 : gen.ndofp );
    % dnb = dn( gen.ndofp+1 : end ); % to be calculated later

end
