function T = forward_kinematics(n, a, alpha, d, theta)
    T(:,:,1) = eye(4);
    for i = 1:n
        T(:,:,i+1) = T(:,:,i)*get_transform_matrix(a(i), alpha(i), d(i), theta(i));
    end
end