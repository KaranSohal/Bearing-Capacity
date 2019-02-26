clc;
clear all;

load input.mat

format short g

disp('Bearing Capacity Based on Standard Penetration Test Value')
disp('AS per I.S.Code - 6403:1981')
fprintf('\n');

%% n is the number of rows in spt table from ini.mat file
%% i represents the row of spt table

% Water table correction factors
if (Dw>= (Df+Wf))
  W=1;
elseif (Dw<Df)
  W=0.5;
elseif (Df<Dw<(Df+Wf))
  W=0.5+(0.5*(Dw-Df)/(Wf));
endif

%% significant depth
switch shape
 case 1
 Sig_Df=(1.5*Wf)+Df;
 case 2
 Sig_Df=(1.5*Wf)+Df;
 case 3
 Sig_Df=(3*Wf)+Df;
 case 4
 Sig_Df=(1.5*Wf)+Df;
 endswitch
 
for i=1:1:n
%% Sr. number
Table(:,1)= spt(:,1);
%% Depth m
Table(:,2)= spt(:,2);

%% Overburden Pressure
if Dw>=spt(i,2)
Table(i,3)=spt(i,2)*spt(i,4);
elseif Dw<spt(i,2)
Table(i,3)=(Dw*gamma_Dw)+((spt(i,4)-10)*(spt(i,2)-Dw));
endif


%% correction factor Cn
Table(i,4)=(0.77)*(log10(2000/Table(i,3)));

%% observed N value
Table(i,5)= spt(i,3);


if spt(i,3)<=15
  Table(i,6)= spt(i,3);
elseif spt(i,3)>15
  Table(i,6)= (15)+((0.5)*((spt(i,3)-15)));
endif
Table(i,7)=((Table(i,4))*(Table(i,6)));
endfor

j=1;
a=0;
for i=spt(1,2):spt(:,2):Sig_Df 
 a=a+(Table(j,7));

 i++;
 j=j+1; 

endfor
N_avg=(a/(j-1));
Qnp=(55.4*(N_avg-3)*(((Wf+0.3)/(2*Wf))^2)*W);

%% for different values of permissable settlement
Qnp_S=(Qnp)*(S/0.040);

%% outputs
disp('S.No Depth(m) Overburden Pressure(kN/m2) correction Factor N Dilatancy correction corrected n value')
disp( num2str(Table));
fprintf('\n');
fprintf('\n');

switch shape
  case 1
disp(['Depth of Rectangular foundation, Df = ' num2str(Df) 'm']);
disp(['Width of Rectangular foundation, B = ' num2str(Wf) 'm']);

disp(['N= ' num2str(N_avg) ])
disp(['S= ' num2str(S) 'm'])
disp(['W''= ' num2str(W) ])
disp(['Safe net allowable bearing pressure for= ' num2str(Qnp_S) 'kN/m^2'])

  case 2
disp(['Depth of Column foundation, Df = ' num2str(Df) 'm']);
disp(['Width of Column foundation, B = ' num2str(Wf) 'm']);

disp(['N= ' num2str(N_avg) ])
disp(['S= ' num2str(S) 'm'])
disp(['W''= ' num2str(W) ])
disp(['Safe net allowable bearing pressure for= ' num2str(Qnp_S) 'kN/m^2'])

  case 3
disp(['Depth of Strip foundation, Df = ' num2str(Df) 'm']);
disp(['Width of Strip foundation, B = ' num2str(Wf) 'm']);

disp(['N= ' num2str(N_avg) ])
disp(['S= ' num2str(S) 'm'])
disp(['W''= ' num2str(W) ])
disp(['Safe net allowable bearing pressure for= ' num2str(Qnp_S) 'kN/m^2'])
  
  case 4
disp(['Depth of Circular foundation, Df = ' num2str(Df) 'm']);
disp(['Width of Circular foundation, B = ' num2str(Wf) 'm']);

disp(['N= ' num2str(N_avg) ])
disp(['S= ' num2str(S) 'm'])
disp(['W''= ' num2str(W) ])
disp(['Safe net allowable bearing pressure for= ' num2str(Qnp_S) 'kN/m^2'])
endswitch

