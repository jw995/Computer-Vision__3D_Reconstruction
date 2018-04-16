function [M2, P] = bundleAdjustment(K1, M1, p1, K2, M2_init, p2, P_init)
% bundleAdjustment:
% Inputs:
%   K1 - 3x3 camera calibration matrix 1
%   M1 - 3x4 projection matrix 1
%   p1 - Nx2 matrix of (x, y) coordinates
%   K2 - 3x3 camera calibration matrix 2
%   M2_init - 3x4 projection matrix 2
%   p2 - Nx2 matrix of (x, y) coordinates
%   P_init: Nx3 matrix of 3D coordinates
%
% Outputs:
%   M2 - 3x4 refined from M2_init
%   P - Nx3 refined from P_init
R2=M2_init(:,1:3);
r2=invRodrigues(R2);
t2=M2_init(:,4);

% xx=[P_init; r2; t2];
% residuals = rodriguesResidual(K1, M1, p1, K2, p2, xx);

fun = @(x)sum(rodriguesResidual(K1, M1, p1, K2, p2, x));
x0=[P_init; r2; t2];
x = lsqnonlin(fun,x0);

N=size(p1,1);
Rotate_vec=x(3*N+1:3*N+3,1);
t=x(3*N+4:3*N+6,1);
R=rodrigues(Rotate_vec);
t=t./norm(t);

M2=[R t];
P=x(1:3*N,1);
P=reshape(P,[N,3]);

scatter3(P(:,1),P(:,2),P(:,3),10,'filled');
end
