% Lab 1, uppgift 2b

% def funktionen f(x)
f = @(x) 61*x - ((x.^2 + x + 0.03) ./ (3*x + 1)).^7 - 20*x.*exp(-x);

%  brett intervall för att hitta rötterna
x = linspace(-1, 10, 1000);
y = f(x);

% plot för översikt av hela funktionen
figure;
subplot(2,2,[3 4]);
x_zoom1 = linspace(-4, 4, 500);
plot(x, y, 'b', 'LineWidth', 2);
yline(0, 'k--'); % nollinje
xlabel('x');
ylabel('f(x)');
title('Översikt');
grid on;
xlim([-10, 10]);
ylim([-20, 20]);

% minsta roten
subplot(2,2,1); 
x_zoom1 = linspace(-0.001, 0.001, 500);
y_zoom1 = f(x_zoom1);
plot(x_zoom1, y_zoom1, 'r', 'LineWidth', 2);
yline(0, 'k--');
xlabel('x');
ylabel('f(x)');
title('Minsta positiva roten');
grid on;

% största positiva roten
subplot(2,2,2);
x_zoom2 = linspace(5, 9, 500);
y_zoom2 = f(x_zoom2);
plot(x_zoom2, y_zoom2, 'g', 'LineWidth', 2);
yline(0, 'k--');
xlabel('x');
ylabel('f(x)');
title('Största positiva roten');
grid on;


%%


% Lab 1, uppgift 2c

% funktionen f(x) och dess derivata f'(x)
f = @(x) 61*x - ((x.^2 + x + 0.03) ./ (3*x + 1)).^7 - 20*x.*exp(-x);
df = @(x) 61 - 7 * ((x.^2 + x + 0.03).^(6) .* (2*x + 1)) ./ ((3*x + 1).^(7)) ...
         - 20*exp(-x) + 20*x.*exp(-x);  % Derivata efter kedjeregel

% Newtons metod
tol = 1e-10; % Tolerans för konvergens
max_iter = 100; % max antal iterationer

% Funktion för Newton
newton = @(x0) newton_method(f, df, x0, tol, max_iter);

% startvärden
x_min_root = newton(0.1); % minsta roten
x_max_root = newton(7);   % största roten

% resultat
fprintf('Minsta positiva roten: x = %.10f\n', x_min_root);
fprintf('Största positiva roten: x = %.10f\n', x_max_root);

% Newtons metod implementerad som funktion
function root = newton_method(f, df, x0, tol, max_iter)
    x = x0;
    for i = 1:max_iter
        x_new = x - f(x) / df(x);  % Newtons steg
        if abs(x_new - x) < tol
            root = x_new;
            return;
        end
        x = x_new;
    end
    error('Newtons metod konvergerade inte!');
end


%%


% Lab 1, uppgift 2e

% def f(x)
f = @(x) 61*x - ((x.^2 + x + 0.03) ./ (3*x + 1)).^7 - 20*x.*exp(-x);

% derivatan f'(x)
df = @(x) 61 - 20*exp(-x) + ...
(-7 * ((x.^2 + x + 0.03) ./ (3*x + 1)).^6) .* ...
((2*x + 1) .* (3*x + 1) - (x.^2 + x + 0.03) .* 3) ./ (3*x + 1).^2;

% Andra derivatan f''(x)
d2f = @(x) (df(x + 1e-5) - df(x - 1e-5)) / (2e-5);

% Största roten från Newtons metod
x_star = 6.396;

% konvergenskonstanten C
C = abs(d2f(x_star)) / (2 * abs(df(x_star)));

% resultatet
fprintf('Konvergenskonstanten vid x* = %.6f är C = %.6e\n', x_star, C);
