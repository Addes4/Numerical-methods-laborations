% matrisen A
A = [1 2 3 0;
     0 4 5 6;
     1 1 -1 0;
     1 1 1 1];

% vektorn b
b = [7; 6; 5; 4];

% a) Beräkna lösningsvektorn x
x = A\b

% b) Beräkna residualvektorn r = b - Ax
r = b - A*x

% c) det blir inte exakt eftersom att matlab pysslar med flyttalsavrunding
% vilket aldrig kan bli exakt med 64 bit osv.