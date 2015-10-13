function [ h ] = getImageFeaturesSPM( layerNum, wordMap, dictionarySize )

    % finest layer first & calculate coarser layer by summing up the finest
    % layer histogram
    
    h = [];
    
    % -- finest layer calculation --
    n_splits = (2 ^ layerNum);
    imgSize = size(wordMap);
    imgSize = imgSize - mod(imgSize, n_splits);
    wordMap = wordMap(1:imgSize(1), 1:imgSize(2));
    
    boxSize = floor(imgSize / n_splits);

    rowSize = boxSize(1) * ones(1, n_splits);
    colSize = boxSize(2) * ones(1, n_splits);

    splitCells = mat2cell(wordMap, rowSize, colSize);

    histCells = {};
    for r = 1 : n_splits
        for c = 1 : n_splits
            histCells{r,c} = getImageFeatures(splitCells{r,c}, dictionarySize);
            h = [h; histCells{r,c}];
        end
    end
    weight = (1/layerNum);
    h = h .* weight;
    % -- end finest layer calculation ---
    
    
    % -- calculate coarser layer histogram from finest histogram
    for l = layerNum-1 : -1 : 0
        n_splits = (2 ^ l);
        if (l ~= 0)
            weight = weight / 2;
        end
        
        boxSize = size(histCells) / n_splits;
        rowSize = boxSize(1) * ones(1, n_splits);
        colSize = boxSize(2) * ones(1, n_splits);
        
        histCells = mat2cell(histCells, rowSize, colSize);
        
        histCellsNew = {};
        h_layer = [];
        for i = 1 : size(histCells,1)
            for j = 1 : size(histCells,2)
                M = sumCells(histCells{i,j});
                histCellsNew{i,j} = M;
                h_layer = [h_layer; M];
            end
        end
        
        h_layer = h_layer .* weight;
        h = [h; h_layer];
        histCells = histCellsNew;
    end
    % -- end calculate coarser layer histogram from finest histogram
    
    h = h ./ sum(h);

end

