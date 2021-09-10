%% add CommonFunctions folder containing basic model functions and Baseline folder containing baseline fits to path
addpath('../CommonFunctions/');
addpath('../BaselineFitting/Baseline_MATLAB');

%% User-defined inputs

% integration time step
da = 1; % 1 month

% Site details: Relevant endemic regions, Country (pertains only Sub-Saharan Africa cases), Village
Regions = {'SSA2';'SSA3';'SSA';'SSA1';'SSA4'; 'PNG'}; % at least one required
Countries = {'Nigeria';'Nigeria';'Mali';'Tanzania';'Mali'};% required only for SSA sites, names should follow format of Countries_w_Demo.mat
SSA2sites = {'DokanTofa'};
SSA3sites = {'Piapung'};
SSAsites = {'Dozanso'};
SSA1sites={'Kirare'};
SSA4sites = {'Missasso'};
PNGsites = {'Peneng'};

% Site data: Mf prevalence, blood sample volume, MDA regimen, MDA frequency,...
% MDA coverage, number of years of treatment, vector control, switch year
% arranged in region-specific .m data files created by the user
[ DokanTofaMf,PiapungMf,DozansoMf,KirareMf,MissassoMf,PenengMf,...
    DokanTofaVol,PiapungVol,DozansoVol,KirareVol,MissassoVol,PenengVol,...
    DokanTofaReg,PiapungReg,DozansoReg,KirareReg,MissassoReg,PenengReg,...
    DokanTofaFreq,PiapungFreq,DozansoFreq,KirareFreq,MissassoFreq,PenengFreq,...
    DokanTofaMDACov,PiapungMDACov,DozansoMDACov,KirareMDACov,MissassoMDACov,PenengMDACov,...
    DokanTofaNumYears,PiapungNumYears,DozansoNumYears,KirareNumYears,MissassoNumYears,PenengNumYears,...
    DokanTofaVC,PiapungVC,DozansoVC,KirareVC,MissassoVC,PenengVC,...
    DokanTofaSwitchYear,PiapungSwitchYear,DozansoSwitchYear,KirareSwitchYear,MissassoSwitchYear,PenengSwitchYear,...
    DokanTofaITNCov,PiapungITNCov,DozansoITNCov,KirareITNCov,MissassoITNCov,PenengITNCov,...
    DokanTofaIRSCov,PiapungIRSCov,DozansoIRSCov,KirareIRSCov,MissassoIRSCov,PenengIRSCov]...
    = PostIntv_data_SSA;

% Number of workers for parallel pool settings
NumWorkers = 4; % dependent on system capabilities

%% Intervention specifications

% Mass drug administration parameters
AgeLimits=[5 100]; % treatment for > 5 yrs old
RegimenEfficacy0 = [0.1 0.99 9; % IVM worm kill rate, mf kill rate, sterilization period (months)
    0.55 0.95 6; % DEC+ALB
    0.55 1 120; % IVM+DEC+ALB (permanent sterilization - 10 yrs)
    0.35 0.99 9; % IVM+ALB
    0.35 0 0; % ALB
    0.59 0.86 10; % DEC salt
    0.55 0.95 6;  % DEC+IVM
    0.35 0.90 3];  % DEC

% Vector control parameters
AnnualDecrease = 0;
IRSParams = [87.5, 93, 277, 6, 80]; % Vector control by indoor residual spraying
ITNParams = [20, 90, 97, 26, 12*3, 80]; % Vector control by long lasting insecticide nets
VCparams = SSA_IRS_ITN_Parameters(IRSParams,ITNParams,AnnualDecrease);

setupParallelPool(); % Initialize the parallel workers

%% Run fitting procedure for each site

