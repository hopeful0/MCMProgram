function in = minv(n, m)
%UNTITLED6 Summary of this function goes here
    % write by hopeful
    % minv ���۵�������Ԫ�� parameters and returns
    % n 
    % m
    % in nģp����Ԫ
    % n * in = 1 (mod m)
%   Detailed explanation goes here

% in = 1;
% while mod(n*in, m) ~= 1
%     in = in + 1;
% end
if (isprime(m) == 0)
    return
end
if (n == 1)
    in = 1;
else
    in = (m - floor(m / n)) * mod(minv(mod(m, n), m), m);
end
end

