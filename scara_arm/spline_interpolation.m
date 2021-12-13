function [t, p, pdot, p2dot] = spline_interpolation(tf)
    t = linspace(0, tf, 100);
    p = zeros(6, length(t));
    pdot = zeros(6, length(t));
    p2dot = zeros(6, length(t));
    
    y(1,:) = [0 -1 -4 -6 -7 -10 -13 -12 -9 -7 -8 -8 -9 -9 -7 -8 -8 -7 -8 -8 -7 -8 -7 -5 1 0 1 3 4 4 8 7 9 8 10 9 14 12 5 8 6 7 5 6 4 4 3 3 2 5 6 7 6 3 0] / 8; 
    y(2,:) = [7 8 8 7 9 11 12 10 7 6 5 3 2 1 -1 -2 -5 -6 -8 -9 -10 -12 -12 -11 -11 -12 -12 -11 -9 -8 -6 -5 -4 -2 -1 1 3 8 4 0 -1 -3 -4 -6 -7 -4 1 3 6 7 8 10 10 9 7] / 8 + 4.2;
    x = linspace(0, 2, length(y));
    pp = spline(x, y);
    
    p = ppval(pp, linspace(0, 2, 100));
    p(3,:) = ones(1, 100);
    p(6,:) = zeros(1, 100);
    
    pdot(1,:) = gradient(p(1,:))/(tf/100);
    pdot(2,:) = gradient(p(2,:))/(tf/100);
    pdot(3,:) = gradient(p(3,:))/(tf/100);
    pdot(6,:) = gradient(p(6,:))/(tf/100);
end