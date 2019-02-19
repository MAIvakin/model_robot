function [collision] = cross(coord_I,coord_II, model)
int1 = intersections(coord_I(:,1),coord_I(:,2),model(:,1),model(:,2));
int2 = intersections(coord_II(:,1),coord_II(:,2),model(:,1),model(:,2));
if isempty(int1)==0 || isempty(int2) == 0
    collision = 1;
else
    collision = 0;
end
%assignin('base','collision',collision)
end