function [t, q, qdot, q2dot] = Scurve_trajectory(qf, v, a)
    if v > sqrt(qf*a/2)
        v = sqrt(qf*a/2);
    end
    
    t1 = v/a;
    t2 = 2*t1;
    t3 = qf/v;
    t4 = t3 + t1;
    tf = t3 + t2;
    j = a/t1;

    t = linspace(0, tf, 100);
    q = zeros(size(t));
    qdot = zeros(size(t));
    q2dot = zeros(size(t));
    for i = 1:length(t)
        if t(i) <= t1
            q(i) = j*t(i)^3/6;
            qdot(i) = j*t(i)^2/2;
            q2dot(i) = j*t(i);
        elseif t(i) <= t2
            q(i) = j*t1^3/6 + j*t1^2/2*(t(i)-t1) + a*(t(i)-t1)^2/2 - j*(t(i)-t1)^3/6;
            qdot(i) = j*t1^2/2 + a*(t(i)-t1) - j*(t(i)-t1)^2/2;
            q2dot(i) = a - j*(t(i)-t1);
        elseif t(i) <= t3
            q(i) = a*t1^2 + v*(t(i)-t2);
            qdot(i) = v;
            q2dot(i) = 0;
        elseif t(i) <= t4
            q(i) = a*t1^2 + v*(t3-t2) + v*(t(i)-t3) - j*(t(i)-t3)^3/6;
            qdot(i) = v - j*(t(i)-t3)^2/2;
            q2dot(i) = -j*(t(i)-t3);
        elseif t(i) <= tf
            q(i) = qf - j*(tf - t(i))^3/6;
            qdot(i) = v - j*(t4-t3)^2/2 - a*(t(i)-t4) + j*(t(i)-t4)^2/2;
            q2dot(i) = -a + j*(t(i)-t4);
        end
    end
end