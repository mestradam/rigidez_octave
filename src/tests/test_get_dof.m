
nod.restr = {
    [ 1 2 0 ];
    [ 3 0 ];
};

ele.conec = {
    [ 1 2 1 ];
    [ 2 3 1 ];
};

gen.nnod = 3;
gen.ndofn = 3;

[nod, ele, gen] = get_dof(nod, ele, gen);
