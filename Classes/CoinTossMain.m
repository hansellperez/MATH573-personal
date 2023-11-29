tic
p=0.8;
n = 1000000000;
nHeads = 0;
parfor I = 1:n
    [lastheads] = headstails(p);
    nHeads = nHeads + lastheads;
end
myApprox = nHeads/n;
WallTime = toc;

OUP = fopen("HeadsTailsResult.txt",'at');
fprintf(OUP, 'Results from ');
fprintf(OUP, 'n = %d\n',n);
fprintf(OUP, 'myApprox = %13.8f\n',myApprox);
fprintf(OUP, 'Wall Time = %13.2f\n\n', WallTime);

function [lastheads] = headstails(p)
    % p: probability of getting heads
    % lastheads = 1 if the last flip is heads and both heads and tails have
    % appeared; otherwise, lastheads = 0
    % get heads if rand(1) < p, tails if otherwise

    x = rand(1);
    heads = 0;
    tails = 0;
    
    if x < p
        heads = 1;
    else
        tails = 1;
    end

    lastheads = 0;
    while (heads+tails) < 2
        x = rand(1);
        if x < p
            heads = 1;
            lastheads = 1;
        else 
            tails = 1;
            lastheads = 0;
        end
    end
end