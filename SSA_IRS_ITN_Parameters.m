function VCparams = SSA_IRS_ITN_Parameters(IRSParams,...
    ITNParams,AnnualDecrease)
% The following are the names of vector control parameters for IRS
% (Indoor Residual Spray) and ITN/LLIN (Insecticide Treated Net/Long Lasting
% Insecticidal Net; ITN parameters are being treated as if they are for LLIN)
% IRS:->
% IRS Repel Efficacy; IRS Kill Efficacy; IRS Efficacy Decay Rate;
% IRS Replacement Period; IRS coverage; (5 IRS parameters)
% ITN:->
% ITN Deter Efficacy; ITN Repel Efficacy; ITN Kill Efficacy;
% ITN Efficacy Decay Rate; ITN replacement Period; ITN coverage; (6 params)
%
% AnnualDecrease is the rate at which ABR may decrease as a result of VC;
VCparams = zeros(1,12);
% IRS
VCparams(1)=IRSParams(1)/100;
VCparams(2)=IRSParams(2)/100;
VCparams(3)=IRSParams(3)/100;
VCparams(4)=IRSParams(4);
VCparams(5)=IRSParams(5)/100;
% ITN
VCparams(6)=ITNParams(1)/100;
VCparams(7)=ITNParams(2)/100;
VCparams(8)=ITNParams(3)/100;
VCparams(9)=ITNParams(4)/100;
VCparams(10)=ITNParams(5);
VCparams(11)=ITNParams(6)/100;
VCparams(12)=max(VCparams(5),VCparams(11))*AnnualDecrease/100;
end
