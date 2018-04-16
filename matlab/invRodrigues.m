function r = invRodrigues(R)
% invRodrigues
% Input:
%   R: 3x3 rotation matrix
% Output:
%   r: 3x1 vector

det(R)
k=0.5.*(R-R');
k=k';

u=[k(3,2);k(1,3);k(2,1)];
u=u./norm(u);

s=norm(u);
c1=((R(1,1)+R(2,2)+R(3,3))-1)*0.5;
if (c1<0)
    theta=atan(s/c1);
else
    theta=pi+atan(s/c1);
end
r=u*theta;

r=rotationMatrixToVector(R);
r=r';

end
