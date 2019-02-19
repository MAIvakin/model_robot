function check_collision(model, coord_I, coord_II)
    for i = 2:5
        [collision_points1x, collision_points1y] = intersections([model(i,1) model(i,2)], [model((i-1),1) model((i-1),2)], coord_I(:,1), coord_I(:,2),1)
        [collision_points2x, collision_points2y] = intersections([model(i,1) model(i,2)], [model((i-1),1) model((i-1),2)], coord_II(:,1), coord_II(:,2),1)
%         if isempty(collision_points1) == 0
%             ans = 'aaaaaaaaaaaaaaaaaaaaaaaa'
%         end
%         if isempty(collision_points2) == 0
%             ans = 'bbbbbbbbbbbbbbbbbbbbbbbb'
%         end
        if (isempty([collision_points1x, collision_points1y]) == 0) || (isempty([collision_points2x, collision_points2y]) == 0)
            collision = true;
            return
        end
    end
end