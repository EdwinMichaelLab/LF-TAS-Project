function VH=Temporal_Change_in_VoverH_due_to_IVM(tWHO,NumYears,VoverH,DecayRate)
VH=zeros(1+NumYears*12,length(VoverH));
% DecayRate = -2.1; % from ensemble paper supp info fitted to Pondicherry
for jj=1:length(VoverH)
    VH(1:tWHO,jj)=VoverH(jj);
    VH(tWHO+1:NumYears*12+1,jj)=VoverH(jj)*exp(DecayRate.*((tWHO:NumYears*12)/12)); % MBR decrease during control
end
end
