
%{

# Estimate parameters of individual equations

%}


close all
clear

load mat/simulateEquationsWithParameters.mat q d startDate endDate


%{

## Estimate all parameters freely

%}


[qest1, d1] = regress(q, d, startDate:endDate);


%{

## Compare "true" parameters and estimated parameters

%}


disp("True parameters vs Estimated parameters");
for i = find(~[q.IsIdentity])
    disp("Equation " + string(i));
    disp(q(i).InputString);
    disp(q(i).Parameters);
    disp(qest1(i).Parameters);
end

databank.plot(d1, ["[x, fit_x]", "[y, fit_y]", "[z, fit_z]"], "range", startDate:endDate);
databank.plot(d1, collectResidualNames(q), "range", startDate:endDate);


%{

## Fix some parameters and estimate the remaining ones

%}


qest2 = q;
qest2(2).Fixed = [NaN, 0.5, NaN];
[qest2, d2] = regress(qest2, d, startDate:endDate);

q(2).Parameters
qest1(2).Parameters
qest2(2).Parameters


