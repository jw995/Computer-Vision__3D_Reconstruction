function [ P, err ] = triangulate( C1, p1, C2, p2 )
% triangulate:
%       C1 - 3x4 Camera Matrix 1
%       p1 - Nx2 set of points
%       C2 - 3x4 Camera Matrix 2
%       p2 - Nx2 set of points

%       P - Nx3 matrix of 3D coordinates
%       err - scalar of the reprojection error

% Q4.2:
%       Implement a triangulation algorithm to compute the 3d locations
%

N=size(p1,1);
P=zeros(N,3); 

for i=1:N
    x1=p1(i,1); y1=p1(i,2);
    x2=p2(i,1); y2=p2(i,2);
    
    % AP = 0  
    % P is homogenious 4*1 
    A=[x1*C1(3,:)-C1(1,:);
        y1*C1(3,:)-C1(2,:);
        x2*C2(3,:)-C2(1,:);
        y2*C2(3,:)-C2(2,:)];

    [~,~,V]=svd(A);
    found=V(:,4); 
    found=found'./found(4);  
    found(4)=[];
    P(i,:)=found;  % 3*1
    
end 

HP=[P';ones(1,N)]; % 4*N
p1_re=C1*HP;  % 3*N
p2_re=C2*HP;

p1_norm=p1_re./p1_re(3,:);
p1_norm(3,:)=[];
p2_norm=p2_re./p2_re(3,:);
p2_norm(3,:)=[];

temp1=(p1-p1_norm').^2;
temp2=(p2-p2_norm').^2;
p1_err=sum(temp1(:));
p2_err=sum(temp2(:));
err=p1_err+p2_err;

end
