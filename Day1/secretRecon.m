function s = secretRecon(n, t, p, f)
%secretRecon 此处显示有关此函数的摘要
    % write by hopeful
    % secretRecon(秘密重构) parameters and returns
    % n participants numbers(参与人数)
    % t threshold(最小人限)
    % p big prime(大素数)
    % f 密钥对集合 (example:[[1,45];[2,37];[3,50]])
    % s secret(秘密)
%   此处显示详细说明
s = -1;
if (n >= t)
    s = 0;
    for i= 1 : n
        b = 1;
        for j = 1 : n
            if (i ~= j)
                b = mod(b * (-f(j,1)) * minv((f(i,1) - f(j,1)), p), p);
                %b = mod(b * (-f(j,1)) / ((f(i,1) - f(j,1))), p);
                %b = b * mod((-f(j,1)) * minv((f(i,1) - f(j,1)), p), p);
            end
        end
        s = mod(s + b * f(i,2),p);
    end
end
end

