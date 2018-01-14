function gant15c15(se,starts,ends) 
figure(2); 
js=[5	4	7	15	11	3	10	2	1	8	9	6	13	12	14
    12	5	2	8	9	15	13	1	4	7	10	6	11	14	3
    10	6	3	8	5	13	1	14	7	11	4	12	9	2	15
    6	1	10	7	5	14	8	9	12	13	3	2	11	15	4
    11	5	9	3	1	12	15	10	7	8	2	14	4	6	13
    1	3	5	14	4	13	15	7	2	10	12	9	8	11	6
    9	5	13	1	8	12	7	11	4	14	2	6	15	3	10
    5	14	12	4	8	10	2	3	13	9	15	1	11	7	6
    6	2	7	9	14	11	3	4	8	12	15	5	1	10	13
    12	6	5	9	8	1	10	7	15	4	11	14	3	13	2
    8	4	1	5	13	15	11	2	10	14	6	9	3	12	7
    2	3	4	6	5	7	10	8	11	9	12	14	13	1	15
    4	8	14	6	12	13	3	5	11	2	10	7	15	9	1
    10	8	6	15	11	5	12	3	2	4	14	7	1	13	9
    10	11	12	15	9	1	8	7	13	2	3	14	5	4	6];
[m,n]=size(ends); 
JN=m*n; 
jobnamee=zeros(m,n); 
mjn=zeros(m,n); 
jp=zeros(1,n); 
mj=zeros(m,1); 
for i=1:JN 
    jp(se(i))=jp(se(i))+1; 
    mj(js(se(i),jp(se(i))))=mj(js(se(i),jp(se(i))))+1; 
    jobnamee(js(se(i),jp(se(i))),mj(js(se(i),jp(se(i)))))=se(i); 
end 
axis_size=[0 max(max(ends))+2 0 m+0.1]; 
axis(axis_size); 
yla=[1:m]; 
set(gca,'ytick',yla); 
ylabel('Processing Machine','FontSize',12,'color','b'); 
xlabel('Processing Time','FontSize',12,'color','b'); 
title('Scheduling Gantt Chart','FontSize',18,'color','r'); 
 
ZO=m+1; 
for i=1:m 
    for j=1:n 
        x=[starts(i,j) ends(i,j)]; 
        y=[ZO-i ZO-i]; 
        line(x,y); 
                 
        x=[ends(i,j) ends(i,j)]; 
        y=[ZO-i ZO-i-0.5]; 
        line(x,y); 
          
        x=[starts(i,j) ends(i,j)]; 
        y=[ZO-i-0.5 ZO-i-0.5]; 
        line(x,y); 
          
        st=strcat(int2str(starts(i,j))); 
        text(x(1),y(1)-0.1,st,'FontSize',8,'color','m'); 
        st=strcat(int2str(ends(i,j))); 
        text(x(2),y(2)-0.1,st,'FontSize',8,'color','m'); 
          
        x=[starts(i,j) starts(i,j)]; 
        y=[ZO-i ZO-i-0.5]; 
        line(x,y); 
          
        jobname=strcat(int2str(jobnamee(i,j))); 
        text((starts(i,j)+ends(i,j))/2-0.2,ZO-i-0.2,jobname); 
   end 
end