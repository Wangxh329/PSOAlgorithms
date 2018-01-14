%%%%%%%%%%%%%%%% 寻优速率 %%%%%%%%%%%%%%%%%%

%设置图片保存格式
set(gcf,'outerposition',get(0,'screensize'));
scrsz = get(0,'ScreenSize');
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'points');
set(gcf, 'PaperPosition', [0 30 scrsz(3) scrsz(4)-95]);
set(gcf, 'PaperPositionMode', 'auto');%保存全屏截图

%输入数据
x=1:1:8;
PSO1=[103.6	332.8	438.9	99.1	443.4	438.1	470.1	468.3];
PSO2=[108.6	334	396.4	222.4	431.1	463.2	456.1	408.6];
PSO3=[107.6	423.3	385.5	89.1	422.2	404.5	422.4	454];
PSO4=[81.8	388.3	441.3	256.6	437.3	440	446.7	447.4];
CPSO1=[16.5	323.1	273.9	14.8	329.9	397.1	308.2	368.8];
CPSO2=[16	194.6	338.2	27.4	292.5	343	291.7	346.6];
CPSO3=[54.3	215.7	319.9	30	296.8	393.4	316.3	289.8];
CPSO4=[43.7	180.9	337.3	70.6	328	411	340.5	351.9];
%画图
figure(1);
subplot(2,2,1);plot(x,PSO1,'-ob');hold on;plot(x,CPSO1,'-*r');
set(gca,'XTick',1:8);
set(gca,'XTickLabel',{'FT06','FT10','FT20','LA01','LA21','LA26','LA31','LA36'});
xlabel('调度算例');
ylabel('寻优速率/代');
title('PARA1:w=0.7298,c1=1.49618,c2=1.49618');
legend('PSO','CPSO',4);

subplot(2,2,2);plot(x,PSO2,'-ob');hold on;plot(x,CPSO2,'-*r');
set(gca,'XTick',1:8);
set(gca,'XTickLabel',{'FT06','FT10','FT20','LA01','LA21','LA26','LA31','LA36'});
xlabel('调度算例');
ylabel('寻优速率/代');
title('PARA2:w=0.6,c1=1.7,c2=1.7');
legend('PSO','CPSO',4);

subplot(2,2,3);plot(x,PSO3,'-ob');hold on;plot(x,CPSO3,'-*r');
set(gca,'XTick',1:8);
set(gca,'XTickLabel',{'FT06','FT10','FT20','LA01','LA21','LA26','LA31','LA36'});
xlabel('调度算例');
ylabel('寻优速率/代');
title('PARA3:w=0.4,c1=2,c2=2');
legend('PSO','CPSO',4);

subplot(2,2,4);plot(x,PSO4,'-ob');hold on;plot(x,CPSO4,'-*r');
set(gca,'XTick',1:8);
set(gca,'XTickLabel',{'FT06','FT10','FT20','LA01','LA21','LA26','LA31','LA36'});
xlabel('调度算例');
ylabel('寻优速率/代');
title('PARA4:w=0.7298,c1=2.0434,c2=0.9487');
legend('PSO','CPSO',4);
suptitle('"寻优速率"指标对比分析图');