load('IntvPeneng.mat');
count = 0; % count number of curves that rise back to 1%
id1 = []; % curves that rise back to 1%
id2 = []; % curves that stay below 1%
for j = 1:length(mfPrevIntv2(1,:))
    if (mfPrevIntv2(end,j)>1)
        id1 = [id1,j];
        count = count + 1;
    else
        id2 = [id2,j];
    end
end

prec = round(length(id1)/(length([id1,id2]))*100);

figure;

for i=1:length(id1)
    plot((1:length(mfPrevIntv2(:,1)))/12,(mfPrevIntv2(:,id1(i))/mfPrevIntv2(1,id1(i))),'Color','r');
    hold on;
end

for i=1:length(id1)
    a(i)=(mfPrevIntv2(end,id1(i))/mfPrevIntv2(1,id1(i)));
    
end
% a1=prctile(a,2.5);
% a2=prctile(a,97.5);
amax=max(a);
amin=min(a);