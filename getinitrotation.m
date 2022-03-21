function rotation = getinitrotation(lm4, lm7)
spincanpoint1 = lm7;
vertpoint2 = lm4;
vect = [(spincanpoint1(1,1)-vertpoint2(1,1)), (spincanpoint1(1,2)-vertpoint2(1,2))];
angle1=angle(vect(1)+1i*vect(2));
rotation = 360+angle1*180/pi;
end