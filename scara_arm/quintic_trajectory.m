function [t, qd, vd, ad] = quintic_trajectory(t0, tf, q0, v0, a0, qf, vf, af)
    M = [1, t0, t0^2, t0^3, t0^4, t0^5;
        0, 1, 2*t0, 3*t0^2, 4*t0^3, 5*t0^4;
        0, 0, 2, 6*t0, 12*t0^2, 20*t0^3;
        1, tf, tf^2, tf^3, tf^4, tf^5;
        0, 1, 2*tf, 3*tf^2, 4*tf^3, 5*tf^4;
        0, 0, 2, 6*tf, 12*tf^2, 20*tf^3];
    
    b = [q0; v0; a0; qf; vf; af];
    a = M\b; % a = inv(M)*b
    t = linspace(t0, tf, 100);
    c = ones(size(t));
    qd = a(1).*c + a(2).*t +a(3).*t.^2 + a(4).*t.^3 +a(5).*t.^4 + a(6).*t.^5;
    vd = a(2).*c +2*a(3).*t +3*a(4).*t.^2 +4*a(5).*t.^3 +5*a(6).*t.^4;
    ad = 2*a(3).*c + 6*a(4).*t +12*a(5).*t.^2 +20*a(6).*t.^3;
end
