clc, clearvars
% Definiera alla datapunkter för plottning
x_all = [1, 32, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335, 365];
hours = [6, 8, 10, 13, 15, 18, 18, 16, 14, 11, 8, 6, 6];
minutes = [15, 6, 33, 14, 55, 4, 24, 38, 5, 24, 47, 36, 14];
y_all = hours + minutes/60;

% Välj ut data för juni-augusti (index 6-8 i vår data)
x_summer = x_all(6:8);  % Dagar för 1 juni, 1 juli, 1 augusti
y_summer = y_all(6:8);  % Motsvarande soltimmar

% Beräkna andragradspolynomet med bara sommardata
p = polyfit(x_summer, y_summer, 2);

% Skapa ett finare grid för plottning
x_fine = 1:1:365;

% Beräkna polynomvärden för hela året
y_quad = polyval(p, x_fine);

% Plotta resultatet
figure;
% Plotta andragradspolynomet för hela året
plot(x_fine, y_quad, 'b-', 'LineWidth', 1.5);
hold on;
% Plotta alla datapunkter
plot(x_all, y_all, 'ro', 'MarkerFaceColor', 'none');
% Markera sommarpunkterna som användes för anpassningen
plot(x_summer, y_summer, 'ro', 'MarkerFaceColor', 'r');
grid on;

xlabel('Dag på året');
ylabel('Soltimmar');
title('Andragradspolynom anpassat till sommardata (1 juni - 1 augusti)');
legend('Andragradspolynom', 'Alla datapunkter', 'Använda datapunkter (sommar)');

% Snygga till plotten
axis([0 370 5 20]);

% Visa polynomets koefficienter
fprintf('Andragradspolynomet är: y = %.6fx² + %.6fx + %.6f\n', p(1), p(2), p(3));