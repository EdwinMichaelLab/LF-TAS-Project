% Before lockdown
p1=0.1+(0.9-0.1).*rand(100,1);
p2=0.1+(0.9-0.1).*rand(100,1);
p3=0.1+(0.9-0.1).*rand(100,1);
p4=0.1+(0.9-0.1).*rand(100,1);
eps=0.001+(0.01-0.001).*rand(100,1);
mu=0.25+(0.33-0.25).*rand(100,1);
del1=0.5+(1-0.5).*rand(100,1);
sigma=0.1+(0.2-0.1).*rand(100,1);
eta=0.1+(0.9-0.1).*rand(100,1);
rho1=0.05+(0.1-0.05).*rand(100,1);
rho3=0.07;
zeta1=0.07;
zeta2=0.1;
zeta3=0.14;
xi1=0.14;
xi2=0.05+(0.1-0.05).*rand(100,1);
nu=0.05;
R01=[2.26,2.58,2.74,3.19,3.37,3.38,3.18];
R0mean1=mean(R01);
beta=zeros(length(p1),1);
for i=1:length(p1)
 beta(i)=R0mean1/((p2(i)/del1(i))+(p1(i)*((1-sigma(i)))/eta(i))+(sigma(i)/(rho1(i)+zeta1+zeta2+zeta3))+(p3(i)*zeta1*sigma(i)/((rho1(i)+zeta1+zeta2+zeta3)*(xi1+xi2(i))))+(p4(i)*sigma(i)*zeta3/((rho1(i)+zeta1+zeta2+zeta3)*(rho3+nu)))+(p4(i)*sigma(i)*xi1*zeta1/((rho1(i)+zeta1+zeta2+zeta3)*(xi1+xi2(i))*(rho3+nu))));
end
betamean1=mean(beta);

%during begining of lockdown R0 decreases


% p1=0.1+(0.9-0.1).*rand(100,1);
% p2=0.1+(0.9-0.1).*rand(100,1);
% p3=0.1+(0.9-0.1).*rand(100,1);
% p4=0.1+(0.9-0.1).*rand(100,1);
% eps=0.001+(0.01-0.001).*rand(100,1);
% mu=0.25+(0.33-0.25).*rand(100,1);
% del1=0.5+(1-0.5).*rand(100,1);
% sigma=0.1+(0.2-0.1).*rand(100,1);
% eta=0.1+(0.9-0.1).*rand(100,1);
% rho1=0.05+(0.1-0.05).*rand(100,1);
% rho3=0.07;
% zeta1=0.07;
% zeta2=0.1;
% zeta3=0.14;
% xi1=0.14;
% xi2=0.05+(0.1-0.05).*rand(100,1);
% nu=0.05;
R02=[2.72,2.28,1.88,1.72,1.48,1.35,1.23,1.04,0.97];
R0mean2=mean(R02);
beta=zeros(length(p1),1);
for i=1:length(p1)
 beta(i)=R0mean2/((p2(i)/del1(i))+(p1(i)*((1-sigma(i)))/eta(i))+(sigma(i)/(rho1(i)+zeta1+zeta2+zeta3))+(p3(i)*zeta1*sigma(i)/((rho1(i)+zeta1+zeta2+zeta3)*(xi1+xi2(i))))+(p4(i)*sigma(i)*zeta3/((rho1(i)+zeta1+zeta2+zeta3)*(rho3+nu)))+(p4(i)*sigma(i)*xi1*zeta1/((rho1(i)+zeta1+zeta2+zeta3)*(xi1+xi2(i))*(rho3+nu))));
end
betamean2=mean(beta);

%during lockdown R0 is linear

R03=[0.86,0.88,0.86,0.89,0.97,0.89,0.94,0.88,0.89,0.91,0.93,1.03,0.96,...
0.96,0.87,0.82,0.81,0.83,0.91,0.86,0.82,0.75,0.68,0.71,0.78,0.84,0.89,...
0.87,0.79,0.79,0.77,0.81,0.89,0.86,0.84,0.79,0.76,0.78,0.81,0.89,0.85,...
0.84,0.84,0.83,0.91,0.97,0.99,0.93,0.85,0.77,0.77,0.82,0.89,0.96,0.98,...
0.95,0.91,0.96,0.88,0.93,0.94,0.81,0.84,0.76,0.85];
R0mean3=mean(R03);
beta=zeros(length(p1),1);
for i=1:length(p1)
 beta(i)=R0mean3/((p2(i)/del1(i))+(p1(i)*((1-sigma(i)))/eta(i))+(sigma(i)/(rho1(i)+zeta1+zeta2+zeta3))+(p3(i)*zeta1*sigma(i)/((rho1(i)+zeta1+zeta2+zeta3)*(xi1+xi2(i))))+(p4(i)*sigma(i)*zeta3/((rho1(i)+zeta1+zeta2+zeta3)*(rho3+nu)))+(p4(i)*sigma(i)*xi1*zeta1/((rho1(i)+zeta1+zeta2+zeta3)*(xi1+xi2(i))*(rho3+nu))));
