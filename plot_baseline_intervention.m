subplot(2,2,1)
load('ParamVectorsDokanTofa.mat');
 plot((1:length(mfPrevArray(:,1)))/12,100*(mfPrevArray(:,:)),'Color',[0.6 0.6 0.6]);
 hold on;
 aa = ConstructBinomialErrorBars(MfData);
 p1= errorbar(aa(:,1),aa(:,2),aa(:,3),aa(:,4),'or','MarkerFaceColor','r','MarkerEdgeColor','r');
 hold on;
 xlabel('Age (years)');
 ylabel('Mf prevalence (%)');
 title('Low prevalence site (DokanTofa)');
 hold on;
 
 subplot(2,2,2)
load('ParamVectorsPeneng.mat');
 plot((1:length(mfPrevArray(:,1)))/12,100*(mfPrevArray(:,:)),'Color',[0.6 0.6 0.6]);
 hold on;
 aa = ConstructBinomialErrorBars(MfData1);
 p1= errorbar(aa(:,1),aa(:,2),aa(:,3),aa(:,4),'-or','MarkerFaceColor','r','MarkerEdgeColor','r');
 hold on;
 aa = ConstructBinomialErrorBars(MfData2);
 p1= errorbar(aa(:,1),aa(:,2),aa(:,3),aa(:,4),'-ob','MarkerFaceColor','b','MarkerEdgeColor','b');
 hold on;
 aa = ConstructBinomialErrorBars(MfData3);
 p1= errorbar(aa(:,1),aa(:,2),aa(:,3),aa(:,4),'-ok','MarkerFaceColor','k','MarkerEdgeColor','k');
 hold on;
 xlabel('Age (years)');
 ylabel('Mf prevalence (%)');
 title('High prevalence site (Peneng)');
 hold on;
 
 subplot(2,2,3)
load('Intv_WK_test_new_DokanTofa.mat')
 plot((1:length(mfPrevIntv1(:,1)))/12,(mfPrevIntv1(:,:)),'Color',[0.6 0.6 0.6]);
 hold on;
 MfData1(:,1)=MfData1(:,1)/12;
 aa = ConstructBinomialErrorBars(MfData1);
 p1= errorbar(aa(:,1),aa(:,2),aa(:,3),aa(:,4),'or','MarkerFaceColor','r','MarkerEdgeColor','r');
 hold on;
 set(gca,'XLim',[0 7]);
 xlabel('Time (years)');
 ylabel('Mf prevalence (%)');

 hold on;
 
 subplot(2,2,4)
load('Intv_WK_test_new_Peneng.mat')
 plot((1:length(mfPrevIntv1(:,1)))/12,(mfPrevIntv1(:,:)),'Color',[0.6 0.6 0.6]);
 hold on;
 MfData0(:,1)=MfData0(:,1)/12;
 aa = ConstructBinomialErrorBars(MfData0);
 p1= errorbar(aa(:,1),aa(:,2),aa(:,3),aa(:,4),'or','MarkerFaceColor','r','MarkerEdgeColor','r');
 hold on;
 set(gca,'XLim',[0 7]);
 xlabel('Time (years)');
 ylabel('Mf prevalence (%)');

 hold on;