for iReg =1%:%length(Regions)
    Sites  = eval(sprintf('%ssites',Regions{iReg}));
    for iSites = 1%:length(Sites)
        %% set up inputs
        
        % define data
        MfData  = eval(sprintf('%sMf',Sites{iSites}));
        Vol     = eval(sprintf('%sVol',Sites{iSites}));
        MDAReg = eval(sprintf('%sReg',Sites{iSites}));
        MDAFreq = eval(sprintf('%sFreq',Sites{iSites}));
        MDACov  = eval(sprintf('%sMDACov',Sites{iSites}));
        VC  = eval(sprintf('%sVC',Sites{iSites}));
        IRSCov  = eval(sprintf('%sIRSCov',Sites{iSites}));
        ITNCov  = eval(sprintf('%sITNCov',Sites{iSites}));
        NumYears  = eval(sprintf('%sNumYears',Sites{iSites}));
        SwitchYear  = eval(sprintf('%sSwitchYear',Sites{iSites}));
        
        % convert data into format compatible with model
        
        % correct mf data for blood sample volume
        if ~isnan(MfData(1,1)) && (Vol == 20)
            MfData(:,3)=floor(min(MfData(:,2),MfData(:,3)*1.95));
        elseif ~isnan(MfData(1,1)) && (Vol == 100 || Vol == 60)
            MfData(:,3)=floor(min(MfData(:,2),MfData(:,3)*1.15));
        end
        
        % Month to switch drug treatment regimen
        SwitchMonth = zeros(1,length(SwitchYear));
        for h = 1:length(SwitchYear)
            if SwitchYear(h) == 0
                SwitchMonth(h) = 0;
            else
                SwitchMonth(h) = SwitchYear(h)*12;
            end
        end
        
        % %
%         %        for kirare and alagramam
%         %          MDA Frequency
%                 MDAInterval = MDAFreq;
%         
%                 % MDA coverage
%                 MonthlyMDACov = zeros(NumYears*12,1);
%         
%                 for i=2:length(MDAFreq)
%                     MonthlyMDACov(MDAFreq(i-1):MDAFreq(i))=MDACov(i-1);
%                 end
%         
%                 % MDA Drug Regimen Efficacy
%                 RegimenEfficacy = zeros(length(MDAReg),length(RegimenEfficacy0(1,:)));
%                 for j = 1:length(MDAReg)
%                     RegimenEfficacy(j,:) = RegimenEfficacy0(MDAReg(j),:);
%                 end
        % % %
        
        
        
%         % MDA Frequency
        MDAInterval = zeros(1,NumYears*12);
        if length(MDAFreq)==1
            MDAInterval(1,1:end) = MDAFreq(1);
        else
            MDAInterval(1,1:SwitchMonth) = MDAFreq(1);
            MDAInterval(1,SwitchMonth+1:end) = MDAFreq(2);
        end
        
        % MDA Drug Regimen Efficacy
        RegimenEfficacy = zeros(length(MDAReg),length(RegimenEfficacy0(1,:)));
        for j = 1:length(MDAReg)
            RegimenEfficacy(j,:) = RegimenEfficacy0(MDAReg(j),:);
        end
        
        % MDA Coverage
        MonthlyMDACov = zeros(NumYears*12,1);
        for i = 1:length(MDACov)
            MonthlyMDACov((i-1)*MDAFreq(1)+1:i*MDAFreq(1)) = MDACov(i);
        end
        %
        % VC coverages
        IRSCoverages=ones(1,NumYears*12)*IRSCov;
        ITNCoverages=ones(1,NumYears*12)*ITNCov;
        
        %% load baseline fits
        % ABR, L3Values, ParameterVectors, ageMthMax, bCulex, demog, mfPrevArray are loaded.
        load(sprintf('ParamVectors%s.mat',Sites{iSites}));
        MultiVecMBR = ABR/12;
        kId = 1:length(ABR);
        
        
        RandStream.setGlobalStream(RandStream('mt19937ar','seed',1));
        reset(RandStream('mt19937ar','seed',1)); % reset so initial sample draw is the same
        
        
        WormKill = 0.3 + 0.4*rand(length(mfPrevArray(1,:)),1);  % for MDA
