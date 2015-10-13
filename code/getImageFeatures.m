function [ h ] = getImageFeatures( wordMap, dictionarySize )

    h = histcounts(wordMap, dictionarySize);
    
    h = h';
    
    % L1 normalized
    h = h ./ numel(wordMap);
    
end
