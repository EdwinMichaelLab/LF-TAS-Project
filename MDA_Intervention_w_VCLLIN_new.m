function [MfPrevStore,MBRArray,L3Array] = ...
    MDA_Intervention_w_VCLLIN_new(beta,alpha,k0,kLin,k1,r1,sigma1,psi1,...
    psi2s2,mu,gamma,b1,c,ageLev,k2,gam2,immC,slopeC,VoverH,del,...
    PP,ageMthMax,da,bCulex,l3,gVec,pVec,...
    wVec,mVec,iVec,demog,AgeLimits0,MonthlyMDACov,...
    RegimenEfficacy,MDAInterval,NumYears,VCparams,...
    IRSCoverages,ITNCoverages,SwitchMonth)

SexRatio = 0.5;

IRScoverage = VCparams(1);
IRS_RepelEff = VCparams(2); IRS_KillEff = VCparams(3);
IRS_EfficacyDecayRate = VCparams(4); IRSreplacementPeriod = VCparams(5);
ITNcoverage = VCparams(6); ITN_DeterEff = VCparams(7);
ITN_RepelEff = VCparams(8); ITN_KillEff = VCparams(9);
ITN_EfficacyDecayRate = VCparams(10); ITNreplacementPeriod = VCparams(11);
AnnualDecrease = VCparams(12); 

% Initialize arrays/counters and enter initial condition
g2=gVec;
p2=pVec;
w2=wVec;
m2=mVec;
i2=iVec;

MfPrevStore = zeros(1,1+12*NumYears,'single');
MBRArray    = zeros(1,1+12*NumYears,'single');
L3Array     = zeros(1,1+12*NumYears);

iMbr=0;
MBRArray(1,iMbr+1)=sum(VoverH*beta);
L3Array(1, iMbr+1)=sum(l3);
iMbr=iMbr+1;

VoverHOrig=VoverH;

sumM=sumMf(m2,ageMthMax,da,demog);
MfPrevStore(1,1)=100*mfAgeprevFun(sumM,negBinshapeFun(sumM,k0,kLin));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Begin the simulation time steps
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
j=1;
sinceTreat=0;
Tswitch = 1;
tIRS=0; tITN=0; % time counters set to zero either for re-spraying
                % the houses with IRS or replenishing the worn-out bed 
                % nets with insecticides
drug = RegimenEfficacy(Tswitch,:);
AgeLimits = AgeLimits0(Tswitch,:);

