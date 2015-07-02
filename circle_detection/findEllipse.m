function [ acc, angleA, angleB ] = findEllipse(pix, points, edgeim, acc, angleA, angleB)
%Function to find Ellipse using 3 point 
% INPUT 3 Points probably lying on ellipse, sorted edge indexes
% and indexes of 3 points
% OUTPUT Ellipse parameters
    
    nc = [ -1, 1, 1, -1 ];
    nr = [-1 -1, 1, 1 ];
    nc = nc * 3;
    nr = nr *3;

    %% Calculate points
    p1 = pix(points(1),:);
    p2 = pix(points(2),:);
    p3 = pix(points(3),:);
    
    %% Calculate midpoints
    
    % calculate the 3 sides
    a=p2-p3;
    b=p1-p3;
    c=p1-p2;
 
    % midpoint on side c
    mc=p2+c.*0.5;
 
    % midpoint on side a
    ma=p3+a.*0.5;
   
    %% find point neightbours
    
    [py, px] = find((roipoly(edgeim,p1(2) + nc, p1(1) + nr) & edgeim) > 0  );
    [P,S] = polyfit(px, py,1);
    
    [p2y, p2x] = find((roipoly(edgeim,p2(2) + nc, p2(1) + nr) & edgeim) > 0  );
    [P2,S2] = polyfit(p2x, p2y,1);
    
    [p3y, p3x] = find((roipoly(edgeim,p3(2) + nc, p3(1) + nr) & edgeim) > 0  );
    [P3,S3] = polyfit(p3x, p3y,1);
    
    %% Calculate intersection points
    interPoints = inv([P(1) -1 ; P2(1) -1])*[ -P(2) -P2(2)]';
    inter2Points = inv([P2(1) -1 ; P3(1) -1])*[ -P2(2) -P3(2)]';
    
    %% Find ellipse center
    
     slope = (mc(1) - interPoints(2))/(mc(2) - interPoints(1));
     bs = slope*interPoints(1) - interPoints(2);
     slope2 = (ma(1) - inter2Points(2))/(ma(2) - inter2Points(1));
     b2s = slope2*inter2Points(1) - inter2Points(2);

     centerPoint = inv([slope -1 ; slope2 -1])*[ bs b2s ]';
     
     centerPoint = round(centerPoint);
     [ sizeh sizew ]= size(acc);
         
     if (centerPoint(1)< sizeh && centerPoint(2)< sizew && centerPoint(2)> 0 && centerPoint(1)> 0)
        acc(centerPoint(1),centerPoint(2)) = acc(centerPoint(1),centerPoint(2)) + 1;
     end
     
     %% Calculate other ellipse parameters
     
     p1cent = fliplr(p1) - [ centerPoint(1) centerPoint(2)];
     p2cent = fliplr(p2) - [ centerPoint(1) centerPoint(2)];
     p3cent = fliplr(p3) - [ centerPoint(1) centerPoint(2)];
    
     ABC = inv([ p1cent(1) p1cent(1)*p1cent(2) p1cent(2) ; p2cent(1) p2cent(1)*p2cent(2) p2cent(2); p3cent(1) p3cent(1)*p3cent(2) p3cent(2)].^2)*[1 1 1]';
     ABC(2) = ABC(2)/2;
     ab(1)  = sqrt(abs(inv(ABC(1))));
     ab(2)  = sqrt(abs(inv(ABC(3))));
     if (centerPoint(1)< sizeh && centerPoint(2)< sizew && centerPoint(2)> 0 && centerPoint(1)> 0)
        angleA(centerPoint(1),centerPoint(2)) = angleA(centerPoint(1),centerPoint(2)) +  ab(1);
        angleB(centerPoint(1),centerPoint(2)) = angleB(centerPoint(1),centerPoint(2)) +  ab(2);
     end
    
    %% Plot functions
%     pause
%     xlim([1 sizew]);
%     ylim([1 sizeh]);
%     plot(mc(2),mc(1),'b*');
%     plot(ma(2),ma(1),'b*');
%     plot(interPoints(1),interPoints(2),'mo');
%     plot(inter2Points(1),inter2Points(2),'ko');
%     plot(centerPoint(1),centerPoint(2),'kv');
%     plot(p1(2),p1(1),'.r');
%     plot(p2(2),p2(1),'.b');
%     plot(p3(2),p3(1),'.g');
%     x = 1:sizew;
%     y = P(1)*x + P(2);
%     y2 = P2(1)*x + P2(2);
%     y3 = P3(1)*x + P3(2);
%     yslop = slope*x - bs;
%     y2slop = slope2*x - b2s;
%     plot(x,y);
%     plot(x,y2);
%     plot(x,y3);
%     plot(x,yslop);
%     plot(x,y2slop);


end

