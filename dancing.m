% Actually this function collect data while the rooster is dancing around
% the chicken.
function points = dancing(roo, ch, size)
    % Find the distance between two points
    distance = norm(roo - ch);
    dif = ch - roo;
    
    s_value = size*0.1;
    if s_value < 1
        s_value = 1;
    end
    % Linearly spaced values for movement
    t = linspace(0, distance, s_value);
    
    % Spiral frequency control
    num_turns = 2;
    theta = linspace(0, 2 * num_turns * pi, s_value); 

    % Normalize direction vector
    direction = dif / norm(dif);
    
    % Generate the spiral in n-dimensions
    n = length(roo);
    points = zeros(length(t), n);
    
    for i = 1:n
        points(:, i) = roo(i) + t' * direction(i);  % Linear Movement 
    end
    
    % Create perpendicular oscillations for spiral effect
    for i = 1:n-1
        points(:, i) = points(:, i) + (0.1 * distance) * sin(theta)';
    end
    
end
