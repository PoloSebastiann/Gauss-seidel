function comparacion_parametros()
    fprintf('\n========= PARÁMETROS DE COMPARACIÓN PARA GAUSS-SEIDEL =========\n');
    tamanos = [50, 100, 200, 500];
    tol = 1e-6;
    max_iter = 1000;

    tiempos = zeros(length(tamanos), 1);
    iteraciones = zeros(length(tamanos), 1);
    errores = zeros(length(tamanos), 1);
    memorias = zeros(length(tamanos), 1);

    fprintf('Tamaño | Tiempo (s) | Iteraciones | Error       | Memoria (KB)\n');
    fprintf('---------------------------------------------------------------\n');

    for i = 1:length(tamanos)
        n = tamanos(i);
        [A, b, x_real] = crear_sistema(n);
        x0 = zeros(n,1);

        % Ejecución de Gauss-Seidel
        [x_gs, iter, ~, ~, tiempo] = gauss_seidel1(A, b, x0, tol, max_iter);

        % Cálculo de métricas
        err_rel = error_relativo(x_gs, x_real);
        mem_kb = memoria_estimacion(n);

        tiempos(i) = tiempo;
        iteraciones(i) = iter;
        errores(i) = err_rel;
        memorias(i) = mem_kb;

        fprintf('%6d | %10.6f | %11d | %10.2e | %11.2f\n', ...
                n, tiempo, iter, err_rel, mem_kb);
    end

    % Gráficas de resultados
    graficar_resultados(tamanos, tiempos, iteraciones, errores, memorias);

    % Prueba de robustez con perturbaciones
    fprintf('\n========= PRUEBA DE ROBUSTEZ CON PERTURBACIONES =========\n');
    n = 100;
    perturbaciones = [0.01, 0.05, 0.1, 0.2];

    [A, b, x_real] = crear_sistema(n);
    x0 = zeros(n, 1);

    for p = perturbaciones
        fprintf('\nPerturbación: %.2f\n', p);
        A_pert = perturbar_matriz(A, p);

        % Solución exacta (matriz perturbada)
        x_exact_pert = A_pert \ b;

        % Ejecución con matriz perturbada
        [x_gs_pert, iter, ~, ~, tiempo] = gauss_seidel1(A_pert, b, x0, tol, max_iter);
        err_pert = error_relativo(x_gs_pert, x_exact_pert);

        fprintf('Iteraciones: %d | Tiempo: %.6f s | Error relativo: %.2e\n', iter, tiempo, err_pert);
    end
end
