income = input("Please enter your income: ");

% taxes for 2002
if income <= 6000
    taxes_2002 = income * 0.017;
elseif income <= 20000
    taxes_2002 = income*0.017 + ((income-6000)/100)*17;
elseif income <= 50000
    taxes_2002 = income*0.017 + ((income-20000)/100)*30 + 2380;
elseif income <= 60000
    taxes_2002 = income*0.017 + ((income-50000)/100)*42 + 11380;
else
    taxes_2002 = income*0.017 + ((income-60000)/100)*47 + 15580;
end

% taxes for 2009
if income <= 6000
    taxes_2009 = income * 0.017;
elseif income <= 34000
    taxes_2009 = income*0.017 + ((income-6000)/100)*15;
elseif income <= 80000
    taxes_2009 = income*0.017 + ((income-34000)/100)*30 + 4200;
elseif income <= 180000
    taxes_2009 = income*0.017 + ((income-80000)/100)*40 + 18000;
else
    taxes_2009 = income*0.017 + ((income-180000)/100)*45 + 58000;
end

% compute result
result = taxes_2002 - taxes_2009;
fprintf('The tax of 2009 is less than 2002 with value %.4f $', result);