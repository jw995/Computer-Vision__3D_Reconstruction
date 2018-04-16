function [ x2, y2 ] = epipolarCorrespondence( im1, im2, F, x1, y1 )
% epipolarCorrespondence:
%       im1 - Image 1
%       im2 - Image 2
%       F - Fundamental Matrix between im1 and im2
%       x1 - x coord in image 1
%       y1 - y coord in image 1

% Q4.1:
%           Implement a method to compute (x2,y2) given (x1,y1)
%           Use F to only scan along the epipolar line
%           Experiment with different window sizes or weighting schemes
%           Save F, pts1, and pts2 used to generate view to q4_1.mat
%
%           Explain your methods and optimization in your writeup

    % epipolar line calculation
    [H,W]=size(im2);
    line=F*[x1;y1;1];
    x1=round(x1);
    y1=round(y1);

    % calculate im1 blocks
    padding=10;
    hei=2*padding+1;
    sigma=5;
    
    filter1=fspecial('gaussian',[hei,hei],sigma);
    block1=im1(y1-padding:y1+padding, x1-padding:x1+padding);
    block1=double(block1);
    new_block1=filter1.*block1;

    % iter through im2
    lower=y1-padding*sigma;
    upper=y1+padding*sigma;
    min_err=10^5;

    for y_im2=lower:upper
        x_im2=round((-line(2)*y_im2-line(3))/line(1));
        % x=(-by-c)/a
        if (x_im2-padding>0 && x_im2+padding<W &&...
           y_im2-padding>0 && y_im2+padding<H)

            block2 = im2(y_im2-padding:y_im2+padding, x_im2-padding:x_im2+padding);
            block2=double(block2);
            new_block2=filter1.*block2;

            diff=(new_block1-new_block2).^2;
            error=sqrt(sum(diff(:)));

            if (error<min_err)
                min_err=error;
                x2=x_im2;
                y2=y_im2;
            end

        end

    end
    
end

