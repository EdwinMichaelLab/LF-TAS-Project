Regions = {'SSA2';'SSA4';'PNG';'SSA3';'SSA1';'SSA'}; % at least one required
% Countries = {'Nigeria';'Nigeria';'Mali';'Tanzania';'Mali'};% required only for SSA sites, names should follow format of Countries_w_Demo.mat
SSA2sites = {'DokanTofa'};
SSA4sites = {'Missasso'};
PNGsites = {'Peneng'};
SSA3sites = {'Piapung'};
SSA1sites={'Kirare'};
SSAsites = {'Dozanso'};



for iReg =1%:%length(Regions)
    Sites  = eval(sprintf('%ssites',Regions{iReg}));
    for iSites = 1%:length(Sites)
%         EP_Th_ABR=zeros(6,4);
%         EP_Th_TBR=zeros(6,4);
%         
        EP_Th_ABR(1:6,3)=[0.003109, 0.000750, 0.004534, 0.001550, 0.001799, 0.001101]; % bi_R-eff method
        EP_Th_TBR(1:6,3)=[0.139108, 0.080041, 0.518994, 0.205402, 0.296635, 0.038734]; % bi_R-eff method
    
    load(sprintf('Intv_WHO_MDA_6to7_%s.mat',Sites{iSites}));
    subplot(2,2,1)
semilogy((1:length(mfPrevIntv3(:,1)))/12,(mfPrevIntv3(:,:)),'Color',[0.6;0.6;0.6]);
hold on;
  for i=1:length(id1)
%     if (id10(i)>0)
%         break;
    semilogy((tWHO-1:(((tWHO-1)/12)+5)*12)/12,(mfPrevIntv3(tWHO-1:(((tWHO-1)/12)+5)*12,id1(i))),'Color','r');
   
hold on;
end  
    for i=1:length(id2)
%     if (id10(i)>0)
%         break;
    semilogy((tWHO-1:(((tWHO-1)/12)+5)*12)/12,(mfPrevIntv3(tWHO-1:(((tWHO-1)/12)+5)*12,id2(i))),'Color',[0;0.6;0]);
   
hold on;
    end  
for i=1:length(id5)
%     if (id10(i)>0)
%         break;
    semilogy(((((tWHO-1)/12)+5)*12:length(mfPrevIntv3(:,1)))/12,(mfPrevIntv3((((tWHO-1)/12)+5)*12:length(mfPrevIntv3(:,1)),id5(i))),'Color','r');
   
hold on;
end  
    for i=1:length(id6)
%     if (id10(i)>0)
%         break;
   semilogy(((((tWHO-1)/12)+5)*12:length(mfPrevIntv3(:,1)))/12,(mfPrevIntv3((((tWHO-1)/12)+5)*12:length(mfPrevIntv3(:,1)),id6(i))),'Color',[0;0.6;0]);
   
hold on;
    end  
hold on;
plot([0 (((tWHO-1)/12)+20)],[1 1],'-b');
hold on;
plot([0 (((tWHO-1)/12)+20)],[0.5 0.5],'--k');
hold on;
plot([0 (((tWHO-1)/12)+20)],[EP_Th_ABR(iReg,3) EP_Th_ABR(iReg,3)],'-k');
hold on;
plot([((tWHO-1)/12) ((tWHO-1)/12)],[10^-10 10^3],'--b');
hold on;
plot([((tWHO-1)/12)+5 ((tWHO-1)/12)+5],[10^-10 10^3],'-b');
hold on;
set(gca,'XLim',[0 (((tWHO-1)/12)+20)]);
set(gca,'YLim',[10^-10 1000]);
hold on;
xlabel("No. of years");
ylabel("Mf prevalence(%)");
hold on;
alpha(0.8);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
     load(sprintf('Intv_WHO_MDA_40to69_%s.mat',Sites{iSites}));
    subplot(2,2,2)
semilogy((1:length(mfPrevIntv3(:,1)))/12,(mfPrevIntv3(:,:)),'Color',[0.6;0.6;0.6]);
hold on;
  for i=1:length(id1)
