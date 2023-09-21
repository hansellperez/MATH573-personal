%% read an image
A = imread("C:\Users\015159428\Downloads\bird.png");
imshow(A)

%% read another image and show size
B = imread();
imshow(B)
size(B)

%% making colors
C = zeros(100, 100, 3); % need 3 dimensions to represent colors (RGB)
C(:, :, 2) = 255;
imshow(C)

%% Main script for calling Newtons Method
z0 = complex(1,-1);
tol = 10^-8;
M = 10;

[z, info] = Newton4z3_1(z0, tol, M)

%% This creates a fractal
p = [1, 0, 0, -1];
r = roots(p); % r(1), r(2), r(3)

a = 3;
n = 999;
h = 2*a/n;
x = -a:h:a;
y = -a:h:a;
A = zeros(n+1, n+1, 3);

tol = 10^-8;
M = 10;

for i = 1:n+1
    for j = 1:n+1
        z0 = complex(x(i), y(j));
        [z, info] = Newton4z3_1(z0, tol, M);
        if info == 0
            if abs(r(1) - z) < .1
                A(j,i,1) = 255;
            elseif abs(r(2) - z) < .1
                    A(j,i,2) = 255;
            else 
                A(j,i,3) = 255;
            end
        end
    end
end

imshow(A)

%% this is the fractal above and adding black spots
p = [1, 0, 0, -1];
r = roots(p); % r(1), r(2), r(3)

a = 3;
n = 999;
h = 2*a/n;
x = -a:h:a;
y = -a:h:a;
A = zeros(n+1, n+1, 3);

tol = 10^-8;
M = 10;

for i = 1:n+1
    for j = 1:n+1
        z0 = complex(x(i), y(j));
        [z, info, iter] = Newton4z3_1(z0, tol, M);
        if info == 0
            if abs(r(1) - z) < .1
                A(j,i,1) = 255;
            elseif abs(r(2) - z) < .1
                if iter < 6
                    A(j,i,2) = 0;
                else
                    A(j,i,2) = 255;
                end
            else 
                A(j,i,3) = 255;
            end
        end
    end
end

imshow(A)


%% Manipulation of vectors and matrices, transforming them from one to another.
A = [ 1, 2; 3, 4];
b = reshape(A, [], 1);

B = reshape(b, 2, 2); % returns original 2x2 matrix A

%% Newton's Method
% z = z0 - f(z0)/f'(z0)

function [z, info, iter] = Newton4z3_1(z0, tol, M)
    % info  = 0: z is the root 
    % info = 1: divergent
    info = 1;
    iter = 0;
    while (iter<M)
        z = z0 - (z0^3 - 1)/(3*z0^2);
        iter = iter +1;
        if abs(z^3 -1) < tol % abs(z-z0) is cheaper than eval the function, this is checking if the improvemnt is small enough
            info = 0;
            return
        end
        z0 = z;
    end
end
