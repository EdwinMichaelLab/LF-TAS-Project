% Site data: Mf prevalence, blood sample volume, MDA regimen, MDA frequency,...
% MDA coverage, number of years of treatment, vector control, switch year

function [ DokanTofaMf,PiapungMf,DozansoMf,KirareMf,MissassoMf,PenengMf,...
    DokanTofaVol,PiapungVol,DozansoVol,KirareVol,MissassoVol,PenengVol,...
    DokanTofaReg,PiapungReg,DozansoReg,KirareReg,MissassoReg,PenengReg,...
    DokanTofaFreq,PiapungFreq,DozansoFreq,KirareFreq,MissassoFreq,PenengFreq,...
    DokanTofaMDACov,PiapungMDACov,DozansoMDACov,KirareMDACov,MissassoMDACov,PenengMDACov,...
    DokanTofaNumYears,PiapungNumYears,DozansoNumYears,KirareNumYears,MissassoNumYears,PenengNumYears,...
    DokanTofaVC,PiapungVC,DozansoVC,KirareVC,MissassoVC,PenengVC,...
    DokanTofaSwitchYear,PiapungSwitchYear,DozansoSwitchYear,KirareSwitchYear,MissassoSwitchYear,PenengSwitchYear,...
    DokanTofaITNCov,PiapungITNCov,DozansoITNCov,KirareITNCov,MissassoITNCov,PenengITNCov,...
    DokanTofaIRSCov,PiapungIRSCov,DozansoIRSCov,KirareIRSCov,MissassoIRSCov,PenengIRSCov]...
    = PostIntv_data_SSA
%% Post-intervention Mf Data
% enter overall community prevalence in a single line
% 1st column = month of survey; 2nd: Total number of samples; 3rd: Mf +ves;
DokanTofaMf = [(2005-2003)*12+1 236 7
    (2006-2003)*12+1 132 0
    (2007-2003)*12+1 151 2
    (2008-2003)*12+1 158 0
    (2009-2003)*12+1 223 1];
PiapungMf = [(2005-2003)*12+1 256 11
    (2006-2003)*12+1 160 6
    (2007-2003)*12+1 187 18
    (2009-2003)*12+1 291 6];
DozansoMf = [(2002-2002)*12+1 120 round(0.4*120);
               (2008-2002)*12+1 86 0];
KirareMf=[(2004-2004)*12+1 471 round(0.261*471);
               (2005-2004)*12+4 461 round(0.208*461);
               (2006-2004)*12+7 438 round(0.158*438);
               (2008-2004)*12+4 302 round(0.129*302);
               (2009-2004)*12+1 259 round(0.05*259);
               (2010-2004)*12+2 400 round(0.044*400);
               (2011-2004)*12+2 393 round(0.027*393)];
MissassoMf=[(2002-2002)*12+1 207 round(0.2*207);
               (2008-2002)*12+1 138 0];
PenengMf=[(1994-1994)*12+1 63 round(0.667*63);
               (1995-1994)*12+1 65 round(0.615*65);
               (1996-1994)*12+1 88 round(0.205*88);
               (1997-1994)*12+1 89 round(0.135*89);
               (1998-1994)*12+1 92 round(0.054*92);
               (1999-1994)*12+1 109 round(0.037*109)];


%% Blood sample volume used to test presence of mf (in uL)
% Standard volumes are 1000 uL, 100 uL, or 20 uL (60 uL uses 100 uL
% correction)
% Model operates based on 1 mL samples, so smaller samples will be
% corrected to reflect this
DokanTofaVol = 60; 
PiapungVol = 60;
DozansoVol=60;
KirareVol=100;
MissassoVol=60;
PenengVol=1000;


%% MDA Regimen 
% if more than one treatment regimen, given frequency for each regimen
% (i.e. [5,2] for ALB followed by DEC+ALB)

% 1: IVM 
% 2: DEC+ALB
% 3: IVM+DEC+ALB
% 4: IVM+ALB
% 5: ALB
% 6: DEC salt
% 7: DEC+IVM
% 8: DEC
DokanTofaReg = [4]; 
PiapungReg = [4];
DozansoReg=[4];
KirareReg=[4];
MissassoReg=[4];
PenengReg=[7];


