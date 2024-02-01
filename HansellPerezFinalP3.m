function [k,x] = HansellPerezFinalP3(d,u1,u2,l1,l2,b,x0,TOL)
    n = length(d);
    k = 1;

    x = zeros(n,1);
    while k <= 10000
        for i = 1:n
            if i == 1
                summation = u1(i)*x0(i+1) + u2(i)*x0(i+2);
            elseif i == 2
                summation = l1(i-1)*x0(i-1) + u1(i)*x0(i+1) + u2(i)*x0(i+2);
            elseif i == n-1
                summation = l2(i-2)*x0(i-2) + l1(i-1)*x0(i-2) + u1(i)*x0(i+1);
            elseif i == n
                summation = l2(i-2)*x0(i-2) + l1(i-1)*x0(i-1);
            else
                summation = l2(i-2)*x0(i-2) + l1(i-1)*x0(i-1) + u1(i)*x0(i+1) + u2(i)*x0(i+2);
            end

            x(i) = (1/d(i))*(-summation + b(i));
        end

        if norm(x - x0) < TOL
            break
        end

        k = k + 1;
        x0 = x;
    end
end