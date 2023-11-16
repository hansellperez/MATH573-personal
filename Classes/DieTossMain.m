tic
p = [0.1;0.1;0.1;0.2;0.1;0.4];
n = 1000000000;
n6 = 0;
parfor i = 1:n
    [last6] = HansellPerezDieToss(p)
    n6 = n6 + last6;
end 
myApprox = n6/n;
WallTime = toc;

OUP = fopen("DieTossResult.txt",'at');
fprintf(OUP, 'Results from ');
fprintf(OUP, 'n = %d\n',n);
fprintf(OUP, 'myApprox = %13.8f\n',myApprox);
fprintf(OUP, 'Wall Time = %13.2f\n\n', WallTime);