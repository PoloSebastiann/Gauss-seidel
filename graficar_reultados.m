function graficar_resultados(tamanos, tiempos, iteraciones, errores, memorias)
    figure;
    subplot(2,2,1);
    plot(tamanos, tiempos, 'o-', 'LineWidth', 2);
    grid on;
    xlabel('Tamaño del sistema');
    ylabel('Tiempo (s)');
    title('Tiempo vs Tamaño');

    subplot(2,2,2);
    plot(tamanos, iteraciones, 'o-', 'LineWidth', 2);
    grid on;
    xlabel('Tamaño del sistema');
    ylabel('Iteraciones');
    title('Iteraciones vs Tamaño');

    subplot(2,2,3);
    semilogy(tamanos, errores, 'o-', 'LineWidth', 2);
    grid on;
    xlabel('Tamaño del sistema');
    ylabel('Error relativo (log)');
    title('Error relativo vs Tamaño');

    subplot(2,2,4);
    plot(tamanos, memorias, 'o-', 'LineWidth', 2);
    grid on;
    xlabel('Tamaño del sistema');
    ylabel('Memoria (KB)');
    title('Memoria vs Tamaño');
end
