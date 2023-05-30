function [airDens,airPres,temp,soundSpeed] = Atmos(geomAlt)
%	1976 U.S. Standard Atmosphere Interpolation for FLIGHT

%	June 12, 2015   
%	===============================================================
%	Copyright 2006-15 by ROBERT F. STENGEL.  All rights reserved.

%	Note:	Function does not extrapolate outside altitude range
%	Input:	Geometric Altitude, m (positive up)
%	Output:	Air Density, kg/m^3
%			Air Pressure, N/m^2
%			Air Temperature, K
%			Speed of Sound, m/s

%	Values Tabulated by Geometric Altitude
	Z	= [-1000,0,2500,5000,10000,11100,15000,20000,47400,51000];
	H	= [-1000,0,2499,4996,9984,11081,14965,19937,47049,50594];
	ppo	= [1,1,0.737,0.533,0.262,0.221,0.12,0.055,0.0011,0.0007];
	rro	= [1,1,0.781,0.601,0.338,0.293,0.159,0.073,0.0011,0.0007];
	T	= [288.15,288.15,271.906,255.676,223.252,216.65,216.65,216.65, ...
		   270.65,270.65];
	a	= [340.294,340.294,330.563,320.545,299.532,295.069,295.069, ...
		   295.069,329.799,329.799];
	R		= 6367435;	% Mean radius of the earth, m
	Dens	= 1.225;	% Air density at sea level, Kg/m^3
	Pres	= 101300;	% Air pressure at sea level, N/m^2
	
%	Geopotential Altitude, m
	geopAlt	=	R * geomAlt / (R + geomAlt);
	
%	Linear Interpolation in Geopotential Altitude 
%	for Temperature and Speed of Sound
	temp		=	interp1(Z,T,geopAlt);
	soundSpeed	=	interp1(Z,a,geopAlt);
	
%	Exponential Interpolation in Geometric Altitude
%	for Air Density and Pressure
	for k = 2:10
		if geomAlt <= Z(k)
			betap	=	log(ppo(k) / ppo(k-1)) / (Z(k) - Z(k-1));
			betar	=	log(rro(k) / rro(k-1)) / (Z(k) - Z(k-1));
			airPres	=	Pres * ppo(k-1) * exp(betap * (geomAlt - Z(k-1)));
			airDens	=	Dens * rro(k-1) * exp(betar * (geomAlt - Z(k-1)));
			break
		end
    end