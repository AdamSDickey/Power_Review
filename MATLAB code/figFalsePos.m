function figFalsePos(wantFig,percTarg)
if ~exist('wantFig')
    wantFig=1;
end
if ~exist('percTarg')
    percTarg=20;
end
    

power=[1:100];
falsePos=5./(5+power)*100;

%Epilepsia palette
red=[163 2 52]/255;
blue=[0 118 192]/255;

if(wantFig)
    figure
end
hold on
plot(power,falsePos,'Color',blue,'LineWidth',2)
axis([0 100 0 100])
xlabel('% POWER')
%ylabel('Prob (+Study is FALSE)')
ylabel('% FALSE +Studies')

%80% power
ind=80;
plot(power(ind),falsePos(ind),'ko')
plot([1 ind],[falsePos(ind) falsePos(ind)],'k--')
plot([power(ind) power(ind)],[0 falsePos(ind)],'k--')
%plot([0 95],[5 5],'k:') %hard to see

%Median Power
ind=percTarg;
plot(power(ind),falsePos(ind),'o','Color',red)
plot([1 ind],[falsePos(ind) falsePos(ind)],'-.','Color',red)
plot([power(ind) power(ind)],[0 falsePos(ind)],'-.','Color',red)

text(50,15,'Well-powered study')
%text(20,28,'Median SEEG','Color','b')
text(20,28,'Median study','Color',red)

%p=get(gcf,'Position');
%p(3:4)=p(3:4)*.7;
%set(gcf,'Position',p,'Color','w')