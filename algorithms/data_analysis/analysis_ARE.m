%%%%%%%%%%%%%%%% 平均相对误差百分比 %%%%%%%%%%%%%%%%%%

%设置图片保存格式
set(gcf,'outerposition',get(0,'screensize'));
scrsz = get(0,'ScreenSize');
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'points');
set(gcf, 'PaperPosition', [0 30 scrsz(3) scrsz(4)-95]);
set(gcf, 'PaperPositionMode', 'auto');%保存全屏截图

%输入数据
x=1:1:8;
PSO1=[0	12.73	12.69	0.69	16.65	16.09	11.59	19.05];
PSO2=[0.36	12.3	13.36	0.3	15.02	14.97	8.41	15.78];
PSO3=[0	14.75	16.08	0.54	21.19	24.06	16.51	22.16];
PSO4=[0.36	15.47	14.11	0.68	18	20.21	17.95	23.28];
CPSO1=[0.36	7.5269	5.72	0.33	7.06	4.49	0.54	6.96];
CPSO2=[1.09	7.1	4.47	0	7.3	6.62	0.27	7.72];
CPSO3=[2.18	6.88	4.15	1.89	6.39	6.84	1.09	9.38];
CPSO4=[0	6.37	4.18	0	6.75	5.87	0.27	9.74];
%画图
figure(1);
subplot(2,2,1);plot(x,PSO1,'-ob');hold on;plot(x,CPSO1,'-*r');
set(gca,'XTick',1:8);
set(gca,'XTickLabel',{'FT06','FT10','FT20','LA01','LA21','LA26','LA31','LA36'});
xlabel('调度算例');
ylabel('平均相对误差百分比/%');
title('PARA1:w=0.7298,c1=1.49618,c2=1.49618');
legend('PSO','CPSO',4);

subplot(2,2,2);plot(x,PSO2,'-ob');hold on;plot(x,CPSO2,'-*r');
set(gca,'XTick',1:8);
set(gca,'XTickLabel',{'FT06','FT10','FT20','LA01','LA21','LA26','LA31','LA36'});
xlabel('调度算例');
ylabel('平均相对误差百分比/%');
title('PARA2:w=0.6,c1=1.7,c2=1.7');
legend('PSO','CPSO',4);

subplot(2,2,3);plot(x,PSO3,'-ob');hold on;plot(x,CPSO3,'-*r');
set(gca,'XTick',1:8);
set(gca,'XTickLabel',{'FT06','FT10','FT20','LA01','LA21','LA26','LA31','LA36'});
xlabel('调度算例');
ylabel('平均相对误差百分比/%');
title('PARA3:w=0.4,c1=2,c2=2');
legend('PSO','CPSO',4);

subplot(2,2,4);plot(x,PSO4,'-ob');hold on;plot(x,CPSO4,'-*r');
set(gca,'XTick',1:8);
set(gca,'XTickLabel',{'FT06','FT10','FT20','LA01','LA21','LA26','LA31','LA36'});
xlabel('调度算例');
ylabel('平均相对误差百分比/%');
title('PARA4:w=0.7298,c1=2.0434,c2=0.9487');
legend('PSO','CPSO',4);
suptitle('"平均相对误差百分比"指标对比分析图');