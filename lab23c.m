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

function anim(tut, fiut, L)
    for i = 1:length(tut)-1
        % ber pendels ände
        x0 = L * sin(fiut(i));
        y0 = -L * cos(fiut(i));
        
        %  rita pendel
        plot([0, x0], [0, y0], '-o', 'LineWidth', 2, 'MarkerSize', 8);
        axis('equal');
        axis([-2 2 -2 2]*1.2*L);
        xlabel('x');
        ylabel('y');
        title('Pendels animering');
        grid on;
        
        % upd bild
        drawnow;
        % paus i exakt den tid som gått mellan nuvarande och nästa tidpunkt
        pause(tut(i+1) - tut(i));
    end
end
anim(t, y(:,1), L);
