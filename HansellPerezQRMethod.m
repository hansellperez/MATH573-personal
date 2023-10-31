% This fuction implements the QR method discussed in section 9.5 of Burden
% and Faires textbook. It is used to approximate the eigenvalues of the
% n-by-n tridiagonal matrix A. 
%
% inputs: 
%   a - an n-by-1 vector containing the diagonal entries of the matrix A
%   corresponding the the problem being solved
%   b -  an (n-1)-by-1 vector containing the off diagonal values of the
%   matrix A corresponding to the problem being solved
%   TOL - a scalar; the acceptable margin of error for conversion
%   M - a scalar; the maximum number of iterations the method will attempt
%   to solve for the eigen values of A
%
% outputs:
%   lambda - a j-by-1 vector containing the approximate eigenvalues of A.
%   If the method is successfully completed then j=n and ALL eigen values
%   of A have been approximated. If the method reaches the maximum
%   iterations or splitting is suggested, then j<n and only the eigenvalues 
%   obtained are displayed. 
%   info - a scalar; defines the final state of the problem:
%       info = 0 if all n eigenvalues are obtained
%       info = 1 if splitting of A is recommended
%       info = 2 if the maximum number of iterations is exceeded

function [lambda, info] = HansellPerezQRMethod(a, b, TOL, M)
    n = length(a);          % define the size of the problem

    k = 1;                  % initiate the iteration counter
    ak = a;                 % this is the vector of diagonal entries that will be modified as the method progresses
    bk = b;                 % this is the vector of off-diagonal entries that will be modified as the method progresses
    cumshift = 0;           % initiate the cumulative shift given by the use of eigenvalues
    lambda = zeros(n,1);    % preallocate space for the solution vector, lambda
    
    % this loop carries out the QR method only for the number of iterations
    % permitted by TOL
    while k <= M
        % if the last off-didagonal entry of the kth iteration, b_(n-1) is  
        % within the specified tolerance, then the last diagonal entry, a_n, 
        % can be accepted as the approximation for the nth eigen value. 
        % (Note: n is updated as the method progresses, so a_n for the kth 
        % iteration may not be the same a_n for the k+1 iteration)
        if abs(bk(end)) <= TOL
            lambda(n) = ak(end) + cumshift;

            % reduce the dimension of the problem
            n = n-1;        
            ak = ak(1:end-1);
            bk = bk(1:end-1);
        end
        
        % if the first off-didagonal entry of the kth iteration, b_1 is  
        % within the specified tolerance, then the first diagonal entry, 
        % a_1, can be accepted as the approximation for the nth eigenvalue. 
        % (Note: n is updated as the method progresses, so a_n for the kth 
        % iteration may not be the same a_n for the k+1 iteration)
        if abs(b(1)) <= TOL
            lambda(n) = a(1) + cumshift;

            % reduce the dimension of the problem
            n = n-1;
            ak = ak(2:end);
            bk = bk(2:end);
        end
        
        % if n = 0 then the method has been run to completion, set info to
        % 0 and terminate the process
        if n == 0
            info = 0;
            return
        end

        % if n = 1 then accept the remaining diagonal entry, a_1, as the
        % last eignevalue of A
        if n == 1
            lambda(n) = a(1) + cumshift;
            info = 0;
            return
        end
        
        % If splitting is recommended, then set info = 1 and terminate the
        % process. (Note: splitting recommended is any b_n value , except
        % for the first and last, value is within the specified tolerance
        if any(abs(bk) < TOL)
            info = 1;
            lambda = lambda(n+1:end);
            return
        end
        
        % compute shifts for this iteration; result from the quadratic
        % formula solutions of the characteristic polynomial of
        % det(A-lambda*I). (Note: qf_ used to denote quadratic formula var)
        qf_b = -(ak(n-1) + ak(n));
        qf_c = ak(n-1)*ak(n) - bk(n-1)^2;
        qf_d = sqrt(qf_b^2 - 4*qf_c);

        if qf_b > 0 
            e_val1 = -2*qf_c/(qf_b + qf_d);
            e_val2 = -(qf_b + qf_d)/2;
        else
            e_val1 = (qf_d - qf_b)/2;
            e_val2 = 2*qf_c/(qf_d - qf_b);
        end

        % if n = 2, then use the eigenvalues obtained above as the
        % approximation for the outstanding eigenvalues of A and terminate
        % the process
        if n == 2
            lambda(n) = e_val1 + cumshift;
            lambda(n-1) = e_val2 + cumshift;

            info = 0;
            return
        end

        % choose sigma so that it is the eignevalue closest to a_n
        if abs(e_val1 - ak(n)) <= abs(e_val2 - ak(n))
            sigma = e_val1;
        else
            sigma = e_val2;
        end

        % accumulate the shift
        cumshift = cumshift + sigma;

        % perform the shift, the new diagonal entries given by d
        d = ak - sigma*ones(n,1);
        
        % preallocate space for variables needed in the computation of R
        x = zeros(n,1);
        y = zeros(n,1);
        z = zeros(n,1);
        c = zeros(n,1);
        q = zeros(n,1);
        r = zeros(n,1);
        s = zeros(n,1);

        % compute Rk, the kth rotation matrix
        x(1) = d(1);
        y(1) = b(1);

        for i = 1:n-1
            z(i) = sqrt(x(i)^2 + bk(i)^2);
            c(i+1) = x(i)/z(i);
            s(i+1) = bk(i)/z(i);
            q(i) = c(i+1)*y(i) + s(i+1)*d(i+1);
            x(i+1) = -s(i+1)*y(i) + c(i+1)*d(i+1);

            if i ~= n-1
                r(i) = s(i+1)*bk(i+1);
                y(i+1) = c(i+1)*bk(i+1); 
            end
        end
        
        % compute A^(k+1), the (k+1)st iteration of A
        z(n) = x(n);
        ak(1) = s(2)*q(1) + c(2)*z(1);
        bk(1) = s(2)*z(2);

        for i = 2:n-1
            ak(i) = s(i+1)*q(i) + c(i+1)*z(i);
            bk(i) = s(i+1)*z(i+1);
        end

        ak(n) = c(n)*z(n);
        k = k + 1;                      % update the iterate number so loop can start again
    end

    if k >= M
        info = 2;
    end
end