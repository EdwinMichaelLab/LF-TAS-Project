figure;
subplot(1,2,1)
% c = colormap(lines(3));
y1 = [91 96];% 61 61; 99.8 70];
x1=1:2
b1=bar(x1,y1);
hold on;
y2=[92 80];
x2=4:5
b2=bar(x2,y2);
hold on;
y3=[50 68];
x3=7:8
b3=bar(x3,y3);

hold on;
set(gca,'YLim',[0 100]);
set(gca,'xticklabels',[]);%{'Low prev','         Med prev      ','high prev'});
    ylabel('Recrudescence probability (%)','FontSize',15);
    
hold on;

subplot(1,2,2)
% c = colormap(lines(3));
y1 = [5 11];% 61 61; 99.8 70];
x1=1:2
b1=bar(x1,y1);
hold on;
y2=[2 2];
x2=4:5
b2=bar(x2,y2);
hold on;
y3=[1 5];
x3=7:8
b3=bar(x3,y3);
% b = bar(y,'FaceColor','flat');
% b(4).CData = [0.5 0.5 0.5];
% % for k = 1:size(y,2)
% %     b(k).CData = k;
% % end
% xlim = get(gca,'XLim');
set(gca,'YLim',[0 100]);
set(gca,'xticklabels',[]);%{'Low prev','         Med prev      ','high prev'});
    ylabel('Recrudescence probability (%)','FontSize',15);