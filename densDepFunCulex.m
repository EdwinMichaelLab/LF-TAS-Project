function f=densDepFunCulex(m,k,gam)
f = (1+((m./k)*(1-exp(-gam)))).^(-k);
end
