clc; clearvars; close all;

% Data
x = [1, 32, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335, 365]; % Dagar på året
timmar = [6, 8, 10, 13, 15, 18, 18, 16, 14, 11, 8, 6, 6];
minuter = [15, 6, 33, 14, 55, 4, 24, 38, 5, 24, 47, 36, 14];

% Konvertera till decimaltimmar
y = timmar + minuter/60;

% Finare grid för hela året
x_fine = 1:1:365;


%Subplot för jämförelse
figure('Position', [100, 100, 1200, 800]);

%% A) Interpolationspolynom
subplot(4,2,1);
coeff_A = polyfit(x, y, length(x)-1); % Grad 12-polynom
y_A = polyval(coeff_A, x_fine);
plot(x_fine, y_A, 'b-', 'LineWidth', 1.5); hold on;
plot(x, y, 'ro', 'MarkerFaceColor', 'r');
title('A) Interpolationspolynom');
grid on;

%% B) Styckvis linjär interpolation
subplot(4,2,2);
y_B = interp1(x, y, x_fine, 'linear');
plot(x_fine, y_B, 'g-', 'LineWidth', 1.5); hold on;
plot(x, y, 'ro', 'MarkerFaceColor', 'r');
title('B) Styckvis Linjär Interpolation');
grid on;

%% C) Splines-approximation
subplot(4,2,3);
y_C = spline(x, y, x_fine);
plot(x_fine, y_C, 'm-', 'LineWidth', 1.5); hold on;
plot(x, y, 'ro', 'MarkerFaceColor', 'r');
title('C) Cubic Spline');
grid on;

%% D) Andragradspolynom (1 juni till 1 augusti)
subplot(4,2,4);
idx_D = find(x >= 152 & x <= 213); % Juni-Augusti
coeff_D = polyfit(x(idx_D), y(idx_D), 2);
y_D = polyval(coeff_D, x_fine);
plot(x_fine, y_D, 'c-', 'LineWidth', 1.5); hold on;
plot(x, y, 'ro', 'MarkerFaceColor', 'r');
title('D) 2:a-gradspolynom (Juni–Augusti)');
grid on;

%% E) Minstakvadratanpassat 2:a-gradspolynom (April–September)
subplot(4,2,5);
idx_E = find(x >= 91 & x <= 244); % April–September
coeff_E = polyfit(x(idx_E), y(idx_E), 2);
y_E = polyval(coeff_E, x_fine);
plot(x_fine, y_E, 'k-', 'LineWidth', 1.5); hold on;
plot(x, y, 'ro', 'MarkerFaceColor', 'r');
title('E) Minstakvadrat (April–Sept)');
grid on;

%% F) Minstakvadratanpassat 2:a-gradspolynom (Hela året)
subplot(4,2,6);
coeff_F = polyfit(x, y, 2);
y_F = polyval(coeff_F, x_fine);
plot(x_fine, y_F, 'y-', 'LineWidth', 1.5); hold on;
plot(x, y, 'ro', 'MarkerFaceColor', 'r');
title('F) Minstakvadrat (Hela Året)');
grid on;

%% G) Trigonometrisk Anpassning (cos & sin)
subplot(4,2,[7,8]);
w = 2*pi/365;
X_G = [ones(length(x),1), cos(w*x(:)), sin(w*x(:))];
c_G = X_G \ y(:); % Minstakvadratanpassning
y_G = c_G(1) + c_G(2)*cos(w*x_fine) + c_G(3)*sin(w*x_fine);
plot(x_fine, y_G, 'r-', 'LineWidth', 1.5); hold on;
plot(x, y, 'ro', 'MarkerFaceColor', 'r');
title('G) Trigonometrisk Anpassning');
grid on;

% Gemensamma etiketter
sgtitle('Anpassning av Soltimmar i Stockholm (A–G)', 'FontSize', 14);

%% 🔍 Hitta årets längsta dag för alla metoder
[max_A, idx_A] = max(y_A);
[max_B, idx_B] = max(y_B);
[max_C, idx_C] = max(y_C);
[max_D, idx_D_max] = max(y_D);
[max_E, idx_E_max] = max(y_E);
[max_F, idx_F_max] = max(y_F);
[max_G, idx_G] = max(y_G);

% Resultattabell
fprintf('--- Årets Längsta Dag (Max Soltimmar) ---\n');
fprintf('A) Dag %d, %.2f timmar\n', x_fine(idx_A), max_A);
fprintf('B) Dag %d, %.2f timmar\n', x_fine(idx_B), max_B);
fprintf('C) Dag %d, %.2f timmar\n', x_fine(idx_C), max_C);
fprintf('D) Dag %d, %.2f timmar\n', x_fine(idx_D_max), max_D);
fprintf('E) Dag %d, %.2f timmar\n', x_fine(idx_E_max), max_E);
fprintf('F) Dag %d, %.2f timmar\n', x_fine(idx_F_max), max_F);
fprintf('G) Dag %d, %.2f timmar\n', x_fine(idx_G), max_G);

julafton = 358;

% Beräkna soltiden för varje metod
soltid_A = polyval(coeff_A, julafton);
soltid_B = interp1(x, y, julafton, 'linear');
soltid_C = spline(x, y, julafton);
soltid_D = polyval(coeff_D, julafton);
soltid_E = polyval(coeff_E, julafton);
soltid_F = polyval(coeff_F, julafton);
soltid_G = c_G(1) + c_G(2)*cos(w*julafton) + c_G(3)*sin(w*julafton);

% Resultattabell
fprintf('--- Soltid på Julafton (24 december, dag 358) ---\n');
fprintf('A) %.2f timmar\n', soltid_A);
fprintf('B) %.2f timmar\n', soltid_B);
fprintf('C) %.2f timmar\n', soltid_C);
fprintf('D) %.2f timmar\n', soltid_D);
fprintf('E) %.2f timmar\n', soltid_E);
fprintf('F) %.2f timmar\n', soltid_F);
fprintf('G) %.2f timmar\n', soltid_G);