%% MDA Frequency
% in months
% if more than one treatment regimen, given frequency for each regimen
% (i.e. [12,6] for annual followed by biannial)
DokanTofaFreq = [12]; 
PiapungFreq = [12];
DozansoFreq=[12];
KirareFreq=[1,17,32,53,62,75,87,99,111,123,135,147,159,171,183,195,207,219,231,243,255,267,279,291,303,315,327,339,351,363,375,387,399,411,423,435,447,459,471,483,495,507,519,531,543,555,567,579,591,603]; 
MissassoFreq=[12];%[1,7,22,37,52,66,78,90,102,114,126,138,150,162,174,186,198,210,222,234,246,258,270,282,294,306,318,330,342,354,366,378,390,402,414,426,438,450,462,474,486,498,510,522,534,546,558,570,582,594];
PenengFreq=[12];


%% Annual MDA Coverage
% enter as proportion (i.e. 0.8)
DokanTofaMDACov = [74.9 76.7 67.4 77.6 77.1 78.3 78.2 76 76 76 76 76 76 76 76 76 76 76 76 76 76 76 76 76 76 76 76 76 76 76 76 76 76 76 76 76 76 76 76 76 76 76 76 76 76 76 76 76 76 76]/100; % 2003-2009 
PiapungMDACov = [70.2 72.0 78.0 78.5 80.1 79.2 78.9 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77]/100; % 2003-2009
DozansoMDACov=[0.725 0.725 0.725 0.725 0.725 0.896 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75]; % 2002-2007
KirareMDACov=[0.724,0.695,0.615,0.588,0.76,0.598,0.66,0.66,0.66,0.66,0.66,0.66,0.66,0.66,0.66,0.66,0.66,0.66,0.66,0.66,0.66,0.66,0.66,0.66,0.66,0.66,0.66,0.66,0.66,0.66,0.66,0.66,0.66,0.66,0.66,0.66,0.66,0.66,0.66,0.66,0.66,0.66,0.66,0.66,0.66,0.66,0.66,0.66,0.66,0.66];
MissassoMDACov=[0.725 0.725 0.725 0.725 0.725 0.896 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75]; % 2002-2007
PenengMDACov=[0.50 0.78 0.75 0.68 0.72 0.69 0.69 0.69 0.69 0.69 0.69 0.69 0.69 0.69 0.69 0.69 0.69 0.69 0.69 0.69 0.69 0.69 0.69 0.69 0.69 0.69 0.69 0.69 0.69 0.69 0.69 0.69 0.69 0.69 0.69 0.69 0.69 0.69 0.69 0.69 0.69 0.69 0.69 0.69 0.69 0.69 0.69 0.69 0.69 0.69]; % 1994-2023
% PenengMDACov=0.70*ones(1,50);
%% Total number of years of treatment
% (last year - first year) + 1
DokanTofaNumYears = 50;
PiapungNumYears = 50;
DozansoNumYears=50;
KirareNumYears=50;
MissassoNumYears=50;
PenengNumYears=50;

%% Vector control
% 0: no VC, 1: VC
DokanTofaVC = 0;
PiapungVC = 0;
DozansoVC=0;
KirareVC=0;
MissassoVC=0;
PenengVC=0;

%% Year to switch treatment regimens
% enter 0 if a single treatment regimen is followed
DokanTofaSwitchYear = 0; 
PiapungSwitchYear = 0;
DozansoSwitchYear=0;
KirareSwitchYear=0;
MissassoSwitchYear=0;
PenengSwitchYear=0;

%% Vector control Coverage
% enter as proportion (i.e. 0.8)
DokanTofaITNCov = 0; % assumed - Emily thinks nets were present but not as high as Seri
PiapungITNCov = 0; % assumed - Emily thinks nets were present but not as high as Seri
DozansoITNCov=0;
KirareITNCov=0;
MissassoITNCov=0;
PenengITNCov=0;

DokanTofaIRSCov = 0; 
PiapungIRSCov = 0;
DozansoIRSCov=0;
KirareIRSCov=0;
MissassoIRSCov=0;
PenengIRSCov=0;

end
