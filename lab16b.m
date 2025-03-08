% Dominant term för stora x
f = @(x) 1./(5*x.^3);

% Beräkna svansbidrag för B=3200
B = 3200;
tail_contribution = integral(f, B, Inf);
fprintf('Svansbidrag för B=3200: %.2e\n', tail_contribution);

