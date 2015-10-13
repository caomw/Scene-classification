function [ M ] = sumCells( cells )
%SUMCELLS Adds all matrices in the cell and creates a new matrix out of it.

    M = zeros(size(cells{1,1}));

    for i = 1 : size(cells,1)
        for j = 1 : size(cells, 2)
            M = M + cells{i,j};
        end
    end

end

