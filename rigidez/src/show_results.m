%--------------------------------------------------------------------------------
% Script to show in the command window the results of load reactions and node 
% displacements in table form for better reading.
%
% Example:
%
%   Node coordinates:
%      1 |            3           4
%      2 |            0           0
%      3 |            3           0
%   
%   Element conectivities:
%      1 |            2           3
%      2 |            2           1
%   
%   Node loads:
%      1 |          1.5           2
%      2 |            0          -2
%      3 |         -1.5           0
%   
%   Node displacements:
%      1 |            0           0
%      2 |          4.5         -19
%      3 |            0           0
%--------------------------------------------------------------------------------

fprintf('\n') 
fprintf('------------------------------------------------------------\n')
fprintf('Stiffness method general results\n')


fprintf('\n')
fprintf('Node coordinates:\n')

for i = 1 : size(nod.xyz, 1)
    fprintf('%4d | ', i);
    fprintf('%12.4g', nod.xyz{i}); fprintf('\n');
end

% Print element conectivities (from, to)
fprintf('\n')
fprintf('Element conectivities:\n')

for i = 1 : size(ele.conec, 1)
    fprintf('%4d | ', i);
    fprintf('%12d', ele.conec{i}(1:2)); fprintf('\n');
end

% Print node loads
fprintf('\n')
fprintf('Node loads:\n')

for i = 1 : size(nod.dofn, 2)
    fprintf('%4d | ', i);
    fprintf('%12.4g', fn(nod.dofn{i})); fprintf('\n');
end

fprintf('\n')
fprintf('Node displacements:\n')

for i = 1 : size(nod.dofn, 2)
    fprintf('%4d | ', i);
    fprintf('%12.4g', dn(nod.dofn{i})); fprintf('\n');
end

fprintf('\n');
fprintf('------------------------------------------------------------\n')
fprintf('\n\n') 