%                  WormKill = 0.55+ 0.0*rand(length(mfPrevArray(1,:)),1);  % for IDA
        %          WormKill = 0.5 + 0.4*rand(length(mfPrevArray(1,:)),1);  % for DECsalt
        %
        %% model interventions
        
        % run interventions as observed
        
        
        % DokanTofaEliminThresholdABR(0.5;0.75;0.9;0.95)=[0.044005	0.015743	0.005752	0.003109];
        % PiapungEliminThresholdABR(0.5;0.75;0.9;0.95)=[0.046290	0.014326	0.003369	0.001550];
        % DozansoEliminThresholdABR(0.5;0.75;0.9;0.95)=[0.050149	0.025042	0.003110	0.001101];
        % KirareEliminThresholdABR(0.5;0.75;0.9;0.95)=[0.037849	0.018811	0.006469	0.001799];
        % MissassoEliminThresholdABR(0.5;0.75;0.9;0.95)=[0.055674	0.016483	0.003135	0.000750];
        % PenengEliminThresholdABR(0.5;0.75;0.9;0.95)=[0.031993	0.016701	0.007572	0.004534];
        
        % DokanTofaEliminThresholdTBR(0.5;0.75;0.9;0.95)=[0.884560	0.433816	0.243900	0.139108];
        % PiapungEliminThresholdTBR(0.5;0.75;0.9;0.95)=[1.665305	1.020304	0.535122	0.205402];
        % DozansoEliminThresholdTBR(0.5;0.75;0.9;0.95)=[1.966066	0.598658	0.087031	0.038734];
        % KirareEliminThresholdTBR(0.5;0.75;0.9;0.95)=[1.243037	0.709644	0.407405	0.296635];
        % MissassoEliminThresholdTBR(0.5;0.75;0.9;0.95)=[1.642060	0.696904	0.184782	0.080041];
        % PenengEliminThresholdTBR(0.5;0.75;0.9;0.95)=[1.746488	1.102214	0.670260	0.518994];
        EP_Th_ABR=zeros(6,4);
        EP_Th_TBR=zeros(6,4);
        
        EP_Th_ABR(1:6,3)=[0.003109, 0.001550, 0.001101, 0.001799, 0.000750, 0.004534]; % bi_R-eff method
        EP_Th_TBR(1:6,3)=[0.139108, 0.205402, 0.038734, 0.296635, 0.080041, 0.518994]; % bi_R-eff method
        
        EP_Th_ABR(1:6,1)=[0.044005, 0.046290, 0.050149, 0.037849, 0.055674, 0.031993]; % bi_R-eff method
        EP_Th_TBR(1:6,1)=[0.884560, 1.665305, 1.966066, 1.243037, 1.642060, 1.746488]; % bi_R-eff method
        
        EP_Th_ABR(1:6,2)=[0.015743, 0.014326, 0.025042, 0.018811, 0.016483, 0.016701]; % bi_R-eff method
        EP_Th_TBR(1:6,2)=[0.433816, 1.020304, 0.598658, 0.709644, 0.696904, 1.102214]; % bi_R-eff method
        
        EP_Th_ABR(1:6,4)=[1, 1, 1, 1, 1, 1]; % WHO
        EP_Th_TBR(1:6,4)=[1, 1, 1, 1, 1, 1]; % WHO
        %         EP_Th_ABR=[0.006614, 0.007578, 0.011843, 0.006651, 0.009766, 0.006528]; % R-eff method
        %         EP_Th_TBR=[0.139128, 0.478895, 0.682548, 0.333045, 0.426618, 0.584660]; % R-eff method
        
        %         EP_Th_ABR=[0.000117, 0.000065, 0.000007, 0.000034, 0.000105, 0.000241]; % Bisection method
        %         EP_Th_TBR=[0.031017, 0.041388, 0.018659, 0.037083, 0.007987, 0.065918]; % Bisection method
        
        % run interventions up to 1% then stop for 5 years
        % run intervention with or without vc
        
        
        
        for i=3%:4
            [mfPrevIntv1,MBRIntv1,L3Intv1] =...
            Modelling_MDAplusVC_WK(kId,...
            ParameterVectors,L3Values,demog,ageMthMax,...
            da,bCulex,AgeLimits,RegimenEfficacy,MDAInterval,...
            NumYears,MultiVecMBR,IRSCoverages,ITNCoverages,MonthlyMDACov,...
            SwitchMonth,VCparams,WormKill);
        
        tWHO = 49;
            
            tWHO2 = Time_toCross_below_Threshold_mean(mfPrevIntv1,EP_Th_ABR(iReg,i));
            
            tWHO1 = 217; % finds month where 1% is reached
            NumYears = (((tWHO1-1)/12)+20); % change number of years to simulation
            MonthlyMDACov(tWHO1:NumYears*12) = 0; % change MDA cov to zero after crossing threshold
            ITNCoverages(tWHO1:NumYears*12) = 0; % change ITN cov to zero after crossing threshold
            IRSCoverages(tWHO1:NumYears*12) = 0;
            MDAInterval(tWHO1:NumYears*12) = 0;
            
            % MonthlyMDACov(((((tWHO1-1)/12)+8)*12):NumYears*12) = 0; % change MDA cov to zero after crossing threshold
            % ITNCoverages(((((tWHO1-1)/12)+8)*12):NumYears*12) = 0; % change ITN cov to zero after crossing threshold
            % IRSCoverages(((((tWHO1-1)/12)+8)*12):NumYears*12) = 0;
            % MDAInterval(((((tWHO1-1)/12)+8)*12):NumYears*12) = 0;
            
            [mfPrevIntv3,MBRIntv3,L3Intv3] =...
                Modelling_MDAplusVC_WK(kId,...
                ParameterVectors,L3Values,demog,ageMthMax,da,bCulex,...
                AgeLimits,RegimenEfficacy,MDAInterval,NumYears,...
                MultiVecMBR,IRSCoverages,ITNCoverages,MonthlyMDACov,SwitchMonth,VCparams,WormKill);
            
             count = 0; % count number of curves that rise back to 1%
            id1 = []; % curves that rise back to 1%
            id2 = []; % curves that stay below 1%
            for j = 1:length(mfPrevIntv3(1,:))
                if ( mfPrevIntv3((((tWHO1-1)/12)+5)*12,j)>mfPrevIntv3(tWHO1,j))
                    id1 = [id1,j];
                    count = count + 1;
                else
                    id2 = [id2,j];
                end
            end
            
            prec1 = round(length(id1)/(length([id1,id2]))*100);
            
            count1 = 0; % count number of curves that rise back to 1%
            id3 = []; % curves that rise back to 1%
            id4 = []; % curves that stay below 1%
            %     p=find(mfPrevIntv3(tWHO1,:)<=EP_Th_ABR(iReg));
            for j = 1:length(mfPrevIntv3(1,:))
                if ( mfPrevIntv3((((tWHO1-1)/12)+5)*12,j)<mfPrevIntv3(tWHO1,j) )
                    id3 = [id3,j];
                    count1 = count1 + 1;
                else
                    id4 = [id4,j];
                end
            end
            prec2 = round(length(id4)/(length([id3,id4]))*100);
            prec3 = round(length(id3)/(length([id3,id4]))*100);
            
            count1 = 0; % count number of curves that rise back to 1%
            id5 = []; % curves that rise back to 1%
            id6 = []; % curves that stay below 1%
