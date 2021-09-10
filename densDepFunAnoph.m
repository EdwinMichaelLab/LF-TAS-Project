function f=densDepFunAnoph(m,k,k2,gam2)
val2=gam2/k2;
fTerm1=2./((1+ (m./k)*(1-exp(-val2))).^k);
fTerm2=1./((1+ (m./k)*(1-exp(-2*val2))).^k);
f = (fTerm1-fTerm2);
end