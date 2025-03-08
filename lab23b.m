clear; clc; close all;

L = 2.5;
g = 9.81;

phi0 = 6*pi/7;   % initial vinkel
omega0 = 0.8;    %init vinkelhast
y0 = [phi0; omega0];

T = 12;
tspan = [0 T];

[t, y] = ode45(@(t, y) pendulum_ode(t, y, L, g), tspan, y0);

fi = y(:,1);      % vikel fi
omega = y(:,2);    % vinkelhast fi'

function dydt = pendulum_ode(~, y, L, g)
    dydt = zeros(2,1);
    dydt(1) = y(2);
    dydt(2) = - (g/L) * sin(y(1));
end

figure;
subplot(2,1,1);
plot(t, fi, 'b-');
xlabel('Tid');
ylabel('fi');
title('Pendels vinkel');
grid on;

subplot(2,1,2);
plot(t, omega, 'r-');
xlabel('Tid');
ylabel('fi');
title('pendels vinkelhastighet');
grid on;
