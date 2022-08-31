

close all
clear
mkdir mat

rng(0);

q = Explanatory.fromFile("example.model");

collectLhsNames(q)

collectRhsNames(q)

collectResidualNames(q)

[q.IsIdentity]

q(1).Parameters = [1, 0.5, -3];
q(2).Parameters = [0.01, 0.5, -0.8];
q(3).Parameters = [0.4];

startDate = qq(2020,1);
endDate = qq(2040,4);

d = struct();
d.a = Series(startDate-2:endDate, @rand);
d.b = Series(startDate-2:endDate, @randn)/100;
d.c = Series(startDate-2:endDate, @randn)/10;
d.d = exp(Series(startDate-2:endDate, @randn)/100);
d.e = exp(Series(startDate-2:endDate, @randn)/100);

d.x = Series(startDate-1, 0);
d.y = Series(startDate-2:startDate-1, [1;1]);

d.res_x = Series(startDate:endDate, @randn)*2;
d.res_y = Series(startDate:endDate, @randn)*0.05;
d.res_z = Series(startDate:endDate, @randn)*0.05;

d = simulate(q, d, startDate:endDate);

save mat/simulateEquations.mat q d startDate endDate


