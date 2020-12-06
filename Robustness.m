 %{ 
Attacks :
        1. Sharpening 
        2. Cropping
        3. Additive Gaussian Noise
        4. Pixelation 
        5. Resizing
        6. Scaling 
        7. Rotation 
        8.Salt and Pepper 
        9.Horizontal flipping

%} 

img=imread('E:\MATLAB\check\embedded.bmp');
input=imread('E:\MATLAB\check\lena_gray.tif');
input=rgb2gray(input);
    input=imresize(input,[512,512]);


%attack%

  %sharpening 

%{
 S=imsharpen(img);
 figure;imshow(S);title('After sharpening');
 cc2=corr2(input,S); 
 fprintf('\n%s \t %5.4f\n',' The correlation value between original image and after sharpening is: ',cc2)
 %}

  %cropping

%{ 
 imshow(img);
  J = imcrop(img,[200 160 180 220]);
    subplot(1,2,1)
    imshow(img)
    title('Original Image')
    
    subplot(1,2,2)
    imshow(J)
    title('Cropped Image')
% figure;imshow(J);title('After cropping');
 J=imresize(J,size(img));
 ssimval = ssim(img,J);
 cc1=corr2(input,J);
 fprintf('\n%s \t %5.4f\n',' The correlation value between original image and after cropping is: ',cc1)
  
 %}  
  
 
 %gaussian noise
 
 %{
    subplot(1,2,1)
    imshow(img);
  J= imnoise(img,'gaussian',0.3);
  subplot(1,2,2)
   imshow(J);
   title('image with gaussian noise')
 cc2=corr2(input,J);
fprintf('\n%s \t %5.4f\n',' The correlation value between original image and after gaussian noise is: ',cc2)
%}
  

%scaling

 Q =imresize(img,0.5) % 0.5 is scale
   figure;imshow(img);title('Original Image')
    figure;imshow(Q);title('scaled Image')
  Q=imresize(Q,size(img));
  ssimval = ssim(img,Q);

   cc2=corr2(input,Q);
  fprintf('\n%s \t %5.4f\n',' The correlation value between original and scaled image is: ',cc2);
%}
%{

%rotation
S= imrotate(img,2,'bilinear','crop');
    subplot(1,2,1)
    imshow(img)
    title('Original Image')
    subplot(1,2,2)
    imshow(S)
    title('Rotated Image')
cc2=corr2(input,S);
fprintf('\n%s \t %5.4f\n',' The correlation value between original and rotated image is: ',cc2)
%}


%{
  %resizing
P = imresize(img,1.5); 
figure;

    imshow(img)
    title('Original Image')
    %subplot(1,2,2)
    imshow(P)
    title('Resized Image')
P=imresize(P,size(img));
ssimval = ssim(img,P);
cc2=corr2(input,P);
fprintf('\n%s \t %5.4f\n',' The correlation value between original and resized image is: ',cc2)
%}    
  
%pixelation
%{
bw = im2bw(img, graythresh(img));
L = bwlabel(bw);                    
s = regionprops(L, 'PixelIdxList') % linear index of pixels
K= img;
K(s(4).PixelIdxList) = 255;      % Replacing object pixel value
K(s(5).PixelIdxList) = 0;
imshow(K)
F = img;
for k1 = 1:numel(s)
    idx = s(k1).PixelIdxList;
    F(idx) = mean(img(idx));     % finding mean value of block of pixels
end
figure,
subplot(1,2,1)
    imshow(img)
    title('Original Image')
    subplot(1,2,2)
    imshow(F)
    title('Pixelated Image')
    cc2=corr2(input,F);
fprintf('\n%s \t %5.4f\n',' The correlation value between original and pixelated image is: ',cc2)
%}    


 %horizontal flipping
%{
 J = flip(img,2);  
imshow(J)
cc2=corr2(input,J);
fprintf('\n%s \t %5.4f\n',' The correlation value between original and horizontally flipped image is: ',cc2)
 %}

  %salt and pepper attack
%{
  subplot(1,2,1)
  imshow(img)
  J=imnoise(img,'salt & pepper',0.1);
  subplot(1,2,2)
  imshow(J);
 cc2=corr2(input,J);
 fprintf('\n%s \t %5.4f\n',' The correlation value between original image and after salt and pepper attack is: ',cc2)
 %}      