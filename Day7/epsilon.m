function [e] = epsilon(dnas, dyes, baselines)
% 求lack of fit(lof)相对误差
% dnas：dns频谱，n行列向量
% dyes: dye频谱，m个n行列向量，即nxm矩阵
% baselines: 基，7个n行列向量，即nx7矩阵
% e：返回值，lof相对误差

% 通过最小二乘法求拟合函数（Y=a1X1+...+anXn+r0+r1T+r2T^2+...+r7T^6）系数
alpha=regress(dnas,[dyes,baselines]);

% 计算（Y-Yb）
delta = dnas;
for k = 1:size(dyes,2)
    delta = delta - alpha(k).*dyes(:,k);
end
for k = 1:size(baselines,2)
    delta = delta - alpha(k+size(dyes,2)).*baselines(:,k);
end

% 求误差 e=(|Y-Yb|2)/|Y|2 ,|X|2指列向量X的二范数，即平方和开根
% e=(sqrt(sum(delta.^2)))/(sqrt(sum(dnas.^2)));
e = norm(delta,2)/norm(dnas,2);
end
