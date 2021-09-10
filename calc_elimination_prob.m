 EP_Th_ABR=[0.006614, 0.007578, 0.011843, 0.006651, 0.000073, 0.006528]; % R-eff method
        EP_Th_TBR=[0.139128, 0.478895, 0.682548, 0.333045, 0.044965, 0.584660]; % R-eff method   
count = 0; % count number of curves that rise back to 1%
    id1 = []; % curves that rise back to 1%
    id2 = []; % curves that stay below 1%
for j = 1:length(mfPrevIntv2(1,:))
    if (mfPrevIntv2(35*12,j)>1)
        id1 = [id1,j];
        count = count + 1;
    else
        id2 = [id2,j];
    end
end

prec = round(length(id1)/(length([id1,id2]))*100);



Regions = {'SSA2';'SSA3';'SSA';'SSA1';'IND'; 'PNG'}; % at least one required
Countries = {'Nigeria';'Nigeria';'Mali';'Tanzania'};% required only for SSA sites, names should follow format of Countries_w_Demo.mat
SSA2sites = {'DokanTofa'};
SSA3sites = {'Piapung'};
SSAsites = {'Dozanso'};
SSA1sites={'Kirare'};
INDsites = {'Alagramam'};
PNGsites = {'Peneng'};

for iReg = 4%:length(Regions)
    Sites  = eval(sprintf('%ssites',Regions{iReg}));
    for iSites = 1%:length(Sites)
        
        load(sprintf('Intv_elim2_reff_MDA_%s.mat',Sites{iSites}));
 EP_Th_ABR=[0.006614, 0.007578, 0.011843, 0.006651, 0.000073, 0.006528]; % R-eff method
        EP_Th_TBR=[0.139128, 0.478895, 0.682548, 0.333045, 0.044965, 0.584660]; % R-eff method   
count = 0; % count number of curves that rise back to 1%
    id1 = []; % curves that rise back to 1%
    id2 = []; % curves that stay below 1%
for j = 1:length(mfPrevIntv3(1,:))
    if (mfPrevIntv3((((tWHO1-1)/12)+5)*12,j)<EP_Th_ABR(iReg))
        id1 = [id1,j];
        count = count + 1;
    else
        id2 = [id2,j];
    end
end

prec = round(length(id1)/(length([id1,id2]))*100);

    end
end