Regions = {'SSA2';'SSA3';'SSA';'SSA1';'SSA4'; 'PNG'}; % at least one required
Countries = {'Nigeria';'Nigeria';'Mali';'Tanzania';'Mali'};% required only for SSA sites, names should follow format of Countries_w_Demo.mat
SSA2sites = {'DokanTofa'};
SSA3sites = {'Piapung'};
SSAsites = {'Dozanso'};
SSA1sites={'Kirare'};
SSA4sites = {'Missasso'};
PNGsites = {'Peneng'};
base=[5 9.9 40 26.1 20.2 66.7];

for iReg =1:6%length(Regions)
    Sites  = eval(sprintf('%ssites',Regions{iReg}));
    for iSites = 1%:length(Sites)
        load(sprintf('Intv_MDAan_WHO_%s.mat',Sites{iSites}));
        low=prctile(mfPrevIntv3((((tWHO-1)/12)+5)*12,id1),2.5);
        high=prctile(mfPrevIntv3((((tWHO-1)/12)+5)*12,id1),97.5);
        low_base=(low/base(iReg))*100;
        high_base=(high/base(iReg))*100;
        
        save(sprintf('Recrud_WHO_5yr_%s.mat',char(Sites{iSites})),...
                'mfPrevIntv3','low','high','low_base','high_base',...
                'id1','id2','prec1','prec2','prec3','prec4','prec5',...
                'prec6','id1','id2','id3','id4','id5','id6','id7','id8','tWHO');
    end
end
        
        