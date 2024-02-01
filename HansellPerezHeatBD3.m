function [wN] = HansellPerezHeatBD3(l, T, alpha, m, N)
    h = l/m;
    k = T/N;
    lambda = alpha^2*k/h^2;
    a = diag((1+2*lambda)*ones(m-1,1));
    b = diag(-lambda*ones(m-2,1), 1);
    c = diag(-lambda*ones(m-2,1), -1);
    [l1, l2, u2] = HPerezCrout3Diag(a, b, c);
    

    A = diag((1+2*lambda)*ones(m-1,1)) + diag(-lambda*ones(m-2,1), 1) + diag(-lambda*ones(m-2,1), -1);
    [L, U] = lu(A);
    x = 0:h:l;
    f = fm;
    w0 = zeros(m-1,1);
    y = zeros(m-1,1);

    for i = 1:m-1
        w0(i) = f(x(i+1));
    end

    for i = 1:N
        y = L\w0;
        wN = U\y;
        w0 = wN;
    end
end

function [l1, l2, u2] = HPerezCrout3Diag(a, b, c)
    % define the dimension of the Tridiagonal matrix to be faxtorized
    n = length(a);
    % preallocate space for output vectors
    l1 = zeros(n, 1);
    l2 = zeros(n-1, 1);
    u2 = zeros(n-1, 1);
    % calculate first values of l1 and u2
    l1(1) = a(1);
    u2(1) = b(1)/l1(1);
    % fill in the output vectors appropriately
    for i = 2:(n - 1)
    l2(i-1) = c(i-1);
    l1(i) = a(i) - l2(i-1)*u2(i-1);
    u2(i) = b(i)/l1(i);
    end
    % finalize l1 and l2 vectors
    l2(n-1) = c(n-1);
    l1(n) = a(n) - c(n-1)*u2(n-1);
end

function f = fm
     f = @(x) sin(pi*x); % insert some function of f
end