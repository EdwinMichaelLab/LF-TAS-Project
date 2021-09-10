% Sample baseline data for sites Masaika,TZ, Kingwede,KEN, and Kirare,TZ 

function [ TirukoilurgrAMf,TirukoilurgrAVol,TirukoilurgrAABR,TirukoilurgrAbCulex,...
    TirukoilurgrBMf,TirukoilurgrBVol,TirukoilurgrBABR,TirukoilurgrBbCulex,...
    TirukoilurgrCMf,TirukoilurgrCVol,TirukoilurgrCABR,TirukoilurgrCbCulex]...
    = baseline_data_Tirukoilur

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
TirukoilurgrAMf = [34.5 724 round(0.1519*724) 69];
TirukoilurgrBMf = [34.5 795 round(0.1509*795) 69];
TirukoilurgrCMf = [34.5 647 round(0.1453*647) 69];


%% Blood sample volume used to test presence of mf (in uL)
% Standard volumes are 1000 uL, 100 uL, or 20 uL (60 uL uses 100 uL
% correction)
% Model operates based on 1 mL samples, so smaller samples will be
% corrected to reflect this

TirukoilurgrAVol = 20; 
TirukoilurgrBVol = 20;
TirukoilurgrCVol = 20;%% simplified into one column

%% Baseline ABR data
% If not available for a particular site, enter value as NaN

TirukoilurgrAABR = NaN; 
TirukoilurgrBABR = NaN;
TirukoilurgrCABR = NaN;%% simplified into one column


%% Mosquito species flag based on dominant genera (0: Anopheles, 1: Culex)

TirukoilurgrAbCulex = 0;
TirukoilurgrBbCulex = 0;
TirukoilurgrCbCulex = 0;%% simplified into one colume,  name change to specy.

end
