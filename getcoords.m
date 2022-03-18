clear all 
close all

angles = [0 22.5 45 67.5 90 112.5 135 157.5 180];
standard_points = [93, 155, 189, 198, 175, 200, 195, 157, 98;5, 41, 68, 87, 95, 153, 188, 197, 175;93, 110, 111, 93, 63, 96, 114, 115,98; ...
        117, 143, 148, 132, 94, 110, 109, 94, 63];

j=1;
Total_points = [];

for i = 1:5:181
angle = i-1;

name = strcat('Register_images\vertebra-', num2str(angle), '.png');
image = imread(name);

pts = readPoints(image, 2,angle);

Total_points(1:2,j) = pts(:,2);
Total_points(3:4,j) = pts(:,1);
j=j+1;

end

function pts = readPoints(image, n,angle)
%readPoints   Read manually-defined points from image
%   POINTS = READPOINTS(IMAGE) displays the image in the current figure,
%   then records the position of each click of button 1 of the mouse in the
%   figure, and stops when another button is clicked. The track of points
%   is drawn as it goes along. The result is a 2 x NPOINTS matrix; each
%   column is [X; Y] for one point.
% 
%   POINTS = READPOINTS(IMAGE, N) reads up to N points only.
if nargin < 2
    n = Inf;
    pts = zeros(2, 0);
else
    pts = zeros(2, n);
end
imshow(image);
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);% display image
xold = 0;
yold = 0;
k = 0;
hold on;           % and keep it there while we plot
while 1
    [xi, yi, but] = ginput(1);      % get a point
    if ~isequal(but, 1)             % stop if not button 1
        break
    end
    k = k + 1;
    pts(1,k) = xi;
    pts(2,k) = yi;
      if xold
          plot([xold xi], [yold yi], 'go-');  % draw as we go
      else
          plot(xi, yi, 'go');         % first point on its own
      end
      if isequal(k, n)
          break
      end
      xold = xi;
      yold = yi;
  end
hold off;
if k < size(pts,2)
    pts = pts(:, 1:k);
end
end