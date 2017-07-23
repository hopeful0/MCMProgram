function s = secretRecon(n, t, p, f)
%secretRecon �˴���ʾ�йش˺�����ժҪ
    % write by hopeful
    % secretRecon(�����ع�) parameters and returns
    % n participants numbers(��������)
    % t threshold(��С����)
    % p big prime(������)
    % f ��Կ�Լ��� (example:[[1,45];[2,37];[3,50]])
    % s secret(����)
%   �˴���ʾ��ϸ˵��
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

