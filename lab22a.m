clear; clc; close all;

function dydx = f_ode(x, y)
    dydx = - (1/6 + (pi * sin(pi * x))/(1.6 - cos(pi * x))) * y;
end

function [x, y] = rk4(f, x0, y0, h, L)
    %vektor för xvärden
    x = x0:h:L;
    N = length(x);
    y = zeros(1, N);
    y(1) = y0;

    %  RK4
    for i = 1:N-1
        k1 = f(x(i), y(i));
        k2 = f(x(i) + h/2, y(i) + h*k1/2);
        k3 = f(x(i) + h/2, y(i) + h*k2/2);
        k4 = f(x(i) + h, y(i) + h*k3);
        y(i+1) = y(i) + (h/6)*(k1 + 2*k2 + 2*k3 + k4);
    end
end


function I = trapregel(x, f_vals)
    I = 0;
    N = length(x);
    for i = 1:N-1
        I = I + (x(i+1) - x(i)) * (f_vals(i) + f_vals(i+1)) / 2;
    end
end

L = 4.00;
x0 = 0;
y0 = 2.5;

% steglängder richardsson
h1 = 0.01;
h2 = 0.005;

%RK4
[x1, y1] = rk4(@f_ode, x0, y0, h1, L);
[x2, y2] = rk4(@f_ode, x0, y0, h2, L);

%vollymen
V1 = pi * trapregel(x1, y1.^2);
V2 = pi * trapregel(x2, y2.^2);

% richard
V_extrap = V2 + (V2 - V1)/3;
fel = abs(V_extrap - V2);

disp(['volym = ', num2str(V_extrap)]);
disp([' felgräns = ', num2str(fel)]);
