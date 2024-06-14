function heterogeneityMap = getHeterogeneityMap(stack, ROIsize)
%getHeterogeneityMap quantifies the local heterogeneity of an image by
%normalizing the image intensity with respect to the mean intensity of its
%local neighborhood.
%
% Input variables:
%   - stack: Image stack (x,y,t).
%   - ROIsize: Diameter (in pixels) of the circular neighborhood to be used.
% 
% Output: 
%   - heterogenityMap has the same size as stack.
% 
% By Rodrigo Migueles Ramirez (GitHub.com/Malvick17), 2024. McGill University, Canada.
% Please cite: Migueles-Ramirez, R., et.al., Journal of Microscopy, 2024.

    % Create circular kernel
    circleMask = circle(ROIsize, ROIsize,...
                    (ROIsize+1)/2, (ROIsize+1)/2, ROIsize/2);
    h = circleMask./sum(circleMask, 'all', 'omitnan');
    
    % Initialize hetMap
    heterogeneityMap = zeros(size(stack));

    % Get hetMap
    for frame = 1:size(stack, 3)
        image = double(stack(:,:,frame));
        meanMap = imfilter(double(image), h);
        differences = image - meanMap;
        heterogeneityMap(:,:,frame) = differences./meanMap;
    end

end