function estimatePowerAll(perc)
if ~exist('perc')
    perc=[.573 .37];
end
 disp(perc)



dataset='Dickey Appendix S1.xlsx';
disp(dataset)
T=readtable(dataset);
nTotal=T.nTot;
nA=T.nA;
nB=T.nB;
numStudies=length(nTotal)





 
nRange=minmax(nTotal')
medianN=median(nTotal)
for i=1:numStudies
    estPowerChi(i)=estimatePower(nA(i),nB(i),perc);
end
medianEstPower=median(estPowerChi)
%medianSimPower=median(simPowerChi)

%%
%allocation to bigger group?
for i=1:numStudies
    if(nA(i)>nB(i))
        frac(i)=nA(i)/nTotal(i);
    else
        frac(i)=nB(i)/nTotal(i);
    end
end
medianFrac=median(frac)

save dataSampleSize nTotal nA nB estPowerChi perc