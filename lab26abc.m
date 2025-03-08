clear; clc; close all;

function [u, iter] = newtonsmet(u0, tol, max_iter)
    u = u0; %startvärde
    for iter = 1:max_iter
        F_varde = F(u);    %sys. värde
        J_varde = J(u);    %jakobi
        delta = -J_varde \ F_varde;
        u = u + delta; % upd av lös
        if norm(delta, inf) < tol %avlsut om konv.
            break;
        end
    end
end

function F_varde = F(u)
    X = u(1);
    Y = u(2);
    R = u(3);
    F_varde = zeros(3,1);
    F_varde(1) = (10 - X)^2 + (10 - Y)^2 - R^2;
    F_varde(2) = (12 - X)^2 + (2 - Y)^2 - R^2;
    F_varde(3) = (3 - X)^2 + (8 - Y)^2 - R^2;
end

function J_varde = J(u)
    X = u(1);
    Y = u(2);
    R = u(3);
    J_varde = zeros(3,3);
    % ekv1
    J_varde(1,1) = 2*(X - 10);
    J_varde(1,2) = 2*(Y - 10);
    J_varde(1,3) = -2*R;
    % ekv2
    J_varde(2,1) = 2*(X - 12);
    J_varde(2,2) = 2*(Y - 2);
    J_varde(2,3) = -2*R;
    % ekv3
    J_varde(3,1) = 2*(X - 3);
    J_varde(3,2) = 2*(Y - 8);
    J_varde(3,3) = -2*R;
end

u0 = [7; 7; 4.24]; % u0 = X0, Y0, R0

tol = 1e-6;
max_iter = 100;

% lös
[u, iter] = newtonsmet(u0, tol, max_iter);
X = u(1);
Y = u(2);
R = u(3);

punkter = [10, 10;
            12, 2;
             3, 8];

%vinkelvektor
fi = linspace(0, 2*pi, 100);
x_cirkel = X + R * cos(fi);
y_cirkel = Y + R * sin(fi);

disp(['medel=(', num2str(X, '%.5f'), ', ', num2str(Y, '%.5f'), ')']);
disp([' R= ', num2str(R, '%.5f')]);

figure;
hold on;
plot(x_cirkel, y_cirkel);
plot(punkter(:,1), punkter(:,2), 'ro', 'MarkerFaceColor', 'r');
plot(X, Y, 'kx');
axis equal;
grid on;
