classdef L_robot
    properties
        %длина и ширина робота в метрах
       Length =0.23;
       Width = 0.16; 
       R = 0.16; %расстояние между колесами
       %постоянная линейная скорость движения робота в м/с
       V = 0.1;
    end
methods
    function move_ahead(obj,dt,x,y,psi)
             %psi = pi_to_pi(psi);
             x = x + obj.V * cosd(psi)*dt;
             y = y + obj.V * sind(psi)*dt;
             assignin('base', 'x',x);
             assignin('base', 'y',y);
             assignin('base', 'psi', psi)
    end
    
    function move_back(obj,dt,x,y,psi)
        x = x - obj.V*cosd(psi)*dt;
        y = y - obj.V*sind(psi)*dt;
        assignin('base', 'x',x);
        assignin('base', 'y',y);
        assignin('base', 'psi', psi)
    end
    function left = turn_left(obj,dt,x,y,psi)
    fi(1) = 0;
    %obj.psi = pi_to_pi(obj.psi);
    i = 1;
    dt =0.1;
    w =40*obj.V/obj.R;
    while fi(i) <= 90
       x(i+1) = x(i) + obj.V*cosd(psi(i))*dt;
       y(i+1) = y(i) + obj.V*sind(psi(i))*dt;
       fi(i+1)=fi(i)+w*dt;
       psi(i+1)=psi(i)+w*dt;
       i = i + 1;
       assignin('base', 'x', x)
       assignin('base', 'y', y)
       assignin('base', 'psi', psi)
    end
     % obj.psi = psi(i);
    end
    function right = turn_right(obj,dt,x,y,psi)
    fi(1) = 0;
    %obj.psi = pi_to_pi(obj.psi);
    i = 1;
    %dt = 0.1;
    w = 40*obj.V/obj.R;
    while fi(i) >= -90
       x(i+1) = x(i) + obj.V*cosd(psi(i))*dt;
       y(i+1) = y(i) + obj.V*sind(psi(i))*dt;
       fi(i+1)=fi(i)-w*dt;
       psi(i+1)=psi(i)-w*dt;
       i = i+1;
       assignin('base', 'x', x)
       assignin('base', 'y', y)
       assignin('base', 'psi', psi)
    end
    %psi = psi(i);
    end
     function back = turn_back(V,dt)
     obj.psi = pi_to_pi(obj.psi);
          obj.x = obj.x - V*cos(obj.psi)*dt;
          obj.y = obj.y - V*sin(obj.psi)*dt;
     end
     function check_distance_ahead()
     end
     function check_distance_right()
     end
     end
end