%load dataSampleSizeFeb  %using Cardinal 45.5% vs. 69.9%


%disp('Using 57.3% vs. 37.0%, OR 2.28, maximized power')
%perc=[.573 .370]
disp('Using 74.5% vs. 56.2%, OR 2.28')
perc=[.745 .562]


%wantRun=0; %if dataSampleSize.mat already exists
wantRun=1; %takes 1 minute to run, creates dataSampleSize

if(wantRun)
    estimatePowerAll(perc);
    simulatePowerAll(perc); 
end
load dataSampleSize 

medianSampSize=median(nTotal);
disp(['Median Sample Size: ' num2str(medianSampSize) ])
disp(['Range Sample Size: ' num2str(minmax(nTotal')) ])
disp(' ')
disp(['Median Estimated Power: ' num2str(median(estPowerChi)*100) '%'])
disp(['Median Simulated Power: ' num2str(median(simPowerChi)*100) '%'])

%% Allocation ratio

%Corrects error in original code - nA not always the larger group
nBig=max(nA,nB); 
allocRatio=nBig./nTotal;


disp(['Median Allocation Ratio: ' num2str(median(allocRatio)*100) '%'])
nTypical(1)=round(median(allocRatio)*medianSampSize)'
nTypical(2)=medianSampSize-nTypical(1);
disp(['Typical Allocation: ' num2str(nTypical(1)) ' vs ' num2str(nTypical(2))])

%% Figures
estPower=round(median(simPowerChi)*100)
figColumn(perc,estPower)
