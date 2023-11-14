%% look at algorithm 12.2 in text book
% check code with example 2 from sec. 12.2 (pg 731)
% also talked about section 6.6
%% Method 1
function [wN] = HansellPerezHeatBD1(l, T, alpha, m, N)
    h = l/m;
    k = T/N;
    lambda = alpha^2*k/h^2;
    A = diag(1+2*lambda) + diag(-lambda, 1) + diag(-lambda, -1);
    x = 0:h:l;
    t = 0:k:T;
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

%% Method 2

%% Method 3