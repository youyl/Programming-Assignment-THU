function [res]=brute_force(x,y)
    n=length(x);
    m=length(y);
    res=zeros(1,n+m-1); % the final length of convolution
    for i=1:n % brute force algorithm in O(nm) time
        for j=1:m
            res(i+j-1)=res(i+j-1)+x(i)*y(j);
        end
    end
end
