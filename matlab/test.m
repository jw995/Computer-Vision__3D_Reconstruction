clc;
clear;
close all hidden;

im1 = imread('../data/im1.png');
im2 = imread('../data/im2.png');
M = max(size(im1));

%% test q2_1>>>
% load('../data/some_corresp.mat');
% [F] = eightpoint(pts1, pts2, M);
% displayEpipolarF(im1, im2, F);

%% test q2_2
% %cpselect(im1,im2); %>>>
% load picked1.mat;
% [ F ] = sevenpoint(movingPoints, fixedPoints, M);
% displayEpipolarF(im1, im2, F{3});

%% test q3_1
% load ('../data/intrinsics.mat');
% load q2_1.mat;
% [ E ] = essentialMatrix( F, K1, K2 );

%% test q4_1
% load('../data/some_corresp.mat');
% [ F ] = eightpoint( pts1, pts2, M );
% [pts1, pts2] = epipolarMatchGUI(im1,im2,F);
% save q4_1.mat F pts1 pts2;

%% test q5_1
load('../data/some_corresp_noisy.mat');
% % F0 = eightpoint(pts1, pts2, M);
% % displayEpipolarF(im1, im2, F0);
% [ F, inliers ] = ransacF( pts1, pts2, M );
% displayEpipolarF(im1, im2, F);

%% test 5_3
% load('../data/some_corresp_noisy.mat');
% load ('../data/intrinsics.mat');
% load RANSAC_points.mat;
% 
% [ E ] = essentialMatrix( F, K1, K2 );
% [P, M2] = cal3d(E, p1, p2, K1, K2);
% 
% N=size(P,1);
% P_init=reshape(P,[3*N,1]);
% 
% M1=[eye(3) zeros(3,1)];
% figure;
% [M2_adj, P_adj] = bundleAdjustment(K1, M1, p1, K2, M2, p2, P_init);

