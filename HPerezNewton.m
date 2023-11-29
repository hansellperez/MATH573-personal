% I included an extra input "f" to facilitate writing the code
% "f" is a symbolic function defined as follows:
% syms f(x)
% f(x) = 2*x^3 + cos(x) - exp(x)^2
function [x, info] = HPerezNewton(x0, TOL, N0, f)
    %start iteration counter
    iter = 0;
    % define the function f'(x) as fp
    fp = diff(f);
    % if the inital guess is close enough to zero we are done
    if abs(double(f(x0))) < TOL
        x = x0;
        info = 1;
        return
    else
        % start the Newton method w/ the follwoing stopping criteria
        while N0 > iter
            iter = iter + 1;
            x0 = double(x0 - f(x0)/fp(x0));
            if abs(double(f(x0))) < TOL
                break
            end
        end
        x = x0;
        if iter <= N0
            info = 1;
        else
            info = 0;
        end
    end
end
