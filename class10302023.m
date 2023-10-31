n = 500;
maxeig = zeros(n,1);
tic
for i = 1:100
    maxeig(i) = max(eig(rand(n)));
end
toc

% compare for loop above to the following
tic
parfor i = 1:100
    maxeig(i) = max(eig(rand(n)));
end
toc

%%
ap = a;
bp = b;
cp = zeros(n,1);

for i = 2:n
    a(i) = b(i);
    c(i) = a(i-1);
end

parfor i = 2:n
    a(i) = b(i);
    c(i) = a(i-1);
end