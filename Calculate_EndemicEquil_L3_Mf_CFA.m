function [L3Values,mfPrevArray,cfaPrevArray] = ...
    Calculate_EndemicEquil_L3_Mf_CFA(NParamVecs,...
    ageMthMax,bCulex,demoX,ParameterVectors,da,toleranceX)

% initialize arrays to store equilibrium values
L3Values = zeros(NParamVecs,length(bCulex));  % change from length() to NParamVecs, the same result, 
                                              % since we are looking into one-specy case only, here length(bCulex) should be replaced with '1'
mfPrevArray = zeros(ageMthMax,NParamVecs,'single');  % ageMax defined in Main, and in RunSelectParameterVector times by 12 as month unit
cfaPrevArray = zeros(ageMthMax,NParamVecs,'single');

% detail seen in the page 3 of 2015 paper

gVec  = zeros((ageMthMax/da),1);  % da = 1 % used in the equation for wVec   gVec is never used but in equilibiumValuesOsStateVars_CFA, might be defined within that function
pVec  = zeros((ageMthMax/da),1); % prepatent worm burden
wVec  = zeros((ageMthMax/da),1); % patent worm burden 
mVec  = zeros((ageMthMax/da),1); % mf intensity
iVec  = zeros((ageMthMax/da),1); % measure of immunity
cfaVec  = zeros((ageMthMax/da),1); % cfa intensity

% loop through each parameter vector i
parfor i = 1:NParamVecs
    
    % access the parameters of index i
    [beta,alpha,k0,kLin,k1,r1,sigma1,psi1,psi2s2,mu,gamma,b1,c,ageLev,...
        VoverH,k2,gam2,immC,slopeC,PP,del,alpha2,gamma2] = ...
        get_theParameters(ParameterVectors,i);  %% recommend to replace the 'get_theParameters' with subsetting
        
    % given the sampled parameter vector, calculate the equilibrium values
    % of L3 and mf 
    [l3Eq,~,~,~,mVec0,~,cfaVec0] = get_equilibrium_values_CFA(VoverH,beta,alpha,k0,kLin,...
    k1,r1,sigma1,psi1,psi2s2,mu,gamma,b1,c,ageLev,k2,gam2,immC,...
    slopeC,PP,del,alpha2,gamma2,ageMthMax,da,bCulex,demoX,...
    toleranceX,gVec,pVec,wVec,mVec,iVec,cfaVec)
            
    % store equilibrium values given parameter vector i 
    L3Values(i,:)=l3Eq; % size: 200,000*1
    mfPrevArray(:,i)=mfAgeprevFun(mVec0,negBinshapeFun(mVec0,k0,kLin)); % size: 828*200,000
    cfaPrevArray(:,i)=mfAgeprevFun(cfaVec0,negBinshapeFun(cfaVec0,k0,kLin));  % size: 828*200,000
    
end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% recommend to optimize this function, the original algo is inefficient
%% 
function [beta,alpha,k0,kLin,k1,r1,sigma1,psi1,psi2s2,mu,gamma,b1,c,ageLev,...
    VoverH,k2,gam2,immC,slopeC,PP,del,alpha2,gamma2] = ...
    get_theParameters(ParameterVectors,i)
beta    = ParameterVectors(1,i);
alpha   = ParameterVectors(2,i);
k0      = ParameterVectors(3,i);
kLin    = ParameterVectors(4,i);
k1      = ParameterVectors(5,i);
r1      = ParameterVectors(6,i);
sigma1  = ParameterVectors(7,i);
psi1    = ParameterVectors(8,i);
psi2s2  = ParameterVectors(9,i);
mu      = ParameterVectors(10,i);
gamma   = ParameterVectors(11,i);
b1      = ParameterVectors(12,i);
c       = ParameterVectors(13,i);
ageLev  = ParameterVectors(14,i);
VoverH  = ParameterVectors(15,i); 
k2      = ParameterVectors(16,i);
gam2    = ParameterVectors(17,i);
immC    = ParameterVectors(18,i);
slopeC  = ParameterVectors(19,i);
PP      = ParameterVectors(20,i);
del     = ParameterVectors(21,i);
alpha2  = ParameterVectors(22,i);
gamma2  = ParameterVectors(23,i);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
