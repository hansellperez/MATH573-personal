%% Two ways to create tri diagonal matrices
n = 5;
A = zeros(n);
for i = 1:n
    A(i,i) = 4;
end 
for i = 1:n-1
    A(i+1, i) = -1;
    A(i, i+1) = -1;
end
A;

% this is more efficient than the for loop
B= 4*eye(n) + diag(-ones(n-1,1),1) + diag(-ones(n-1,1),-1)

%% Solving a system using sparse vs non sparse matrices

n = 5;
B= 4*eye(n) + diag(-ones(n-1,1),1) + diag(-ones(n-1,1),-1)
S = sparse(B);
b = sum(B,2);
tic
X = A\b;
toc

tic
X = S\b;
toc

M = rand(n);
S = sparse(M);
b = sum(M,2);
tic
X = M\b;
toc
tic
X = S\b;
toc

%% Using Hessenberg form of matrix
n = 5000

T = rand(n);
H = hess(T);
S = sparse(H);
b = sum(H,2)

tic 
X = H\b;
toc
tic
X = S\b;
toc

%% Sparse matrix example 2 comparing factorization methods
n = 5000;
A = rand(n);

tic
[L, U] = lu(A);
toc

tic 
[Q, R] = qr(A);
toc

%% Comparing factorization methods using sparse matrix
n = 5000;
A = rand(n);

H = hess(A);
S = sparse(H);
tic
[L,U] = lu(H);
toc

tic
[L, U] = lu(S);
toc

tic
[Q, R] = qr(H);
toc

tic
[Q, R] = qr(S);
toc



%%
n = 20000;
A = 4*eye(n) + diag(-ones(n-1,1),1) + diag(-ones(n-1,1),-1);
S = sparse(A);

spy(S)

figure
B = 4*eye(n) + diag(-ones(n-100,1),100) + diag(-ones(n-100,1),-100);
S = sparse(B)
spy(S)

%% Digging into QR factorization properties
% eigen values appear on diagonal of A = R*Q
n = 5;
A = rand(n);
A = (A + A')/2;

eig(A)

iter = 0;
while norm(diag(A, -1),2) > 10^-8
    [Q, R] = qr(A);
    A = R*Q;
    iter = iter + 1;
end

iter 
A

%% timing stuff from previous section 

n = 5000;
A = rand(n);
A = (A+A')/2;

tic 
eig(A);
toc

a = rand(n-1,1);
B = diag(rand(n,1)) + diag(a,1) + diag(a,-1);

tic
eig(B);
toc

S = sparse(B);
tic
eig(S);
toc

% A and B are similar if there is a non singular matrix P such that 
% B = inverse(P)AP
% A and B have same eigenvalues  since |B - lambda*I| = |invers(P)AP

% A' = A (A is symmetric) --->  B is still symmetric
% inverse(P)AP = B
% in scientific omputing, if you can change a problem into another that is easier to solve then you do that
% purpose of reducing matrices to QR

% for 4x4, P = I - 2WW'
% P1(a11 a12 a13 a14)' = (a11 * 0 0)'
% look into process of changing symmetric matric to tri diagonal matrix








