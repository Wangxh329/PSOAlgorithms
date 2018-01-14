function gant20c10(se,starts,ends) 
figure(2); 
js=[9 8 7 10 3 2 6 5 1 4
    5 6 4 10 1 9 7 8 3 2
    6 5 3 7 2 8 1 4 10 9
    2 6 1 4 3 8 9 7 10 5
    3 6 7 10 2 4 9 1 8 5
    2 5 1 3 10 9 6 4 8 7
    6 10 1 5 7 4 3 2 9 8
    6 10 9 8 5 7 4 1 2 3
    2 9 1 3 10 4 6 7 5 8
    5 4 7 6 3 9 2 10 8 1
    5 8 10 3 4 9 6 7 2 1
    9 6 2 8 3 4 7 10 5 1
    3 5 4 2 9 7 8 1 10 6
    1 9 4 8 6 3 5 7 2 10
    10 1 5 9 7 3 6 4 8 2
    4 3 6 1 8 5 9 2 7 10
    2 8 9 4 5 6 7 1 3 10
    2 8 3 1 9 7 4 10 6 5
    3 4 5 10 1 7 8 9 2 6
    2 1 6 4 10 8 9 3 7 5];
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