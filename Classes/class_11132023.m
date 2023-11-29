n = 5;

A = rand(n);
A = (A+A')/2;
A = A + 10*n*eye(n);
b = sum(A,2);

D = diag(A);
A(1:1+n:end) = 0;

x0 = rand(n,1);
x1 = zeros(n,1);
tol = 10^-8;
tic
while (1)
    for i = 1:n
        x1(i) = b(i);
        for j = 1:n
            x1(i) = x1(i) - A(i,j)*x0(j);
        end
        x1(i) = x1(i)/D(i);
    end
    if norm(x1-x0,2)<tol
        break;
    end
    x0 = x1;
end
walltime = toc;
Norm2Error = norm(x1-1,2);

OUP = fopen("JacobiResult.txt", 'at');
fprintf(OUP, 'Results from');
fprintf(OUP, 'n = %d\n',n);
fprintf(OUP, 'Norm2Error = %13.8f\n', Norm2Error);
fprintf(OUP, 'wall time = %13.2f\n', Walltime);
fprintf(OUP, '\n');
