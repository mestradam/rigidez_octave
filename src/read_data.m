% General script to initialize and read data from the input file
%
% This script also set all needed variables (degrees of freedom, etc.) to
% arrange, assemble, and organize the other variables of the problem.
%

tic;

[nod, ele, gen] = initialize_variables();

eval(inputFile); % Read user input file

[nod, ele, gen] = set_variables(nod, ele, gen);

tocRead = toc;
fprintf('%-35s','  Reading input file');
fprintf(' --> %10.4g seconds.\n', tocRead)
