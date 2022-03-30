clear all
close all

load('postop.mat');
load('preop.mat');

% for i = 1:1:width(parameters_preop)
%     for j = 1:1:height(parameters_preop)
%         pre = parameters_preop(j,i);
%         post = parameters_postop(j,i);
% 
%         percentagechange = (post-pre)/pre * 100;
% 
%         result(j,i) = percentagechange;
%     end
% end
% 
% mean_res = mean(result, 1);
% std_res = std(result, 1)

preop4 = transpose(parameters_preop(:,1));
j=1;

for i = 1:1:length(preop4)
    
    temp = preop4(i);

    a = temp-temp*0.1;
    b = temp+temp*0.1;
    r = (b-a).*rand(10,1) + a;

    preop4fake(j:j+9,:) = r;

    j=j+10;
end

postop4 = transpose(parameters_postop(:,1));
j=1;

for i = 1:1:length(postop4)
    
    temp = postop4(i);

    a = temp-temp*0.1;
    b = temp+temp*0.1;
    r = (b-a).*rand(10,1) + a;

    postop4fake(j:j+9,:) = r;

    j=j+10;
end

figure()
subplot(1,2,1)
plot(preop4,postop4,'o')
hold on
p = polyfit(preop4fake, postop4fake, 3);
x=min(preop4fake):(max(preop4fake)-min(preop4fake))/100:max(preop4fake);
y = polyval(p,x);
plot(x,y)
xlabel('preop');
ylabel('postop')
subplot(1,2,2)
temp = [0.25 0.5 1 1.25];
y2 = polyval(p,temp);
plot(temp,y2,'o');
axis([0 1.5 0.2 1.4])

