# Scene classification
Scene classification using visual bag of words approach and Spatial Pyramid matching

**Dataset**: SUN database
- the dataset contains 1600 images from various scene categories like "airport", "bedroom", and "dessert"

##### Filter bank: 20
1. (1 - 5) Guassian filters with sigma values - 1, 2, 4, 8, sqrt(2)*8.
2. (6 - 10) Laplacian of Guassian filter with same scale.
3. (11 - 15) x-derivative of Guassian fillter with same scale.
4. (16 - 20) y-derivative of Guassian fillter with same scale.

Classifier used to determine the dictionary of visual words: K-Means classification (k = 100)

#### Algorithm:
##### Training:
1. Build visual word dictionary
    1. Apply 20 filters on each image and construct visual words using random alpha pixels in each image (alpha used = 50).
    2. Use k-means classifier to create k visual words out of it (k = 100).
    3. Save the vocabulary in dictionary.mat file.
2. Building recognition system
    1. Using the dictionary, iterate through every test image and find the nearest visual word for each pixel. This is referred as 'wordMap'.
    2. Construct a histogram of wordMap for every test image.
    3. To increase the context in the image, the approach uses "Spatial Pyramid Matching" technique and gives high priority to nearby pixels. This is achieved by building the histogram for every patch in the pyramid layer.

#### Testing:
1. Construct the wordMap histogram for the test image in the similar way.
2. Compare the histogram with all training image histograms, and find the nearest match.
3. The category of the matched image is the result.
