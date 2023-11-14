% This function serves to classify images of handwritten numbers by using
% SVD bases as a training model.
% 
% NOTE: This function is designed to operate with the directory "Test1" in
% the matlab path. (i.e. "Test1", case sensitive, is the directory that
% houses directories "Digit0", "Digit1", ..., "Digit9", and "TestDigits",
% ALL CASE SENSITIVE!)
% 
% inputs: 
%   svTol - serves as a measure of the percentage of information that you
%   want to keep when using the SVD factorization.
%   
%   nImgs - indicates the number of images that we wish to classify, they
%   are to be found in the directory "Test1\TestDigits"
%
% outputs: 
%   w  - a column vector of dimension nImgs-by-1 that stores an integer
%   valued the same as the integer in the image that was being classified
%   (i.e. if w(i) = 2, then the ith digit in "TestDigits" is an image of a
%   handwritten number 2.)
% 
%   nDigits - a 10-by-1 column vector that stores a count for each digit.
%   Of the nImgs classified, nDigits stores how many times each digit 0-9
%   was the resultant classification of an image in TestDigits (i.e. if
%   nDigits(3) = 20, then 20 of the classified images were classified as a
%   2.

function [w,nDigits] = HansellPerezClassifyDigits(svTol,nImgs)
    % preallocate space for output vectors
    w = zeros(nImgs, 1);
    nDigits = zeros(10,1);
    
    ntrain_img = 500;
    Sdim = min(784,nImgs);

    % here I preallocate space for the A matrix that will store the
    % information of each training set. Note that I only use 500 images to
    % train the SVD classifier, increasing the second entry in the "zeros()"
    % argument below could increase accuracy of the model but it will also
    % increase computation requirements
    A = zeros(784,ntrain_img, 10);
    for i = 1:10        % this loop builds the A matrix for each "Digit" training set 
        for j = 1:ntrain_img
            filename = ['Test1\Digit' num2str(i-1,'%1d') '\' num2str(j,'%04d') '.png'];
            img = imread(filename);
            A(:,j,i) = double(reshape(img(:,:,1),[],1));
        end
    end
    
    % preallocate space for output of SVD factorization 
    U = zeros(784,784,10);
    S = zeros(784, ntrain_img, 10);
    % V = zeros(500, 500,10);       i never used it so no need to store it
    for i = 1:10        % This loop factorizes A into using SVD
         [U(:,:,i),S(:,:,i), ~] = svd(A(:,:,i));
    end
    
    k = zeros(10,1);
    for i = 1:10
        sigmaAll = trace(S(1:Sdim,1:Sdim,i));
        sigmak = 0;
        for j = 1:Sdim
            sigmak = sigmak + S(j,j,i);
            if sigmak/sigmaAll > svTol
                k(i) = j;
                break
            end
        end
    end
    
    % compute Uk*Uk^T for each training set
    UkUkT = cell(10,1);
    for i = 1:10
        UkUkT{i} = U(:,1:k(i),i)*U(:,1:k(i),i)';
    end
    
    % compute residuals for each image we want to classify
    for i = 1:nImgs
        filename = ['Test1\TestDigits\' num2str(i,'%04d') '.png'];
        img = imread(filename);
        z = double(reshape(img(:,:,1),[],1));
        res = zeros(10,1);
        for j = 1:10
            res(j) = norm(z-UkUkT{j}*z,2)/norm(z,2);
        end
        w(i) = find(res == min(res),1) -1;
    end

    for i = 1:10
        nDigits(i) = length(find(w == i-1));
    end
end