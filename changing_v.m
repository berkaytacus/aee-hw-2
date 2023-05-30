function [v] = changing_v(h)

W = 75000;
S = 30;
CD_0 = 0.03;  %constants
K = 0.04;
CLmax = 2;
TAmax0 = 40000;

v = ((TAmax0 + (6*CD_0*W^2*K+TAmax0^2).^(1/2) )./  (3*Atmos(h) * CD_0 * S)).^(1/2)


end