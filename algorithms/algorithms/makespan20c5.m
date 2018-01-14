function [minmakespan,starts,ends]=makespan20c5(gen) 
%js is the job sequence matrix 
T=[29     9    49    62    44 
    43    75    69    46    72 
    91    39    90    12    45 
    81    71     9    85    22 
    14    22    26    21    72 
    84    52    48    47     6 
    46    61    32    32    30 
    31    46    32    19    36 
    76    76    85    40    26 
    85    61    64    47    90 
    78    36    11    56    21 
    90    11    28    46    30 
    85    74    10    89    33 
    95    99    52    98    43 
     6    61    69    49    53 
     2    95    72    65    25 
    37    13    21    89    55 
    86    74    88    48    79 
    69    51    11    89    74 
    13     7    76    52    45]; 
js=[ 1     2     3     4     5 
     1     2     4     3     5 
     2     1     3     5     4 
     2     1     5     3     4 
     3     2     1     4     5 
     3     2     5     1     4 
     2     1     3     4     5 
     3     2     1     4     5 
     1     4     3     2     5 
     2     3     1     4     5 
     2     4     1     5     3 
     3     1     2     4     5 
     1     3     2     4     5 
     3     1     2     4     5 
     1     2     5     3     4 
     2     1     4     5     3 
     1     3     2     4     5 
     1     2     5     3     4 
     2     3     1     4     5 
     1     2     3     4     5]; 
[n,m]=size(T); 
wpn=length(gen); 
starts=zeros(m,n); 
ends=zeros(m,n); 
jp=zeros(1,n);%job working procedure 
mj=zeros(m,1);% job on machine 
mjn=zeros(m,n); 
for i=1:wpn 
    jp(gen(i))=jp(gen(i))+1; 
    mj(js(gen(i),jp(gen(i))))=mj(js(gen(i),jp(gen(i))))+1; 
    mjn(js(gen(i),jp(gen(i))),gen(i))=mj(js(gen(i),jp(gen(i)))); 
    if jp(gen(i))==1 
       if mj(js(gen(i),1))==1 
          starts(js(gen(i),1),1)=0; 
          ends(js(gen(i),1),1)=T(gen(i),1); 
       else 
          starts(js(gen(i),1),mj(js(gen(i),1)))=ends(js(gen(i),1),mj(js(gen(i),1))-1); 
          ends(js(gen(i),1),mj(js(gen(i),1)))=starts(js(gen(i),1),mj(js(gen(i),1)))+T(gen(i),1); 
       end 
    else 
       if mj(js(gen(i),jp(gen(i))))==1 
          starts(js(gen(i),jp(gen(i))),1)=ends(js(gen(i),jp(gen(i))-1),mjn(js(gen(i),jp(gen(i))-1),gen(i))); 
          ends(js(gen(i),jp(gen(i))),1)=starts(js(gen(i),jp(gen(i))),1)+T(gen(i),jp(gen(i))); 
       else 
          starts(js(gen(i),jp(gen(i))),mj(js(gen(i),jp(gen(i)))))=max(ends(js(gen(i),jp(gen(i))),mj(js(gen(i),jp(gen(i))))-1),ends(js(gen(i),jp(gen(i))-1),mjn(js(gen(i),jp(gen(i))-1),gen(i)))); 
          ends(js(gen(i),jp(gen(i))),mj(js(gen(i),jp(gen(i)))))=starts(js(gen(i),jp(gen(i))),mj(js(gen(i),jp(gen(i)))))+T(gen(i),jp(gen(i))); 
       end 
    end 
end 
minmakespan=max(max(ends));