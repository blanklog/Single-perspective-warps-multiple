function [ cell_inliers, stitch_pairs ] = calcInliers( xk )
% modification of inliers-finding, to make the features used in mesh
% deformation are same with bundle adjustment
num_imgs = size(xk,1)/2;
cell_inliers = cell(num_imgs*(num_imgs-1), 2); stitch_pairs = zeros(num_imgs*(num_imgs-1), 2);
k=1;
for i=1:num_imgs
    for j=i+1:num_imgs
        aux_i = find(~isnan(xk(2*i-1,:)));
        aux_j = find(~isnan(xk(2*j-1,:)));
        aux_ij = intersect(aux_i, aux_j);
        if ~isempty(aux_ij)
            cell_inliers{k,1} = xk(2*i-1:2*i, aux_ij);
            cell_inliers{k,2} = xk(2*j-1:2*j, aux_ij);
            stitch_pairs(k,1) = i; stitch_pairs(k,2) = j;
            k=k+1;
        end
    end
end
cell_inliers = cell_inliers(1:k-1,:);
stitch_pairs = stitch_pairs(1:k-1,:);

end

