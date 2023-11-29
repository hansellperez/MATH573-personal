function [d] = HPerezDividedDiff(x, y)
    % define the number of nodes given
    m = length(x);
    % preallocate space for all the divided differences
    div_diff = zeros(m);
    % store the zeroth differences in column 1
    for i = 1:m
        div_diff(i,1) = y(i);
    end
    % define parameter to facilitate for loop stopping criterion
    last = m-1;
    % for columns 2-end fill in each row using the divided diff. formula
    % note this forms a upper left triangular matrix
    for c = 2:m
        for r = 1:last
            div_diff(r,c) = (div_diff(r+1,c-1) - div_diff(r,c - 1))/(x(r+c-1) - x(r));
        end
        last = last - 1;
    end
    % the desired divided diff given by row 1 of diff matrix
    d = div_diff(1,:);
end
