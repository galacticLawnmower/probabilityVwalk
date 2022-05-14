clear all
seed =[0 1 0 0 1;1 0 0 1 0;0 0 0 1 0;0 1 1 0 0;1 0 0 0 0]
Net = SFNG(30, 2, seed);
m1 = zeros(30);
for i=1:30
    sum(Net(i,:));
    m1(i,i) = sum(Net(i,:));
end
m2 = inv(m1);
m3 = Net;
for i =1:30
    tsum = sum(Net(i,:));
    for j = 1:30
        m3(i,j) = m3(i,j)/tsum;
    end
end
e_t = zeros(1,30);
e_t(1,14) =1;
e_1 = zeros(30,1);
e_1(1,1) =1;

prob_M = m3;
N=20;
mu_time = BA(prob_M,e_t,e_1,N)
PL_Equation = PLplot(Net)
CNet(Net)