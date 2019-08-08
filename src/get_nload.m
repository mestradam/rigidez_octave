function [fnb] = get_nload(nod, gen)
    % Function to arrange (assemble) the vector of nodal external loads
    %
    % Input:
    %   - nod: structure with the nodal information (nod.xyz, nod.restr, etc.)
    %   - gen: structure with general model info (ndof, ndof per node, etc.)
    %
    % Output:
    %   - fnb: subvector of nodal loads at free dofs
    %

    fn = zeros(gen.ndof, 1);

    for i = 1 : size(nod.nload, 1)
        inod = nod.nload{i}(1);
        dof = nod.nload{i}(2);

        % Loads are accumulated (added) if more thn one defined
        fn( nod.dofn{inod}(dof) ) += nod.nload{i}(3);

    end

    % fna = fn( gen.dofa ); % To be calculated later (reactions)
    fnb = fn( gen.dofb );

end
