for v = 1:20
    list1=dir(['initial\v' num2str(v)]);            %获取vxx文件夹下的信息
    list2=dir([list1(3).folder '\' list1(3).name]); %获取vxx文件夹下的文件下的信息
    filename(v)=string([list2(3).folder '\' list2(3).name]);
    %[la,lb]=tdms2data("initial\v"+num2str(v)+"\v*");
end

for v = 1:20
    [v_initial(v).la,v_initial(v).lb]=tdms2data(filename(v));
end

for v = 1:20
    list1=dir(['steady\v' num2str(v)]);            %获取vxx文件夹下的信息
    list2=dir([list1(3).folder '\' list1(3).name]); %获取vxx文件夹下的文件下的信息
    filename_steady(v)=string([list2(3).folder '\' list2(3).name]);%获取每种流速下的tdms文件名称，组成字符串数组                                                           
    %[la,lb]=tdms2data("initial\v"+num2str(v)+"\v*");
end

for v = 1:20
    [v_steady(v).la,v_steady(v).lb]=tdms2data(filename_steady(v));
end

for v = 1:20
    v_initial(v).lab=v_initial(v).la-v_initial(v).lb;
    v_steady(v).lab=v_steady(v).la-v_steady(v).lb;
end

for v = 1:20
    v_initial(v).mean = mean(v_initial(v).lab(1:10000));
    v_steady(v).mean = mean(v_steady(v).lab(1:15000));    
end

pian = ones(1, 20);
for v = 1:20
    pian(v) = v_steady(v).mean-v_initial(v).mean;
end
pian = [0 pian];

for v = 1:20
    [m,n] = size(v_steady(v).lab);
    v_steady(v).pian = v_steady(v).lab - v_initial(v).mean*ones(m,n);
end

for v = 1:20
    v_steady(v).pianMean = mean(v_steady(v).pian(1:15000));    
end

pian2=[];
for v = 1:20
    pian2(v) = v_steady(v).pianMean;
end

pian2 = [0 pian2];

% v_steady(v).pian 表示减去初始均值后的偏移量
% v_steady(v).pianMean 表示减去初始均值后的偏移量的均值

v = 0:20;
plot(v,pian,v,pian2);
legend