function powerChi=simulatePower(n1,n2,perc,numRep,wantText,wantFig)
if ~exist('n1')
    n1=22;
end
if ~exist('n2')
    n2=11;
end
if ~exist('perc')
    disp('Pre-hoc estimate - Cardinale 2019 ILAE 1-2 MRI-pos (67%) vs not (46%)')
    perc=[204/305 75/165];
end

if~exist('numRep')
    numRep=10000;
end
if~exist('wantText')
    wantText=1;
end
if~exist('wantFig')
    wantFig=1;
end
a=perc(1);
b=perc(2);

if(wantText)
    disp('Predicting surgical outcome in MRI positive vs not')
end


%%

if(wantText)
    disp([n1 n2])
    disp([a b])
end

%pick random seed
rng(1)

x=binornd(n1,a,numRep,1);
y=binornd(n2,b,numRep,1);
percX=x/n1;
percY=y/n2;

diffPerc=percY-percX;

oddsX=percX./(1-percX);
oddsY=percY./(1-percY);
oddsRatio=oddsX./oddsY;

oddsRatioTrue=(perc(1)/(1-perc(1)))/(perc(2)/(1-perc(2)));

warning off 
%chi square gives warning for small sample size
%tic
for i=1:numRep
    if(mod(i,5000)==0)
        if(wantText)
            disp(i)
        end
    end
    z=[x(i) n1-x(i); y(i) n2-y(i)];
    pChi(i,1)=chisquarecont(z);
end

powerChi=sum(pChi<0.05)/numRep;


%%
%use chi-square 
ind=find(pChi<=.05 & oddsRatio>0 & isfinite(oddsRatio));
indNot=find(pChi>.05 & oddsRatio>0 & isfinite(oddsRatio));


 edges=[-0.5:1:20.5];
diffSig=histc(oddsRatio(ind),edges)/numRep*100;
diffNot=histc(oddsRatio(indNot),edges)/numRep*100;


%typeM= mean(diffPerc(pVal<.05))/(b-a);
%oddsRatioMedian=median(oddsRatio);

%Median
oddsRatioSig_Median=median(oddsRatio(ind));
oddsRatioNot=median(oddsRatio(indNot));

%Mean
oddsRatioSig_Mean=mean(oddsRatio(ind));
%oddsRatioNot=mean(oddsRatio(indNot));


%typeM = oddsRatioSig/oddsRatioMedian;
typeM_Median= oddsRatioSig_Median/oddsRatioTrue;
typeM_Mean= oddsRatioSig_Mean/oddsRatioTrue;

falsePos=.05/(powerChi+.05);

%Epilepsia palette
red=[163 2 52]/255;
%blue=[0 118 192]/255;
blue=[0 33 87]/255; %darker

if(wantText)
    if(wantFig)
        figure
         p=get(gcf,'Position');
         p(3)=p(3)*.6;
         p(4)=p(4)*.5;
         set(gcf,'Position',p,'Color','w')

    end
    hold on
    b=bar(edges+.5,[diffNot diffSig],'stacked')
    b(1).FaceColor=blue;
    b(2).FaceColor=red;
    xlabel('Odds Ratio')
    ylabel('%')
    %xlim([-1 21])
    xlim([-1 15])
    ylim([0 40])
    plot([2.4 2.4],[0 35],'k--')
    text(0, 37,'True Odds Ratio')
    
    plot(repmat(oddsRatioSig_Median,2,1),[0 15],'-.','Color',red)
    text(4.5, 20,'Median Sig.','Color',red')
    text(4.5, 17,'Odds Ratio','Color',red)
    
    
    
    leg=legend('P>0.05','P\leq0.05')
    set(leg,'Box','off')
    
   
 
    
    powerChi
    %oddsRatioMedian
    oddsRatioTrue
    oddsRatioSig_Median
    oddsRatioSig_Mean
    %oddsRatioNot
    
    typeM_Median
    typeM_Mean
    falsePos
end



