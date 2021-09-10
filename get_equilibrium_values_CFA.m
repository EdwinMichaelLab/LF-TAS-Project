function [l3,flag,pVec,wVec,mVec,iVec,cfaVec] = ...
    get_equilibrium_values_CFA(VoverH,beta,alpha,k0,kLin,...
    k1,r1,sigma1,psi1,psi2s2,mu,gamma,b1,c,ageLev,k2,gam2,immC,...
    slopeC,PP,del,alpha2,gamma2,ageMthMax,da,bCulex,demoX,...
    tol1,gVec,pVec,wVec,mVec,iVec,cfaVec)

l3=ones(size(VoverH)); % For current concern, just one specy is taken into account, size(VoverH)=1, for both species case, len(VoverH) = 1 or 3.

% Generate the vector of wVec, mVec, iVec, etc.
[pVec,wVec,mVec,iVec,cfaVec]=...
    equilibriumValuesOfStateVars_CFA(beta,k0,kLin,...
    psi1,mu,alpha,gamma,c,ageLev,VoverH,psi2s2,immC,slopeC,del,...
    alpha2,gamma2,ageMthMax,da,l3,PP,pVec,wVec,mVec,iVec,gVec,cfaVec);

for iSpp=1:length(VoverH)
    l3(iSpp) = calcL3Fun(mVec,k0,kLin,r1,k1,beta,b1,sigma1,psi1,...
        ageMthMax,da,k2,gam2,bCulex,demoX);  % from page3 of 2015 paper, calculate the L* with the first 5 PDEs
       
end

flag = 0;
while (flag < length(VoverH))
    
    % calculate equil values given l3 guess value
    [pVec,wVec,mVec,iVec,cfaVec]=...
        equilibriumValuesOfStateVars_CFA(beta,k0,kLin,...
        psi1,mu,alpha,gamma,c,ageLev,VoverH,psi2s2,immC,slopeC,del,...
        alpha2,gamma2,ageMthMax,da,l3,PP,pVec,wVec,mVec,iVec,gVec,cfaVec);
    
    temp=l3; % store previous l3 guess value
    
    for iSpp=1:length(VoverH) % calculate new l3 value given new equil mVec
        l3(iSpp)=calcL3Fun(mVec,k0,kLin,r1,k1,beta,b1,sigma1,psi1,...
            ageMthMax,da,k2,gam2,bCulex,demoX);
    end
    
    flag=0;
    
    for iSpp=1:length(l3) % if l3 did not change, stop iterating
        if abs(l3(iSpp)-temp(iSpp)) <= tol1
            flag=flag+1;
        end
    end
    
end

end