end
betamean3=mean(beta);


%% solve the model



dt=1;

% S=zeros(100/dt,1);
% E1=zeros(100/dt,1);
% E2=zeros(100/dt,1);
% Ia=zeros(100/dt,1);
% Is=zeros(100/dt,1);
% Q=zeros(100/dt,1);
% J=zeros(100/dt,1);
% R=zeros(100/dt,1);

% S=zeros(100,1);
% E1=zeros(100,1);
% E2=zeros(100,1);
% Ia=zeros(100,1);
% Is=zeros(100,1);
% Q=zeros(100,1);
% J=zeros(100,1);
% R=zeros(100,1);

S0=83000000;
E1(1)=500;
E2(1)=0;
Ia(1)=0;
Is(1)=0;
Q(1)=0;
J(1)=0;
R(1)=0;
t(1)=0;
tmax=100;
tmin=0;
n1=length(R01);

p1mean=mean(p1);
p2mean=mean(p2);
p3mean=mean(p3);
p4mean=mean(p4);
epsmean=mean(eps);
mumean=mean(mu);
del1mean=mean(del1);
sigmamean=mean(sigma);
etamean=mean(eta);
rho1mean=mean(rho1);
rho3=0.07;
zeta1=0.07;
zeta2=0.1;
zeta3=0.14;
xi1=0.14;
xi2mean=mean(xi2);
nu=0.05;

for i=1:n1
          %% Eular method. 
    %S(i+1) = S(i) + (-((beta*S(i))/(S(i)+E1(i)+E2(i)+Ia(i)+Is(i)+Q(i)+J(i)+R(i)))*(Is(i)+p1*Ia(i)+p2*E2(i)+p3*Q(i)+p4*J(i))+eps*R(i))*dt;
    E1(i+1) = E1(i) + (((betamean1*S0)/(S0+E1(i)+E2(i)+Ia(i)+Is(i)+Q(i)+J(i)+R(i)))*(Is(i)+p1mean*Ia(i)+p2mean*E2(i)+p3mean*Q(i)+p4mean*J(i))-mumean*E1(i))*dt;
    E2(i+1) = E2(i) + (mumean*E1(i)-del1mean*E2(i))*dt;
    Ia(i+1) = Ia(i) + ((1-sigmamean)*del1mean*E2(i)-etamean*Ia(i))*dt;
    Is(i+1) = Is(i) + (sigmamean*del1mean*E2(i)-(rho1mean+zeta1+zeta2+zeta3)*Is(i))*dt;
    Q(i+1) = Q(i) + (zeta1*Is(i)-(xi1+xi2mean)*Q(i))*dt;
    J(i+1) = J(i) + (zeta3*Is(i)+xi1*Q(i)-(rho3+nu)*J(i))*dt;
    R(i+1) = R(i) + (etamean*Ia(i)+zeta2*Is(i)+xi2mean*Q(i)+nu*J(i)-epsmean*R(i))*dt;
    
    % update current value
    %S(i)=S(i+1);
    E1(i)=E1(i+1);
    E2(i)=E2(i+1);
    Ia(i)=Ia(i+1);
    Is(i)=Is(i+1);
    Q(i)=Q(i+1);
    J(i)=J(i+1);
    R(i)=R(i+1);
    
    t(i+1)=t(i)+dt;
end


S0=83000000;

n2=length(R02);

