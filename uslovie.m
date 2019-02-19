function [l2, l1] = uslovie(x,y,psi)
l= normrnd(0.5,0.002);%длина дальномера с погрешностью
if psi == 90 || psi == -270
    l2 = line([x x+l],[y y]);
    l1 = line([x x],[y y+l]);
end
    if psi == 0 || psi == 360 || psi == -360
    l2 = line([x x],[y y-l]);
    l1 = line([x x+l],[y y]);
    end
    if abs(psi) == 180
    l2 = line([x x],[y y+l]);
    l1 = line([x x-l],[y y]); 
    end
if psi == 270 || psi == -90
    l2 = line([x x-l],[y y]);
    l1 = line([x x],[y y-l]);
end
end