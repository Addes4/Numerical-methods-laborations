clc, clearvars

% Definiera data
x = [1 2 3 4 5 6 7 8 9 10 11 12 12.97]; % Månad som numeriskt värde
y = [6.25 8.10 10.55 13.2333 15.9167 18.0667 18.40 16.6333 14.0833 11.40 8.7833 6.60 6.2333]; % Tid i timmar

% Anpassa ett andragradspolynom
p = polyfit(x, y, 2);

% Visa koefficienterna
disp('Koefficienter för andragradspolynomet:');
disp(p);

% Plot för att visualisera anpassningen
x_fit = linspace(1, 13, 100); % Skapa ett finare x-nät
y_fit = polyval(p, x_fit); % Beräkna y-värden med polynomet

plot(x, y, 'ro', 'MarkerFaceColor', 'r'); % Rita data
hold on;
plot(x_fit, y_fit, 'b-', 'LineWidth', 2); % Rita det anpassade polynomet
xlabel('Månad (Januari = 1, December = 12)');
ylabel('Tid (h)');
title('Minstakvadratanpassat andragradspolynom');
grid on;
hold off;
