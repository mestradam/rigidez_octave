function rigidez(inputFile)
    % -------------------------------------------------------------------------
    % General function to solve structural analysis problems with the stiffness
    % matrix method.
    % -------------------------------------------------------------------------

    % clear active variables not defined in the input file
    clear -x inputFile

    % add path to source code and input files
    addpath('src');
    addpath('src/utils');
    addpath('user');

    % start mesage
    fprintf('\n\n------------------------------------------------------------\n');
    fprintf('Structural analysis for: %s\n\n', inputFile);


    % -------------------------------------------------------------------------
    % Initialize and read data

    read_data;


    % -------------------------------------------------------------------------
    % Solve linear elastic problem

    solve_linela;


    % -------------------------------------------------------------------------
    % Show results

    show_results;


end
