%%%%%%%%%%%%%%%% 达优率/% or 最大值 %%%%%%%%%%%%%%%%%%

%设置图片保存格式
set(gcf,'outerposition',get(0,'screensize'));
scrsz = get(0,'ScreenSize');
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'points');
set(gcf, 'PaperPosition', [0 30 scrsz(3) scrsz(4)-95]);
set(gcf, 'PaperPositionMode', 'auto');%保存全屏截图

%输入数据
x=1:1:8;
PSO1=[100	1109	1356	70	1254	1457	2069	1588];
PSO2=[90	1103	1435	80	1253	1489	2035	1511];
PSO3=[100	1108	1480	70	1355	1574	2263	1610];
PSO4=[90	1169	1370	50	1299	1526	2223	1626];
CPSO1=[90	1037	1272	90	1153	1314	1813	1407];
CPSO2=[80	1070	1250	100	1169	1337	1813	1398];
CPSO3=[50	1022	1248	50	1133	1337	1844	1448];
CPSO4=[100	1025	1249	100	1138	1330	1789	1460];
%画图
figure(1);
subplot(2,2,1);plot(x,PSO1,'-ob');hold on;plot(x,CPSO1,'-*r');
set(gca,'XTick',1:8);
set(gca,'XTickLabel',{'FT06','FT10','FT20','LA01','LA21','LA26','LA31','LA36'});
xlabel('调度算例');
ylabel('最大完工时间(Makespan)max/秒');
title('PARA1:w=0.7298,c1=1.49618,c2=1.49618');
legend('PSO','CPSO',4);

subplot(2,2,2);plot(x,PSO2,'-ob');hold on;plot(x,CPSO2,'-*r');
set(gca,'XTick',1:8);
set(gca,'XTickLabel',{'FT06','FT10','FT20','LA01','LA21','LA26','LA31','LA36'});
xlabel('调度算例');
ylabel('最大完工时间(Makespan)max/秒');
title('PARA2:w=0.6,c1=1.7,c2=1.7');
legend('PSO','CPSO',4);

subplot(2,2,3);plot(x,PSO3,'-ob');hold on;plot(x,CPSO3,'-*r');
set(gca,'XTick',1:8);
set(gca,'XTickLabel',{'FT06','FT10','FT20','LA01','LA21','LA26','LA31','LA36'});
xlabel('调度算例');
ylabel('最大完工时间(Makespan)max/秒');
title('PARA3:w=0.4,c1=2,c2=2');
legend('PSO','CPSO',4);

subplot(2,2,4);plot(x,PSO4,'-ob');hold on;plot(x,CPSO4,'-*r');
set(gca,'XTick',1:8);
set(gca,'XTickLabel',{'FT06','FT10','FT20','LA01','LA21','LA26','LA31','LA36'});
xlabel('调度算例');
ylabel('最大完工时间(Makespan)max/秒');
title('PARA4:w=0.7298,c1=2.0434,c2=0.9487');
legend('PSO','CPSO',4);
suptitle('"最大完工时间(Makespan)max"指标对比分析图');