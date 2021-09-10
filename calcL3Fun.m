%Function to calculate the value of L3 given the arrays w, m and i at equilibrium.

function l3 = calcL3Fun(mVec,k0,kLin,r1,k1,beta,b1,sigma1,psi1,ageMthMax,da,k2,gam2,bCulex,demoX)

% calculate probability that person is of age a
a1=(1:da:ageMthMax)'; %%  ' transpose
sumPeople = sum(pi_PeopleFun(a1/12.0,demoX));
pI = pi_PeopleFun(a1/12.0,demoX)/sumPeople;  % to calculate the relative frequancy

% genus-specific mf uptake/larval establishment term
if bCulex == 1
    fI = 1 - densDepFunCulex(mVec,negBinshapeFun(mVec,k0,kLin),(r1/k1));  % for the (1-f(M)) in the Lstar equation, 2015 Paper, Page3
else
    fI = 1 - densDepFunAnoph(mVec,negBinshapeFun(mVec,k0,kLin),k2,gam2);
end

% average uptake term over the population
int1 = sum(pI.*fI); % this equals the integration of pi(a)*(1-f(M)), also 2015 Paper, Page3

% derive l3 as a function of uptake term and genus
if bCulex == 1
    l3 = beta*k1*b1*int1/(sigma1+beta*psi1);
else
    l3 = beta*k2*b1*int1/(sigma1+beta*psi1);
end

end

