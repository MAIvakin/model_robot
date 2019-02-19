function [l1,l2] = draw_line(Object,x,y,psi)
    %base1 = [x y; x y+0.5];
    base1 = [x+0.5-x y-y];
    base2 = [0 -0.5];
    angle = psi;
    DCM = [cosd(angle) sind(angle); -sind(angle) cosd(angle)];
    base1 = base1*DCM;
    base2 = base2*DCM;
    l1(1,:) = [x, y];
    l1(2,:) = [base1(1)+x, base1(2)+y];
    l2(1,:) = [x,y];
    l2(2,:) = [base2(1)+x, base2(2)+y];
    
end