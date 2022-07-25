function simulatePowerAll(perc)
if ~exist('perc')
    %disp('Pre-hoc estimate - Cardinale 2019 ILAE 1-2 MRI-pos (67%) vs not (46%)')
    %perc=[204/305 75/165];
    disp('Meta analysis - OR 2.25, 60% vs. 40%')
    perc=[.6 .4];
end
 disp(perc)

% load dataSampleSize
% nTotal=n(:,1);
% nA=n(:,2);
% nB=n(:,3);
% numStudies=length(nTotal);

dataset='Dickey Appendix S1.xlsx';
disp(dataset)
T=readtable(dataset);
nTotal=T.nTot;
nA=T.nA;
nB=T.nB;
numStudies=length(nTotal)

numRep=10000;

%%
disp('Analyzing studies..')
tic
for i=1:numStudies
    disp(i)
    simPowerChi(i)=simulatePower(nA(i),nB(i),perc,numRep,0);
end
toc



%%
medianSimPowerChi=median(simPowerChi)

save dataSampleSize -append simPowerChi
