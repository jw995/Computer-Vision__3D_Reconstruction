% Q4.2:
% Integrating everything together.
% Loads necessary files from ../data/ and visualizes 3D reconstruction
% using scatter3

clc;
clear;
close all hidden;

im1 = imread('../data/im1.png');
im2 = imread('../data/im2.png');

load('../data/some_corresp.mat');
load('../data/intrinsics.mat');
load('../data/templeCoords.mat');

M = max(size(im1));
[ F ] = eightpoint( pts1, pts2, M );
[ E ] = essentialMatrix( F, K1, K2 );

N=length(x1);
x2=zeros(N,1); y2=zeros(N,1);

for i=1:N
    [ x2(i), y2(i) ] = epipolarCorrespondence( im1, im2, F, x1(i), y1(i) );
end

p1_set=[x1 y1];
p2_set=[x2 y2];

M1=[eye(3) zeros(3,1)];
C1=K1*M1;
[M2s] = camera2(E);  

possible_num=size(M2s,3);
error1=zeros(possible_num,1);
P_all=cell(possible_num,1);


for i=1:possible_num
    M2=M2s(:,:,i);
    C2=K2*M2;
    [ P, err ] = triangulate( C1, p1_set, C2, p2_set );
    error1(i)=err;
    P_all{i}=P;
    
    if (P(:,3)>0)
        M2_best=M2s(:,:,i);
        Points=P_all{i};
    end
    
end

% [best,idx]=min(error1);
% M2_best=M2s(:,:,idx);
% P=P_all{idx};
M2=M2_best;
P=Points;

scatter3(P(:,1),P(:,2),P(:,3),10,'filled');

save q4_2.mat M1 M2 C1 C2;
save point3d.mat P;

