function [P, M2] = cal3d(E, pts1, pts2, K1, K2)

    M1=[eye(3) zeros(3,1)];
    C1=K1*M1;
    [M2s] = camera2(E);  

    possible_num=size(M2s,3);
    error1=zeros(possible_num,1);
    P_all=cell(possible_num,1);


    for i=1:possible_num
        M2=M2s(:,:,i);
        C2=K2*M2;
        [ P, err ] = triangulate( C1, pts1, C2, pts2 );
        error1(i)=err;
        P_all{i}=P;

        if (P(:,3)>0)
            M2_best=M2s(:,:,i);
            Points=P_all{i};
        end

    end

    M2=M2_best;
    P=Points;

    scatter3(P(:,1),P(:,2),P(:,3),10,'filled');

end