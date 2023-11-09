function plotVec(v, varargin)
% Plot 3d column vectors

origin = zeros(1,3);

if isvector(v)
    if nargin>1
        line_width = varargin{1};
    else
        line_width = 0.5;
    end
    quiver3(origin(1),origin(2),origin(3),v(1),v(2),v(3),"off","filled",Marker=".",MaxHeadSize=0.3*norm(v), LineWidth=line_width);
    return
end

if ismatrix(v)
n = size(v,2);
for i = 1:n
    plotVec(v(:,i), varargin{:});
    hold on
end
end
hold off
axis equal
end
