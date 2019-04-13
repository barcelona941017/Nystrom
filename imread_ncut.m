function I = imread_ncut(Image_file_name,nr,nc);
%  I = imread_ncut(Image_file_name);
%
% Timothee Cour, Stella Yu, Jianbo Shi, 2004.


%% read image 
if(ischar(Image_file_name))
    I = imread(Image_file_name);
else
    I = Image_file_name;
end
[Inr,Inc,nb] = size(I);

if (nb>1),
    I =double(rgb2gray(I));
else
    I = double(I);
end

I = imresize(I,[nr, nc],'bicubic');
