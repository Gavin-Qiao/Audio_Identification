function [x1, x2, y1, y2] = SurfFeaturepoints(p1, p2, sig)

I1 = imread(p1); %left image
I2 = imread(p2); %right image

I1 = imgaussfilt(rgb2gray(I1), sig);
I2 = imgaussfilt(rgb2gray(I2), sig);

%returns a SURFPoints object, points, containing information about SURF features detected in the 2-D grayscale input image I. 
ptsLeft  = detectSURFFeatures(I1); 
ptsRight = detectSURFFeatures(I2);

%ExtractFeatures: Returns [features, validPoints], extracted feature vectors, also known as
%descriptors, and their corresponding locations.
[featuresLeft,  validPtsLeft ] = extractFeatures(I1,  ptsLeft);
[featuresRight, validPtsRight] = extractFeatures(I2, ptsRight);

%indexPairs the matching feature vectors and return the matching points
%index in featuresLeft, and featuresRight
indexPairs = matchFeatures(featuresLeft, featuresRight);

%Get the valid points using the index.
matchedLeft  = validPtsLeft(indexPairs(:,1));
matchedRight = validPtsRight(indexPairs(:,2));

%The matchedpoints here are the SURFPoints but we can get the x,y coordinates
%by the Location attribute. 

x1 = matchedLeft.Location(:,1);
x2 = matchedRight.Location(:,1);
y1 = matchedLeft.Location(:,2);
y2 = matchedRight.Location(:,2);
