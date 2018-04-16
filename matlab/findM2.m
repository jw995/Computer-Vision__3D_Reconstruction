% Q3.3:
%       1. Load point correspondences
%       2. Obtain the correct M2
%       3. Save the correct M2, C2, p1, p2, R and P to q3_3.mat

clc;
clear;
close all hidden;

im1 = imread('../data/im1.png');
im2 = imread('../data/im2.png');
M = max(size(im1));

load('../data/some_corresp.mat');
load('../data/intrinsics.mat');

[ F ] = eightpoint( pts1, pts2, M );
[ E ] = essentialMatrix( F, K1, K2 );

M1=[eye(3) zeros(3,1)];
C1=K1*M1;
[M2s] = camera2(E);  
% possible M2 - 3*4*possible_num

% compute error for each M
possible_num=size(M2s,3);
error1=zeros(possible_num,1);
P_all=cell(possible_num,1);

for i=1:possible_num
    M2=M2s(:,:,i);
    C2=K2*M2;
    [ P, err ] = triangulate( C1, pts1, C2, pts2 );
    error1(i)=err;
    P_all{i}=P;
    
%     if (P(:,3)>0)
%         M2_best=M2s(:,:,i);
%         Points=P_all{i};
%     end
    
end

[best,idx]=min(error1);
M2_best=M2s(:,:,idx);
P=P_all{idx};
C2=K2*M2_best;
p1=pts1; p2=pts2; M2=M2_best;

save q3_3.mat M2 P p1 p2;

