function [k] = get_ke(type, mat, sec, xyz)
    % Function to compute element k matrix

    if size(mat, 2) == 1
        mat(2) = mat(1) / (2*(1+0.3)); % nu = 0.3 asumed
    end

    [L, r] = get_length_rot(xyz);

    switch type

        case 'truss2d'
            E   = mat(1);
            A   = sec(1);

            k = k_truss2d(E, A, L, r(1:2 , 1:2));

        case 'truss3d'
            E   = mat(1);
            A   = sec(1);

            k = k_truss3d(E, A, L, r);

        case 'beam'
            E = mat(1);
            G = mat(2);
            A = sec(1);
            I = sec(2);

            k = k_beam(E, G, A, I, L);

        case 'frame2d'
            E   = mat(1);
            G   = mat(2);
            A   = sec(1);
            I   = sec(2);

            k = k_frame2d(E, G, A, I, L, r);

        case 'frame3d'
            E   = mat(1);
            G   = mat(2);
            A   = sec(1);
            I2  = sec(2);
            I3  = sec(3);
            J   = sec(4);

            k = k_frame3d(E, G, A, I2, I3, L, r);

        otherwise
            error('Some element type is no in our database!')
    end

end


% ===================================================================
% Local functions
% ===================================================================

% -------------------------------------------------------------------
% Truss 2d element
function k = k_truss2d(E, A, L, r)

    % Local coordinates k matrix
    k = [ A*E/L ,  0 ,-A*E/L ,  0 ;
          0     ,  0 , 0     ,  0 ;
         -A*E/L ,  0 , A*E/L ,  0 ;
          0     ,  0 , 0     ,  0 ];

    % Transformation matrix
    T = [ r        , zeros(2) ;
          zeros(2) , r        ];

    % Global coordinates k matrix
    k = T'*k*T;
end

% -------------------------------------------------------------------
% Truss 3d element
function k = k_truss3d(E, A, L, r)

    % Local coordinates k matrix
    k = [ A*E/L ,  0 , 0 ,-A*E/L , 0 , 0 ;
          0     ,  0 , 0 , 0     , 0 , 0 ;
          0     ,  0 , 0 , 0     , 0 , 0 ;
         -A*E/L ,  0 , 0 , A*E/L , 0 , 0 ;
          0     ,  0 , 0 , 0     , 0 , 0 ;
          0     ,  0 , 0 , 0     , 0 , 0 ];

    % Transformation matrix
    T = [ r        , zeros(3) ;
          zeros(3) , r        ];

    % Global coordinates k matrix
    k = T'*k*T;
end

% -------------------------------------------------------------------
% Beam element
function k = k_beam(E, G, A, I, L, alpha=0)

    % shear strain contribution
    B = (6*alpha*E*I)/(G*A*L*L);

    c1 = 1 / (1+2*B);
    c2 = (2+B) / (2*(1+2*B));
    c3 = (1-B) / (1+2*B);

    % internal variables
    d1 = 12*E*I*c1/L^3 ;
    d2 = 6*E*I*c1/L^2 ;
    d3 = 4*E*I*c2/L ;
    d4 = 2*E*I*c3/L ;

    % local coordinate matrix
    k = [ d1 , d2 ,-d1 , d2 ;
          d2 , d3 ,-d2 , d4 ;
         -d1 ,-d2 , d1 ,-d2 ;
          d2 , d4 ,-d2 , d3 ];
end

