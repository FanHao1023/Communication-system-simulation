function result = random_normal(n, m)
    if nargin < 2
        m = n;
    end
    
    result = zeros(n, m);
    
    for i = 1:n
        for j = 1:m
            x1 = -1 + 2 * rand();
            x2 = -1 + 2 * rand();

            while x1^2 + x2^2 >= 1
                x1 = -1 + 2 * rand();
                x2 = -1 + 2 * rand();
            end

            r = x1^2 + x2^2;
            y1 = x1 * sqrt(-2 * log(r) / r);
            % y2 = x2 * sqrt(-2 * log(r) / r);

            result(i, j) = y1;
        end
    end
end

