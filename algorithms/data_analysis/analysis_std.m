%%%%%%%%%%%%%%%% 结果的标准偏差(稳定性) %%%%%%%%%%%%%%%%%%

%设置图片保存格式
set(gcf,'outerposition',get(0,'screensize'));
scrsz = get(0,'ScreenSize');
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'points');
set(gcf, 'PaperPosition', [0 30 scrsz(3) scrsz(4)-95]);
set(gcf, 'PaperPositionMode', 'auto');%保存全屏截图

%输入数据
x=1:1:8;
PSO1=[0	36.5	36.68	7.89	24.48	20.56	54.66	50.15];
PSO2=[0.6325	47.2563	59.9967	5.98	39.12	38.67	62.98	29.76];
PSO3=[0	25.4	64.63	7.47	52	53.22	87.37	56.17];
PSO4=[0.6325	37.53	31.39	5.48	51.57	42.36	67.12	33.57];
CPSO1=[0.6325	19.25	29.65	6.96	17.56	20.65	13.67	27];
CPSO2=[1.2649	30.1	19.16	0	24.92	20.65	10	33.14];
CPSO3=[1.3166	21.9	18.4	13.99	11.83	24.75	18.95	34.38];
CPSO4=[0	22.95	27.86	0	14.92	16.71	10.39	30.91];
%画图
figure(1);
subplot(2,2,1);plot(x,PSO1,'-ob');hold on;plot(x,CPSO1,'-*r');
set(gca,'XTick',1:8);
set(gca,'XTickLabel',{'FT06','FT10','FT20','LA01','LA21','LA26','LA31','LA36'});
xlabel('调度算例');
ylabel('结果的标准偏差(稳定性)');
title('PARA1:w=0.7298,c1=1.49618,c2=1.49618');
legend('PSO','CPSO',4);

subplot(2,2,2);plot(x,PSO2,'-ob');hold on;plot(x,CPSO2,'-*r');
set(gca,'XTick',1:8);
set(gca,'XTickLabel',{'FT06','FT10','FT20','LA01','LA21','LA26','LA31','LA36'});
xlabel('调度算例');
ylabel('结果的标准偏差(稳定性)');
title('PARA2:w=0.6,c1=1.7,c2=1.7');
legend('PSO','CPSO',4);

subplot(2,2,3);plot(x,PSO3,'-ob');hold on;plot(x,CPSO3,'-*r');
set(gca,'XTick',1:8);
set(gca,'XTickLabel',{'FT06','FT10','FT20','LA01','LA21','LA26','LA31','LA36'});
xlabel('调度算例');
ylabel('结果的标准偏差(稳定性)');
title('PARA3:w=0.4,c1=2,c2=2');
legend('PSO','CPSO',4);

subplot(2,2,4);plot(x,PSO4,'-ob');hold on;plot(x,CPSO4,'-*r');
set(gca,'XTick',1:8);
set(gca,'XTickLabel',{'FT06','FT10','FT20','LA01','LA21','LA26','LA31','LA36'});
xlabel('调度算例');
ylabel('结果的标准偏差(稳定性)');
title('PARA4:w=0.7298,c1=2.0434,c2=0.9487');
legend('PSO','CPSO',4);
suptitle('"结果的标准偏差(稳定性)"指标对比分析图');