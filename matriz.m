N = 100; 

% Generar matriz diagonal dominante
A = rand(N); 
for i = 1:N
    A(i, i) = sum(abs(A(i, :))) + 1;
end

x_real = ones(N, 1);  % Solución real (todas las componentes = 1)
B = A * x_real;       % Vector del lado derecho

tol = 1e-8;           % Tolerancia
max_iter = 100;      % Máximo de iteraciones

% Diferentes vectores iniciales
x0_zeros = zeros(N, 1);
x0_rand = rand(N, 1);
x0_neg = -ones(N, 1);

% Medir tiempo y memoria para cada caso
fprintf('--- Métricas de Gauss-Seidel ---\n');

% Función para calcular memoria aproximada (en MB)
mem_GS = @(N) (N^2 + 3*N)*8/1e6; % A + x + b + otros vectores (double precision)

% Caso 1: x0 = zeros
tic;
[x1, err1, relerr1, it1] = gauss_seidel1(A, B, x0_zeros, tol, max_iter);
time_zeros = toc;
residuo1 = norm(B - A*x1);
error_real1 = norm(x1 - x_real);

% Caso 2: x0 = rand
tic;
[x2, err2, relerr2, it2] = gauss_seidel1(A, B, x0_rand, tol, max_iter);
time_rand = toc;
residuo2 = norm(B - A*x2);
error_real2 = norm(x2 - x_real);

% Caso 3: x0 = -ones
tic;
[x3, err3, relerr3, it3] = gauss_seidel1(A, B, x0_neg, tol, max_iter);
time_neg = toc;
residuo3 = norm(B - A*x3);
error_real3 = norm(x3 - x_real);

% Mostrar resultados
fprintf('\n--- Resultados ---\n');
fprintf('Memoria estimada: %.2f MB\n', mem_GS(N));
fprintf('\nCaso x0 = zeros:\n');
fprintf('  Tiempo: %.4f seg | Iter: %d | Residuo: %.2e | Error real: %.2e\n', time_zeros, it1, residuo1, error_real1);
fprintf('\nCaso x0 = rand:\n');
fprintf('  Tiempo: %.4f seg | Iter: %d | Residuo: %.2e | Error real: %.2e\n', time_rand, it2, residuo2, error_real2);
fprintf('\nCaso x0 = -1:\n');
fprintf('  Tiempo: %.4f seg | Iter: %d | Residuo: %.2e | Error real: %.2e\n', time_neg, it3, residuo3, error_real3);

% Graficar error relativo (escala logarítmica)
figure;
semilogy(1:length(relerr1), relerr1, 'r', ...
         1:length(relerr2), relerr2, 'b--', ...
         1:length(relerr3), relerr3, 'm');
xlabel('Iteraciones');
ylabel('Error relativo (log escala)');
legend('X0 = 0', 'X0 aleatorio', 'X0 = -1');
title('Convergencia del método de Gauss-Seidel');
grid on;

% Gráfica de tiempo de cómputo
figure;
bar([time_zeros, time_rand, time_neg]);
set(gca, 'XTickLabel', {'X0 = 0', 'X0 aleatorio', 'X0 = -1'});
ylabel('Tiempo (segundos)');
title('Tiempo de cómputo para diferentes vectores iniciales');
grid on;

% Gráfica de error real comparativo
figure;
bar([error_real1, error_real2, error_real3]);
set(gca, 'XTickLabel', {'X0 = 0', 'X0 aleatorio', 'X0 = -1'});
ylabel('Error real (||x - x_{real}||)');
title('Precisión alcanzada para diferentes x0');
grid on
