function [x,y] = tdms2data(tdmsfilename)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明    
n = length(tdmsfilename);
x = [];
y = [];
for i = tdmsfilename
    rawdata = convertTDMS(0,i);
    xi = rawdata.Data.MeasuredData(6).Data;
    yi = rawdata.Data.MeasuredData(7).Data;
    x = [x;xi];
    y = [y;yi];
end
end

