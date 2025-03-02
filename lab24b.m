clear; clc; close all;

%värden
L = 3.60;
T0 = 310;
TL = 450;

%små steglängder för nogranhet
n1 = 576;
h1 = L/n1;
x1 = linspace(0, L, n1+1)';  % kolumnvektor med n1+1 noder
index1 = round(1.65/h1) + 1; %index för x = 1.65
T_1 = rvp(L, T0, TL, x1, h1);
T_1_165 = T_1(index1);

n2 = 1152;
h2 = L/n2;
x2 = linspace(0, L, n2+1)';
index2 = round(1.65/h2) + 1;
T_2 = rvp(L, T0, TL, x2, h2);
T_2_165 = T_2(index2);

% richard
T_extrap = T_2_165 + (T_2_165 - T_1_165)/3;
err_est = abs(T_extrap - T_2_165);

function T = rvp(L, T0, TL, x, h)
    N = length(x) - 1;
    N_int = N - 1; % inre noder

    A = zeros(N_int, N_int);
    b = zeros(N_int, 1);

    %loop inre noder
    for i = 1:N_int
        idx = i + 1;
        xi = x(idx);
        
        %  k vid halva stegen:
        k_ip = 3 + ((x(idx) + x(idx+1))/2)/7;
        k_im = 3 + ((x(idx-1) + x(idx))/2)/7;
        
        %koefficienter nod idx:
        A(i, i) = (k_ip + k_im) / h^2;
        if i > 1
            A(i, i-1) = -k_im / h^2;
        else
            % anpassa höger med T0
            b(i) = b(i) + k_im * T0 / h^2;
        end
        if i < N_int
            A(i, i+1) = -k_ip / h^2;
        else
            % anpassa höger med TL
            b(i) = b(i) + k_ip * TL / h^2;
        end
        
        %HL: Q = 280*exp(- (x - L/2)^2)
        b(i) = b(i) + 280 * exp(- (xi - L/2)^2);
    end

    % få b
    T_interior = A\b;
    T = [T0; T_interior; TL];
end

disp([' n1 = ', num2str(T_1_165, '%.4f')]);
disp(['n2 = ', num2str(T_2_165, '%.4f')]);
disp(['richard.extr.  = ', num2str(T_extrap, '%.4f')]);
disp([' fel: ', num2str(err_est, '%.4e')]);

figure;
plot(x2, T_2, 'b-o');
grid on;
