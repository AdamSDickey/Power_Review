function figPower(wantFig,perc,percTarg)
if ~exist('wantFig')
    wantFig=1;
end
if ~exist('perc')
    disp('Using 74.5% vs. 56.2%, OR 2.28')
    perc=[.745 .562]

end
if ~exist('percTarg')
    percTarg=18;
end

n2=[1:1:80];
n1=2*n2;
nTotal=n1+n2;

powerChi(1)=nan; %power is 0 for n of 3
for i=2:length(nTotal)
    powerChi(i)=estimatePower(n1(i),n2(i),perc)*100;
end
    
%%
%Epilepsia palette
red=[163 2 52]/255;
blue=[0 118 192]/255;

if(wantFig)
    figure
end
hold on
plot(nTotal,powerChi,'Color',blue,'LineWidth',2)
axis([0 240 0 100])

%EXACT POWER = clutters the graph
% load data_rExactPower
% powerExact=rExactPower(:,3)*100
% plot(nTotal(3:end),powerExact(3:end),'b')

ind=find(powerChi>80,1); %66
powerChi(ind)
plot(nTotal(ind),powerChi(ind),'ko')
plot([1 nTotal(ind)],[powerChi(ind) powerChi(ind)],'k--')
plot([nTotal(ind) nTotal(ind)],[0 80],'k--')




%Sample size 39, 26 vs. 13, ind 13
% plot(nTotal(13),powerChi(13),'bo')
% plot([1 39],[powerChi(13) powerChi(13)],'b-.')
% plot([nTotal(13) nTotal(13)],[0 powerChi(13)],'b-.')

%or show power 23.5%, sample size 36 = 24 vs. 12, ind 12
ind=find(powerChi>percTarg,1); %10

plot(nTotal(ind),powerChi(ind),'o','Color',red)
plot([1 nTotal(ind)],[powerChi(ind) powerChi(ind)],'-.','Color',red)
plot([nTotal(ind) nTotal(ind)],[0 powerChi(ind)],'-.','Color',red)


xlabel('SAMPLE SIZE (2:1 allocation)')
%ylabel('% POWER (for OR 2.4)')
ylabel('% POWER')

text(100,90,'Well-powered study')
%text(40,21,'Median SEEG','Color','b')
text(50,21,'Median study','Color',red)



%p=get(gcf,'Position');
%p(3:4)=p(3:4)*.7;
%set(gcf,'Position',p,'Color','w')

