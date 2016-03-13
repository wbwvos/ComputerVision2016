function [ narray1, narray2 ] = matchHeight( array1, array2 )
if size(array1, 1) ~= size(array2,1)
    if size(array1, 1) > size(array2, 1)
      add = zeros(size(array1, 1) - size(array2, 1 ), size(array2, 2));
      narray2 = cat(1, array2, add);
      narray1 = array1;
    else
      add = zeros(size(array2, 1) - size(array1, 1 ), size(array1, 2));
      narray1 = cat(1, array1, add);
      narray2 = array2;
    end
else
   narray1 = array1;
   narray2 = array2;
end


end

