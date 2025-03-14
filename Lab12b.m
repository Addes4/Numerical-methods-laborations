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
