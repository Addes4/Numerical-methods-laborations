clear; clc; close all;

L = 2.5;
g = 9.81;
phi0 = 6*pi/7; %init vinkel
omega0 = 0.8; % init vinkelhast
y0 = [phi0; omega0];  % startvärden

tspan = [0, 12];

%Lös ode45
[t, y] = ode45(@(t,y) pendulum_ode(t, y, L, g), tspan, y0);
fi = y(:,1);  %vinkelkurv

%  lokala max m kvad. interp
max_times = [];

%loopar 2 till length(fi)-1 så alltid har 3p
for i = 2:length(fi)-1
    if fi(i) > fi(i-1) && fi(i) >= fi(i+1)
        % 3p
        t_local = t(i-1:i+1);
        fi_local = fi(i-1:i+1);
        %2agradspol
        p = polyfit(t_local, fi_local, 2);
        % vertex ber.
        t_vertex = -p(2)/(2*p(1));
        max_times = [max_times; t_vertex];
    end
end

function dydt = pendulum_ode(~, y, L, g)
    % y(1) = fi, y(2) = fi'
    % y1' = y2
    % y2' = - (g/L)*sin(y1)
    dydt = [y(2); - (g/L)*sin(y(1))];
end

%perioder
if length(max_times) < 2
    error('Färre än två maximum hittades – öka tidsintervallet eller lösningens noggrannhet.');
end
periods = diff(max_times);   % per. mellan på varandra följande max
period_avg = mean(periods);    % medelper.

disp(['pemdels period: ', num2str(period_avg, '%.3f')]);

figure;
plot(t, fi, 'b-');
hold on;
% Interpolera phi vid de raffinerade maximum-tidpunkterna (använd pchip)
phi_max = interp1(t, fi, max_times, 'pchip');
plot(max_times, phi_max, 'ro', 'MarkerFaceColor', 'r');
xlabel('Tid');
ylabel('fi');
grid on;
