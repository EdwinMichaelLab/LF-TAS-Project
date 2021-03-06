% Function to calculate the equilibrium values of worm-load mf-intensity
% and acquired immunity over age GIVEN the Equilibrium value of l3

function [pVec,wVec,mVec,iVec,cfaVec]=...
    equilibriumValuesOfStateVars_CFA(beta,k0,kLin,...
    psi1,mu,alpha,gamma,c,ageLev,VoverH,psi2s2,immC,slopeC,del,...
    alpha2,gamma2,ageMthMax,da,l3,PP,pVec,wVec,mVec,iVec,gVec,cfaVec)

SexRatio = 0.5; % worm sex ratio
l3VoverH=sum(VoverH.*l3); % l3 intensity * since VoverH is a number for one specy case, here same as (VoverH * l3)

% initialize arrays and variables holding current worm load values
pVec=pVec*0;
wVec=wVec*0;
mVec=mVec*0;
iVec=iVec*0;
gVec=gVec*0;
cfaVec=cfaVec*0;

p1=0;
w1=0;
m1=0;
i1=0;
cfa1=0;

for a2=2:da:PP % loop over people of age less than the prepatent worm period (will not have patent worms)  % a2: age variable to loop
    % foi=min(a2/(12.0*ageLev),1); % exposure rises linearly with age
    foi=1-exp(-a2/(12.0*ageLev)); % exposure rises exponentially with age 
    immSupp = (1+immC*slopeC*(w1+p1))/(1+slopeC*(w1+p1)); 
    immFun = (1/(1+c*i1));
    gVec(a2)=foi*beta*psi1*psi2s2*immFun*immSupp*l3VoverH;
    Pworm = 0; % Patent worm, b/ of prepatent
    
    %% f(x t) = f(x t-1)+ 'delta x' need to figure out math. 
    pVec(a2) = p1 + (gVec(a2)-mu*p1)*da;
    wVec(a2) = w1 + (Pworm-mu*w1)*da;
    mVec(a2) = m1 + (SexRatio*alpha*wormMatingProb(w1,negBinshapeFun(w1,k0,kLin))*w1-gamma*m1)*da;
    iVec(a2) = i1 + ((p1+w1)-del*i1)*da;
    cfaVec(a2) = cfa1 + (alpha2*w1-gamma2*cfa1)*da;
    
    % update current value
    p1 = pVec(a2);
    w1 = wVec(a2);
    m1 = mVec(a2);
    i1 = iVec(a2);
    cfa1 = cfaVec(a2);
end

for a2=PP+1:da:ageMthMax % loop over people of age greater than the prepatent worm period (will have patent worms)
    % foi=min(a2/(12.0*ageLev),1); % exposure rises linearly with age
    foi=1-exp(-a2/(12.0*ageLev)); % exposure rises exponentially with age
    immSupp = (1+immC*slopeC*(w1+p1))/(1+slopeC*(w1+p1));
    immFun = (1/(1+c*i1));
    gVec(a2)=foi*beta*psi1*psi2s2*immFun*immSupp*l3VoverH;
    Pworm=gVec(a2-PP)*exp(-mu*PP);
    pVec(a2)=p1+(gVec(a2)-mu*p1-gVec(a2-PP)*exp(-mu*PP))*da;
    wVec(a2) = w1+(Pworm-mu*w1)*da;
    mVec(a2) = m1 + (SexRatio*alpha*wormMatingProb(w1,negBinshapeFun(w1,k0,kLin))*w1-gamma*m1)*da;
    iVec(a2) = i1 + ((w1+p1) - del*i1)*da;
    cfaVec(a2) = cfa1 + (alpha2*w1-gamma2*cfa1)*da;
    
    % update current value
    p1 = pVec(a2);
    w1 = wVec(a2);
    m1 = mVec(a2);
    i1 = iVec(a2);
    cfa1 = cfaVec(a2);
end

% check that real numbers are stored, check if there's complicated numbers in the arrays
if (isreal(pVec)==0 && isreal(wVec)==0 && isreal(mVec)==0 && isreal(iVec)==0)
    pVec=pVec*0;
    wVec=wVec*0;
    mVec=mVec*0;
    iVec=iVec*0;
    cfaVec=cfaVec*0;
end

end

