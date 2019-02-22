% To calculate Bearing Capacity of Soil as per IS Code against Local Shear Failure.
clc;
clear;

% load input and data file
load data.mat
load input.mat

disp('Bearing Capacity Based on Shear Considerations')
disp('AS per I.S.Code - 6403:1981')
fprintf('\n');
% Bearing_Capacity_Factors
phiPrime= atand(0.67*tand(phi));
NcPrime= interp1(Bearing_Capacity_Factors(:,1),Bearing_Capacity_Factors(:,2),phiPrime);
NqPrime= interp1(Bearing_Capacity_Factors(:,1),Bearing_Capacity_Factors(:,3),phiPrime);
NgPrime= interp1(Bearing_Capacity_Factors(:,1),Bearing_Capacity_Factors(:,4),phiPrime);


% Depth_factors
Dc= 1+(0.2*(Df/Wf)*tand(45+phiPrime/2));
if (phiPrime<10)
  Dq = 1;
  Dg = 1;
elseif (phiPrime>10)
  Dq= 1+(0.1*(Df/Wf)*tand(45+phiPrime/2));
  Dg= 1+(0.1*(Df/Wf)*tand(45+phiPrime/2));
endif

% Water table correction factors
if (Dw>= (Df+Wf))
  W=1;
elseif (Dw<Df)
  W=0.5;
elseif (Df<Dw<(Df+Wf))
  W=0.5+(0.5*(Dw-Df)/(Wf));
endif

% inclination factors
ic=(1-(alpha/90))^2;
iq=(1-(alpha/90))^2;
ig=(1-(alpha/phiPrime))^2;

%shape factors
%% case_1_for_rectangular
%% case_2_for_square
%% case_3_for_strip
%% case_4_for_circle

switch shape
  case 1
    Sc= 1+0.2*(Wf/L);
    Sq= 1+0.2*(Wf/L);
    Sg= 1-0.4*(Wf/L);
    
  case 2
    Sc= 1.3;
    Sq= 1.2;
    Sg= 0.8;
       
  case 3
    Sc= 1;
    Sq= 1;
    Sg= 1;
    
  case 4
    Sc= 1.3;
    Sq= 1.2;
    Sg= 0.6;
    
endswitch


if (Dw>=Df)
% surcharge
q=gamma*Df;
% net ultimate bearing capacity for local shear failure
net_ultimate_bearing_capacity= 0.67*cohesion*NcPrime*Sc*Dc*ic+ q*(NqPrime-1)*Sq*Dq*iq+ 0.5*gamma*Wf*NgPrime*Sg*Dg*ig*W;

elseif (Dw<Df)
% surcharge
q= (gamma-10)*Df;
% net ultimate bearing capacity for local shear failure
net_ultimate_bearing_capacity= 0.67*cohesion*NcPrime*Sc*Dc*ic+ q*(NqPrime-1)*Sq*Dq*iq+ 0.5*gamma*Wf*NgPrime*Sg*Dg*ig*W;
endif

safe_net_allowable_bearing_capacity= net_ultimate_bearing_capacity/FOS;

%% output
switch shape
  case 1
    %% rectangle
disp(['Depth of column Foundation, Df= ' num2str(Df) 'm' ]);
disp(['Width of column Foundation, B= ' num2str(Wf) 'm' ]);
disp(['Length of column Foundation, L= ' num2str(L) 'm']);
disp(['Size of column Foundation = ' num2str(L) 'm x ' num2str(Wf) 'm' ]);
printf('\n')
disp(['The least soil properties at the foundation level i.e. at ' num2str(Df) 'm depth are:']);
disp(['    gamma = ' num2str(gamma) ' kN/m^3' ]);
disp(['    c = ' num2str(cohesion) ' kN/m^2' ]);
disp(['    phi = ' num2str(phi) ' degree' ]);
disp(['    phi'' = ' num2str(phiPrime) ' degree' ]);
printf('\n')
disp(['Bearing Capacity factors are:'])
disp(['    Nc'' = ' num2str(NcPrime) ]);
disp(['    Nq'' = ' num2str(NqPrime) ]);
disp(['    Ng'' = ' num2str(NgPrime) ]);
printf('\n')
disp(['Shape factors are:'])
disp(['    Sc = ' num2str(Sc) ]);
disp(['    Sq = ' num2str(Sq) ]);
disp(['    Sg = ' num2str(Sg) ]);
printf('\n')
disp(['Depth factors are:'])
disp(['    dc = ' num2str(Dc) ]);
disp(['    dq = ' num2str(Dq) ]);
disp(['    dg = ' num2str(Dg) ]);
printf('\n')
disp(['Inclination factors are:'])
disp(['    ic = ' num2str(ic) ]);
disp(['    iq = ' num2str(iq) ]);
disp(['    ig = ' num2str(ig) ]);
printf('\n')
disp(['Water table correction factor, w'' = ' num2str(W)])
disp(['Ultimate net bearing capacity, qu'' = ' num2str(net_ultimate_bearing_capacity) 'kN/m^2'])
disp(['Factor of safety = ' num2str(FOS) ]);
disp(['Safe net allowable bearing capacity, qu_safe'' = ' num2str(safe_net_allowable_bearing_capacity) 'kN/m^2'])


case 2
%% square

