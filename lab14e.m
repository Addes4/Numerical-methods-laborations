% Definiera data
x = [1 2 3 4 5 6]; % Månadsindex (April = 1, Maj = 2, ..., September = 6)
y = [13.2333 15.9167 18.0667 18.4000 16.6333 14.0833]; % Tid i timmar

% Anpassa ett andragradspolynom
p = polyfit(x, y, 2);

% Visa koefficienterna
disp('Koefficienter för andragradspolynomet:');
disp(p);

% Plot för att visualisera anpassningen
x_fit = linspace(1,6,100); % Skapa ett finare x-nät
y_fit = polyval(p, x_fit); % Beräkna y-värden med polynomet

plot(x, y, 'ro', 'MarkerFaceColor', 'r'); % Rita data
hold on;
plot(x_fit, y_fit, 'b-', 'LineWidth', 2); % Rita det anpassade polynomet
xlabel('Månad (April = 1, September = 6)');
ylabel('Tid (h)');
title('Minstakvadratanpassat andragradspolynom');
grid on;
hold off;
