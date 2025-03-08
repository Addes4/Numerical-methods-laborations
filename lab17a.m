% Definiera integranden som en funktion
f = @(x) 153 * exp(-(11*x - pi).^2 / 0.004);

% Sätt toleranser för noggrann beräkning
tol = 1e-10;

% Beräkna med quad
[Q_val, Q_err] = quad(f, 0, 6, tol);

% Beräkna med integral
I_val = integral(f, 0, 6, 'AbsTol', tol, 'RelTol', tol);

% Visa resultat
fprintf('\nResultat med quad:\n');
fprintf('Värde: %.12f\n', Q_val);
fprintf('Uppskattad felprecision: %.2e\n', Q_err);

fprintf('\nResultat med integral:\n');
fprintf('Värde: %.12f\n', I_val);

% Plotta integranden för verifiering
x = linspace(0, 6, 1000);
y = f(x);

figure;
plot(x, y, 'LineWidth', 1.5);
grid on;
xlabel('x');
ylabel('f(x)');
title('Integrand: 153e^{-(11x-\pi)^2/0.004}');

% Zooma in där huvuddelen av arean finns
figure;
x_zoom = linspace(0.28, 0.29, 1000);
y_zoom = f(x_zoom);
plot(x_zoom, y_zoom, 'LineWidth', 1.5);
grid on;
xlabel('x');
ylabel('f(x)');
title('Integrand (inzoomad runt maximum)');