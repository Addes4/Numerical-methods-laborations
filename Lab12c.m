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
