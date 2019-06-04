function rgb = colormapCreating(N)
    r = linspace(0, 1, N);
    g = linspace(0, 1, N);
    b = linspace(0, 1, N);
    
    r = r(randperm(length(r)));
    g =g(randperm(length(g)));
    b = b(randperm(length(b)));
    
    rgb = zeros(N, 3);
    for i=1:N
        rgb(i, :) = [r(i), g(i), b(i)];
    end
    rgb = [0.94 0.94 0.94; rgb];
end