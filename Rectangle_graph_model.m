function sqare = Rectangle_graph_model(Object,x,y,psi)
    base = [-0.23 -0.16; -0.23 0.16; 0.23 0.16; 0.23 -0.16; -0.23 -0.16]./2;
    angle = psi;
    DCM = [cosd(angle) sind(angle); -sind(angle) cosd(angle)];
    base = base*DCM;
    sqare(1,:) = [base(1,1)+x, base(1,2)+y];
    sqare(2,:) = [base(2,1)+x, base(2,2)+y];
    sqare(3,:) = [base(3,1)+x, base(3,2)+y];
    sqare(4,:) = [base(4,1)+x, base(4,2)+y];
    sqare(5,:) = [base(5,1)+x, base(5,2)+y];
end