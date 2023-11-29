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