clear;
close all
%набор координат для I линии
coord_I = [-0.25 0; -0.25 1; 0.85 1; 0.85 0.5; 0.95 0.5; 0.95 2; -0.25 2; -0.25 3.5; 1.95 3.5; 1.95 -0.5; 0.25 -0.5]./0.8;
%набор координат для II линии
coord_II = [0.25 0; 0.25 0.5; 0.35 0.5; 0.35 0; 1.45 0; 1.45 2.5; 0.25 2.5; 0.25 3; 1.45 3]./0.8;
% --- Стена одной линией: coord_joined = reverse(coord_II) + coord_I ---
coord_joined = cat(1, flipud(coord_II), coord_I);
f = figure('Visible','on','Name','LABIRINT','NumberTitle','off');
% axis([-0.4 1.6 -0.2 1.2]);
axis equal
hold on
wall_joined = line(coord_joined(:,1), coord_joined(:,2), 'LineWidth', 2);
x = 0.2;
y = 0;
psi = 90;
dt = 0.1;
robot = L_robot;
o = 1;
i = 1;
collision = false;
while o == 1
    clf();
    axis equal
    hold on
    wall_1 = line(coord_I(:,1), coord_I(:,2));
    wall_2 = line(coord_II(:,1), coord_II(:,2)); 
    model(:,:,i) = Rectangle_graph_model2(robot,x,y,psi);
    h(i) = plot(model(:,1,i), model(:,2,i),'black');
    collision = cross(coord_I,coord_II, model(:,:,i));
    [l1,l2] = draw_line(robot,x,y,psi);
%     plot(l1(:,1), l1(:,2),'c')
%     plot(l2(:,1), l2(:,2),'c')
    if collision == 1
        for e = 1:20
            pause(0.1)
            clf();
            axis equal
            hold on
            wall_1 = line(coord_I(:,1), coord_I(:,2));
            wall_2 = line(coord_II(:,1), coord_II(:,2)); 
            move_back(robot,dt,x,y,psi)
            model(:,:,e) = Rectangle_graph_model2(robot,x,y,psi);
            h(e) = plot(model(:,1,e), model(:,2,e),'black');
        end
        psi = psi + 10;
    end
    %Ищем пересечения
    [x11,y11] = intersections(coord_I(:,1),coord_I(:,2),l1(:,1),l1(:,2),1);
    [x12,y12] = intersections(coord_II(:,1),coord_II(:,2),l1(:,1),l1(:,2),1);
    [x21,y21] = intersections(coord_I(:,1),coord_I(:,2),l2(:,1),l2(:,2),1);
    [x22,y22] = intersections(coord_II(:,1),coord_II(:,2),l2(:,1),l2(:,2),1);
    %расстояние между дальномерами и препятсвиями
    if isempty(x11) == 1 && isempty(y11) == 1
           d11 = inf;
           line(l1(:,1), l1(:,2), 'Color', 'c');
    else
           dist1 = sqrt( (x11(1) - x)^2 + (y11(1) - y)^2 );
           d11 = normrnd(dist1, 0.0);
           line([l1(1,1) x11(1)], [l1(1,2) y11(1)], 'Color', 'r');
    end
    if isempty(x21) == 1 && isempty(y21) == 1
           d21 =inf;
           line(l2(:,1), l2(:,2), 'Color', 'c');
    else
           dist2 = sqrt( (x21(1) - x)^2 + (y21(1) - y)^2 );
           d21 = normrnd(dist2, 0);
           line([l2(1,1) x21(1)], [l2(1,2) y21(1)], 'Color', 'r');
    end       
