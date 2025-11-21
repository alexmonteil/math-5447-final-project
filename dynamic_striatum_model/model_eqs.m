function  v = model_eqs(~, y, Z, var, flagSTN, flagC, AdjSTN, AdjC)

%  function  v = model_eqs (t,y,Z,var,flag,flag2,AdjSTN,AdjC)
%  Neural mass model (coupled Wilson-Cowan equations) representing
%  basal ganglia cortical loops.

%  Description of the full non-linear model
%  INPUTS:
%  t - current time (not used)
%  y - matrix representing [S(t), G(t)]
%  Z - matrix representing [S(t - delay), G(t - delay)]
%  par - vector of the following parameters:
%  wgs=var(1)
%  wsg=var(2)
%  wgg=var(3)
%  C=var(4)
%  str=var(5)
%  wcs=var(6)
%  wsc=var(7)
%  wcc=var(8)
%  wstrg=var(16)
%  wcstr=var(17)
%  Tcc=var(9)
%  Tstrg=var(18)
%  Tcstr=var(19)
%  taue = var(10)
%  taui = var(11)
%  Be = var(12)
%  Bi = var(13)
%  Me = var(14)
%  Mi = var(15)
%  
%  flagSTN  - if flagSTN = 1, AdjSTN is included in model, else it is excluded.
%  flagC    - if flagC = 1, AdjC is included in model, else it is excluded.
%  AdjSTN   - Adjusted STN after blocking wcs
%  AdjC     - Adjusted C after blocking wsc

%  OUTPUT:
%  v - vector representing [S(t+dt), G(t+dt), E(t+dt), I(t+dt)]

% time delays
ylag1 = Z(:,1); % SG, GS
ylag2 = Z(:,2); % GG
ylag3 = Z(:,3); % CS
ylag4 = Z(:,4); % SC
ylag5 = Z(:,5); % CC
ylag6 = Z(:,6); % Str-> GPe delay
ylag7 = Z(:,7); % Ctx-> Str delay

% rescaled free parameters 
taue = var(10)/1000;
taui = var(11)/1000;
C = var(4)*10;
% str = var(5)*10;
Be = var(12);
Bi = var(13);
Me = var(14)*10;
Mi = var(15)*10;

% additional fixed parameters
taus = 12.8*10^-3; % STN time constant
taug = 20*10^-3; % GPe time constant
tauStr = 20*10^-3; % Striatum time constant
Ms=300; % STN Max firing rate
Mg = 400; % GPe Max firing rate
MStr = 400; % Striatum Max firing rate
Bs = 10; % STN baseline firing rate
Bg = 20; % GPe baseline firing rate
BStr = 20; % Striatum baseline firing rate

v = zeros(4,1);

    %inS = wcs*E(t-Tcs) - wgs*G(t-Tgs) + [0,1]*AdjSTN 
    inS = var(6)*ylag3(3)-var(1)*ylag1(2) + flagSTN*AdjSTN;
   
    %inG = wsg*S(t-Tsg) - wgg*G(t-Tgg) - wstrg*Str(t - Tstrg)
    inG =  var(2)*ylag1(1)-var(3)*ylag2(2) - var(16)*ylag6(5); 
    
    %inE =  - wsc*S(t-Tsc) - wcc*I(t-Tcc) + C - [0,1]*AdjC 
    inE =   - var(7)*ylag4(1) - var(8)*ylag5(4) + C - flagC*AdjC;
    
    %inI = wcc*E(t-Tcc)
    inI =  var(8)*ylag5(3);
    
    %inStr = wcstr*E(t - Tcstr)
    inStr = var(17)*ylag7(3);
    
v(1)= ((Ms/((1+exp(-4*inS/Ms)*((Ms-Bs)/Bs)))) - y(1))*(1/taus); % STN

v(2)= ((Mg/((1+exp(-4*inG/Mg)*((Mg-Bg)/Bg)))) - y(2))*(1/taug); % GPe

v(3)= ((Me/((1+exp(-4*inE/Me)*((Me-Be)/Be)))) - y(3))*(1/taue); % Ctx E

v(4)= ((Mi/((1+exp(-4*inI/Mi)*((Mi-Bi)/Bi)))) - y(4))*(1/taui); % Ctx I

v(5)= ((MStr/((1+exp(-4*inStr/MStr)*((MStr-BStr)/BStr)))) - y(5))*(1/tauStr); % Str

end 