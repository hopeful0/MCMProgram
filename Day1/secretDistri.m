function out = secretDistri(t, n, p, s)
%secretDistri Summary of this function goes here
    % write by hopeful
    % secretDistri(���ַܷ�) parameters and returns
    % t threshold(��С����)
    % n participants numbers(��������)
    % p big prime(������)
    % s secret(����)
    % out �����Կ
%   Detailed explanation goes here

% failed if p is not a prime
if (isprime(p) == 0)
    return;
end

% generated random ai for f(x) = a0+...+at*x^(t-1), where a0 = s is the
% secret
a = zeros(1, t);
a(1) = s;
for i = 2 : t
    while(a(i) == 0)
        a(i) = mod(floor(p * rand(1)), p);
    end
end
out = zeros(1, n);
for i = 1 : n
    for j = 1 : t
        out(i) = mod(out(i) + a(j) * i ^ (j - 1), p);
        %out(i) = out(i) + mod(a(j) * i ^ (j - 1), p);
    end
    out(i) = mod(out(i), p);
end

end
