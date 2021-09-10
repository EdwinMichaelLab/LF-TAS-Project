% Sample baseline data for sites Masaika,TZ, Kingwede,KEN, and Kirare,TZ 

function [ DokanTofaMf,PiapungMf,...
    DokanTofaVol,PiapungVol,...
    DokanTofaABR,PiapungABR,...
    DokanTofabCulex,PiapungbCulex]...
    = baseline_data_SSA
%% Baseline Mf Data
% Best data to provide would be age-stratified prevalence
% Variable names = {SiteName}Mf

% 1st column = mid-age of group; 2nd: Total number of samples; 3rd: Mf +ves;
% 4th: upper age of group

% If age-stratified data is not available, enter overall community
% prevalence in a single line following the column definitions above
DokanTofaMf = [4.5 49 1 9
    14.5 137 4 19
    24.5 101 8 29
    34.5 61	4 39
    44.5 33	2 49
    54.5 24	1 59
    64.5 10	1 69
    74.5 4	0 79];
PiapungMf = [4.5 62	1 9
    14.5 100 3 19
    24.5 74	5 29
    34.5 66	8 39
    44.5 43	6 49
    54.5 36	12 59
    64.5 14	3 69
    74.5 8	2 79];

%% Blood sample volume used to test presence of mf (in uL)
% Standard volumes are 1000 uL, 100 uL, or 20 uL (60 uL uses 100 uL
% correction)
% Model operates based on 1 mL samples, so smaller samples will be
% corrected to reflect this

DokanTofaVol = 60; 
PiapungVol = 60;

%% Baseline ABR data
% If not available for a particular site, enter value as NaN

DokanTofaABR = NaN; 
PiapungABR = NaN; 

%% Mosquito species flag based on dominant genera (0: Anopheles, 1: Culex)

DokanTofabCulex = 0;
PiapungbCulex = 0; 

end
