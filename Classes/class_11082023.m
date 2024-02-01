% class 11 08 2023
n = 1000;
A = rand(n);
x = rand(n,1);
b = rand(n,1);
y = zeros(n,1);

for i = 1:n
    y = b(i);
    for j = 1:n
        y(i) = y(i) + A(i,j)*x(j);
    end
end

%%
n = 5;
A = rand(n);
A = A + n*eye(n);
B = A - diag(A);
b = sum(A,2);
x0 = rand(n,1);
x1 = rand(n,1);
tol = 10^-8;
while norm(x1-x0)>tol
    for i = 1:n
        x1(i) = b(i);
        for j = 1:n
            x1(i) = x1(i) - B(i,j)*x0(j);
        end
        x1(i) = x1(i)/A(i,i);
    end
    x0 = x1;
end