for i=n1:n2
          %% Eular method. 
    %S(i+1) = S(i) + (-((beta*S(i))/(S(i)+E1(i)+E2(i)+Ia(i)+Is(i)+Q(i)+J(i)+R(i)))*(Is(i)+p1*Ia(i)+p2*E2(i)+p3*Q(i)+p4*J(i))+eps*R(i))*dt;
    E1(i+1) = E1(i) + (((betamean2*S0)/(S0+E1(i)+E2(i)+Ia(i)+Is(i)+Q(i)+J(i)+R(i)))*(Is(i)+p1mean*Ia(i)+p2mean*E2(i)+p3mean*Q(i)+p4*J(i))-mumean*E1(i))*dt;
    E2(i+1) = E2(i) + (mumean*E1(i)-del1mean*E2(i))*dt;
    Ia(i+1) = Ia(i) + ((1-sigmamean)*del1mean*E2(i)-etamean*Ia(i))*dt;
    Is(i+1) = Is(i) + (sigmamean*del1mean*E2(i)-(rho1mean+zeta1+zeta2+zeta3)*Is(i))*dt;
    Q(i+1) = Q(i) + (zeta1*Is(i)-(xi1+xi2mean)*Q(i))*dt;
    J(i+1) = J(i) + (zeta3*Is(i)+xi1*Q(i)-(rho3+nu)*J(i))*dt;
    R(i+1) = R(i) + (etamean*Ia(i)+zeta2*Is(i)+xi2mean*Q(i)+nu*J(i)-epsmean*R(i))*dt;
    
    % update current value
    %S(i)=S(i+1);
    E1(i)=E1(i+1);
    E2(i)=E2(i+1);
    Ia(i)=Ia(i+1);
    Is(i)=Is(i+1);
    Q(i)=Q(i+1);
    J(i)=J(i+1);
    R(i)=R(i+1);
    
    t(i+1)=t(i)+dt;
end

S0=83000000;

n3=length(R03);
for i=n2:n3
          %% Eular method. 
    %S(i+1) = S(i) + (-((beta*S(i))/(S(i)+E1(i)+E2(i)+Ia(i)+Is(i)+Q(i)+J(i)+R(i)))*(Is(i)+p1*Ia(i)+p2*E2(i)+p3*Q(i)+p4*J(i))+eps*R(i))*dt;
    E1(i+1) = E1(i) + (((betamean3*S0)/(S0+E1(i)+E2(i)+Ia(i)+Is(i)+Q(i)+J(i)+R(i)))*(Is(i)+p1mean*Ia(i)+p2mean*E2(i)+p3mean*Q(i)+p4*J(i))-mumean*E1(i))*dt;
    E2(i+1) = E2(i) + (mumean*E1(i)-del1mean*E2(i))*dt;
    Ia(i+1) = Ia(i) + ((1-sigmamean)*del1mean*E2(i)-etamean*Ia(i))*dt;
    Is(i+1) = Is(i) + (sigmamean*del1mean*E2(i)-(rho1mean+zeta1+zeta2+zeta3)*Is(i))*dt;
    Q(i+1) = Q(i) + (zeta1*Is(i)-(xi1+xi2mean)*Q(i))*dt;
    J(i+1) = J(i) + (zeta3*Is(i)+xi1*Q(i)-(rho3+nu)*J(i))*dt;
    R(i+1) = R(i) + (etamean*Ia(i)+zeta2*Is(i)+xi2mean*Q(i)+nu*J(i)-epsmean*R(i))*dt;
    
    % update current value
    %S(i)=S(i+1);
    E1(i)=E1(i+1);
    E2(i)=E2(i+1);
    Ia(i)=Ia(i+1);
    Is(i)=Is(i+1);
    Q(i)=Q(i+1);
    J(i)=J(i+1);
    R(i)=R(i+1);
    
    t(i+1)=t(i)+dt;
end

subplot(4,2,1)
 plot(t,S,'LineWidth',2);
 xlabel("Time (days)");
 ylabel("S");
 set(gca,'XLim',[0 100]);
 hold on;
subplot(4,2,2)
 plot(t,E1,'LineWidth',2);
 xlabel("Time (days)");
 ylabel("E_1");
 set(gca,'XLim',[0 100]);
 hold on;
subplot(4,2,3)
 plot(t,E2,'LineWidth',2);
 xlabel("Time (days)");
 ylabel("E_2");
 set(gca,'XLim',[0 100]);
 hold on;
subplot(4,2,4)
 plot(t,Ia,'LineWidth',2);
 xlabel("Time (days)");
 ylabel("I_a");
 set(gca,'XLim',[0 100]);
 hold on;
subplot(4,2,5)
 plot(t,Is,'LineWidth',2);
 xlabel("Time (days)");
 ylabel("I_s");
 set(gca,'XLim',[0 100]);
 hold on;
subplot(4,2,6)
 plot(t,Q,'LineWidth',2);
 xlabel("Time (days)");
 ylabel("Q");
 set(gca,'XLim',[0 100]);
 hold on;
subplot(4,2,7)
 plot(t,J,'LineWidth',2);
 xlabel("Time (days)");
 ylabel("J");
 set(gca,'XLim',[0 100]);
 hold on;
subplot(4,2,8)
 plot(t,R,'LineWidth',2);
 xlabel("Time (days)");
 ylabel("R");
 hold on;
 set(gca,'XLim',[0 100]);
 