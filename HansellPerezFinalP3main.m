n = 1000000000; % I test this n value and my code worked.
% If this is too big, use n = 100,000,000
TOL = 10^-8;
d = 5 + rand(n,1);
u1 = 1 - 2*rand(n-1,1);
u2 = 1 - 2*rand(n-2,1);
l1 = 1 - 2*rand(n-1,1);
l2 = 1 - 2*rand(n-2,1);
%A = diag(l2,-2) + diag(l1,-1) + diag(d) + diag(u1,1) + diag(u2,2)
b = 1 - 2*rand(n,1);
x0 = 1 - 2*rand(n,1);
tic
[k,x] = HansellPerezFinalP3(d,u1,u2,l1,l2,b,x0,TOL);

WallTime = toc;
OUP = fopen("ResultsFinalP3.txt",'at');
fprintf(OUP, 'Results from ');
fprintf(OUP, 'n = %d\n',n);
fprintf(OUP, 'k = %d\n',k);
fprintf(OUP, 'Wall Time = %13.2f\n\n', WallTime);
fclose(OUP);