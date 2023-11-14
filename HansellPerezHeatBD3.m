function [wN] = HansellPerezHeatBD3(l, T, alpha, m, N)
    h = l/m;
    k = T/N;
    lambda = alpha^2*k/h^2;
    A = diag((1+2*lambda)*ones(m-1,1)) + diag(-lambda*ones(m-2,1), 1) + diag(-lambda*ones(m-2,1), -1);
    [L, U] = lu(A);
    x = 0:h:l;
    f = fm;
    w0 = zeros(m-1,1);

    for i = 1:m-1
        w0(i) = f(x(i+1));
    end

    for i = 1:N
        y = L\w0;
        wN = U\y;
        w0 = wN;
    end
end

function f = fm
     f = @(x) sin(pi*x); % insert some function of f
end