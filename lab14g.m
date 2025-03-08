% Definiera datapunkterna
x = [1, 32, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335, 365];

% Konvertera tiden till decimaltimmar
hours = [6, 8, 10, 13, 15, 18, 18, 16, 14, 11, 8, 6, 6];
minutes = [15, 6, 33, 14, 55, 4, 24, 38, 5, 24, 47, 36, 14];
y = hours + minutes/60;

% Definiera frekvensen (w)
w = 2*pi/365;

% Skapa designmatrisen
A = [ones(length(x), 1), cos(w*x'), sin(w*x')];

% Lös minstakvadratproblemet
c = (A'*A)\(A'*y');

% Skapa ett finare grid för plottning
x_fine = 1:1:365;

% Beräkna den anpassade funktionen
y_trig = c(1) + c(2)*cos(w*x_fine) + c(3)*sin(w*x_fine);

% Plotta resultatet
figure;
plot(x_fine, y_trig, 'b-', 'LineWidth', 1.5);
hold on;
plot(x, y, 'ro', 'MarkerFaceColor', 'r');
grid on;
xlabel('Dag på året');
ylabel('Soltimmar');
title('Trigonometrisk minstakvadratanpassning för soluppgångstider');
legend('Trigonometrisk anpassning', 'Datapunkter');

% Snygga till plotten
axis([0 370 5 20]);

% Skriv ut koefficienterna
fprintf('Koefficienterna (c1, c2, c3):\n');
fprintf('c1 = %.4f\n', c(1));
fprintf('c2 = %.4f\n', c(2));
fprintf('c3 = %.4f\n', c(3));

% Beräkna RMS-felet
rms_error = sqrt(mean((y - (c(1) + c(2)*cos(w*x) + c(3)*sin(w*x))).^2));
fprintf('\nRMS-fel: %.4f\n', rms_error);