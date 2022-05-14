function BA_G = BA(lin, star,en,N)
       % Number of Intervals
bump = (1/N);    % Stepsize
start = bump;
a=.99;
b=.1;
syms t g d 
size(lin,2)
e_t = zeros(1,size(lin,2));
e_t(1,star) =1;
e_1 = zeros(size(lin,2),1);
e_1(en,1) =1;

for mas = 1:N
    n(mas) = start;
    g = start;
    g;
    %v = vpasolve( (exp((a-b-g)*t))*(symsum(((e_t*(lin^d)*e_1)*(g*t)^d)/(factorial(d)),d,1,5)) == 1, g)
    
    ew = (exp((a-b-g)*t));
    we = 0;
    for i=1:20
        d = i;
        
       
        cu1 = e_t*g^d*(lin)^d*t^d*e_1;
        cu = cu1/factorial(d);
    
    
         we = we + cu;
    end
    u = vpasolve(we  == 1, t, [0 inf]);
    plist(mas) = u;
    glist(mas) = g;
    
    ug = vpasolve(ew*we  == 1, t, [0 inf]);
    ug = real(ug);
    %vpasolve(ew*we  == 1, t)
    %ug = vpasolve(ew*we  == 1, t);
    
    %v = vpasolve( (exp((a-b-g)*t))*(symsum(((e_t*(lin^d)*e_1)*(g*t)^d)/(factorial(d)),d,1,5)) == 1, g)
    %v = vpasolve([((exp((a-b-g)*t))*(symsum((2*(g*P*t)x^d)/(factorial(d)),d,1,10))) == 1], g);
    %wer = so(start);
    %solb = vpasolve(wer, t);
    m(mas) = ug;
    start = start + bump;
end

n = transpose(n);
m = transpose(m);
mink = min(m,[],1);
length(m);
mini = 1;
for i = 1:length(m)
    if m(i) == mink
        mini = i;
    end
end
'cat';
if length(m) > mini+1
    tmin = m(mini);
    gmin = n(mini);
    p0 = plist(mini-1);
    p1 = plist(mini);
    p2 = plist(mini+1);
    p3 = plist(mini+2);
    g1 = glist(mini);
    g0 = glist(mini-1);
    g2 = glist(mini+1);
    ga = (1-g1)/g1;

    temp = p1*ga;
    temp - p2;

    ga = (1-g0)/g0;
    temp = p0*ga;
    temp - p1;

    ga = (1-g2)/g2;
    temp = p2*ga;
    temp - p3;
end
'cat';
%plot(n,m)
BA_G = m