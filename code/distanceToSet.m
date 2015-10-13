function [ histInter ] = distanceToSet( wordHist, histograms )
%DISTANCETOSET distance between wordHist and all training histograms
% wordHist is a { K (4(L+1) - 1) /3 x 1 } vector.  
% histograms is a { K (4(L+1) - 1) /3 x T } matrix of all training histograms.  
%     k -> #kmeans_classes
%     L -> #layers

% duplicate wordHist to match the dimension of histograms matrix
    training_samples_count = size(histograms, 2);
    wordHist = repmat(wordHist, 1, training_samples_count);
    
%     histInter = sum(min(wordHist, histograms));
    histInter = sum(bsxfun(@min, wordHist, histograms));

end

