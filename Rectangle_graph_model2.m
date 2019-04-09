function square = Rectangle_graph_model(robot_obj,x,y,psi)

     %base =[-0.15 -0.05; 0.05 -0.1; 0.15 -0.1; 0.15 0.1; 0.1 0.1; -0.15 0.05;-0.15 -0.05];
      base =[-0.1 -0.05; 0.1 -0.1; 0.2 -0.1; 0.2 0.1; 0.1 0.1; -0.1 0.05; -0.1 -0.05];
    angle = psi;
    shift = [ -0.1 0];
    DCM = [cosd(angle) sind(angle); -sind(angle) cosd(angle)];
    base = base*DCM;
        shift = shift*DCM;
%     sqare(1,:) = [base(1,1) + x, base(1,2) + y];
%     sqare(2,:) = [base(2,1) + x, base(2,2) + y];
%     sqare(3,:) = [base(3,1) + x, base(3,2) + y];
%     sqare(4,:) = [base(4,1) + x, base(4,2) + y];
%     sqare(5,:) = [base(5,1) + x, base(5,2) + y];
%     sqare(6,:) = [base(6,1) + x, base(6,2) + y];
%     sqare(7,:) = [base(7,1) + x, base(7,2) + y];
    for i=1:7
        square(i,:) = [base(i,1) + x + shift(1,1), base(i,2) + y+shift(1,2)];
    end
end