% -------------------------------------------------------------------
% Frame 2d element
function k = k_frame2d(E, G, A, I, L, r, alpha=0)

    % shear strain contribution
    B = (6*alpha*E*I)/(G*A*L*L);

    c1 = 1 / (1+2*B);
    c2 = (2+B) / (2*(1+2*B));
    c3 = (1-B) / (1+2*B);

    % internal variables
    d1 = E*A/L ;
    d2 = 12*E*I*c1/L^3 ;
    d3 = 6*E*I*c1/L^2 ;
    d4 = 4*E*I*c2/L ;
    d5 = 2*E*I*c3/L ;

    % local coordinate matrix
    k = [ d1 , 0  , 0  ,-d1 , 0  , 0  ;
          0  , d2 , d3 , 0  ,-d2 , d3 ;
          0  , d3 , d4 , 0  ,-d3 , d5 ;
         -d1 , 0  , 0  , d1 , 0  , 0  ;
          0  ,-d2 ,-d3 , 0  , d2 ,-d3 ;
          0  , d3 , d5 , 0  ,-d3 , d4 ];

    % transformation matrix
    T = [ r        , zeros(3) ;
          zeros(3) , r        ];

    % global coordinates k matrix
    k = T'*k*T;
end

% -------------------------------------------------------------------
% Frame 3d element
function k = k_frame3d(E, G, A, I2, I3, L, r, alpha=0)

    % shear strain contribution
    B2 = (6*alpha*E*I2) / (G*A*L*L);
    B3 = (6*alpha*E*I3) / (G*A*L*L);

    c12 = 1 / (1+2*B2);
    c22 = (2+B2) / (2*(1+2*B2));
    c32 = (1-B2) / (1+2*B2);

    c13 = 1 / (1+2*B3);
    c23 = (2+B3) / (2*(1+2*B3));
    c33 = (1-B3) / (1+2*B3);

    % variables internas
    d1 = E*A / L ;
    d2 = G*J / L ;

    d32 = 12*E*I2*c12 / L^3 ;
    d42 = 6 *E*I2*c12 / L^2 ;
    d52 = 4 *E*I2*c22 / L   ;
    d62 = 2 *E*I2*c32 / L   ;

    d33 = 12*E*I3*c13 / L^3 ;
    d43 = 6 *E*I3*c13 / L^2 ;
    d53 = 4 *E*I3*c23 / L   ;
    d63 = 2 *E*I3*c33 / L   ;

    % local coordinate matrix
    k = [ d1 , 0   , 0   , 0  , 0   , 0   ,-d1 , 0   , 0   , 0  , 0   , 0   ;
          0  , d33 , 0   , 0  , 0   , d43 , 0  ,-d33 , 0   , 0  , 0   , d43 ;
          0  , 0   , d32 , 0  ,-d42 , 0   , 0  , 0   ,-d32 , 0  ,-d42 , 0   ;
          0  , 0   , 0   , d2 , 0   , 0   , 0  , 0   , 0   ,-d2 , 0   , 0   ;
          0  , 0   ,-d42 , 0  , d52 , 0   , 0  , 0   , d42 , 0  , d62 , 0   ;
          0  , d43 , 0   , 0  , 0   , d53 , 0  ,-d43 , 0   , 0  , 0   , d63 ;
         -d1 , 0   , 0   , 0  , 0   , 0   , d1 , 0   , 0   , 0  , 0   , 0   ;
          0  ,-d33 , 0   , 0  , 0   ,-d43 , 0  , d33 , 0   , 0  , 0   ,-d43 ;
          0  , 0   ,-d32 , 0  , d42 , 0   , 0  , 0   , d32 , 0  , d42 , 0   ;
          0  , 0   , 0   ,-d2 , 0   , 0   , 0  , 0   , 0   , d2 , 0   , 0   ;
          0  , 0   ,-d42 , 0  , d62 , 0   , 0  , 0   , d42 , 0  , d52 , 0   ;
          0  , d43 , 0   , 0  , 0   , d63 , 0  ,-d43 , 0   , 0  , 0   , d53 ];

    % transformation matrix
    T = [ r        , zeros(3) , zeros(3) , zeros(3) ;
          zeros(3) , r        , zeros(3) , zeros(3) ;
          zeros(3) , zeros(3) , r        , zeros(3) ;
          zeros(3) , zeros(3) , zeros(3) , r        ];

    % global coordinates k matrix
    k = T'*k*T;
end
