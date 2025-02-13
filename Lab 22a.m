% Huvudprogram
% Spara denna fil som 'berakna_volym.m'
function [V, fel] = berakna_volym()
    % Parametrar
    L = 4.00;
    y0 = 2.5;
    steglangder = [0.1, 0.05, 0.025];
    volymer = zeros(size(steglangder));
    
    % Beräkna volymer för olika steglängder
    for i = 1:length(steglangder)
        h = steglangder(i);
        [x, y] = runge_kutta4(y0, 0, L, h);
        volymer(i) = trapets(x, y);
        fprintf('h = %.3f: V = %.6f\n', h, volymer(i));
    end
    
    % Richardson-extrapolation
    V_rich1 = richardson_extrapolation(steglangder(2), steglangder(1), volymer(2), volymer(1), 4);
    V_rich2 = richardson_extrapolation(steglangder(3), steglangder(2), volymer(3), volymer(2), 4);
    
    fprintf('\nRichardson-extrapolation:\n');
    fprintf('Mellan h = %.3f och %.3f: V = %.6f\n', steglangder(2), steglangder(1), V_rich1);
    fprintf('Mellan h = %.3f och %.3f: V = %.6f\n', steglangder(3), steglangder(2), V_rich2);
    
    % Uppskatta felgränsen
    fel = abs(V_rich2 - V_rich1);
    fprintf('\nUppskattad felgräns: %.2e\n', fel);
    
    V = V_rich2;  % Använd det mest förfinade värdet
end

% Differentialekvationsfunktion
function dydt = f(x, y)
    dydt = -(1/6 + pi * sin(pi*x)/(1.6 - cos(pi*x))) * y;
end

% Runge-Kutta metod
function [x, y] = runge_kutta4(y0, a, b, h)
    n = floor((b - a) / h);
    x = linspace(a, b, n+1);
    y = zeros(size(x));
    y(1) = y0;
    
    for i = 1:n
        k1 = h * f(x(i), y(i));
        k2 = h * f(x(i) + h/2, y(i) + k1/2);
        k3 = h * f(x(i) + h/2, y(i) + k2/2);
        k4 = h * f(x(i) + h, y(i) + k3);
        y(i+1) = y(i) + (k1 + 2*k2 + 2*k3 + k4) / 6;
    end
end

% Trapetsregeln
function V = trapets(x, y)
    y_squared = y .* y;
    h = x(2) - x(1);
    V = pi * h * (sum(y_squared(2:end-1)) + (y_squared(1) + y_squared(end))/2);
end

% Richardson-extrapolation
function V_extrap = richardson_extrapolation(h1, h2, V1, V2, p)
    r = h1/h2;
    V_extrap = (r^p * V2 - V1)/(r^p - 1);
end
