function [ U] = givecomp( U )
%Returns the computational subspace of the matrix

if size(U,1) == 16
    U = U([6 7 10 11],[6 7 10 11]);
elseif size(U,1)== 6
    U = U([2 3 4 5],[2 3 4 5]);
end


end

