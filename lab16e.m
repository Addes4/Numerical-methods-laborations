clc, clearvars, close all
syms x
y = (1-exp(-(x./5).^3))./(5.*x.^3);
T = taylor(y,x);
disp('Taylorpolynom:')
disp(T)

% trapetsregeln för taylorpolynom
a = 0; % undre gräns
b = 1.09745e-5; %övre gräns
h = 100000; %delintervall
dx = (b-a) ./h; %steglängd
x_values = linspace(a,b,h+1);% h+1 så vi får h antal delintervall
y_values = (1./625) - (x_values.^3)./156250;
trap_taylor = dx.* (sum(y_values) - ((y_values(1)./2) - y_values(end)./2));
disp('Trapetsregeln för taylorpolynom:')
disp(trap_taylor)

%trapetsgregeln för resten av integralen
a = 1.09745e-5; % under gräns
b = 3200;
h = 10000000;
dx = (b-a)./h;
x_values = linspace(a,b,h+1);
y_values = (1-exp(-(x_values./5).^3))./(5.*x_values.^3);
int_taylor = dx.* (sum(y_values) - ((y_values(1)./2) - y_values(end)./2));
disp('Trapetsregeln för resten av integralen:')
disp(int_taylor)

disp('Total integral (summa av båda delarna):')
disp(int_taylor + trap_taylor)