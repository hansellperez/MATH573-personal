function [t1, t2, t3] = HansellPerezColorImageC(svTol)
    % Read the color image
    filename = ''; % insert the path for the image file desired
    image = imread(filename);

    % Split the image into R, G, and B channels
    redChannel = double(image(:,:,1));
    greenChannel = double(image(:,:,2));
    blueChannel = double(image(:,:,3));

    % Apply SVD method to each color channel with the given svTol
    [U_R, S_R, V_R] = svd(redChannel);
    [U_G, S_G, V_G] = svd(greenChannel);
    [U_B, S_B, V_B] = svd(blueChannel);

    % Calculate the threshold values for each channel
    singularValuesR = diag(S_R);
    singularValuesG = diag(S_G);
    singularValuesB = diag(S_B);

    t1 = findThreshold(singularValuesR, svTol);
    t2 = findThreshold(singularValuesG, svTol);
    t3 = findThreshold(singularValuesB, svTol);

    % Reconstruct the channels based on the thresholds
    reconstructedR = U_R(:,1:t1) * S_R(1:t1,1:t1) * V_R(:,1:t1)';
    reconstructedG = U_G(:,1:t2) * S_G(1:t2,1:t2) * V_G(:,1:t2)';
    reconstructedB = U_B(:,1:t3) * S_B(1:t3,1:t3) * V_B(:,1:t3)';

    % Combine the reconstructed channels to form the RGB image
    reconstructedImage = uint8(cat(3, reconstructedR, reconstructedG, reconstructedB));

    % Display the reconstructed image
    imshow(reconstructedImage);
    title('Reconstructed Color Image');
end

function t = findThreshold(singularValues, svTol)
    totalSum = sum(singularValues);
    partialSum = 0;
    t = 0;

    for idx = 1:numel(singularValues)
        partialSum = partialSum + singularValues(idx);
        ratio = partialSum / totalSum;

        if ratio >= svTol
            t = idx;
            break;
        end
    end
end
