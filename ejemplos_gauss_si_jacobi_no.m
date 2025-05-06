unction ejemplo_gauss_si_jacobi_no()
    fprintf('\n========= SISTEMA DONDE GAUSS-SEIDEL CONVERGE Y JACOBI NO =========\n');

    % Crear matriz simétrica definida positiva pero no diagonalmente dominante
    n = 10;
    R = rand(n);
    A = R' * R; % A es simétrica definida positiva

    % Reducir ligeramente la diagonal para romper la diagonal dominante
    for i = 1:n
        A(i, i) = A(i, i) / 10;
    end

    b = rand(n, 1) * 10;
    x0 = zeros(n, 1);
    tol = 1e-6;
    max_iter = 500;

    x_exacta = A \ b;

    % Inicialización de variables
    err_jac = [];
    err_gs = [];

    % Método de Jacobi
    jacobi_converge = true;
    try
        [x_jac, it_jac, err_jac] = jacobi(A, b, x0, tol, max_iter);
        err_rel_jac = norm(x_jac - x_exacta) / norm(x_exacta);
        fprintf('\nJacobi:\n');
        fprintf('  Iteraciones: %d\n', it_jac);
        fprintf('  Error relativo: %.2e\n', err_rel_jac);
    catch e
        jacobi_converge = false;
        fprintf('\nJacobi falló o no converge: %s\n', e.message);
    end

    % Método de Gauss-Seidel
    try
        [x_gs, it_gs, err_gs] = gauss_seidel1(A, b, x0, tol, max_iter);
        err_rel_gs = norm(x_gs - x_exacta) / norm(x_exacta);
        fprintf('\nGauss-Seidel:\n');
        fprintf('  Iteraciones: %d\n', it_gs);
        fprintf('  Error relativo: %.2e\n', err_rel_gs);
    catch e
        fprintf('\nGauss-Seidel falló: %s\n', e.message);
    end

    % Graficar si es posible
    figure;
    hold on;
    if jacobi_converge
        semilogy(1:length(err_jac), err_jac, 'r--', 'LineWidth', 2);
    end
    semilogy(1:length(err_gs), err_gs, 'b-', 'LineWidth', 2);
    legend_entries = {'Gauss-Seidel'};
    if jacobi_converge
        legend_entries = {'Jacobi', 'Gauss-Seidel'};
    end
    legend(legend_entries, 'Location', 'southwest');
    xlabel('Iteraciones');
    ylabel('Error relativo (escala log)');
    title('Comparación de convergencia: Jacobi vs Gauss-Seidel');
    grid on;
    hold off;
end
