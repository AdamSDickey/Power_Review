function figColumn(perc,estPower)
if ~exist('perc')
    disp('Using 57.3% vs. 37.0%, OR 2.28, maximized power')
    perc=[.573 .366]
end
if~exist('estPower')
    estPower=19;
end
numRep=10000;
%numRep=1e5;


figure
wantFig=0;
%subplot(5,1,[1:2])
subplot(311)
figPower(wantFig,perc,estPower)
text(-50,103,'A','FontSize',16)

%subplot(5,1,[3:4])
subplot(312)
figFalsePos(wantFig,estPower)
text(-22,103,'B','FontSize',16)

%subplot(5,1,[5])
subplot(313)

%Typical study = median sample size 38, 63% in group 1 = 24 vs. 14 patients

%simulatePower(24,14,[204/305 75/165],numRep,1,wantFig) %using Cardinal 45.5% vs. 69.9%
simulatePower(25,13,perc,numRep,1,wantFig) %Using 60% vs. 40% seizure free from meta-analysis


text(-4.5,41,'C','FontSize',16)

p=get(gcf,'Position');
p(3)=p(3)*.4;
p(4)=p(4)*1.45;
set(gcf,'Position',p,'Color','w')
