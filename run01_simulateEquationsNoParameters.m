
%{

# Simulate explanatory equations

%}


close all
clear

rng(0);

q = Explanatory.fromFile("example01-no-parameters.model");

collectLhsNames(q)

collectRhsNames(q)

collectResidualNames(q)

[q.IsIdentity]

startDate = qq(2020,1);
endDate = qq(2040,4);

d = struct();
d.a = Series(startDate-2:endDate, @rand);
d.b = Series(startDate-2:endDate, @randn)/100;
d.c = Series(startDate-2:endDate, @randn)/10;
d.d = exp(Series(startDate-2:endDate, @randn)/100);
d.e = exp(Series(startDate-2:endDate, @randn)/100);

d.alpha = 0.5;
d.beta = -0.4;
d.gamma = 2;
d.delta1 = 0;
d.phi1 = 0.8;
d.omega1 = 0.1;
d.sigma1 = 0.1;
d.delta2 = 0;
d.phi2 = 0.8;
d.omega2 = 0.1;
d.sigma2 = 0.1;
d.delta3 = 0;
d.phi3 = 0.8;
d.omega3 = 0.1;
d.sigma3 = 0.1;

d.x = Series(startDate-1, 0);
d.y1 = Series(startDate-2:startDate-1, [1;1]);
d.y2 = Series(startDate-2:startDate-1, [1;1]);
d.y3 = Series(startDate-2:startDate-1, [1;1]);

d.res_x = Series(startDate:endDate, @randn)*2;
d.res_y1 = Series(startDate:endDate, @randn)*0.05;
d.res_y2 = Series(startDate:endDate, @randn)*0.05;
d.res_y3 = Series(startDate:endDate, @randn)*0.05;
d.res_z = Series(startDate:endDate, @randn)*0.05;

s = simulate(q, d, startDate:endDate);


list = databank.filterFields(d, "value", @(x) isa(x, "Series"));
databank.plot(s, list, "range", startDate:endDate);


%{

## Use data, do not simulate, whenever data is available

%}


d1 = d;
d1.y1 = Series(startDate-2:endDate, 100);
s1 = simulate(q, d1, startDate:endDate, "skipWhenData", true);

[s.y1, s1.y1]
[s.w, s1.w]


%{

## Retrieve only a subset of equations with given attributes or LHS names

%}


q0 = retrieve(q, [":snail", "y1"])
collectLhsNames(q0)

% Simulating w will fail because y2 and y3 are not available
s0 = simulate(q0, d, startDate:endDate);


