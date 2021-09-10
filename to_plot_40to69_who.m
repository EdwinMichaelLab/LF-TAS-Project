Regions = {'SSA2';'SSA4';'PNG';'SSA3';'SSA1';'SSA'}; % at least one required
% Countries = {'Nigeria';'Nigeria';'Mali';'Tanzania';'Mali'};% required only for SSA sites, names should follow format of Countries_w_Demo.mat
SSA2sites = {'DokanTofa'};
SSA4sites = {'Missasso'};
PNGsites = {'Peneng'};
SSA3sites = {'Piapung'};
SSA1sites={'Kirare'};
SSAsites = {'Dozanso'};



for iReg =1:6%:%length(Regions)
    Sites  = eval(sprintf('%ssites',Regions{iReg}));
    for iSites = 1%:length(Sites)
%         EP_Th_ABR=zeros(6,4);
%         EP_Th_TBR=zeros(6,4);
%         
        EP_Th_ABR(1:6,3)=[0.003109, 0.000750, 0.004534, 0.001550, 0.001799, 0.001101]; % bi_R-eff method
        EP_Th_TBR(1:6,3)=[0.139108, 0.080041, 0.518994, 0.205402, 0.296635, 0.038734]; % bi_R-eff method
        
%         EP_Th_ABR(1:6,1)=[0.044005, 0.046290, 0.050149, 0.037849, 0.055674, 0.031993]; % bi_R-eff method
%         EP_Th_TBR(1:6,1)=[0.884560, 1.665305, 1.966066, 1.243037, 1.642060, 1.746488]; % bi_R-eff method
%         
%         EP_Th_ABR(1:6,2)=[0.015743, 0.014326, 0.025042, 0.018811, 0.016483, 0.016701]; % bi_R-eff method
%         EP_Th_TBR(1:6,2)=[0.433816, 1.020304, 0.598658, 0.709644, 0.696904, 1.102214]; % bi_R-eff method
%         
%         EP_Th_ABR(1:6,4)=[1, 1, 1, 1, 1, 1]; % WHO
%         EP_Th_TBR(1:6,4)=[1, 1, 1, 1, 1, 1]; % WHO
        
        load(sprintf('Intv_WHO_MDA_40to69_%s.mat',Sites{iSites}));
        count = 0; % count number of curves that rise back to 1%
            re1 = []; % curves that rise back to 1%
            re2 = []; % curves that stay below 1%
            for j = 1:length(mfPrevIntv3(1,:))
                if (mfPrevIntv3(35*12,j)>mfPrevIntv3(tWHO,j))
                    re1 = [re1,j];
                    count = count + 1;
                else
                    re2 = [re2,j];
                end
            end
            
            recrud35 = round(length(re1)/(length([re1,re2]))*100);
            
            count1 = 0; % count number of curves that rise back to 1%
            eli1 = []; % curves that rise back to 1%
            eli2 = []; % curves that stay below 1%
            %     p=find(mfPrevIntv3(tWHO1,:)<=EP_Th_ABR(iReg));
            for j = 1:length(mfPrevIntv3(1,:))
                if (mfPrevIntv3(35*12,j)<mfPrevIntv3(tWHO,j) )
                    eli1 = [eli1,j];
                    count1 = count1 + 1;
                else
                    eli2 = [eli2,j];
                end
            end
            
            elim35 = round(length(eli1)/(length([eli1,eli2]))*100);
            
            count1 = 0; % count number of curves that rise back to 1%
            re3 = []; % curves that rise back to 1%
            re4 = []; % curves that stay below 1%
            %     p=find(mfPrevIntv3(tWHO1,:)<=EP_Th_ABR(iReg));
            for j = 1:length(mfPrevIntv3(1,:))
                if (mfPrevIntv3((((tWHO-1)/12)+5)*12,j)>mfPrevIntv3(tWHO,j) ) 
                    re3 = [re3,j];
                    count1 = count1 + 1;
                else
                    re4 = [re4,j];
                end
            end
            
            recrud5 = round(length(re3)/(length([re3,re4]))*100);
            
            count1 = 0;
    eli3 = []; % curves that rise back to 1%
    eli4 = []; % curves that stay below 1%
    for j = 1:length(mfPrevIntv3(1,:))
        if (mfPrevIntv3((((tWHO-1)/12)+5)*12,j)<mfPrevIntv3(tWHO,j))
            eli3 = [eli3,j];
            count1 = count1 + 1;
        else
            eli4 = [eli4,j];
        end
    end
    
    elim5 = round(length(eli3)/(length([eli3,eli4]))*100);
            
            
%            

% EP_Th_ABR(1:6,3)=[0.003109, 0.001550, 0.001101, 0.001799, 0.000750, 0.004534]; % bi_R-eff method
%         EP_Th_TBR(1:6,3)=[0.031017, 0.041388, 0.018659, 0.037083, 0.007987, 0.065918]; % bi_R-eff method
subplot(2,3,iReg)
semilogy((1:length(mfPrevIntv3(:,1)))/12,(mfPrevIntv3(:,:)),'Color',[0.6;0.6;0.6]);
hold on;
% load('Intv_WHO_MDA_DokanTofa.mat')

