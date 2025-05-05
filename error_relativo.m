function error = error_relativo(x_aprox, x_real)
    error = norm(x_aprox - x_real) / (norm(x_real) + eps);
end
