function [result] = spectraTest()
% 频谱测试，测试成功返回1，否则返回0

% 生成仿真频谱

% 成分数量分布[2 3 4 5]
numP=[0 37 44 19];

% 决定成分数量
num = 1;
seed = floor(rand()*100);
for k = 1:length(numP)
    if (seed <= sum(numP(1:k)))
        num = k;
        break;
    end
end

% 决定成分
temp = randperm(12);
element = temp(1:num);

% 生成强度系数
beta = abs(0.6+randn(1,num));

% 读取数据
load 'DYEData';

% 预设频谱为blank频谱
spectra = (1-sum(beta)).*blankSpectra{1,1}(floor(rand().*size(blankSpectra{1,1},1)+1),:);

% 累加其他成分频谱
for k = 1:num
    dSpectra = dyeSpectra{1,1}{element(k),1};
    spectra = spectra + beta(k) .* dSpectra(floor(rand().*size(dSpectra,1)+1),:);
end

% 绘制生成的仿真频谱
% plot(spectra')

% 检验频谱

% 从13种成分（包括blank）频谱中提取出频谱均值，并去掉尾巴（取550到877列，因为基矩阵中只有328列）
mdyes = zeros(328,13);
temps = blankSpectra{1};
mdyes(:,1)=mean(temps(:,550:end))';
for k = 1:12
    temps = dyeSpectra{1}{k};
    mdyes(:,k+1)=mean(temps(:,550:end))';
end

% 设置默认相对误差为1（极大）
e = 1;

% 取生成的dna频谱，并去掉尾巴（同上）
dnas = spectra(550:end)';
% dyes指当前检验中确定的成分频谱，开始为空
dyes=[];
% ds指当前检验中确定的成分序列（blank为1，其他顺延），开始为空
ds=[];

% 循环加入频谱
while(true)
    % es指加入对应成分频谱后拟合的相对误差
    es=zeros(1,13);
    % tdyes指加入新的成分后的成分频谱
    tdyes=[];
    % 循环加入成分，并拟合计算相对误差
    for k = 1:13
        % 如果是已确定的成分，不计算直接将相对误差置1（极大），保证不会重复加入该成分
        if(any(ds==k))
            es(k) = 1;
            continue;
        end
        tdyes=[dyes,mdyes(:,k)];
        % epsilon为自定义函数
        es(k) = epsilon(dnas,tdyes,baselineS{1}');
    end
    % 取最小的误差
    me = min(es);
    % 如果加入新的成分后误差减小小于0.001，认为加入的新的成分不属于生成的频谱，即频谱中成分已完全确定，跳出循环
    if(abs(me-e) <= 0.001)
        break;
    end
    % 未跳出循环的话
    % 置最小误差为新的误差
    e=me;
    % 找到最小误差对于的成分
    di=find(es==me,1);
    % 将该成分加入确定的成分序列
    ds=[ds,di];
    % 将该成分的频谱加入确定的成分频谱
    dyes=[dyes, mdyes(:,di)];
end

% 输出生成频谱与检验频谱
% sort([1,element+1])
% sort(ds)

% 判断两者是否一致
result = isequal(sort([1,element+1]),sort(ds));

end
