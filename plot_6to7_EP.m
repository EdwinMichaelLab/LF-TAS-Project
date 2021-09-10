subplot(2,3,1)
load('Intv_bp_MDA_6to7_DokanTofa.mat')
id=[];
for j = 1:length(mfPrevIntv3(1,:))
    if (mfPrevIntv3(421,j)<0.1)
         id = [id,j];
    end

end
semilogy((1:length(mfPrevIntv3(:,1)))/12,(mfPrevIntv3(:,id)),'Color',[0.6 0.6 0.6]);
hold on
plot([0 35],[0.5 0.5],'--r');
hold on;
a=(tWHO1-1)/12;
plot([a a],[10^-15 100],'--b');
hold on;
plot([a+5 a+5],[10^-15 100],'--k');
hold on;
set(gca,'XLim',[0 35]);
hold on;
set(gca,'YLim',[10^-14 100]);
hold on;
title("DokanTofa");
ylabel("Mf prevalence(%)");
xlabel("No. of years");
hold on;

subplot(2,3,2)
load('Intv_bp_MDA_6to7_Missasso.mat')
id=[];
for j = 1:length(mfPrevIntv3(1,:))
    if (mfPrevIntv3(421,j)<0.1)
         id = [id,j];
    end

end
semilogy((1:length(mfPrevIntv3(:,1)))/12,(mfPrevIntv3(:,id)),'Color',[0.6 0.6 0.6]);
hold on
plot([0 35],[0.5 0.5],'--r');
hold on;
a=(tWHO1-1)/12;
plot([a a],[10^-15 100],'--b');
hold on;
plot([a+5 a+5],[10^-15 100],'--k');
hold on;
set(gca,'XLim',[0 35]);
hold on;
set(gca,'YLim',[10^-14 100]);
hold on;
title("Missasso");
ylabel("Mf prevalence(%)");
xlabel("No. of years");
hold on;

subplot(2,3,3)
load('Intv_bp_MDA_6to7_Peneng.mat')
id=[];
for j = 1:length(mfPrevIntv3(1,:))
    if (mfPrevIntv3(421,j)<0.1)
         id = [id,j];
    end

end
semilogy((1:length(mfPrevIntv3(:,1)))/12,(mfPrevIntv3(:,id)),'Color',[0.6 0.6 0.6]);
hold on
plot([0 35],[0.5 0.5],'--r');
hold on;
a=(tWHO1-1)/12;
plot([a a],[10^-15 100],'--b');
hold on;
plot([a+5 a+5],[10^-15 100],'--k');
hold on;
set(gca,'XLim',[0 35]);
hold on;
set(gca,'YLim',[10^-14 100]);
hold on;
title("Peneng");
ylabel("Mf prevalence(%)");
xlabel("No. of years");
hold on;

subplot(2,3,4)
load('Intv_bp_MDA_6to7_Piapung.mat')
id=[];
for j = 1:length(mfPrevIntv3(1,:))
    if (mfPrevIntv3(421,j)<0.1)
         id = [id,j];
    end

end
semilogy((1:length(mfPrevIntv3(:,1)))/12,(mfPrevIntv3(:,id)),'Color',[0.6 0.6 0.6]);
hold on
plot([0 35],[0.5 0.5],'--r');
hold on;
a=(tWHO1-1)/12;
plot([a a],[10^-15 100],'--b');
hold on;
plot([a+5 a+5],[10^-15 100],'--k');
hold on;
set(gca,'XLim',[0 35]);
hold on;
set(gca,'YLim',[10^-14 100]);
hold on;
title("Piapung");
ylabel("Mf prevalence(%)");
xlabel("No. of years");
hold on;

subplot(2,3,5)
load('Intv_bp_MDA_6to7_Kirare.mat')
id=[];
for j = 1:length(mfPrevIntv3(1,:))
    if (mfPrevIntv3(421,j)<0.1)
         id = [id,j];
    end

end
semilogy((1:length(mfPrevIntv3(:,1)))/12,(mfPrevIntv3(:,id)),'Color',[0.6 0.6 0.6]);
hold on
plot([0 35],[0.5 0.5],'--r');
hold on;
a=(tWHO1-1)/12;
plot([a a],[10^-15 100],'--b');
hold on;
plot([a+5 a+5],[10^-15 100],'--k');
hold on;
set(gca,'XLim',[0 35]);
hold on;
set(gca,'YLim',[10^-14 100]);
hold on;
title("Kirare");
ylabel("Mf prevalence(%)");
xlabel("No. of years");
hold on;

subplot(2,3,6)
load('Intv_bp_MDA_6to7_Dozanso.mat')
id=[];
for j = 1:length(mfPrevIntv3(1,:))
    if (mfPrevIntv3(421,j)<0.1)
         id = [id,j];
    end

end
semilogy((1:length(mfPrevIntv3(:,1)))/12,(mfPrevIntv3(:,id)),'Color',[0.6 0.6 0.6]);
hold on
plot([0 35],[0.5 0.5],'--r');
hold on;
a=(tWHO1-1)/12;
plot([a a],[10^-15 100],'--b');
hold on;
plot([a+5 a+5],[10^-15 100],'--k');
hold on;
set(gca,'XLim',[0 35]);
hold on;
set(gca,'YLim',[10^-14 100]);
hold on;
title("Dozanso");
ylabel("Mf prevalence(%)");
xlabel("No. of years");
hold on;