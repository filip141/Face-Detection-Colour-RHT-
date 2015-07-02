function [ boolValue ] = checkPoints( p1, p2, p3, maxEllipse, minEllipse )
%Function checks distance between selected points 
% INPUT    points, max and minimum treshold
% OUTPUT   Boolean value true or false

vec1 = p3 - p1;
vec2 = p2 - p1;
vec3 = p3 - p2;
norms = [norm(vec1, 2) norm(vec2, 2) norm(vec3, 2)];
if(min(norms) < minEllipse)
    boolValue = 0;
    return
else
    if(max(norms) > maxEllipse)
        boolValue = 0;
        return
    else
        boolValue = 1;
        return
    end
end

end

