clear; clc; close all;

x1 = 10; y1 = 10;
x2 = 12; y2 = 2;
x3 = 3;  y3 = 8;

% sys.
A = [ 1,   x1,   y1;
      1,   x2,   y2;
      3, 3*x3, 3*y3 ];
  
b = [ x1^2 + y1^2;
      x2^2 + y2^2;
      3*(x3^2 + y3^2) ];

% lös c = [c1; c2; c3]
c = A\b;

% cirk param
X = c(2)/2;
Y = c(3)/2;
R = sqrt((c(2)/2)^2 + (c(3)/2)^2 + c(1));

disp(['medel = (', num2str(X, '%.4f'), ', ', num2str(Y, '%.4f'), ')']);
disp(['radie = ', num2str(R, '%.4f')]);

% plot
fi = linspace(0, 2*pi, 100);
x_circ = X + R * cos(fi);
y_circ = Y + R * sin(fi);

figure;
hold on;
plot(x_circ, y_circ, 'b-');
plot([x1; x2; x3], [y1; y2; y3], 'ro', 'MarkerFaceColor', 'r');
plot(X, Y, 'kx');
axis equal;
grid on;
