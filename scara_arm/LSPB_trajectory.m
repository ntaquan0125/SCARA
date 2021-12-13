function [t, q, qdot, q2dot] = LSPB_trajectory(qf, v, a)
    tb = v/a;
    tf = (qf - v*tb)/(v) + 2*tb;
    
    t = linspace(0, tf, 100);
    q = zeros(size(t));
    qdot = zeros(size(t));
    q2dot = zeros(size(t));
    for i = 1:length(t)
        if t(i) <= tb
            q(i) = a*t(i)^2/2;
            qdot(i) = a*t(i);
            q2dot(i) = a;
        elseif t(i) <= tf - tb
            q(i) = (qf - v*tf)/2 + v*t(i);
            qdot(i) = v;
            q2dot(i) = 0;
        elseif t(i) <= tf
            q(i) = qf - a*(tf -t(i))^2/2;
            qdot(i) = a*(tf-t(i));
            q2dot(i) = -a;
        end
    end
end