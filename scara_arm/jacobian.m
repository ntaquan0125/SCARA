function J = jacobian(n, a, alpha, d, theta, type)
    T = forward_kinematics(n, a, alpha, d, theta);
    J = zeros(6, n);
    for i = 1:n
        if type(i) == 'r'
            J(:,i) = [cross(T(1:3,3,i), T(1:3,4,n+1)-T(1:3,4,i)); T(1:3,3,i)];
        elseif type(i) == 'p'
            J(:,i) = [T(1:3,3,i); 0; 0; 0];
        end
    end
end