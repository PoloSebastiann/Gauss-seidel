function ejemplo_no_convergente()
    fprintf('\n========= EJEMPLO: SISTEMA DONDE GAUSS-SEIDEL NO CONVERGE =========\n');
    n = 50;

    % Generar matriz aleatoria NO diagonalmente dominante (alta probabilidad de no convergencia)
    A = rand(n) * 10; % Matriz aleatoria
    for i = 1:n
        A(i,i) = sum(abs(A(i,:))) / (n * 10);  % Forzar la diagonal a ser pequeña (no dominante)
    end

    b = rand(n, 1) * 10;  % Vector de términos independientes aleatorio

    fprintf('Sistema de tamaño %dx%d con valores diagonales pequeños\n', n, n);

    x0 = zeros(n, 1);  % Vector inicial
    tol = 1e-6;
    max_iter = 200;

    % Solución exacta para referencia
    x_real = A \ b;

    % Llamada al método de Gauss-Seidel
    try
        [x_gs, iter_gs, err_hist_gs, tiempo_gs, err_gs] = gauss_seidel1(A, b, x0, tol, max_iter);
        
        % Mostrar resultados
        fprintf('\nResultados Gauss-Seidel:\n');
        fprintf('Iteraciones: %d\n', iter_gs);
        fprintf('Tiempo: %.6f segundos\n', tiempo_gs);
        fprintf('Error relativo: %.10e\n', err_gs);

        % Graficar error relativo por iteración
        figure;
        semilogy(1:length(err_hist_gs), err_hist_gs, 'r-', 'LineWidth', 2);
        grid on;
        xlabel('Iteración');
        ylabel('Error relativo (escala log)');
        title('Convergencia del Método de Gauss-Seidel (Ejemplo No Convergente)');

        % Guardar datos
        save('resultados_no_convergente.mat', 'A', 'b', 'x_real', 'x_gs', 'iter_gs', 'tiempo_gs', 'err_gs', 'err_hist_gs');

    catch e
        fprintf('Error en ejecución de Gauss-Seidel: %s\n', e.message);
    end
end

