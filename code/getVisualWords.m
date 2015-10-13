function [ wordMap ] = getVisualWords( I, filterBank, dictionary )
%getVisualWords Map each pixel in the image to its closest word in the dictionary

    % W*H x #filters*3 matrix of filter responses
    filterResponse = extractFilterResponses(I, filterBank);
    
    dictionary = dictionary';
    
    % distance between all pixels and dictionary words
    distM = pdist2(filterResponse, dictionary);
    
    wordMap = zeros(size(distM,1),1);
    
    % choose closest dictionary-word and construct wordMap
    for i = 1 : size(distM,1)
        [~, wordMap(i,:)] = min(distM(i,:));
    end
    
    % change dimension of wordMap back to image dimension
    wordMap = reshape(wordMap, [size(I,1), size(I,2)]);

end

