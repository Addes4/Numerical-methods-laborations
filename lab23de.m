clear; clc; close all;

L = 2.5;
g = 9.81;
fi0 = 6*pi/7;   % initial vinkel
omega0 = 0.8;   % initial vinkelhastighet
y0 = [fi0; omega0];  % startvärden

tspan = [0, 12];

function dydt = pendulum_ode(~, y, L, g)
    dydt = [y(2); - (g/L)*sin(y(1))];
end

%Lös ode45
options = odeset('RelTol', 1e-8, 'AbsTol', 1e-10);
[t, y] = ode45(@(t,y) pendulum_ode(t,y,L,g), tspan, y0, options);
fi = y(:,1);  % vinkelkurv

%  lokala max m kvad. interp
max_times = [];

%loopar 2 till length(fi)-1 så alltid har 3p
for i = 2:length(fi)-1
    if fi(i) > fi(i-1) && fi(i) >= fi(i+1)
        %  3p
        t_local = t(i-1:i+1);
        fi_local = fi(i-1:i+1);
        % 2agradspol
        p = polyfit(t_local, fi_local, 2);
        %om p(1 negativ använd fminbnd för att exakt hitta vertexen
        if p(1) < 0
            f_interp = @(tt) -polyval(p, tt);% minimerar -p(tt) så hitta max
            t_vertex = fminbnd(f_interp, t_local(1), t_local(end));
        else
            %om ej, tbx t enkla formeln
            t_vertex = -p(2)/(2*p(1));
        end
        max_times = [max_times; t_vertex];
    end
end

periods = diff(max_times);% per mellan på varandra följ max
period_avg = mean(periods);

disp([' period = ', num2str(period_avg, '%.3f')]);

figure;
plot(t, fi, 'b-', 'LineWidth',2);
hold on;
fi_max = interp1(t, fi, max_times, 'pchip');
plot(max_times, fi_max, 'ro', 'MarkerFaceColor','r');
xlabel('tid');
ylabel('fi');
grid on;
