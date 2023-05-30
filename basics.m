clc

rho = Atmos(1000); % calculating air density for different altitudes.

W = 75000;
S = 30;
CD_0 = 0.03;  %constants
K = 0.04;
CLmax = 2;
TAmax0 = 40000;

rho_0 = Atmos(0);
CD = CD_0 + K*(CLmax^2);
V_stall = (2*W / (rho_0 * S * CLmax))^(1/2);

%% Q1
clc

V = 0:300;
PR = (rho_0 * V.^3 * S * CD_0)/2 + (K * 2*W^2) ./ (rho_0 * V.*S); 
plot(V, PR)
PAmax = TAmax0 * V;
plot(V,PR), hold on, plot(V,PAmax);
legend('P_R', 'P_A(max)')
xlabel('V_∞ (m/s)')
ylabel('P(W)')
title('P vs V_∞ Graph')

%% Q3

p_ac = 2*W*rho_0/TAmax0 * ((CD_0 * K)^(1/2));
V_ac = (2*W / (p_ac * S * CLmax))^(1/2);

%% Q2
clc
h = 0:500;
PR_new = (Atmos(h) .* 100^3 * S * CD_0)/2 + (K * 2*W^2) ./ (Atmos(h) .* 100*S);
TA_new = TAmax0 * Atmos(h) ./ rho_0;
PA_new = TA_new * 100; 
RC = (PA_new - PR_new) / W;
plot(h, 1/RC)
ylabel('RC'), xlabel('h(m)'), title('RC vs h graph')

%% Q4 time for steady climb
clc
RC_11 = Calculate_RC(1000,100); % P11
RC_21 = Calculate_RC(9000,100); % P21

h_new = 1000:9000; % altitude interval 
inverse_RC = (Calculate_RC(h_new, 100)).^(-1);
plot(h_new, inverse_RC) % check if the figure was accurate
time = trapz(h_new,inverse_RC) % calculating the area
%% P21 to P22
clc

PA_100 = TAmax0 * Atmos(9000)/rho_0 * 100  
PR_100 = (Atmos(9000) * 100^3 * S * CD_0)/2 + (K * 2*W^2) ./ (Atmos(9000) * 100*S)
EP_100 = PA_100 - PR_100 
a_100 = (9.81 / 100)* EP_100 / W % acceleratiın at P21

PA_200 = TAmax0 * Atmos(9000)/rho_0 * 200 ;
PR_200 = (Atmos(9000) * 200^3 * S * CD_0)/2 + (K * 2*W^2) ./ (Atmos(9000) * 200*S);
EP_200 = PA_200 - PR_200 ;
a_200 = (9.81 / 200)* EP_200 / W % acceleration at P22

%% Time
clc
a_average = abs(a_200 - a_100) / 2;
% speed change = a_average * time
time_2 = (200 - 100) / a_average
time_2 +  345.5615

%% Q4 e)

clc

PA_100 = TAmax0 * Atmos(1000)/rho_0 * 100  ;
PR_100 = (Atmos(1000) * 100^3 * S * CD_0)/2 + (K * 2*W^2) ./ (Atmos(1000) * 100*S);
EP_100 = PA_100 - PR_100 ;
a_100 = (9.81 / 100)* EP_100 / W % acceleratiın at P21

PA_200 = TAmax0 * Atmos(1000)/rho_0 * 200 ;
PR_200 = (Atmos(1000) * 200^3 * S * CD_0)/2 + (K * 2*W^2) ./ (Atmos(1000) * 200*S);
EP_200 = PA_200 - PR_200 ;
a_200 = (9.81 / 200)* EP_200 / W % acceleration at P22

a_average = abs(a_200 - a_100) / 2;
% speed change = a_average * time
time_3 = (200 - 100) / a_average

%% f)
clc
a_average = abs(a_200 - a_100) / 2;
% speed change = a_average * time
time_3 = (200 - 100) / a_average

%% h)
clc
RC_12 = Calculate_RC(1000,200) % P12
RC_22 = Calculate_RC(9000,200) % P22

h_new = 1000:9000; % altitude interval 
inverse_RC = (Calculate_RC(h_new, 200)).^(-1);
plot(h_new, inverse_RC) % check if the figure was accurate
time_4 = trapz(h_new,inverse_RC) % calculating the area


%% 5
clc
alt = 1000:9000;
v_v = changing_v(alt);

(max(v_v) - min(v_v)) / area
RC_final = Calculate_RC(alt, v_v);
area = trapz(alt, 1./RC_final)
plot(alt, RC_final)
plot(alt, 1./RC_final)

%% 6
clc
PA = 6000000;
alt = 1000:9000;
V_PR_min = sqrt(2.*W./(Atmos(alt).*S*(3*CD_0/K).^(3/4)));
PR_min = (Atmos(alt) .* V_PR_min.^3 .* S * CD_0)/2 + (K * 2*W^2) ./ (Atmos(alt) .* V_PR_min.*S);
RC = (PA - PR_min)./W;
Time = trapz(alt, 1./RC)
