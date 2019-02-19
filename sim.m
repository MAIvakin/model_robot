clear;
%набор координат для I линии
coord_I = [-0.25 0; -0.25 1; 0.85 1; 0.85 0.5; 0.95 0.5; 0.95 1]./1.2;
%набор координат для II линии
coord_II = [0.25 0; 0.25 0.5; 0.35 0.5; 0.35 0; 1.45 0; 1.45 1]./1.2;
f = figure('Visible','on','Name','LABIRINT','NumberTitle','off');
axis([-0.4 1.6 -0.2 1.2]);
hold on
wall_1 = line(coord_I(:,1), coord_I(:,2));
wall_2 = line(coord_II(:,1), coord_II(:,2));
x = 0;
y = 0;
psi = 90;
robot = L_robot;
o = 1;
i = 1;
while y < 1
    model(:,:,i) = Rectangle_graph_model(robot,x,y,psi);
    h(i) = plot(model(:,1,i), model(:,2,i),'black');
    [l1, l2] = uslovie(x,y,psi);
    intersection21 = intersections(coord_I(:,1),coord_I(:,2),l1.XData,l1.YData,1);
    intersection22 = intersections(coord_II(:,1),coord_II(:,2),l1.XData,l1.YData,1);
    intersection11 = intersections(coord_I(:,1),coord_I(:,2),l2.XData,l2.YData,1);
    intersection12 = intersections(coord_II(:,1),coord_II(:,2),l2.XData,l2.YData,1);
    %Найти дальность до точки пересечения
    %length_1 = abs(sqrt(()^2+()^2))
    delete(l1)
    delete(l2)
    if isempty(intersection11) == 1 && isempty(intersection12) == 1
        move_ahead(robot,0.1,x,y,psi)
    end
    if (isempty(intersection11) == 0 || isempty(intersection12) == 0) && (isempty(intersection21) == 1 && isempty(intersection22) == 1)
        %поворот направо
        delete(h(i))
        delete(h(i-1))
        for j = 1:37
            psi(j+1) = psi(j) - 2.5;
            x(j+1) = x(j) + ((robot.V)/2)*cosd(psi(j))*0.1;
            y(j+1) = y(j) + ((robot.V)/2)*sind(psi(j))*0.1;
            model(:,:,j) = Rectangle_graph_model(robot,x(j),y(j),psi(j));
            h(j) = plot(model(:,1,j), model(:,2,j),'black');
            if j ~= 1
                delete(h(j-1))
            end
            pause(0.1)
        end
        delete(h(j))
        x = x(j);
        y = y(j);
        psi = psi(j);
    end
    if (isempty(intersection11) == 0 || isempty(intersection12) == 0) && (isempty(intersection21) == 0 || isempty(intersection22) == 0)
        %поворот налево
        delete(h(i))
        delete(h(i-1))
        for j = 1:37
            psi(j+1) = psi(j) +  2.5;
            x(j+1) = x(j) + ((robot.V)/2)*cosd(psi(j))*0.1;
            y(j+1) = y(j) + ((robot.V)/2)*sind(psi(j))*0.1;
            model(:,:,j) = Rectangle_graph_model(robot,x(j),y(j),psi(j));
            h(j) = plot(model(:,1,j), model(:,2,j),'black');
            if j ~= 1
                delete(h(j-1))
            end
            pause(0.1)
        end
        delete(h(j))
        x = x(j);
        y = y(j);
        psi = psi(j);
    end
    if i ~= 1
       delete(h(i-1))
    end
     pause(0.1)
    i = i+1;
    %Проверка на выход из лабиринта
end