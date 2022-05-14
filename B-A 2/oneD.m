for  i =1: 30
    if mod((i+3), 2) == 0
        N = (i+3)/2
        g=combntns(N,i)
        x = i
    end
end
plot(x,g)