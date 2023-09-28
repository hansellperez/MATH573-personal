A = imread("BW)1.jpg");
imshow(A(:,:,1))
[m,n] = size(A)

[U, S, V] = svd(double(A(:,:,1)));

B = U*S*V'; % adjust resolution by only multiplying certain dimension submatrices of U*S*V (e.g U(:,1:100)*S(1:100, 1:100)*V(:,1:100)' )
norm(B-double(A(:,:,1),1))
[m,n] = size(S)


%% loop for traversing through images, want to insert code above in the loop so that everyhting is automated
num_images = 10; % hardcoded by professor; possible to automate to read a folder contents
for i = 1:num_images
    filename = ['BW' num2str(I, '%02d') '.jpg'];
    A = imread(filename);
    imshow(A)
    pause(10)
end