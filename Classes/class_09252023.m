%% look at algorithm 12.2 in text book
% check code with example 2 from sec. 12.2 (pg 731)
% also talked about section 6.6
%% Method 1
function [wN] = HansellPerezHeatBD1(l, T, alpha, m, N)
    h = l/m;
    k = T/N;
    lamba = alpha^2*k/h^2;
    A = diag(1+2*lambda) + diag(-lambda, 1) + diag(-lambda, -1);
    f = f.m();

    for i = 1:m-1
        w0(i) = 
    end
end

function f = f.m.(f)
     f = @x ; % insert some function of f
end

%% Method 2

%% Method 3