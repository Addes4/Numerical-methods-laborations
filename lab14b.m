clc, clearvars
% Definiera datapunkterna
% Dagar på året (x-värden)
x = [1, 32, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335, 365];

% Konvertera tiden till decimaltimmar (y-värden)
hours = [6, 8, 10, 13, 15, 18, 18, 16, 14, 11, 8, 6, 6];
minutes = [15, 6, 33, 14, 55, 4, 24, 38, 5, 24, 47, 36, 14];
y = hours + minutes/60;

% Skapa ett finare grid för plottning
x_fine = 1:1:365;

% Använd linjär interpolation
y_interp = interp1(x, y, x_fine, 'linear');

% Plotta resultatet
figure;
plot(x_fine, y_interp, 'b-', 'LineWidth', 1.5);
hold on;
plot(x, y, 'ro', 'MarkerFaceColor', 'r');
grid on;
xlabel('Dag på året');
ylabel('Soltimmar');
title('Styckvis linjär interpolation för soluppgångstider i Stockholm');
legend('Linjär interpolation', 'Datapunkter');

% Snygga till plotten
axis([0 370 5 20]);