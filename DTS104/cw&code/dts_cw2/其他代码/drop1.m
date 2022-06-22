function[dist,vel]=drop1(a,v0,t)
%computes the distance traveled and velocity of a dropped object
vel = v0.+a.*t
dist = v0.*t+1/2*a.*(t.^2)
end

