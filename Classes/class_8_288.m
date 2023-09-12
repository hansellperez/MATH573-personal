f = @(x) exp(x);
x0 = 0;
h = 1;

for n = 1:20
    h = h/10;
    df = (f(x0 + h) - f(x0))/h;
    fprintf('%.10f %.10f %.20f\n', df, abs(df-1), h)
end

%% Importance of specifying length of vars using matlab syntax
n = uint64(2);
for I = 1:40
    n = n*2;
end
%% storage 
n = 10000;
A = rand(n);
x = rand(n,1);


tic
A*x
toc

tic
b = A\x
toc