clear; clc; close all;

L = 3.60;
T0 = 310;
TL = 450;

k = @(x) 3 + x/7;
kprime = @(x) 1/7;

Q = @(x) 280 * exp(- (x - L/2).^2);

odefunk = @(x, y) [ y(2); (- Q(x) - kprime(x)*y(2)) / k(x) ];

%funk. för inskjutningsmetoden
shootF = @(s) ode_los(s, L, T0, odefunk) - TL;

% initial gissning för s
s0 = (TL - T0) / L;  %ca 38.89

%fzero att hitta s som gör shootF(s) = 0:
s_correct = fzero(shootF, s0);

%lös ODE med start.deriv.
[x_sol, Y_sol] = ode45(odefunk, [0, L], [T0; s_correct]);

% temp x = 1.65 med interpol.
T_at_165 = interp1(x_sol, Y_sol(:,1), 1.65, 'pchip'); %slät interp.

disp(['T(1.65) i K= ', num2str(T_at_165, '%.4f')]);

figure;
plot(x_sol, Y_sol(:,1));
grid on;

function T_L = ode_los(s, L, T0, odefunk) %löser IVP m start T(0)=T0 och T'(0)=s över [0,L] med ode45 och ger T(L)
    [~, Y_temp] = ode45(odefunk, [0, L], [T0; s]);
    T_L = Y_temp(end, 1);
end
