function [k,I] = HansellPerezFinalP1(A,TOL)
    n = length(A);
    subdiag = diag(A,1);
    k = 0;

    while abs(min(subdiag)) > TOL
        [Qk, Rk] = qr(A);
        Ak = Rk*Qk;
        
        subdiag = diag(Ak,1);
        A = Ak;
        k = k+1;
    end
    
    if k == 0
        Ak = A;
    end

    TOLvals = abs(subdiag) < TOL;
    [~, idx] = max(subdiag(TOLvals));
    
    I = idx + 1;
end