x=imread('peppers.png');
figure,imshow(x);
gray_x = rgb2gray(x);
red_x = x(:,:,1);
sub_x = imsubtract(red_x,gray_x);
figure,imshow(sub_x);
bin_x  = im2bw(sub_x,0.21);
mask  = ~bin_x;
mask3 = cat(3,mask,mask,mask); 
new_x = x;   %create a backup copy of original image
new_x(mask3) = 0;
figure,imshow(new_x);
green_x = x(:,:,2);  %get green matrix just like the red one
gsub_x = imsubtract(green_x,gray_x); %subtract gray from green 
figure,imshow(gsub_x);
gbin_x = im2bw(gsub_x,0.01);
figure,imshow(gbin_x);
%% Read Original Image

x=imread('peppers.png');
gray_x = rgb2gray(x);
%% Extract Red Space 
red_x = x(:,:,1);
rsub_x = imsubtract(red_x,gray_x);

%% Red to binary
rbin_x = im2bw(rsub_x,0.3);
rbmask = im2bw(imcomplement(rbin_x));
rbmask = cat(3,rbmask,rbmask,rbmask);
only_red_x = x;
only_red_x(rbmask)=0;
figure,subplot(2,1,1),imshow(x),title('original Peppers Image');
subplot(2,1,2),imshow(only_red_x),title('red objects found');

%% display red_sub 
figure,imshow(rsub_x);
figure,imshow(x),title('Original Peppers Image')
%%

green_x = x(:,:,2); 
gsub_x = imsubtract(green_x,gray_x);
figure,imshow(gsub_x),title('Green Matrix')
gbin_x = im2bw(gsub_x,0.01);
figure,imshow(gbin_x),title('green to binary with 0.01 threshold')

%% mask only green objects

only_green_x = x;
ogx_mask = im2bw(double(imcomplement(gbin_x)));
ogx_mask = cat(3,ogx_mask,ogx_mask,ogx_mask);
only_green_x(ogx_mask)=0;
figure,imshow(only_green_x),title('Green Objects Subtracted');


%% subtract together

comb_x = x;
abs_comb_x = x;
combined_x = imsubtract(rbin_x,gbin_x);
abs_cx = abs(imsubtract(rbin_x,gbin_x));

%% apply masks
mk1 = im2bw(imcomplement(combined_x));
mk2 = im2bw(imcomplement(abs_cx));
mk1 = cat(3,mk1,mk1,mk1);mk2=cat(3,mk2,mk2,mk2);
comb_x(mk1)=0;abs_comb_x(mk2)=0;

%% plotting
figure,subplot(2,2,1),imshow(combined_x); title('without abs')
subplot(2,2,2),imshow(abs_cx),title('with abs')
subplot(2,2,3),imshow(comb_x),title('without abs x')
subplot(2,2,4),imshow(abs_comb_x),title('with abs x')

clear all; close all; clc;

%%
x       = imread('peppers.png');
red_x   = x(:,:,1);
green_x = x(:,:,2);
gray_x  = rgb2gray(x);

%% GET ONLY RED OBJECTS
sub_rg=imsubtract(red_x,green_x);
sub_rg_gray = imsubtract(sub_rg,gray_x);
only_red_bin = im2bw(sub_rg_gray,0.18);


%% Prepare and Apply Mask
only_red_mask = im2bw(imcomplement( only_red_bin));
only_red_mask = cat(3,only_red_mask,only_red_mask,only_red_mask);
only_red_x = x;
only_red_x(only_red_mask)=0;


%% display Results
figure,imshow(x),title('original image'),
figure,imshow(only_red_x),title('extracted objects');