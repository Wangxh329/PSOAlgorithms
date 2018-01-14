function gant10c5(se,starts,ends) 
figure(2); 
js=[2 1 5 4 3
    1 4 5 3 2
    4 5 2 3 1
    2 1 5 3 4
    1 4 3 2 5
    2 3 5 1 4
    4 5 2 3 1
    3 1 2 4 5
    4 2 5 1 3
    5 4 3 2 1]; 
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
xlabel('Processing Time/seconds','FontSize',12,'color','b'); 
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