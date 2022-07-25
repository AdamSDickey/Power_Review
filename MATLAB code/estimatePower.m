function powerChi=calcPower(n1,n2,perc)


if ~exist('n1')
    n1=25;
end
if ~exist('n2')
    n2=13;
    disp([n1 n2])
end
if ~exist('perc')
    disp('Pre-hoc estimate - Cardinale 2019 ILAE 1-2 MRI-pos (66.9%) vs not (45.5%)')
    perc=[204/305 75/165];
end

p1=perc(1); p2=perc(2);
zAlpha=1.96;

%Episilon is the effect size  - Wang & Chow 2007 = |p1-p2|
%This also matches Gelman Regression and Other Stories, p296
%x>0 means 95% confidence interval excludes zero
zBeta=abs(p1-p2)/sqrt(p1*(1-p1)/n1+p2*(1-p2)/n2)-zAlpha;
powerChi=normcdf(zBeta);