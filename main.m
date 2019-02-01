% To calculate Bearing Capacity of Soil as per IS Code.
clc;
clear;

% load input and data file
load data.mat
load input.mat

% Bearing_Capacity_Factors
phiPrime= atand(0.67*tand(phi))
NcPrime= interp1(Bearing_Capacity_Factors(:,1),Bearing_Capacity_Factors(:,2),phiPrime)
NqPrime= interp1(Bearing_Capacity_Factors(:,1),Bearing_Capacity_Factors(:,3),phiPrime)
NgPrime= interp1(Bearing_Capacity_Factors(:,1),Bearing_Capacity_Factors(:,4),phiPrime)


% Depth_factors
Dc= 1+(0.2*(Df/Wf)*tand(45+phiPrime/2))
if (phiPrime<10)
  Dq = 1
  Dg = 1
elseif (phiPrime>10)
  Dq= 1+(0.1*(Df/Wf)*tand(45+phiPrime/2))
  Dg= 1+(0.1*(Df/Wf)*tand(45+phiPrime/2))
endif

% Water table correction factors
if (Dw>= (Df+Wf))
  W=1
elseif (Dw<Df)
  W=0.5
elseif (Df<Dw<(Df+Wf))
  W=0.5+(0.5*(Dw-Df)/(Wf))
endif

% inclination factors
ic=(1-(alpha/90))^2
iq=(1-(alpha/90))^2
ig=(1-(alpha/phiPrime))^2

%shape factors
%% case_1_for_rectangular
%% case_2_for_square
%% case_3_for_strip
%% case_4_for_circle

switch shape
  case 1
    Sc= 1+0.2*(Wf/L)
    Sq= 1+0.2*(Wf/L)
    Sg= 1-0.4*(Wf/L)
    
  case 2
    Sc= 1.3
    Sq= 1.2
    Sg= 0.8
       
  case 3
    Sc= 1
    Sq= 1
    Sg= 1
    
  case 4
    Sc= 1.3
    Sq= 1.2
    Sg= 0.6
    
endswitch


if (Dw>=Df)
% surcharge
q=gamma*Df
% net ultimate bearing capacity for local shear failure
net_ultimate_bearing_capacity= 0.67*cohesion*NcPrime*Sc*Dc*ic+ q*(NqPrime-1)*Sq*Dq*iq+ 0.5*gamma*Wf*NgPrime*Sg*Dg*ig*W

elseif (Dw<Df)
% surcharge
q= (gamma-10)*Df
% net ultimate bearing capacity for local shear failure
net_ultimate_bearing_capacity= 0.67*cohesion*NcPrime*Sc*Dc*ic+ q*(NqPrime-1)*Sq*Dq*iq+ 0.5*gamma*Wf*NgPrime*Sg*Dg*ig*W
endif

safe_net_allowable_bearing_capacity= net_ultimate_bearing_capacity/2.5

