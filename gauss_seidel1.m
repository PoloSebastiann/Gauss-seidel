function [x, iter, err_vec, relerr_vec, tiempo] = gauss_seidel1(A, b, x0, tol, max_iter)
    n = length(b);
    x = x0;
    err_vec = zeros(max_iter,1);
    relerr_vec = zeros(max_iter,1);

    tic;
    for iter = 1:max_iter
        x_old = x;

        for i = 1:n
            sum1 = A(i,1:i-1) * x(1:i-1);
            sum2 = A(i,i+1:n) * x_old(i+1:n);
            x(i) = (b(i) - sum1 - sum2) / A(i,i);
        end

        err = norm(x - x_old);
        relerr = err / (norm(x) + eps);
        err_vec(iter) = err;
        relerr_vec(iter) = relerr;

        if err < tol || relerr < tol
            tiempo = toc;
            err_vec = err_vec(1:iter);
            relerr_vec = relerr_vec(1:iter);
            return;
        end
    end
    tiempo = toc;
    warning('Se alcanzó el máximo de iteraciones sin convergencia.');
end