for iTime=1:da:NumYears*12
    
    % Vector control to reduce the vector biting rate
    if iTime > 1 && mod(iTime,12)==1 % Annual decrease in VoverHOrig
        VoverHOrig=max(0,VoverHOrig*(1-AnnualDecrease));
    end
    IRSP1Cov=IRS_RepelEff*IRSCoverages(iTime);
    IRSP2Cov=IRS_KillEff*IRSCoverages(iTime);
    ITNP1Cov=ITN_DeterEff*ITNCoverages(iTime);
    ITNP2Cov=ITN_RepelEff*ITNCoverages(iTime);
    ITNP3Cov=ITN_KillEff*ITNCoverages(iTime);
    VoverH=VoverHOrig*(1-IRSP1Cov*exp(-IRS_EfficacyDecayRate*tIRS/12))*...
        (1-ITNP1Cov*exp(-ITN_EfficacyDecayRate*tITN/12))*...
        (1-ITNP2Cov*exp(-ITN_EfficacyDecayRate*tITN/12))*...
        (1-ITNP3Cov*exp(-ITN_EfficacyDecayRate*tITN/12))*...
        (1-IRSP2Cov*exp(-IRS_EfficacyDecayRate*tIRS/12));
    MBRArray(1, iMbr+1) = sum(VoverH*beta);
    tIRS=tIRS+1;
    tITN=tITN+1;
    if mod(iTime,IRSreplacementPeriod)==0
        tIRS=0;
    end
    if mod(iTime,ITNreplacementPeriod)==0
        tITN=0;
    end
       
    % Initialise arrays
    p1=0;
    w1=0;
    m1=0;
    i1=0;
    
    pVec(1) = p1;
    wVec(1) = w1;
    mVec(1) = m1;
    iVec(1) = i1;
    
    l3VoverH=sum(l3.*VoverH);
    for a2=2:da:PP
        foi = 1-exp(-a2/(12.0*ageLev));
        immSupp = (1+immC*slopeC*(w1+p1))/(1+slopeC*(w1+p1));
        immFun = (1/(1+c*i1));
        gVec(a2)=foi*beta*psi1*psi2s2*immFun*immSupp*l3VoverH;
        Pworm = 0; % Patent worm
        pVec(a2) = p1 + (gVec(a2)-mu*p1)*da;
        wVec(a2) = w1 + (Pworm-mu*w1)*da;
        mVec(a2) = m1 + (SexRatio*alpha*wormMatingProb(w1,negBinshapeFun(w1,k0,kLin))*w1-gamma*m1)*da;
        iVec(a2) = i1 + (p1+w1-del*i1)*da;
        
        p1 = p2(a2);
        w1 = w2(a2);
        m1 = m2(a2);
        i1 = i2(a2);
    end
    
    % The main loop calculating the equilibrium (time-independent)
    % values of the arrays wVec, mVec and iVec
    % Check whether it is time to administer chemo
    if iTime == MDAInterval(j) %(mod(iTime,MDAInterval(iTime)) == 1) || MDAInterval(iTime) == 1
        j = min(j+1,length(MDAInterval));
        
        sinceTreat=1;
        for a2=PP+1:da:ageMthMax
            foi = 1-exp(-a2/(12.0*ageLev));
            immSupp = (1+immC*slopeC*(w1+p1))/(1+slopeC*(w1+p1));
            immFun = (1/(1+c*i1));
            gVec(a2) = foi*beta*psi1*psi2s2*immFun*immSupp*l3VoverH;
            if (a2 >= AgeLimits(1)*12 && a2 < AgeLimits(2)*12)
                gVec(a2)=(1-drug(1)*MonthlyMDACov(iTime))*gVec(a2);
                pVec(a2)=(1-drug(1)*MonthlyMDACov(iTime))*p1;
                wVec(a2)=(1-drug(1)*MonthlyMDACov(iTime))*w1;
                mVec(a2)=(1-drug(2)*MonthlyMDACov(iTime))*m1;
            else
                Pworm    = gVec(a2-PP)*exp(-mu*PP);
                pVec(a2) = p1+(gVec(a2)-mu*p1-gVec(a2-PP)*exp(-mu*PP))*da;
                wVec(a2) = w1+(Pworm-mu*w1)*da;
                mVec(a2) = m1+(SexRatio*alpha*wormMatingProb(w1,...
                    negBinshapeFun(w1,k0,kLin))*w1-gamma*m1)*da;
            end % end of age-group 'if' block
            iVec(a2) = i1 + ((w1+p1) - del*i1)*da;
            p1 = p2(a2);
            w1 = w2(a2);
            m1 = m2(a2);
            i1 = i2(a2);
        end
        
    % If the current time is after one of the treatments but not before the
    % the drug has worn off, then the proportion of the
    % population that was treated will not produce Mf.   
    elseif (sinceTreat<drug(3))
        sinceTreat=sinceTreat+1;
        for a2=PP+1:da:ageMthMax
            foi = 1-exp(-a2/(12.0*ageLev));
            immSupp = (1+immC*slopeC*(w1+p1))/(1+slopeC*(w1+p1));
            immFun = (1/(1+c*i1));
            gVec(a2)=foi*beta*psi1*psi2s2*immFun*immSupp*l3VoverH;
            Pworm=gVec(a2-PP)*exp(-mu*PP);
            pVec(a2)=p1+(gVec(a2)-mu*p1-gVec(a2-PP)*exp(-mu*PP))*da;
            wVec(a2) = w1+(Pworm-mu*w1)*da;
            % Only those untreated will produce Mf, hence a fraction
            % w*(1-coverage)
            if(a2 >= AgeLimits(1)*12+sinceTreat && a2 < ...
                    AgeLimits(2)*12+sinceTreat)
                mVec(a2)=m1+(SexRatio*alpha*wormMatingProb(w1,...
                    negBinshapeFun(w1,k0,kLin))*...
                    (1-drug(2)*MonthlyMDACov(iTime))*w1-gamma*m1)*da;
            else
                mVec(a2)=m1+(SexRatio*alpha*wormMatingProb(w1,...
                    negBinshapeFun(w1,k0,kLin))*w1-gamma*m1)*da;
            end
            iVec(a2) = i1 + ((w1+p1) - del*i1)*da;
            
            p1 = p2(a2);
            w1 = w2(a2);
            m1 = m2(a2);
            i1 = i2(a2);
        end
        
    % If the current time doesn't lie in a
    % treatment/post-treatment-pre-waning period, just update the
    % variables as usual
    else
        for a2=PP+1:da:ageMthMax
            foi = 1-exp(-a2/(12.0*ageLev));
            immSupp = (1+immC*slopeC*(w1+p1))/(1+slopeC*(w1+p1));
            immFun = (1/(1+c*i1));
            gVec(a2)=foi*beta*psi1*psi2s2*immFun*immSupp*l3VoverH;
            Pworm=gVec(a2-PP)*exp(-mu*PP);
            pVec(a2)=p1+(gVec(a2)-mu*p1-gVec(a2-PP)*exp(-mu*PP))*da;
            wVec(a2) = w1+(Pworm-mu*w1)*da;
            mVec(a2)=m1+(SexRatio*alpha*wormMatingProb(w1,...
                negBinshapeFun(w1,k0,kLin))*w1-gamma*m1)*da;
            iVec(a2) = i1 + ((w1+p1) - del*i1)*da;
            
            p1 = p2(a2);
            w1 = w2(a2);
            m1 = m2(a2);
            i1 = i2(a2);
            
        end
    end % end of big 'if' block
    
    % calculate the new value of l3
    l3 = calcL3Fun(mVec,k0,kLin,r1,k1,beta,b1,sigma1,psi1,...
        ageMthMax,da,k2,gam2,bCulex,demog);
    L3Array(1, iMbr+1)=sum(l3);
    iMbr=iMbr+1;
    
    sumM=sumMf(mVec,ageMthMax,da,demog);
    MfPrevStore(1,iTime+1)=100*mfAgeprevFun(sumM,negBinshapeFun(sumM,k0,kLin));

    % Set the dummy variable arrays to store the current values so
    % that they can be used as the initial conditions for the next timestep.
    p2=pVec;
    w2=wVec;
    m2=mVec;
    i2=iVec;
    
    % Check if time to change MDA Regimen
    if Tswitch <= length(SwitchMonth) && iTime == SwitchMonth(Tswitch)
        disp('Switch!');
        Tswitch = Tswitch + 1;
        drug = RegimenEfficacy(Tswitch,:);
    end
    
end % end of for loop, looping over the timesteps
end
