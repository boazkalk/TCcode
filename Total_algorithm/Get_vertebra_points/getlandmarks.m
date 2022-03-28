function landmarks = getlandmarks(x)
j=1;
for i = 2:2:16
temp = x.Children(2).Children(6).Children(i).Children(4).Children.Data;
temp = str2num(temp);
landmarks(j,:) = temp(1,1:3);
j=j+1;
end
end