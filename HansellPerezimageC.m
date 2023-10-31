function [tsum,nsum] = HansellPerezimageC(nImages, svTol)
    t = zeros(nImages,1);
    n = zeros(nImages,1);
    
    for i = 1:nImages
        filename = ['BW' num2str(i, '%02d') '.jpg'];
        A = imread(filename);
        
        [U, S, V] = svd(double(rgb2gray(A)));

        [r,c] = size(S);
        Sdim = min(r,c);
        
        S_diag_sum = trace(S(1:Sdim, 1:Sdim));
        S_diag_cumsum = 0;
        for j = 1:length(S)
            S_diag_cumsum = S_diag_cumsum + S(j,j);
            if S_diag_cumsum/S_diag_sum > svTol
                t(i) = j;
                break
            end
        end
        n(i) = (2*t(i))/(1-svTol);
        
        if i == nImages
            Aappr = zeros(size(A));
            for j = 1:t(i)
                Aappr = Aappr + S(j,j)*U(:,j)*V(:,j)';
            end 
            imshow(Aappr)
        end
    end
    tsum = sum(t);
    nsum = sum(n);
end