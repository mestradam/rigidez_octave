% General script to show results of load reactions and node displacements in
% table form

fprintf('\n-----------------------------------------------------------\n')
fprintf('\n')
fprintf('Node coordinates:\n')
fprintf('-----------------\n\n')

for i = 1 : size(nod.xyz, 1)
    fprintf('%4d | ', i);
    fprintf('%12.4g', nod.xyz{i}); fprintf('\n');
end

fprintf('\n')
fprintf('Element conectivities:\n')
fprintf('----------------------\n\n')

for i = 1 : size(ele.conec, 1)
    fprintf('%4d | ', i);
    fprintf('%4d', ele.conec{i}(1:2)); fprintf('\n');
end


fprintf('\n')
fprintf('Node loads:\n')
fprintf('-----------\n\n')

for i = 1 : size(nod.dofn, 2)
    fprintf('%4d | ', i);
    fprintf('%12.4g', fn(nod.dofn{i})); fprintf('\n');
end

fprintf('\n');


fprintf('\n')
fprintf('Node displacements:\n')
fprintf('-------------------\n\n')

for i = 1 : size(nod.dofn, 2)
    fprintf('%4d | ', i);
    fprintf('%12.4g', dn(nod.dofn{i})); fprintf('\n');
end

fprintf('\n');
fprintf('\n');
