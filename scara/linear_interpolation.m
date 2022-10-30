function [t, p, pdot, p2dot] = linear_interpolation(p0, pf, t, q, qdot, q2dot)
    [azimuth, elevation, q_max] = cart2sph(pf(1) - p0(1), pf(2) - p0(2), pf(3) - p0(3));
    p = zeros(6, length(t));
    pdot = zeros(6, length(t));
    p2dot = zeros(6, length(t));
    for i = 1:length(t)
        p(1,i) = p0(1) + q(i)/q_max*(pf(1) - p0(1));
        p(2,i) = p0(2) + q(i)/q_max*(pf(2) - p0(2));
        p(3,i) = p0(3) + q(i)/q_max*(pf(3) - p0(3));
        p(6,i) = p0(6) + q(i)/q_max*(pf(6) - p0(6));
        
        pdot(1,i) = qdot(i)/q_max*(pf(1) - p0(1));
        pdot(2,i) = qdot(i)/q_max*(pf(2) - p0(2));
        pdot(3,i) = qdot(i)/q_max*(pf(3) - p0(3));
        pdot(6,i) = qdot(i)/q_max*(pf(6) - p0(6));
        
        p2dot(1,i) = q2dot(i)/q_max*(pf(1) - p0(1));
        p2dot(2,i) = q2dot(i)/q_max*(pf(2) - p0(2));
        p2dot(3,i) = q2dot(i)/q_max*(pf(3) - p0(3));
        p2dot(6,i) = q2dot(i)/q_max*(pf(6) - p0(6));
    end
end