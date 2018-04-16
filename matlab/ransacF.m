function [ F, inliers ] = ransacF( pts1, pts2, M )
% ransacF:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q5.1:
%     Implement RANSAC
%     Generate a matrix F from some '../data/some_corresp_noisy.mat'
%          - using eightpoint
%          - using ransac

%     In your writeup, describe your algorithm, how you determined which
%     points are inliers, and any other optimizations you made

%%%
N=size(pts1,1);
inliers=zeros(N,1);

% set scope here
sigma=0.008;
iter=2000;

for i=1:iter
    idx=randperm(N,8);
    pair1=pts1(idx,:);
    pair2=pts2(idx,:);
    [ F_ori ] = eightpoint( pair1, pair2, M );
    
    pair1_3D=[pts1 ones(N,1)];
    eplines=F_ori*pair1_3D';
    eplines=eplines./eplines(3,:);
    
    x2=pts2(:,1); y2=pts2(:,2);
    outcome=eplines(1,:)'.*x2+eplines(2,:)'.*y2+eplines(3,:)';
    outcome=abs(outcome);
   
    count=outcome<sigma;

    if (sum(count)>sum(inliers))
        inliers = count;
        F=F_ori;
    end

end

sum(inliers)
    
%     correct_idx=find(inliers==1);
%     new_p1=pts1(correct_idx,:);
%     new_p2=pts2(correct_idx,:);
%     
%     [ F ] = eightpoint( new_p1, new_p2, M );
%     sum(inliers)
end