%             %     p=find(mfPrevIntv3(tWHO1,:)<=EP_Th_ABR(iReg));
            for j = 1:length(mfPrevIntv3(1,:))
                if (mfPrevIntv3((((tWHO1-1)/12)+20)*12,j)>mfPrevIntv3(tWHO1,j) ) 
                    id5 = [id5,j];
                    count1 = count1 + 1;
                else
                    id6 = [id6,j];
                end
            end
            
            prec4 = round(length(id5)/(length([id5,id6]))*100);
            
            count1 = 0;
    id7 = []; % curves that rise back to 1%
    id8 = []; % curves that stay below 1%
    for j = 1:length(mfPrevIntv3(1,:))
        if ( mfPrevIntv3((((tWHO1-1)/12)+20)*12,j)<mfPrevIntv3(tWHO1,j))
            id7 = [id7,j];
            count1 = count1 + 1;
        else
            id8 = [id8,j];
        end
    end
    prec5 = round(length(id8)/(length([id7,id8]))*100);
    prec6 = round(length(id7)/(length([id7,id8]))*100);
            
            
            save(sprintf('Intv_EP_MDAan_40to69_%s.mat',char(Sites{iSites})),...
                'mfPrevIntv1','MBRIntv1','L3Intv1','RegimenEfficacy',...
                'MonthlyMDACov','IRSCoverages',...
                'ITNCoverages','MfData','SwitchMonth','mfPrevIntv3',...
                'MBRIntv3','L3Intv3','tWHO1','WormKill','prec1','prec2',...
                'prec3','prec4','prec5','prec6','id1','id2','id3',...
                'id4','id5','id6','id7','id8','tWHO','tWHO2');
        end
        
    end
end