%     if (id10(i)>0)
%         break;
    semilogy((tWHO-1:(((tWHO-1)/12)+5)*12)/12,(mfPrevIntv3(tWHO-1:(((tWHO-1)/12)+5)*12,id1(i))),'Color','r');
   
hold on;
end  
    for i=1:length(id2)
%     if (id10(i)>0)
%         break;
    semilogy((tWHO-1:(((tWHO-1)/12)+5)*12)/12,(mfPrevIntv3(tWHO-1:(((tWHO-1)/12)+5)*12,id2(i))),'Color',[0;0.6;0]);
   
hold on;
    end  
for i=1:length(id5)
%     if (id10(i)>0)
%         break;
    semilogy(((((tWHO-1)/12)+5)*12:length(mfPrevIntv3(:,1)))/12,(mfPrevIntv3((((tWHO-1)/12)+5)*12:length(mfPrevIntv3(:,1)),id5(i))),'Color','r');
   
hold on;
end  
    for i=1:length(id6)
%     if (id10(i)>0)
%         break;
   semilogy(((((tWHO-1)/12)+5)*12:length(mfPrevIntv3(:,1)))/12,(mfPrevIntv3((((tWHO-1)/12)+5)*12:length(mfPrevIntv3(:,1)),id6(i))),'Color',[0;0.6;0]);
   
hold on;
    end  
hold on;
plot([0 (((tWHO-1)/12)+20)],[1 1],'-b');
hold on;
plot([0 (((tWHO-1)/12)+20)],[0.5 0.5],'--k');
hold on;
plot([0 (((tWHO-1)/12)+20)],[EP_Th_ABR(iReg,3) EP_Th_ABR(iReg,3)],'-k');
hold on;
plot([((tWHO-1)/12) ((tWHO-1)/12)],[10^-6 10^2],'--b');
hold on;
plot([((tWHO-1)/12)+5 ((tWHO-1)/12)+5],[10^-6 10^2],'-b');
hold on;
set(gca,'XLim',[0 (((tWHO-1)/12)+20)]);
set(gca,'YLim',[10^-6 100]);
hold on;
xlabel("No. of years");
ylabel("Mf prevalence(%)");
hold on;
alpha(0.8);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 load(sprintf('Intv_EP_MDAan_6to7_%s.mat',Sites{iSites}));
    subplot(2,2,3)
    a1=find(mfPrevIntv3(((tWHO1-1)/12)+20,:)<0.2);
semilogy((1:tWHO1-1)/12,(mfPrevIntv3(1:tWHO1-1,a1)),'Color',[0.6;0.6;0.6]);
hold on;
%a=find(mfPrevIntv3(((tWHO1-1)/12)+5,id1)<0.4);
  for i=1:length(id1)
%     if (id10(i)>0)
%         break;
    semilogy((tWHO1-1:(((tWHO1-1)/12)+5)*12)/12,(mfPrevIntv3(tWHO1-1:(((tWHO1-1)/12)+5)*12,id1(i))),'Color','r');
   
hold on;
end  
    for i=1:length(id2)
%     if (id10(i)>0)
%         break;
    semilogy((tWHO1-1:(((tWHO1-1)/12)+5)*12)/12,(mfPrevIntv3(tWHO1-1:(((tWHO1-1)/12)+5)*12,id2(i))),'Color',[0;0.6;0]);
   
hold on;
    end  
    
  % c=find(mfPrevIntv3(((tWHO1-1)/12)+20,id5)<0.5);
for i=1:length(id5)
%     if (id10(i)>0)
%         break;
    semilogy(((((tWHO1-1)/12)+5)*12:length(mfPrevIntv3(:,1)))/12,(mfPrevIntv3((((tWHO1-1)/12)+5)*12:length(mfPrevIntv3(:,1)),id5(i))),'Color','r');
   
hold on;
end  
    for i=1:length(id6)
