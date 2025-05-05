% SCRIPT PRINCIPAL PARA ANÁLISIS DEL MÉTODO DE GAUSS-SEIDEL
fprintf('=========== ANÁLISIS DEL MÉTODO DE GAUSS-SEIDEL ===========\n');

% Opciones para ejecutar individualmente o todos los ejemplos
fprintf('Seleccione una opción:\n');
fprintf('1. Ejecutar ejemplo sistema convergente\n');
fprintf('2. Ejecutar ejemplo sistema no convergente\n');
fprintf('3. Analizar dependencia de condiciones iniciales\n');
fprintf('4. Obtener parámetros de comparación\n');
fprintf('5. Ejecutar todos los ejemplos\n');

opcion = input('Ingrese el número de opción: ');

switch opcion
    case 1
        ejemplo_sistema_convergente();
    case 2
        ejemplo_no_convergente();
    case 3
        analizar_condiciones_iniciales();
    case 4
        parametros_comparacion();
    case 5
        ejemplo_sistema_convergente();
        ejemplo_no_convergente();
        analizar_condiciones_iniciales();
        parametros_comparacion();
    otherwise
        fprintf('Opción no válida\n');
end
