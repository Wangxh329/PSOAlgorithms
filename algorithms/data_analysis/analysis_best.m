%%%%%%%%%%%%%%%% 最优值 %%%%%%%%%%%%%%%%%%

%设置图片保存格式
set(gcf,'outerposition',get(0,'screensize'));
scrsz = get(0,'ScreenSize');
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'points');
set(gcf, 'PaperPosition', [0 30 scrsz(3) scrsz(4)-95]);
set(gcf, 'PaperPositionMode', 'auto');%保存全屏截图

%输入数据
x=1:1:8;
PSO1=[55	1003	1247	666	1186	1391	1912	1428];
PSO2=[55	976	    1243	666	1139	1346	1841	1426];
PSO3=[55	1027	1275	666	1185	1408	1944	1466];
PSO4=[55	1034	1280	666	1145	1375	2020	1524];
CPSO1=[55	962	1183	666	1091	1244	1784	1319];
CPSO2=[55	961	1187	666	1097	1270	1784	1308];
CPSO3=[55	952	1190	666	1099	1263	1784	1338];
CPSO4=[55	954	1178	666	1097	1273	1784	1359];
%画图
figure(1);
subplot(2,2,1);plot(x,PSO1,'-ob');hold on;plot(x,CPSO1,'-*r');
set(gca,'XTick',1:8);
set(gca,'XTickLabel',{'FT06','FT10','FT20','LA01','LA21','LA26','LA31','LA36'});
xlabel('调度算例');
ylabel('最大完工时间(Makespan)min/秒');
title('PARA1:w=0.7298,c1=1.49618,c2=1.49618');
legend('PSO','CPSO',4);

subplot(2,2,2);plot(x,PSO2,'-ob');hold on;plot(x,CPSO2,'-*r');
set(gca,'XTick',1:8);
set(gca,'XTickLabel',{'FT06','FT10','FT20','LA01','LA21','LA26','LA31','LA36'});
xlabel('调度算例');
ylabel('最大完工时间(Makespan)min/秒');
title('PARA2:w=0.6,c1=1.7,c2=1.7');
legend('PSO','CPSO',4);

subplot(2,2,3);plot(x,PSO3,'-ob');hold on;plot(x,CPSO3,'-*r');
set(gca,'XTick',1:8);
set(gca,'XTickLabel',{'FT06','FT10','FT20','LA01','LA21','LA26','LA31','LA36'});
xlabel('调度算例');
ylabel('最大完工时间(Makespan)min/秒');
title('PARA3:w=0.4,c1=2,c2=2');
legend('PSO','CPSO',4);

subplot(2,2,4);plot(x,PSO4,'-ob');hold on;plot(x,CPSO4,'-*r');
set(gca,'XTick',1:8);
set(gca,'XTickLabel',{'FT06','FT10','FT20','LA01','LA21','LA26','LA31','LA36'});
xlabel('调度算例');
ylabel('最大完工时间(Makespan)min/秒');
title('PARA4:w=0.7298,c1=2.0434,c2=0.9487');
legend('PSO','CPSO',4);
suptitle('"最大完工时间(Makespan)min"指标对比分析图');