function mem_kb = memoria_estimacion(n)
    % Memoria estimada en KB
    mem_bytes = (n^2 + 3*n) * 8; % double precision (8 bytes)
    mem_kb = mem_bytes / 1024;
end