%     if d11 > 0.6 && d12 > 0.6 && (d21 < 0.6 || d22 < 0.6)
%         move_ahead(robot,0.1,x,y,psi)
%     end
    if d21 > 0.4 && d22 > 0.4
        %поворот направо
        for j = 1:37+fix(normrnd(0,2))
            clf();
            axis equal
            hold on
            wall_1 = line(coord_I(:,1), coord_I(:,2));
            wall_2 = line(coord_II(:,1), coord_II(:,2));
            psi(j+1) = psi(j) - 2.5;
            x(j+1) = x(j) + ((robot.V)/2)*cosd(psi(j))*0.1;
            y(j+1) = y(j) + ((robot.V)/2)*sind(psi(j))*0.1;
            model(:,:,j) = Rectangle_graph_model2(robot,x(j),y(j),psi(j));
            h(j) = plot(model(:,1,j), model(:,2,j),'black');
            [collision] = cross(coord_I,coord_II, model(:,:,j));
            if collision == 1
                collision = 1;
                for e = 1:20
                    pause(0.1)
                    clf();
                    axis equal
                    hold on
                    wall_1 = line(coord_I(:,1), coord_I(:,2));
                    wall_2 = line(coord_II(:,1), coord_II(:,2)); 
                    move_back(robot,dt,x,y,psi)
                    model(:,:,e) = Rectangle_graph_model2(robot,x(j),y(j),psi(j));
                    h(e) = plot(model(:,1,e), model(:,2,e),'black');
                end
                break
            end
%             if j ~= 1
%                 delete(h(j-1))
%             end
            pause(0.1)
        end
%         delete(h(j))
        x = x(j);
        y = y(j);
        psi = psi(j);
        for e = 1:10
            pause(0.1)
            clf();
            axis equal
            hold on
            wall_1 = line(coord_I(:,1), coord_I(:,2));
            wall_2 = line(coord_II(:,1), coord_II(:,2));
            move_ahead(robot,0.1,x,y,psi)
            move_ahead(robot,0.1,x,y,psi)
            model(:,:,e) = Rectangle_graph_model2(robot,x,y,psi);
            h(e) = plot(model(:,1,e), model(:,2,e),'black');
%               plot(l1(:,1), l1(:,2),'c')
%    plot(l2(:,1), l2(:,2),'c')
        end
        
    else
       if d11 > 0.3 && d12 > 0.3
        move_ahead(robot,0.1,x,y,psi)
        move_ahead(robot,0.1,x,y,psi)
        move_ahead(robot,0.1,x,y,psi)
       else
       %поворот налево
        for j = 1:37+fix(normrnd(0,2))
            clf();
            axis equal
            hold on
            wall_1 = line(coord_I(:,1), coord_I(:,2));
            wall_2 = line(coord_II(:,1), coord_II(:,2));
            psi(j+1) = psi(j) +  2.5;
            x(j+1) = x(j) + ((robot.V)/2)*cosd(psi(j))*0.1;
            y(j+1) = y(j) + ((robot.V)/2)*sind(psi(j))*0.1;
            model(:,:,j) = Rectangle_graph_model2(robot,x(j),y(j),psi(j));
            h(j) = plot(model(:,1,j), model(:,2,j),'black');
            [collision] = cross(coord_I,coord_II, model(:,:,j));
            if collision == true
                collision = 1;
                for e = 1:20
                    pause(0.1)
                    clf();
                    axis equal
                    hold on
                    wall_1 = line(coord_I(:,1), coord_I(:,2));
                    wall_2 = line(coord_II(:,1), coord_II(:,2)); 
                    move_back(robot,dt,x,y,psi)
                    model(:,:,e) = Rectangle_graph_model2(robot,x(j),y(j),psi(j));
                    h(e) = plot(model(:,1,e), model(:,2,e),'black');
                end
                break
            end
%             if j ~= 1
%                 delete(h(j-1))
%             end
            pause(0.1)
        end
%         delete(h(j))
        x = x(j);
        y = y(j);
        psi = psi(j);
        for e = 1:6
            pause(0.1)
            clf();
            axis equal
            hold on
            wall_1 = line(coord_I(:,1), coord_I(:,2));
            wall_2 = line(coord_II(:,1), coord_II(:,2));
            move_ahead(robot,0.1,x,y,psi)
            model(:,:,e) = Rectangle_graph_model2(robot,x,y,psi);
            h(e) = plot(model(:,1,e), model(:,2,e),'black');
        end
       end
    end
%     if i ~= 1
%        delete(h(i-1))
%     end
     pause(0.1)
    i = i+1; 
end