% Define function
f = @(x) 61*x - ((x.^2 + x + 0.03)./(3x + 1)).^7 - 20*x.*exp(-x);

% Plot with adjusted y-limits
x = linspace(-0.5, 0.5, 2000);
plot(x, f(x))
grid on
title('f(x) runt origo')
xlabel('x')
ylabel('f(x)')
ylim([-10, 10])  % Justerat y-intervall
yline(0, '--')