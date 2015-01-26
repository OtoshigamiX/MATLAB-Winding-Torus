function out=stringColsPurger(data)
[m,n]=size(data);
count=0;
clear index;
for i = 1:n
    if ischar(data{1,i})
        count=count+1;
        index(count)=data.Properties.VarNames(i);
    end
end
[m,n]=size(index);
for i=1:n
    data.(index{i})=[];
end
out=data;