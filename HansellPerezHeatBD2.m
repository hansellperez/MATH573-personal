function [wN] = HansellPerezHeatBD2(l, T, alpha, m, N)
    h = l/m;
    k = T/N;
    lambda = alpha^2*k/h^2;
    A = sparse(diag((1+2*lambda)*ones(m-1,1)) + diag(-lambda*ones(m-2,1), 1) + diag(-lambda*ones(m-2,1), -1));
    x = 0:h:l;
    f = fm;
    w0 = zeros(m-1,1);

    for i = 1:m-1
        w0(i) = f(x(i+1));
    end

    for i = 1:N
        wN = A\w0;
        w0 = wN;
    end
end

function f = fm
     f = @(x) sin(pi*x); % insert some function of f
end