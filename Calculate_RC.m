function [RC_Result] = Calculate_RC(altitude, speed)
W = 75000;
S = 30;
CD_0 = 0.03;  %constants
K = 0.04;
CLmax = 2;
TAmax0 = 40000;

rho_0 = Atmos(0);
PA_R = TAmax0 * (Atmos(altitude) ./ rho_0) .* speed;
PR_R = (Atmos(altitude) .* speed.^3 * S * CD_0)./2 + (K * 2*W^2) ./ (Atmos(altitude) .* speed.*S);
RC_Result = (PA_R - PR_R) / W;
end
