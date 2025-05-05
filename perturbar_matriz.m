function A_pert = perturbar_matriz(A, p)
    delta_A = p * randn(size(A));
    A_pert = A + delta_A;
end
