function [t, p, pdot, p2dot] = circular2d_interpolation(p1, p2, p3, t, q, qdot, q2dot)
    % Center point
    A = 2*[p2(1) - p1(1), p2(2) - p1(2); p3(1) - p1(1), p3(2) - p1(2)];
    B = [p2(1)^2 + p2(2)^2; p3(1)^2 + p3(2)^2] - [p1(1)^2 + p1(2)^2; p1(1)^2 + p1(2)^2];
    pc = inv(A)*B;
    pc = [pc(1) pc(2) p1(3) 0 0 0];

    % Boundary angle
    alpha1 = atan2(p1(2) - pc(2), p1(1) - pc(1));
    alpha3 = atan2(p3(2) - pc(2), p3(1) - pc(1));

    % Radius
    r = sqrt((p1(1) - pc(1))^2 + (p1(2) - pc(2))^2);
    q_max = r*abs(alpha3 - alpha1);

    p = zeros(6, length(t));
    pdot = zeros(6, length(t));
    p2dot = zeros(6, length(t));
    for i = 1:length(t)
        alpha = alpha1 + q(i)/q_max*(alpha3 - alpha1);
        p(1, i) = pc(1) + r*cos(alpha);
        p(2, i) = pc(2) + r*sin(alpha);
        p(3, i) = pc(3);
        
        alphadot = qdot(i)/q_max*(alpha3 - alpha1);
        pdot(1, i) = -r*sin(alphadot);
        pdot(2, i) = r*cos(alphadot);
        pdot(3, i) = 0;
    end
end