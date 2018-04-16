function R = rodrigues(r)
% rodrigues:

% Input:
%   r - 3x1 vector
% Output:
%   R - 3x3 rotation matrix

theta=norm(r);
r=r./theta;

k=[0 -r(3) r(2); 
    r(3) 0 -r(1);
    -r(2) r(1) 0];

R=eye(3)+sin(theta).*k+(1-cos(theta)).*k*k;
R=R';

end
