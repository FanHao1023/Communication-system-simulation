function df = derivative(vect, dx)
    if dx <= 0
        error('dx must > 0.');
    end
    
    n = length(vect);
    
    df = zeros(1, n);
    for i = 1:n-1
        df(i) = (vect(i+1) - vect(i)) / dx;
    end

    df(n) = df(n-1);
end

