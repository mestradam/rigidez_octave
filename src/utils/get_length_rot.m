function [L, r] = get_length_rot(xyz)
    % Compute elements length and rotation matrix (dir)

    dims = size(xyz, 2);

    dxyz = xyz(2,:) - xyz(1,:);
    L = sqrt( sum( dxyz.^2 ) );

    if dims == 1
        r = 1;

    elseif dims == 2
        r = [
            dxyz(1)/L , dxyz(2)/L , 0 ;
           -dxyz(2)/L , dxyz(1)/L , 0 ;
            0         , 0         , 1 ;
        ];

    elseif dims == 3
        X = [1 0 0];
        Y = [0 1 0];
        Z = [0 0 1];

        x = dxyz / L;

        if x == Y
            z = cross(x, -X);
        else
            z = cross(x, Y);
        end
        y = cross(z, x);

        r = [X ; Y ; Z]' * [x ; y ; z];

    end

end
