%summing up the mf levels over ages for a population average intensity
function mSum=sumMf40to69(mVec,ageMthMax,da,demoX)
mSum0=sum(pi_PeopleFun(((1:da:ageMthMax)/12.0)',demoX)); % denominator to normalize pia such that the age probabilities sum to 1
mSum=sum(pi_PeopleFun(((39*12+1:da:69*12)/12.0)',demoX).*mVec)/mSum0;
end