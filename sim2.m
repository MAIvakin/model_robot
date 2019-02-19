clear;
%набор координат для I линии
coord_I = [-0.25 0; -0.25 1; 0.85 1; 0.85 0.5; 0.95 0.5; 0.95 2; 0.85 2; 0.85 1.2; -0.25 1.2; -0.25 3.5; 1.95 3.5; 1.95 -0.5; 0.25 -0.5]./0.8;
%набор координат для II линии
coord_II = [0.25 0; 0.25 0.5; 0.35 0.5; 0.35 0; 1.45 0; 1.45 2.5; 0.25 2.5; 0.25 3; 1.45 3]./0.8;
f = figure('Visible','on','Name','LABIRINT','NumberTitle','off');
% axis([-0.4 1.6 -0.2 1.2]);
axis equal
hold on
wall_1 = line(coord_I(:,1), coord_I(:,2));
wall_2 = line(coord_II(:,1), coord_II(:,2));
x = 0.2;
y = 0.2;
psi = 90;
robot = L_robot;
o = 1;
i = 1;
collision = false;
while o == 1
%     delete(wall_1)
%     delete(wall_2)
    clf();
    axis equal
    hold on
    wall_1 = line(coord_I(:,1), coord_I(:,2));
    wall_2 = line(coord_II(:,1), coord_II(:,2)); 
    model(:,:,i) = Rectangle_graph_model(robot,x,y,psi);
    collision = cross(coord_I,coord_II, model);
    if collision == 1
        move_back(robot,dt,x,y,psi)
        move_back(robot,dt,x,y,psi)
        move_back(robot,dt,x,y,psi)
    end
    h(i) = plot(model(:,1,i), model(:,2,i),'black');
    [l2, l1] = uslovie(x,y,psi);
    [x11,y11] = intersections(coord_I(:,1),coord_I(:,2),l1.XData,l1.YData,1);
    [x12,y12] = intersections(coord_II(:,1),coord_II(:,2),l1.XData,l1.YData,1);
    [x21,y21] = intersections(coord_I(:,1),coord_I(:,2),l2.XData,l2.YData,1);
    [x22,y22] = intersections(coord_II(:,1),coord_II(:,2),l2.XData,l2.YData,1);
    %расстояние между дальномерами и препятсвиями
    if isempty(x11) == 1 && isempty(y11) == 1
        d11 = inf;
    else
    d11 = normrnd(sqrt((x11(1)-x)^2 +(y11(1)-y)^2),0); % - расстояние между 1-стенкой и 1-ым дальномером
    end
    if isempty(x12) == 1 && isempty(y12) == 1
        d12 =inf;
    else
    d12 = normrnd(sqrt((x12(1)-x)^2 +(y12(1)-y)^2),0); % - расстояние между 2-стенкой и 1-ым дальномером
    end
    if isempty(x21) == 1 && isempty(y21) == 1
        d21 =inf;
    else
    d21 = normrnd(sqrt((x21(1)-x)^2 +(y21(1)-y)^2),0); % - расстояние между 1-стенкой и 2-ым дальномером
    end
    if isempty(x22) == 1 && isempty(y22) == 1
        d22 =inf;
    else
   d22 = normrnd(sqrt((x22(1)-x)^2 +(y22(1)-y)^2),0); % - расстояние между 2-стенкой и 2-ым дальномером
    end
%     delete(l1)
%     delete(l2)           
    if d11 > 0.6 && d12 > 0.6 && (d21 < 0.6 || d22 < 0.6)
        move_ahead(robot,0.1,x,y,psi)
    end
    if d21 > 0.5 && d22 > 0.5
        %поворот направо
        for j = 1:37%+2*fix(randn)
            delete(h(i))
           % delete(h(i-1))
           % delete(h(i-2))
            psi(j+1) = psi(j) - 2.5;
            x(j+1) = x(j) + ((robot.V)/2)*cosd(psi(j))*0.1;
            y(j+1) = y(j) + ((robot.V)/2)*sind(psi(j))*0.1;
            model(:,:,j) = Rectangle_graph_model(robot,x(j),y(j),psi(j));
            [collision] = cross(coord_I,coord_II, model);
            if collision == 1
                return
            end
            h(j) = plot(model(:,1,j), model(:,2,j),'black');
            if j ~= 1
                delete(h(j-1))
            end
            pause(0.1)
        end
        if collision == true
            move_back(robot,dt,x,y,psi)
            move_back(robot,dt,x,y,psi)
            move_back(robot,dt,x,y,psi)
        end
        move_ahead(robot,0.1,x,y,psi)
        move_ahead(robot,0.1,x,y,psi)
        move_ahead(robot,0.1,x,y,psi)
        move_ahead(robot,0.1,x,y,psi)
        move_ahead(robot,0.1,x,y,psi)
        move_ahead(robot,0.1,x,y,psi)
        move_ahead(robot,0.1,x,y,psi)
        move_ahead(robot,0.1,x,y,psi)
        move_ahead(robot,0.1,x,y,psi)
        move_ahead(robot,0.1,x,y,psi)
        move_ahead(robot,0.1,x,y,psi)
        delete(h(j))
        x = x(j);
        y = y(j);
        psi = psi(j);
    else
       if d11 > 0.3 && d12 > 0.3
        move_ahead(robot,0.1,x,y,psi)
        move_ahead(robot,0.1,x,y,psi)
        move_ahead(robot,0.1,x,y,psi)
       else
       %поворот налево
        delete(h(i))
        delete(h(i-1))
        delete(h(i-2))
        for j = 1:37%+2*fix(randn)
            psi(j+1) = psi(j) +  2.5;
            x(j+1) = x(j) + ((robot.V)/2)*cosd(psi(j))*0.1;
            y(j+1) = y(j) + ((robot.V)/2)*sind(psi(j))*0.1;
            model(:,:,j) = Rectangle_graph_model(robot,x(j),y(j),psi(j));
            [collision] = cross(coord_I,coord_II, model);
            if collision == 1
                return
            end
            h(j) = plot(model(:,1,j), model(:,2,j),'black');
            if j ~= 1
                delete(h(j-1))
            end
            pause(0.1)
        end
        if collision == true
            break
        end
        delete(h(j))
        x = x(j);
        y = y(j);
        psi = psi(j);
       end
    end
    if i ~= 1
       delete(h(i-1))
    end
     pause(0.1)
    i = i+1; 
end