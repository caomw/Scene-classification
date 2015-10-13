function [ filterBank, dictionary ] = getFilterBankAndDictionary( imageNames )
%getFilterBankAndDictionary Creates a dictionary using kmeans for the input
%   image names

[filterBank] = createFilterBank();
K = 100;
alpha = 50;
filterResponses = [];

for imgName = imageNames
    I = imread(imgName{1});
    
    % filterResponses: (h*w) x (3*filter-size)
    [filterResponsesI] = extractFilterResponses(I, filterBank);
    
    % select random alpha pixels ->  (alpha) x (3*filter-size)
    randIndices = randperm(size(filterResponsesI, 1), alpha);
    filterResponses = [filterResponses; filterResponsesI(randIndices, :)];

end

[~, dictionary] = kmeans(filterResponses, K, 'EmptyAction','drop');
dictionary = dictionary';
