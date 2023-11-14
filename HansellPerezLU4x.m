function [x] = HansellPerezLU4x(A,b)
    y = (tril(A,-1) + eye(length(A)))\b;
    x = triu(A)\y;
end