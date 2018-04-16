function [ F ] = eightpoint( pts1, pts2, M )
% eightpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.1:
%     Implement the eightpoint algorithm
%     Generate a matrix F from some '../data/some_corresp.mat'
%     Save F, M, pts1, pts2 to q2_1.mat

%     Write F and display the output of displayEpipolarF in your writeup

% scale the image
pts1_norm=pts1./M;
pts2_norm=pts2./M;
N=size(pts1,1);

% A matrix
x1=pts1_norm(:,1); y1=pts1_norm(:,2);  % N*1
x2=pts2_norm(:,1); y2=pts2_norm(:,2); 
% A=[x1.*x2 x1.*y2 x1 y1.*x2 y1.*y2 y1 x2 y2 ones(N,1)];
A=[x2.*x1 x2.*y1 x2 y2.*x1 y2.*y1 y2 x1 y1 ones(N,1)];

% eight point 
[~,~,V] = svd(A'*A);
F=V(:,9);
F=reshape(F,[3,3]);
F=F';

% enforce rank2
[u,s,v]=svd(F);
s(3,3)=0;
F=u*s*v';

% un-normalize
T=eye(3)./M;
T(3,3)=1;
F=T'*F*T;

save('q2_1.mat', 'F', 'M', 'pts1', 'pts2');

end

