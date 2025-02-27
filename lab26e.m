clear; clc; close all;

function [u, iter] = gaussNewton(u0, tol, maxIter, data)
    u = u0;
    for iter = 1:maxIter
        r = residuals(u, data);  % ber res
        J = jac_res(u, data); % ber jac
        delta = - (J' * J) \ (J' * r);
        u = u + delta;
        if norm(delta, inf) < tol
            break;
        end
    end
end

function r = residuals(u, data)
    X = u(1); Y = u(2); R = u(3);
    n = size(data, 1);
    r = zeros(n, 1);
    for i = 1:n
        x_i = data(i, 1);
        y_i = data(i, 2);
        if i == 3
            r(i) = 3 * ( (x_i - X)^2 + (y_i - Y)^2 - R^2 );
        else
            r(i) = (x_i - X)^2 + (y_i - Y)^2 - R^2;
        end
    end
end


function J = jac_res(u, data)
    X = u(1); Y = u(2); R = u(3);
    n = size(data, 1);
    J = zeros(n, 3);
    for i = 1:n
        x_i = data(i, 1);
        y_i = data(i, 2);
        if i == 3
            J(i,1) = 3 * (-2*(x_i - X));
            J(i,2) = 3 * (-2*(y_i - Y));
            J(i,3) = 3 * (-2*R);
        else
            J(i,1) = -2*(x_i - X);
            J(i,2) = -2*(y_i - Y);
            J(i,3) = -2*R;
        end
    end
end

punkter = [10, 10;
        12, 2;
         3, 8;
        11, 11;
         2, 9];

% start giss
% mittp. = medel av p.
% R medel avs.
X0 = mean(punkter(:,1));
Y0 = mean(punkter(:,2));
R0 = mean(sqrt((punkter(:,1)-X0).^2 + (punkter(:,2)-Y0).^2));
u0 = [X0; Y0; R0];

tol = 1e-6;
maxiter = 100;

% anrop
[u, iter] = gaussNewton(u0, tol, maxiter, punkter);

% cirk param
X = u(1);
Y = u(2);
R = u(3);

disp(['medel = (', num2str(X, '%.4f'), ', ', num2str(Y, '%.4f'), ')']);
disp([' radie= ', num2str(R, '%.4f')]);

% visa
fi = linspace(0, 2*pi, 100);
x_circ = X + R * cos(fi);
y_circ = Y + R * sin(fi);

figure;
hold on;
plot(x_circ, y_circ, 'b-');
plot(punkter(:,1), punkter(:,2), 'ro', 'MarkerFaceColor', 'r');
plot(X, Y, 'kx');
axis equal;
grid on;
