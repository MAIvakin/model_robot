%Построить лабиринт для модели робота
function maze
clear;
maze_points = [];
j = 1+0*i;
map = figure('Visible','on','Name','Map','NumberTitle','off');
    ax = axes('Units', 'normalized', 'Position', [0.05 0.2 0.9 0.7]);
    ax.XLim = [-1.5 1.5];
    ax.YLim = [-1.5 1.5];
    axis equal
    grid on
%Точка лабиринта
    uicontrol('Style', 'pushbutton', 'String', 'Set maze point',...
        'Units', 'normalized','Position', [0.05 0.05 0.2 0.1],...
        'Callback', @Set_maze_point);
function Set_maze_point(source, event)
        dot = ginput(1);
        traj_points(j,1) = dot(1);
        traj_points(j,2) = dot(2);
        line(ax,traj_points(:,(j-1)), traj_points(:,2),'color','g','linewidth',2);
        ax.XLim = [-1.5 1.5];
        ax.YLim = [-1.5 1.5];
        axis equal
        grid on
        j = j+1;
    end
end