%     if (id10(i)>0)
%         break;
   semilogy(((((tWHO1-1)/12)+5)*12:length(mfPrevIntv3(:,1)))/12,(mfPrevIntv3((((tWHO1-1)/12)+5)*12:length(mfPrevIntv3(:,1)),id6(i))),'Color',[0;0.6;0]);
   
hold on;
    end  
hold on;
plot([0 (((tWHO1-1)/12)+20)],[1 1],'-b');
hold on;
plot([0 (((tWHO1-1)/12)+20)],[0.5 0.5],'--k');
hold on;
plot([0 (((tWHO1-1)/12)+20)],[EP_Th_ABR(iReg,3) EP_Th_ABR(iReg,3)],'-k');
hold on;
plot([((tWHO1-1)/12) ((tWHO1-1)/12)],[10^-14 10^4],'--b');
hold on;
plot([((tWHO1-1)/12)+5 ((tWHO1-1)/12)+5],[10^-14 10^4],'-b');
hold on;
set(gca,'XLim',[0 (((tWHO1-1)/12)+20)]);
set(gca,'YLim',[10^-14 10000]);
hold on;
xlabel("No. of years");
ylabel("Mf prevalence(%)");
hold on;
alpha(0.8);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 load(sprintf('Intv_EP_MDAan_40to69_%s.mat',Sites{iSites}));
    subplot(2,2,4)
     a1=find(mfPrevIntv3(((tWHO1-1)/12)+20,:)<0.5);
semilogy((1:tWHO1-1)/12,(mfPrevIntv3(1:tWHO1-1,a1)),'Color',[0.6;0.6;0.6]);
hold on;
%b=find(mfPrevIntv3(((tWHO1-1)/12)+5,id1)<0.5);
  for i=1:length(id1)
%     if (id10(i)>0)
%         break;
    semilogy((tWHO1-1:(((tWHO1-1)/12)+5)*12)/12,(mfPrevIntv3(tWHO1-1:(((tWHO1-1)/12)+5)*12,id1(i))),'Color','r');
   
hold on;
end  
    for i=1:length(id2)
%     if (id10(i)>0)
%         break;
    semilogy((tWHO1-1:(((tWHO1-1)/12)+5)*12)/12,(mfPrevIntv3(tWHO1-1:(((tWHO1-1)/12)+5)*12,id2(i))),'Color',[0;0.6;0]);
   
hold on;
    end  
    
  %d=find(mfPrevIntv3(((tWHO1-1)/12)+20,id5)<0.5);
for i=1:length(id5)
%     if (id10(i)>0)
%         break;
    semilogy(((((tWHO1-1)/12)+5)*12:length(mfPrevIntv3(:,1)))/12,(mfPrevIntv3((((tWHO1-1)/12)+5)*12:length(mfPrevIntv3(:,1)),id5(i))),'Color','r');
   
hold on;
end  
    for i=1:length(id6)
%     if (id10(i)>0)
%         break;
   semilogy(((((tWHO1-1)/12)+5)*12:length(mfPrevIntv3(:,1)))/12,(mfPrevIntv3((((tWHO1-1)/12)+5)*12:length(mfPrevIntv3(:,1)),id6(i))),'Color',[0;0.6;0]);
   
hold on;
    end  
hold on;
plot([0 (((tWHO1-1)/12)+20)],[1 1],'-b');
hold on;
plot([0 (((tWHO1-1)/12)+20)],[0.5 0.5],'--k');
hold on;
plot([0 (((tWHO1-1)/12)+20)],[EP_Th_ABR(iReg,3) EP_Th_ABR(iReg,3)],'-k');
hold on;
plot([((tWHO1-1)/12) ((tWHO1-1)/12)],[10^-14 10^4],'--b');
hold on;
plot([((tWHO1-1)/12)+5 ((tWHO1-1)/12)+5],[10^-14 10^4],'-b');
hold on;
set(gca,'XLim',[0 (((tWHO1-1)/12)+20)]);
set(gca,'YLim',[10^-14 10000]);
hold on;
xlabel("No. of years");
ylabel("Mf prevalence(%)");
hold on;
alpha(0.8);
    
    
    end 
end