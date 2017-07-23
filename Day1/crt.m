function x = crt(ms, as)
%crt Summary of this function goes here
    % write by hopeful
    % crt(�й�ʣ�ඨ��) parameters and returns
    % ms ������
    % as ������
    % x ������
%   Detailed explanation goes here
if (length(ms) ~= length(as))
    return;
end
n = length(ms);
for i = 1:n
   if (isprime(ms(i))  == 0 || as(i) >= ms(i))
       return;
   end
end
M = 1;
for i = 1:n
   M = M * ms(i);
end
Ms = zeros(1,n);
ts = zeros(1,n);
x = 0;
for i = 1:n
    Ms(i) = M / ms(i);
    ts(i) = minv(Ms(i), ms(i));
    %ts(i) = mod(Ms(i)^(ms(i) - 2), ms(i));
    x = x + as(i) * ts(i) * Ms(i);
end
x = mod(x, M);
end

