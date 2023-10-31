%% Quiz 3 - Linear Programming
%% max B + 1.9D + 1.5E + 1.08S_2
f = -1*[0; 1; 0; 1.9; 1.5; 0; 0; 1.08];
Aeq = [1 0 1 1 0 1 0 0;
    .5 -1 1.2 0 0 1.08 -1 0;
    1 .5 0 0 -1 0 1.08 -1];
beq = [100000; 0; 0];
lb = zeros(8,1);
ub = [75000; 75000; 75000; 75000; 75000; inf; inf; inf];

x1 = linprog(f, [], [], Aeq, beq, lb, ub)




%% min 50x_1 + 20x_2 + 30x_3 + 80x_4
f = [50; 20; 30; 80];
A = [-400, -200, -150, -500;
    -3, -2, 0, 0;
    -2, -2, -4, -4;
    -2 -4 -1 -5];
b = [-500; -6; -10; -8];
lb = [0;0;0;0];

x = linprog(f, A, b, [], [], lb, []);



%% Quiz 4 - Quadratic Programming
%% example done together

H = [1 -1;
    -1 2];
f = [-1; -1];
A = [1 1;
    -2 -3];
b = [3; 6];
lb = [0; 0];

x = quadprog(H, f, A, b, [], [], lb, []);

%% problem to work on alone
H = [.4 .1 .04;
    .1 .16 .06;
    .04 .06 .36];
f = [0; 0; 0];
A = -1*[.14 .11 .1];
Aeq = [1 1 1];
b = [-120];
beq = [1000];
lb = [0; 0; 0];

x = quadprog(H, [], A, b, Aeq, beq, lb, [])
