% 朴素贝叶斯分类器
%% 清除缓存
clc
close all
clear all

%% 读取数据
data=load('data.txt');%训练数据

[m,n]=size(data);%特征维数为m-1，数据总数目为n

%% 计算各种各特征的取值（默认都是从1开始）
A=zeros(m);
for i=1:m
    A(i)=max(data(i,:));
end
classfy=cell(m,1);
y(1,A(m))=0;
for i=1:n
    for j=1:A(m)
        if data(m,i)==j
            y(j)=y(j)+1;
        end
    end
end


%% 计算条件概率分布
for i=1:m-1
    b(1:A(i),1:A(m))=0; 
    for j=1:n
        for p=1:A(i)
            if data(i,j)==p
                break;
            end
        end
        
        for q=1:m
            if data(m,j)==q
                break;
            end
        end
        b(p,q)=b(p,q)+1;   
    end
    for j=1:A(m)
        b(:,j)=b(:,j)/y(j);
    end
    classfy(i,1)={b};
end
y=y/n;
classfy(m,1)={y};



%% 计算测试数据的分类
test=load('test.txt');%测试数据

out(1:A(m))=0;
for i=1:A(m)
    temp=classfy{m,1}(i);
    for j=1:m-1
        temp=temp*classfy{j,1}(test(j),i);
    end
    out(i)=temp;
end
[a,b]=max(out);%判断出test属于b类型

