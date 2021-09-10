function[ PenengMf,PenengVol,PenengABR,PenengbCulex]...
    = baseline_data_PNG
%% Baseline Mf Data
% Best data to provide would be age-stratified prevalence
% Variable names = {SiteName}Mf

% 1st column = mid-age of group; 2nd: Total number of samples; 3rd: Mf +ves;
% 4th: upper age of group

% If age-stratified data is not available, enter overall community
% prevalence in a single line following the column definitions above
% DokanTofaMf = [4.5 49 1 9;
%     14.5 137 4 19;
%     24.5 101 8 29;
%     34.5 61 4 39;
%     44.5 33 2 49;
%     54.5 24 1 59;
%     64.5 10 1 69;
%     74.5 4 0 79]
% DozansoMf = [34.5 120 round(0.4*120) 69];
PenengMf = [34.5 63 round(0.667*63) 69];


%% Blood sample volume used to test presence of mf (in uL)
% Standard volumes are 1000 uL, 100 uL, or 20 uL (60 uL uses 100 uL
% correction)
% Model operates based on 1 mL samples, so smaller samples will be
% corrected to reflect this

% DozansoVol = 60;  %% simplified into one column
PenengVol = 1000;

%% Baseline ABR data
% If not available for a particular site, enter value as NaN

% DozansoABR = 605.9;  %% simplified into one column
PenengABR = 8194;

%% Mosquito species flag based on dominant genera (0: Anopheles, 1: Culex)

% DozansobCulex = 0;  %% simplified into one colume,  name change to specy.
PenengbCulex = 0;

end
