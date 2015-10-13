load('traintest.mat');

source = '../dat/';
test_size = length(test_imagenames);

% confusion matrix
C = zeros(8);

for i = 1 : test_size
    path = strcat(source, test_imagenames{i});
    
    guessedLabel = guessImage(path);
    guessedIndex = find(strcmp(mapping, guessedLabel));
    
    trueIndex = test_labels(i);
    
    C(trueIndex, guessedIndex) = C(trueIndex, guessedIndex) + 1;
    
    if (trueIndex ~= guessedIndex)
        disp(strcat(path, ', trueLabel: ', mapping{trueIndex}));
    end
end