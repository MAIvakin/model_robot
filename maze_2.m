clear;
%набор координат для I линии
coord_I = [-0.25 0; -0.25 1; 0.85 1; 0.85 0.5; 0.95 0.5; 0.95 1];
%набор координат для II линии
coord_II = [0.25 0; 0.25 0.5; 0.35 0.5; 0.35 0; 1.45 0; 1.45 1];
f = figure('Visible','on','Name','LABIRINT','NumberTitle','off');
axis([-0.4 1.6 -0.2 1.2]);
hold on
line(coord_I(:,1), coord_I(:,2))
line(coord_II(:,1), coord_II(:,2))
x = 0;
y = 0;
psi = 90;
%model = rectangle('Position', [x-0.23/2 y-0.08 0.23 0.16]);
robot = L_robot;
%движение вперед
i = 1;
o = 1;
while o == 1%exit condition
while y <= 0.6
    move_ahead(robot,0.1,x,y,psi);
    model(:,:,i) = Rectangle_graph_model(robot,x,y,psi);
    %set(model, 'Position' , [x-0.23/2 y-0.08 0.23 0.16])
    %h = plot(model(:,1), model(:,2),'black');
    h(i) = plot(model(:,1,i), model(:,2,i),'black');
[l1(i), l2(i)] = uslovie(x,y,psi);
    if i ~= 1
        delete(h(i-1))
        delete(l1(i-1))
        delete(l2(i-1))
    end
    pause(0.1)
    i = i+1;
    
end
%поворот
i = 2;
turn_right(robot,0.1,x,y,psi)
while psi(i-1)>= 0
    model(:,:,i-1) = Rectangle_graph_model(robot,x(i-1),y(i-1),psi(i-1))
    h(i) = plot(model(:,1,i-1), model(:,2,i-1),'black');
    if i ~= 2
        delete(h(i-1))
    end
    i=i+1;
    if i > length(psi)
  break      
    end
    pause(0.1)
end
psi =psi(i-2);
x = x(i-2);
y = y(i-2);
while x <= 0.5
   move_ahead(robot,0.1,x,y,psi);
    model(:,:,i) = Rectangle_graph_model(robot,x,y,psi);
    %set(model, 'Position' , [x-0.23/2 y-0.08 0.23 0.16])
    %h = plot(model(:,1), model(:,2),'black');
    h(i) = plot(model(:,1,i), model(:,2,i),'black');
%      if abs(psi) == 90
%     l1(i) = line([x x+0.33],[y y]);
%     l2(i) = line([x x],[y y+0.33]);
%     elseif abs(psi) == 0
%     l1(i) = line([x x],[y y-0.33]);
%     l2(i) = line([x x+0.33],[y y]);    
%     elseif abs(psi) == 180
%     l1(i) = line([x x],[y y-0.33]);
%     l2(i) = line([x x-0.33],[y y]);  
%         else
%     l1(i) = line([x x-0.33],[y y]);
%     l2(i) = line([x x],[y y-0.33]);
%         end
[l1(i), l2(i)] = uslovie(x,y,psi);
    if i ~= 1
        delete(h(i-1))
        delete(l1(i-1))
        delete(l2(i-1))
    end
    pause(0.1)
    i = i+1;   
end
turn_right(robot,0.1,x,y,psi)
i = 2;
while psi(i-1)<= 90
    model(:,:,i-1) = Rectangle_graph_model(robot,x(i-1),y(i-1),psi(i-1));
    h(i) = plot(model(:,1,i-1), model(:,2,i-1),'black');
    if i ~= 2
        delete(h(i-1))
    end
    i=i+1;
    if i > length(psi)
  break      
    end
    pause(0.1)
end
psi =psi(i-1);
x = x(i-2);
y = y(i-2);
while y <= 0.3
move_ahead(robot,0.1,x,y,psi)
model(:,:,i) = Rectangle_graph_model(robot,x,y,psi);
    %set(model, 'Position' , [x-0.23/2 y-0.08 0.23 0.16])
    %h = plot(model(:,1), model(:,2),'black');
    h(i) = plot(model(:,1,i), model(:,2,i),'black');
    if abs(psi) == 90
    l1(i) = line([x x+0.33],[y y]);
    l2(i) = line([x x],[y y+0.33]);
    elseif abs(psi) == 0
    l1(i) = line([x x],[y y+0.33]);
    l2(i) = line([x x+0.33],[y y]);    
    elseif abs(psi) == 180
    l1(i) = line([x x],[y y-0.33]);
    l2(i) = line([x x-0.33],[y y]);  
        else
    l1(i) = line([x x-0.33],[y y]);
    l2(i) = line([x x],[y y-0.33]);
        end
    if i ~= 1
        delete(h(i-1))
        delete(l1(i-1))
        delete(l2(i-1))
    end
    pause(0.1)
    i = i+1;  
end
end