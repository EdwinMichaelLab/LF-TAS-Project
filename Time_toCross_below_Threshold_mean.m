function time = Time_toCross_below_Threshold_mean(MfPrevArray,EP_Th)
[m,n] = size(MfPrevArray);
timeX = [];
for i = 1:n
    id = find(MfPrevArray(1:12:m,i) < EP_Th);
    if ~isempty(id)
        timeX = [timeX; id(1)-1];
    else
        timeX= [timeX; (m-1)/12];
    end
end
% time = 1 + max(timeX)*12; %all curves pass through threshold
% time = 1 + median(timeX)*12; % median time to pass through threshold
% time = 1 + round(prctile(timeX,95))*12; % 95% of curves pass through threshold
time = 1 + mean(timeX)*12; % mean time to pass through threshold
% time = 1 + round(prctile(timeX,100))*12;
end