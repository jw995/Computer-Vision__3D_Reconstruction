function [ F ] = sevenpoint( pts1, pts2, M )
% sevenpoint:
%   pts1 - 7x2 matrix of (x,y) coordinates
%   pts2 - 7x2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.2:
%     Implement the eightpoint algorithm
%     Generate a matrix F from some '../data/some_corresp.mat'
%     Save recovered F (either 1 or 3 in cell), M, pts1, pts2 to q2_2.mat

%     Write recovered F and display the output of displayEpipolarF in your writeup

% scale the image
pts1_norm=pts1./M;
pts2_norm=pts2./M;
N=size(pts1,1);

% A matrix
x1=pts1_norm(:,1); y1=pts1_norm(:,2);  % N*1
x2=pts2_norm(:,1); y2=pts2_norm(:,2); 
% A=[x1.*x2 x1.*y2 x1 y1.*x2 y1.*y2 y1 x2 y2 ones(N,1)];
A=[x2.*x1 x2.*y1 x2 y2.*x1 y2.*y1 y2 x1 y1 ones(N,1)];

% seven point 
[~,~,V] = svd(A'*A);
F1=V(:,9); 
F1=reshape(F1,[3,3]);
F1=F1';
F2=V(:,8); 
F2=reshape(F2,[3,3]);
F2=F2';

% det[a*F1+(1-a)*F2]=0
syms a;
myeq=det(a*F1+(1-a)*F2);
myeq=sym2poly(myeq);
alpha=real(roots(myeq));

% un-normalize
T=eye(3)./M;
T(3,3)=1;
cell_N=size(alpha,1);
F = cell(cell_N,1);

for i=1:cell_N
    F{i}=alpha(i)*F1+(1-alpha(i))*F2;
%     [u,s,v]=svd(F{i});
%     s(3,3)=0;
%     F{i}=u*s*v';
    F{i}=T'*F{i}*T;
end

save('q2_2.mat', 'F', 'M', 'pts1', 'pts2');

end

