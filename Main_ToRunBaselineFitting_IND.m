%% add CommonFunctions folder containing basic model functions to path
addpath('../../CommonFunctions/'); 

%% User-defined inputs

% Parameters related to sampling and resampling
NParamVecs = 200000; % default: 200000
SIR_samples = 500; % default: 500

% Site details: Relevant endemic regions, Country (pertains only Sub-Saharan Africa cases), Village
Regions = {'IND';}; % at least one required

% Below required only for SSA sites, names should follow format of Countries_w_Demo.mat
Countries = {'India'}; 
INDsites = {'Alagramam'};

% Site data: Mf prevalence, blood sample volume, ABR, vector genera
% arranged in region-specific .m data files created by the user
% [ DozansoMf,DozansoVol,DozansoABR,DozansobCulex]...
%     = baseline_data_SSA;
[ AlagramamMf,AlagramamVol,AlagramamABR,AlagramambCulex]...
    = baseline_data_IND;

% ABR range for use in sites without baseline ABR data
ABRmin = 18000; % Use default value, won't increase computaiton intensitivity
ABRmax = 22000; 

% Mf range for use in sites without baseline Mf data  % when this data will be used, mark!!!
minPrev = 0.05;
maxPrev = 0.60; 

%NumWorkers = 4; % This has moved to CommonFunctions/setupParallelPool
setupParallelPool();

%% Import country-level age-demographics of SSA countries if needed

if ~isempty(Countries)
    Import_subSaharanCountries_demoA_demoB;  % Yang load data from file
    load('Countries_w_demo.mat','Country_demo');
end


%% Run fitting procedure for each site
%% Based on the data we have originally,  mf (age profile or overall mf) and CFA inclusion

for iReg = 1%:length(Regions)
    Sites  = eval(sprintf('%ssites',Regions{iReg}));  % Yang 'sprintf' form strings, 'eval' connects the string and varialbe 
    for iSites = 1   %:length(Sites)   % Loop run for only once since "%" deactivate ":length(Sites)"
        % define data
        MfData  = eval(sprintf('%sMf',Sites{iSites}));
        Vol     = eval(sprintf('%sVol',Sites{iSites}));
        bCulex  = eval(sprintf('%sbCulex',Sites{iSites}));   % column name change to specy ??
        ABR     = eval(sprintf('%sABR',Sites{iSites}));
        
        % define demographic parameters
        if strcmp(Regions{iReg},'SSA') % Sub-Saharan Africa demographic parameters by Country  if the region is SSA
            [demoA1, demoB1] = get_demoA_and_demoB(Countries{iSites},...  %% get the demoA and demoB by Country's name
                Country_demo,demoA,demoB);
        else
            demoA1 = 0.0361; demoB1 = 0.0304; % India and PNG demographic parameters
        end
        
        % adjust mf data for blood sample volume
        if ~isnan(MfData(1,1)) && (Vol == 20)
            MfData(:,3)=floor(min(MfData(:,2),MfData(:,3)*1.95));  % column: # positive/  floor rounds to smaller integer 
        elseif ~isnan(MfData(1,1)) && (Vol == 100 || Vol == 60)    % column: # positive/  floor rounds to smaller integer
            MfData(:,3)=floor(min(MfData(:,2),MfData(:,3)*1.15));  % standard blood sample size:1000 muL
        end
        
        % find maximum age in population
        if isnan(MfData)  % here should be: MfData(:,4)????
            ageMax = 69;
        else
            ageMax = max(MfData(:,4));   % 4th column
        end
        
        % if ABR data not availabe, sample ABR as a parameter
        if isnan(ABR)   % if this sampling is correct? the job it does is to evenly generate NParamVecs ABR between ABRmin and ABRmax
            ABR = ABRmin + ...
                (ABRmax-ABRmin)*lhsdesign(1,NParamVecs,'criterion','correlation');  
                % (Yang) Criterion: reduce correlation, NParamVecs as defined, maybe 'randomsample' is better here
        end
        
        % All possibilities will be ran out of this if statement: AgeMf_asInput, 
        %       OverallMf_asInput, OverallMfRange_asInput.   12-13-17 CJK
        RunSelectParameterVectors_wCFA(Sites{iSites},NParamVecs,MfData,ABR,SIR_samples,...
            demoA1,demoB1,ageMax,bCulex,minPrev,maxPrev)
    end
end
