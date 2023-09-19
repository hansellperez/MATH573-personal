%% Code 1
n = 10000; % choose n values according to the question below
A = rand(n);
x = rand(n,1);
b1 = zeros(n,1);

tic
for i = 1:n
    for j = 1:n
        b1(i) = b1(i) + A(i,j)*x(j);
    end
end
toc

%% modified code 1
n = 10000; % choose n values according to the question below
A = rand(n);
x = rand(n,1);
b2 = zeros(n,1);

tic
for j = 1:n
    for i = 1:n
        b2(j) = b2(j) + A(j,i)*x(i);
    end
end
toc

%% Code 2
n = 10000;
A = rand(n);
x = rand(n,1);
b3 = zeros(n,1);

tic
for i = 1:n
    for j = 1:n
        b3(i) = b3(i) + A(j,i)*x(j);
    end
end
toc