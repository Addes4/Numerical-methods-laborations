% Använd symboliska beräkningar
syms x
f = (1 - exp(-(x/5)^3))/(5*x^3);
% Beräkna Taylorserien symboliskt
T = taylor(f, x, 'Order', 4);

% Konvertera till numerisk funktion
T_func = matlabFunction(T);

% Skapa x-värden och beräkna värden
x_vals = linspace(1e-20, 1e-4, 1000);
y_vals = T_func(x_vals);

% Plotta resultatet
figure;
plot(x_vals, y_vals, 'r--', 'LineWidth', 1.5);
xlabel('x');
ylabel('Taylor approx');
title('Taylorserie approx');
grid on;

