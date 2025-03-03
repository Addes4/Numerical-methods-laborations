clear; clc; close all;

L = 3.60;
T0 = 310;
TL = 450;

k = @(x) 3 + x/7;
kprim = @(x) 1/7;
Q = @(x) 280 * exp(- (x - L/2).^2);

odefunk = @(x, y) [ y(2); (- Q(x) - kprim(x)*y(2)) / k(x) ];

%funk. för inskjutningsmetoden
shootF = @(s) ode_los(s, L, T0, odefunk) - TL;

%  initial gissning för s
s0 = (TL - T0) / L;  % ca 38.89

%fzero att hitta s som gör shootF(s) = 0
s_correct = fzero(shootF, s0);

%lös ODE med toleranser
options_loose = odeset('RelTol',1e-6, 'AbsTol',1e-8);
options_strict = odeset('RelTol',1e-10, 'AbsTol',1e-12);

% lös m lätta toleranser
[x_sol_loose, Y_sol_loose] = ode45(odefunk, [0, L], [T0; s_correct], options_loose);
% lös m sktrika toleranser
[x_sol_strict, Y_sol_strict] = ode45(odefunk, [0, L], [T0; s_correct], options_strict);

% interp. båda lösningarna (använder pchip för slät interpolation)
T_at_165_loose = interp1(x_sol_loose, Y_sol_loose(:,1), 1.65, 'pchip');
T_at_165_strict = interp1(x_sol_strict, Y_sol_strict(:,1), 1.65, 'pchip');

%  skillnaden de två lösningarna
error_est = abs(T_at_165_strict - T_at_165_loose);

function T_L = ode_los(s, L, T0, odefunk) %löser IVP m start T(0)=T0 och T'(0)=s över [0,L] med ode45 och ger T(L)
    [~, Y_temp] = ode45(odefunk, [0, L], [T0; s]);
    T_L = Y_temp(end, 1);
end

disp(['T(1.65)  = ', num2str(T_at_165_strict, '%.4f')]);
disp([' fel = ', num2str(error_est, '%.4e')]);

figure;
plot(x_sol_strict, Y_sol_strict(:,1), 'b-');
xlabel('x');
ylabel('T');
grid on;
