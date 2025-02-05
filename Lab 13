% Laboration 1, uppgift 3

% a)
% def funktionen f
f = @(x) 61*x - ((x.^2 + x + 0.03) ./ (3*x + 1)).^7 - 20*x.*exp(-x);

% sekantmetoden som en funktion
function [root] = sekant_method(x0, x1, f)
tol = 1e-8; % Toleransen för noggranhet
max_iter = 100; % Max antal iterationer
iter = 0; % börjar på 0
while iter < max_iter

% räkna nästa approx. med sekantmetoden
x_new = x1 - f(x1) * (x1 - x0) / (f(x1) - f(x0));

% checka konvergens
if abs(x_new - x1) < tol
            root = x_new;
            return;
end

% uppdatera värden för nästa iteration
x0 = x1;
x1 = x_new;
iter = iter + 1;
end
root = x_new;
end

% Startvärden för sekantmetoden
x0_1 = 0.01; % 1a startvärdet för den mindre roten
x1_1 = 0.1; % 2a startvärdet för den mindre roten
x0_2 = 6.0; % 1a startvärdet för den större roten
x1_2 = 6.5; % 2a startvärdet för den större roten

% räkna rötterna och felen med sekantmetoden
[root1] = sekant_method(x0_1, x1_1, f);
[root2] = sekant_method(x0_2, x1_2, f);


% resultaten
fprintf('minsta roten: %.8f\n', root1);
fprintf('största roten: %.8f\n', root2);

%%
% d)

% def funktionen f
f = @(x) 61*x - ((x.^2 + x + 0.03) ./ (3*x + 1)).^7 - 20*x.*exp(-x);

% sekantmetoden som en funktion
function [root, errors] = sekant_method(x0, x1, f)
tol = 1e-8; % Toleransen för noggranhet
max_iter = 100; % Max antal iterationer
iter = 0; % börjar på 0
errors = []; %lista för fel
while iter < max_iter

% räkna nästa approx. med sekantmetoden
x_new = x1 - f(x1) * (x1 - x0) / (f(x1) - f(x0));

% ger felet
error = abs(x_new - x1);
errors = [errors; error];

% checka konvergens
if error < tol
break;
end

% uppdatera värden för nästa iteration
x0 = x1;
x1 = x_new;
iter = iter + 1;
end
root = x_new;
end

% Startvärden för sekantmetoden
x0_1 = 0.01; % 1a startvärdet för den mindre roten
x1_1 = 0.1; % 2a startvärdet för den mindre roten
x0_2 = 6.0; % 1a startvärdet för den större roten
x1_2 = 6.5; % 2a startvärdet för den större roten

% räkna rötterna och felen med sekantmetoden
[root1, errors1] = sekant_method(x0_1, x1_1, f);
[root2, errors2] = sekant_method(x0_2, x1_2, f);

% ger konvergensordningen alfa (p)
alpha_vals = log(errors2(3:end) ./ errors2(2:end-1)) ./ log(errors2(2:end-1) ./ errors2(1:end-2));
alpha = mean(alpha_vals);

% ger konvergenskonstanten (C)
C_vals = errors2(3:end) ./ (errors2(2:end-1) .^ alpha);
C = mean(C_vals);

% resultaten
fprintf('minsta roten: %.8f\n', root1);
fprintf('största roten: %.8f\n', root2);
fprintf('konvergensordning: %.6f\n', alpha);
fprintf('konvergenskonstant: %.6e\n', C);