disp(['Depth of column Foundation, Df= ' num2str(Df) 'm' ]);
disp(['Width of column Foundation, B= ' num2str(Wf) 'm' ]);
disp(['Length of column Foundation, L= ' num2str(L) 'm']);
disp(['Size of column Foundation = ' num2str(L) 'm x ' num2str(Wf) 'm' ]);
printf('\n')
disp(['The least soil properties at the foundation level i.e. at ' num2str(Df) 'm depth are:']);
disp(['    gamma = ' num2str(gamma) ' kN/m^3' ]);
disp(['    c = ' num2str(cohesion) ' kN/m^2' ]);
disp(['    phi = ' num2str(phi) ' degree' ]);
disp(['    phi'' = ' num2str(phiPrime) ' degree' ]);
printf('\n')
disp(['Bearing Capacity factors are:'])
disp(['    Nc'' = ' num2str(NcPrime) ]);
disp(['    Nq'' = ' num2str(NqPrime) ]);
disp(['    Ng'' = ' num2str(NgPrime) ]);
printf('\n')
disp(['Shape factors are:'])
disp(['    Sc = ' num2str(Sc) ]);
disp(['    Sq = ' num2str(Sq) ]);
disp(['    Sg = ' num2str(Sg) ]);
printf('\n')
disp(['Depth factors are:'])
disp(['    dc = ' num2str(Dc) ]);
disp(['    dq = ' num2str(Dq) ]);
disp(['    dg = ' num2str(Dg) ]);
printf('\n')
disp(['Inclination factors are:'])
disp(['    ic = ' num2str(ic) ]);
disp(['    iq = ' num2str(iq) ]);
disp(['    ig = ' num2str(ig) ]);
printf('\n')
disp(['Water table correction factor, w'' = ' num2str(W)])
disp(['Ultimate net bearing capacity, qu'' = ' num2str(net_ultimate_bearing_capacity) 'kN/m^2'])
disp(['Factor of safety = ' num2str(FOS) ]);
disp(['Safe net allowable bearing capacity, qu_safe'' = ' num2str(safe_net_allowable_bearing_capacity) 'kN/m^2'])

case 3
%% strip

disp(['Depth of strip Foundation, Df= ' num2str(Df) 'm' ]);
disp(['Width of strip Foundation, B= ' num2str(Wf) 'm' ]);
printf('\n')
disp(['The least soil properties at the foundation level i.e. at ' num2str(Df) 'm depth are:']);
disp(['    gamma = ' num2str(gamma) ' kN/m^3' ]);
disp(['    c = ' num2str(cohesion) ' kN/m^2' ]);
disp(['    phi = ' num2str(phi) ' degree' ]);
disp(['    phi'' = ' num2str(phiPrime) ' degree' ]);
printf('\n')
disp(['Bearing Capacity factors are:'])
disp(['    Nc'' = ' num2str(NcPrime) ]);
disp(['    Nq'' = ' num2str(NqPrime) ]);
disp(['    Ng'' = ' num2str(NgPrime) ]);
printf('\n')
disp(['Shape factors are:'])
disp(['    Sc = ' num2str(Sc) ]);
disp(['    Sq = ' num2str(Sq) ]);
disp(['    Sg = ' num2str(Sg) ]);
printf('\n')
disp(['Depth factors are:'])
disp(['    dc = ' num2str(Dc) ]);
disp(['    dq = ' num2str(Dq) ]);
disp(['    dg = ' num2str(Dg) ]);
printf('\n')
disp(['Inclination factors are:'])
disp(['    ic = ' num2str(ic) ]);
disp(['    iq = ' num2str(iq) ]);
disp(['    ig = ' num2str(ig) ]);
printf('\n')
disp(['Water table correction factor, w'' = ' num2str(W)])
disp(['Ultimate net bearing capacity, qu'' = ' num2str(net_ultimate_bearing_capacity) 'kN/m^2'])
disp(['Factor of safety = ' num2str(FOS) ]);
disp(['Safe net allowable bearing capacity, qu_safe'' = ' num2str(safe_net_allowable_bearing_capacity) 'kN/m^2'])

case 4
%% circular

disp(['Depth of circular Foundation, Df= ' num2str(Df) 'm' ]);
disp(['Diameter of circular Foundation, Dia= ' num2str(Wf) 'm' ]);
printf('\n')
disp(['The least soil properties at the foundation level i.e. at ' num2str(Df) 'm depth are:']);
disp(['    gamma = ' num2str(gamma) ' kN/m^3' ]);
disp(['    c = ' num2str(cohesion) ' kN/m^2' ]);
disp(['    phi = ' num2str(phi) ' degree' ]);
disp(['    phi'' = ' num2str(phiPrime) ' degree' ]);
printf('\n')
disp(['Bearing Capacity factors are:'])
disp(['    Nc'' = ' num2str(NcPrime) ]);
disp(['    Nq'' = ' num2str(NqPrime) ]);
disp(['    Ng'' = ' num2str(NgPrime) ]);
printf('\n')
disp(['Shape factors are:'])
disp(['    Sc = ' num2str(Sc) ]);
disp(['    Sq = ' num2str(Sq) ]);
disp(['    Sg = ' num2str(Sg) ]);
printf('\n')
disp(['Depth factors are:'])
disp(['    dc = ' num2str(Dc) ]);
disp(['    dq = ' num2str(Dq) ]);
disp(['    dg = ' num2str(Dg) ]);
printf('\n')
disp(['Inclination factors are:'])
disp(['    ic = ' num2str(ic) ]);
disp(['    iq = ' num2str(iq) ]);
disp(['    ig = ' num2str(ig) ]);
printf('\n')
disp(['Water table correction factor, w'' = ' num2str(W)])
disp(['Ultimate net bearing capacity, qu'' = ' num2str(net_ultimate_bearing_capacity) 'kN/m^2'])
disp(['Factor of safety = ' num2str(FOS) ]);
disp(['Safe net allowable bearing capacity, qu_safe'' = ' num2str(safe_net_allowable_bearing_capacity) 'kN/m^2'])
endswitch


%% end