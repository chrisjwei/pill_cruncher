function [] = process(filename)
    close all;
    I_original = imresize(imread(filename), [200 200]);
    I = rgb2gray(I_original);
    [height width] = size(I);

    r = 60;
    x = 38;
    y = 38;
    Mask = uint8(fspecial('disk',r)~=0);
    [u, v, i]=size(Mask);

    I_bg = im2double(I);
    I_blur = medfilt2(I_bg, [20 20]);
    I_diff = im2uint8((abs(I_bg - I_blur)));

    I_crop = imcrop(I_diff,[x y u-1 v-1]).*Mask;
    I_eq = medfilt2(histeq(I_crop),[4,4]);

    I_bin = im2bw(I_eq, 0.8);
    
    figure;
    subplot(1,2,1);
    imshow(zeros(size(I_bin)));
    hold on

    I_bin_filled = imfill(I_bin,'holes');
    
    boundaries = bwboundaries(I_bin_filled);
    
    for k=1:size(boundaries);
       b = boundaries{k};
       if (size(b, 1) > 20)
          fill(b(:,2),b(:,1),'w');
       end
    end
    
    subplot(1,2,2);
    imshow(I_original);
    pause(0.5);
    %[pathstr,name,ext] = fileparts(filename);
    %print('-dsvg', ['pimages\' name '.svg']);
end