% semilogy((1:length(mfPrevIntv3(1:((((tWHO-1)/12)+5)*12),1)))/12,(mfPrevIntv3(1:((((tWHO-1)/12)+5)*12),id5)),'r');
% hold on;
% semilogy((109:length(mfPrevIntv3(1:421,1)))/12,(mfPrevIntv3(109:421,id3)),'g');
% hold on;
% semilogy((109:length(mfPrevIntv3(1:421,1)))/12,(mfPrevIntv3(109:421,id1)),'r');
% hold on;
% semilogy((1:length(mfPrevIntv3(:,1)))/12,(mfPrevIntv3(:,eli1)),'Color','k');
% hold on;


id10=[];

for i=1:length(re1)
    for j=tWHO+1:421
        if(mfPrevIntv3(j-1,re1(i))<mfPrevIntv3(j,re1(i)) &&  mfPrevIntv3(j-1,re1(i))<mfPrevIntv3(421,re1(i)))
            id10(i)=j-1;
           break;
        end
    end
end
a=find(id10>0);
% 
for i=1:length(id10)
    if (id10(i)>0)
%         break;
    semilogy((id10(i):length(mfPrevIntv3(:,1)))/12,(mfPrevIntv3(id10(i):end,re1(i))),'Color','r');
    end
hold on;
end

id=[];

for i=1:length(eli1)
    for j=tWHO+1:421
        if(mfPrevIntv3(j-1,eli1(i))>mfPrevIntv3(j,eli1(i)) && mfPrevIntv3(421,eli1(i))<mfPrevIntv3(j-1,eli1(i)))
            id(i)=j-1;
           break;
        end
    end
end
b=find(id>0);
for i=1:length(id)
    if (id(i)>0)
        semilogy((tWHO:length(mfPrevIntv3(1:id(i),1)))/12,(mfPrevIntv3(tWHO:id(i),eli1(i))),'Color',[0.6;0.6;0.6]);
    end
    hold on;
end
   
% 
for i=1:length(id)
    if (id(i)>0)
%         break;
    semilogy((id(i):length(mfPrevIntv3(:,1)))/12,(mfPrevIntv3(id(i):end,eli1(i))),'Color',[0;0.6;0]);
    end
hold on;
end

% for i=1:length(id)
%     if (id(i)>0)
% %         break;
%     semilogy((id(i):length(mfPrevIntv3(1:(((tWHO-1)/12)+5)*12,1)))/12,(mfPrevIntv3(id(i):(((tWHO-1)/12)+5)*12,eli1(i))),'Color','b');
%     end
% hold on;
% end
% % 
% hold on;

% for i=1:length(id)
%     if (id(i)==tWHO)
% %         break;
%     semilogy((id(i):length(mfPrevIntv3(:,1)))/12,(mfPrevIntv3(id(i):end,eli1(i))),'Color','g');
%     end
% hold on;
% end

% for i=1:length(id)
%     if (id(i)>0)
% %         break;
%     semilogy(((((tWHO-1)/12)+5)*12:length(mfPrevIntv3(:,1)))/12,(mfPrevIntv3((((tWHO-1)/12)+5)*12:end,eli1(i))),'Color','g');
%     end
% hold on;
% end
% semilogy((1:length(mfPrevIntv3(1:((((tWHO-1)/12)+5)*12),1)))/12,(mfPrevIntv3(1:((((tWHO-1)/12)+5)*12),id7)),'k');

hold on;
plot([0 35],[0.5 0.5],'--k');
hold on;
plot([0 35],[EP_Th_ABR(iReg,3) EP_Th_ABR(iReg,3)],'-k');
hold on;
plot([((tWHO-1)/12) ((tWHO-1)/12)],[10^-10 10^2],'--b');
hold on;
plot([((tWHO-1)/12)+5 ((tWHO-1)/12)+5],[10^-10 10^2],'-b');
hold on;
set(gca,'XLim',[0 35]);
set(gca,'YLim',[10^-5 100]);
hold on;
xlabel("No. of years");
ylabel("Mf prevalence(%)");
hold on;
c=find(id>(((tWHO-1)/12)+5)*12);
d=min(id);
e=find(id==tWHO);
f=find(id~=tWHO);
elimination5 = round(length(e)/(length([eli1,eli2]))*100);
stick5 = round(length(f)/(length([eli1,eli2]))*100);
 save(sprintf('Intv_WHO_MDA_40to69_info_%s.mat',char(Sites{iSites})),...
                'mfPrevIntv1','MBRIntv1','L3Intv1','RegimenEfficacy',...
                'MonthlyMDACov','IRSCoverages',...
                'ITNCoverages','MfData','SwitchMonth','mfPrevIntv3',...
                'MBRIntv3','L3Intv3','tWHO1','WormKill','prec2','prec3',...
                'prec4','prec5','id1','id2','id3','id4','id5','id6','id7','id8',...
                're1','re2','re3','re4','a','b','c','d','e','f','stick5','elimination5','recrud35','recrud5','elim35','elim5','tWHO','tWHO2');
    
    end
end