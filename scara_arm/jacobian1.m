function J = jacobian1(n, a, alpha, d, theta, type)
    % Analytical method: faster
    epsilon = 1e-6;
    epsilon_inv = 1/epsilon;
    T = forward_kinematics(n, a, alpha, d, theta);
    J = zeros(6, n);
    
    for i = 1:n
        theta_ = theta;
        d_ = d;
        if type(i) == 'r'     
            theta_(i) =  theta(i) + epsilon;
            J(:,i) = [(f(n, a, alpha, d_, theta_) - T(1:3,4,n+1)) .* epsilon_inv; T(1:3,3,i)]; 
        elseif type(i) == 'p'
            d_(i) =  d(i) + epsilon;
            J(:,i) = [(f(n, a, alpha, d_, theta_) - T(1:3,4,n+1)) .* epsilon_inv; 0; 0; 0]; 
        end
    end
end

function x = f(n, a, alpha, d, theta)
    T = forward_kinematics(n, a, alpha, d, theta);
    x = T(1:3,4,n+1);
end