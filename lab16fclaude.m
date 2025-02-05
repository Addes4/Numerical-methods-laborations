clc, clearvars, close all

% 1. x₀-fel vid startpunkten
B = 3200;  % Övre gräns
x0_error = 1e-4 / (10*B^2);

% 2. Svansfel (från B till oändlighet)
tail_error = 1/(B^3);  % Korrigerad tail error

% Resten av koden fortsätter som tidigare...
function result = calc_taylor_integral(h, a, b)
    n = round((b-a)/h);
    x_values = linspace(a,b,n+1);
    y_values = (1/625) - (x_values.^3)/156250;
    result = h * (sum(y_values) - (y_values(1)/2 + y_values(end)/2));
end

function result = calc_main_integral(h, a, b)
    n = round((b-a)/h);
    x_values = linspace(a,b,n+1);
    y_values = (1-exp(-(x_values./5).^3))./(5.*x_values.^3);
    result = h * (sum(y_values) - (y_values(1)/2 + y_values(end)/2));
end

% Beräkna trunkferingsfel för Taylor-delen
a1 = 0;
b1 = 1.09745e-5;
h1 = (b1-a1)/100000;
taylor_h = calc_taylor_integral(h1, a1, b1);
taylor_2h = calc_taylor_integral(2*h1, a1, b1);
taylor_error = abs(taylor_2h - taylor_h)/3;

% Beräkna trunkferingsfel för huvudintegralen
a2 = 1.09745e-5;
b2 = 3200;
h2 = (b2-a2)/10000000;
main_h = calc_main_integral(h2, a2, b2);
main_2h = calc_main_integral(2*h2, a2, b2);
main_error = abs(main_2h - main_h)/3;

% Totalt fel (summa av alla felkällor)
total_error = x0_error + tail_error + taylor_error + main_error;

disp('Felskattningar:')
fprintf('x₀-fel: %.2e\n', x0_error)
fprintf('Taylor-del fel: %.2e\n', taylor_error)
fprintf('Huvudintegral fel: %.2e\n', main_error)
fprintf('Svansfel (tail error): %.2e\n', tail_error)
fprintf('Totalt uppskattat fel: %.2e\n', total_error)