function [ OUT ] = ReduceDim(IN,i)
%Reduces the Dimension of the matrix(by cutting)
%i is the output dimension
% 8 , 6 or 4 is allowed
OUT = IN;

%if input=output
if(size(IN,1) == i)
    return
end


if size(IN,1) == 16 

    

    if (i ==8)

    OUT(2,:)='';
    OUT(3,:)='';
    OUT(5,:)='';
    OUT(8,:)='';
    OUT(9,:)='';
    OUT(12,:)='';
    OUT(14,:)='';
    OUT(15,:)='';

    OUT(:,2)='';
    OUT(:,3)='';
    OUT(:,5)='';
    OUT(:,8)='';
    OUT(:,9)='';
    OUT(:,12)='';
    OUT(:,14)='';
    OUT(:,15)='';

    elseif(i==6)

     OUT = OUT([4 6 7 10 11 13],[4 6 7 10 11 13]);

    % OUT = [ OUT(4,4)    OUT(4,6)    OUT(4,7)    OUT(4,10)   OUT(4,11)   OUT(4,13) ; ...
    %         OUT(6,4)    OUT(6,6)    OUT(6,7)    OUT(6,10)   OUT(6,11)   OUT(6,13) ; ...
    %         OUT(7,4)    OUT(7,6)    OUT(7,7)    OUT(7,10)   OUT(7,11)   OUT(7,13) ; ...
    %         OUT(10,4)   OUT(10,6)   OUT(10,7)   OUT(10,10)  OUT(10,11)  OUT(10,13) ; ...
    %         OUT(11,4)   OUT(11,6)   OUT(11,7)   OUT(11,10)  OUT(11,11)  OUT(11,13) ; ...
    %         OUT(13,4)   OUT(13,6)   OUT(13,7)   OUT(13,10)  OUT(13,11)  OUT(13,13)]; 


    elseif(i==4)

        OUT = OUT([6 7 10 11],[6 7 10 11]);

    % OUT = [ OUT(6,6)    OUT(6,7)    OUT(6,10)   OUT(6,11) ; ...
    %         OUT(7,6)    OUT(7,7)    OUT(7,10)   OUT(7,11) ; ...
    %         OUT(10,6)   OUT(10,7)   OUT(10,10)  OUT(10,11) ; ...
    %         OUT(11,6)   OUT(11,7)   OUT(11,10)  OUT(11,11) ]    ; 



    end



elseif size(IN,1) ==6
   
    if (i == 4)
        OUT = OUT(2:5,2:5);
    end
    
end





end

