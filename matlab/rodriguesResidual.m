function residuals = rodriguesResidual(K1, M1, p1, K2, p2, x)
% rodriguesResidual:
% Inputs:
%   K1 - 3x3 camera calibration matrix 1
%   M1 - 3x4 projection matrix 1
%   p1 - Nx2 matrix of (x, y) coordinates
%   K2 - 3x3 camera calibration matrix 2
%   p2 - Nx2 matrix of (x, y) coordinates
%   x - (3N + 6)x1 flattened concatenation of P, r_2 and t_2

% Output:
%   residuals - 4Nx1 vector

N=size(p1,1);

Rotate_vec=x(3*N+1:3*N+3,1);
Tran_vec=x(3*N+4:3*N+6,1);
points_3d=x(1:3*N,1);

R=rodrigues(Rotate_vec);
M2=[R Tran_vec];

C1=K1*M1;
C2=K2*M2;
P=reshape(points_3d,[N,3]);

HP=[P';ones(1,N)]; % 4*N
p1_re=C1*HP;  % 3*N
p2_re=C2*HP;

p1_norm=p1_re./p1_re(3,:);
p1_norm(3,:)=[];
p2_norm=p2_re./p2_re(3,:);
p2_norm(3,:)=[];

temp1=(p1-p1_norm').^2;
temp2=(p2-p2_norm').^2;
% p1_err=sum(temp1(:));
% p2_err=sum(temp2(:));
residuals=[temp1(:,1); temp1(:,2); temp2(:,1); temp2(:,2)];


end
