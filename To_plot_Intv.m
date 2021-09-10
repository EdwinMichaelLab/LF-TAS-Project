clear all; clc;

% load data
Regions = {'SSA'; 'IND'; 'PNG';}; % at least one required
Countries = {'Tanzania';'Tanzania';'Tanzania';'Tanzania';'Tanzania'}; % required only for SSA sites, names should follow format of Countries_w_Demo.mat
SSAsites = {'A1';'A2';'A3';'A4';'A5'};
INDsites = {'B1';'B2';'B3';'B4';'B5'};
PNGsites = {'C1';'C2';'C3';'C4';'C5'};

% Site data: Mf prevalence, blood sample volume, ABR, vector genera
% arranged in region-specific .m data files created by the user
[ A1Mf,A2Mf,A3Mf,A4Mf,A5Mf,...
    A1Vol,A2Vol,A3Vol,A4Vol,A5Vol,...
    A1ABR,A2ABR,A3ABR,A4ABR,A5ABR,...
    A1bCulex,A2bCulex,A3bCulex,A4bCulex,A5bCulex,...
    A1Reg,A2Reg,A3Reg,A4Reg,A5Reg,...
    A1Freq,A2Freq,A3Freq,A4Freq,A5Freq,...
    A1MDACov,A2MDACov,A3MDACov,A4MDACov,A5MDACov,...
    A1NumYears,A2NumYears,A3NumYears,A4NumYears,A5NumYears,...
    A1VC,A2VC,A3VC,A4VC,A5VC,...
    A1SwitchYear,A2SwitchYear,A3SwitchYear,A4SwitchYear,A5SwitchYear,...
    A1ITNCov,A2ITNCov,A3ITNCov,A4ITNCov,A5ITNCov,...
    A1IRSCov,A2IRSCov,A3IRSCov,A4IRSCov,A5IRSCov] = multi_data_SSA_Kirare_cov;

for iReg = 1%:length(Regions)
    Sites  = eval(sprintf('%ssites',Regions{iReg}));
    for iSites = 4%:length(Sites)
        
        MfData  = eval(sprintf('%sMf','A5'));
        Vol     = eval(sprintf('%sVol',Sites{iSites}));
        
        % correct data for standard 1 mL blood volume
        if Vol == 20
            MfData(:,3)=floor(min(MfData(:,2),MfData(:,3)*1.95));
        elseif Vol == 100
            MfData(:,3)=floor(min(MfData(:,2),MfData(:,3)*1.15));
        end
        
        % load baseline fits
        load(sprintf('IntvFits_chi200_%s.mat',Sites{iSites}));
        
        figure; hold('on');
        
        % plot fits and mean
        %         mfPrevMean=mean(mfPrevArray,2);
        plot((1:length(mfPrevIntv(:,1)))/12,(mfPrevIntv(:,:)),'Color',[0.6 0.6 0.6]);
        
        % plot data with error bars
        MfData(:,1)=MfData(:,1)/12;
        aa = ConstructBinomialErrorBars(MfData);
        p1= errorbar(aa(:,1),aa(:,2),aa(:,3),aa(:,4),'xr');
        
        % format plot
        %         maxY=max(max(max(mfPrevArray*100)),max(aa(:,2)+aa(:,4))*1.1);
        %         h_title=title(sprintf('%s',Sites{iSites}));
        %         tpos=get(h_title,'Position');
        %         plot((1:length(mfPrevMean))/12,mfPrevMean(:,1:end)*100,'Color',...
        %             [0 0 0],'LineStyle','--','LineWidth',0.71);
        %         set(gca,'XLim',[0 MfData(end,4)],'YLim',[0 maxY],'fontsize',11,...
        %             'TickDir','out');
        xlabel('No. of Intervention years');
        ylabel('Mf Prevalence');
%         title('Scenario 1 (Pre-treatment data only)');
%         title('Scenario 2 (Pre-treatment+Post MDA3 data)');
%         title('Scenario 3 (Pre-treatment+Post MDA3+Post MDA5 data)');
        title('Scenario 4 (Pre-treatment+Post MDA5 data)');
        legend(p1,'Observed data');
        hold('off');
    end
end