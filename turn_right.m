  function right = turn_right(obj,dt,x,y,psi)
    fi(1) = 0;
    %obj.psi = pi_to_pi(obj.psi);
    psi(1) = psi;
    i = 1;
    %dt = 0.1;
    w = 40*obj.V/obj.R;
    while fi(i) < 90;
       x(i+1) = x(i) + obj.V*cosd(psi(i))*dt;
       y(i+1) = y(i) + obj.V*sind(psi(i))*dt;
       fi(i+1)=fi(i)+w*dt;
       psi(i+1)=psi(i)+w*dt;
       i = i+1;
       assignin('base', 'x', x)
       assignin('base', 'y', y)
       assignin('base', 'psi', psi)
    end
    %psi = psi(i);
    end