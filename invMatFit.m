function [fit] = invMatFit(A, X, dim)
fit = [];
for i = 1:size(X,2)
    t = reshape(X(:,i), dim, dim);
    t = A * t;
    sum = 0;
    for j = 1:size(t,1)
        for k = 1:size(t,2)
            if j==k,
                sum = sum + (1-t(j,k)).^2;
            else
                sum = sum + (0-t(j,k).^2);
            end
        end
    end
    fit = [fit sum];
end
