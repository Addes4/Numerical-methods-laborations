function main
    % Vi delar upp integralen i två delar:
    % 1) Från nästan 0 till 1 (där vi använder Taylorserie nära 0)
    % 2) Från 1 till "oändlighet" (vi väljer en tillräckligt stor övre gräns)
    
    a = 1e-15;  % Nedre gräns, nära nog noll
    b = 1;      % Mellangräns
    c = 3200;    % Övre gräns, approximation av oändlighet
    
    % Beräkna integralen i två delar med olika antal steg
    n1 = 1000;  % Antal steg för första delen
    n2 = 2000;  % Antal steg för andra delen
    
    % Första delen av integralen (använd Taylorserie nära 0)
    I1 = trap_rule(@integrand_taylor, a, b, n1);
    
    % Andra delen av integralen (använd ursprunglig funktion)
    I2 = trap_rule(@integrand_original, b, c, n2);
    
    % Total integral
    I_Summa = I1 + I2;
    
    % Richardson-extrapolation för att förbättra noggrannheten
    I_rich = richardson_extrapolation(a, b, c);
    
    % Skriv ut resultaten
    fprintf('Resultat med trapetsregeln: %.10f\n', I_Summa);
    fprintf('Resultat efter Richardson-extrapolation: %.10f\n', I_rich);
end

function I = trap_rule(f, a, b, n)
    % Implementering av trapetsregeln
    h = (b-a)/n;
    x = a:h:b;
    y = f(x);
    
    % Trapetsregeln
    I = h * (0.5*y(1) + sum(y(2:end-1)) + 0.5*y(end));
end

function y = integrand_original(x)
    % Ursprungliga integranden
    numerator = 1 - exp(-(x/5).^3);
    denominator = 5 * x.^3;
    y = numerator ./ denominator;
end

function y = integrand_taylor(x)
    % Taylorserie-approximation av integranden nära x=0
    % Taylor expansion: 1/15 - x^3/125 + x^6/3125 + O(x^9)
    y = 1/15 - (x.^3)/125 + (x.^6)/3125;
end

function I_rich = richardson_extrapolation(a, b, c)
    % Richardson-extrapolation med tre olika stegstorlekar
    n1 = 500;
    n2 = 1000;
    n3 = 2000;
    
    % Beräkna integraler med olika stegstorlekar
    I1 = trap_rule(@integrand_taylor, a, b, n1) + trap_rule(@integrand_original, b, c, n1);
    I2 = trap_rule(@integrand_taylor, a, b, n2) + trap_rule(@integrand_original, b, c, n2);
    I3 = trap_rule(@integrand_taylor, a, b, n3) + trap_rule(@integrand_original, b, c, n3);
    
    % Richardson-extrapolation formel
    % Använder antagandet att felet är O(h^2) för trapetsregeln
    h1 = 1/n1;
    h2 = 1/n2;
    h3 = 1/n3;
    
    % Kombinera resultaten för att eliminera ledande feltermer
    I_rich = I3 + (I3 - I2)^2 / (I2 - I1);
end