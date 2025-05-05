N = 100;

% Generar matriz diagonalmente dominante
A = rand(N);
for i = 1:N
    A(i, i) = sum(abs(A(i, :))) + 1;
end

B = rand(N, 1) * 10;  % Vector independiente aleatorio

tol = 1e-8;
max_iter = 5000;

% Diferentes vectores iniciales
x0_zeros = zeros(N, 1);
x0_rand = rand(N, 1);
x0_neg = -ones(N, 1);

% Función para calcular memoria aproximada (en MB)
mem_GS = @(N) (N^2 + 3*N) * 8 / 1e6; % A, B, x, y, vectores auxiliares (double)

fprintf('--- Métricas de Gauss-Seidel ---\n');

% CASO 1: x0 = zeros
tic;
[x1, ~, relerr1, it1] = gauss_seidel1(A, B, x0_zeros, tol, max_iter);
time_zeros = toc;
residuo1 = norm(B - A * x1);

% CASO 2: x0 = aleatorio
tic;
[x2, ~, relerr2, it2] = gauss_seidel1(A, B, x0_rand, tol, max_iter);
time_rand = toc;
residuo2 = norm(B - A * x2);

% CASO 3: x0 = -1
tic;
[x3, ~, relerr3, it3] = gauss_seidel1(A, B, x0_neg, tol, max_iter);
time_neg = toc;
residuo3 = norm(B - A * x3);

% Mostrar resultados
fprintf('\n--- Resultados ---\n');
fprintf('Memoria estimada: %.2f MB\n', mem_GS(N));

fprintf('\nCaso x0 = zeros:\n');
fprintf('  Tiempo: %.4f seg | Iteraciones: %d | Residuo: %.2e\n', time_zeros, it1, residuo1);

fprintf('\nCaso x0 aleatorio:\n');
fprintf('  Tiempo: %.4f seg | Iteraciones: %d | Residuo: %.2e\n', time_rand, it2, residuo2);

fprintf('\nCaso x0 = -1:\n');
fprintf('  Tiempo: %.4f seg | Iteraciones: %d | Residuo: %.2e\n', time_neg, it3, residuo3);

% --- Graficar error relativo (logarítmico) ---
figure;
semilogy(1:length(relerr1), relerr1, 'r', ...
         1:length(relerr2), relerr2, 'b--', ...
         1:length(relerr3), relerr3, 'm');
xlabel('Iteraciones');
ylabel('Error relativo (escala logarítmica)');
legend('x0 = 0', 'x0 aleatorio', 'x0 = -1');
title('Convergencia del método de Gauss-Seidel');
grid on;

% --- Gráfico de tiempo de cómputo ---
figure;
bar([time_zeros, time_rand, time_neg]);
set(gca, 'XTickLabel', {'x0 = 0', 'x0 aleatorio', 'x0 = -1'});
ylabel('Tiempo (segundos)');
title('Tiempo de cómputo para diferentes vectores iniciales');
grid on;

% --- Gráfico de residuo final ---
figure;
bar([residuo1, residuo2, residuo3]);
set(gca, 'XTickLabel', {'x0 = 0', 'x0 aleatorio', 'x0 = -1'});
ylabel('Residuo final ||Ax - b||');
title('Precisión (residuo) según condición inicial');
grid on;
