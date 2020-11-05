% ��ȡ����ѧ�����þ���
clc,clear;

format long e

%1 ԭʼ���ݽ��д�������������к��к�ʹ����Ӧ�кϼƵ����кϼ�

RawData = xlsread('C:\Users\HP\Desktop\Data\26Mathmatic\26Mathmatic.xlsx' , 'sheet2');
% RawData = xlsread('C:\Users\HP\Desktop\Data\Time\CiteMatrix2000.csv');
[Number_Row,Number_Column] = size(RawData);

A = eye(Number_Row,Number_Column);

%�к��к͵ļ�ֵFillData

FillData = zeros(Number_Column,1);

%�������飨�кͣ�

Cited_Number = zeros(Number_Column,1);

%�������飨�кͣ�

Cite_Number = zeros(Number_Row,1);

Column_Sum_RawData = zeros(1,Number_Column);

Row_Sum_RawData = zeros(1,Number_Row);



for j = 1:Number_Column        

    for i = 1:Number_Row

        Column_Sum_RawData(j) = Column_Sum_RawData(j)+ RawData(i,j);

    end

end

for i = 1 : Number_Row        

    for j = 1 : Number_Column

        Row_Sum_RawData(i) = Row_Sum_RawData(i)+ RawData(i,j);

    end

end



for i = 1 : Number_Row

    if ( Column_Sum_RawData(i) >= Row_Sum_RawData(i) )

        FillData(i) = Column_Sum_RawData(i) ;

        Cited_Number(i) = Column_Sum_RawData(i) - Row_Sum_RawData(i);

    else 

        FillData(i) = Row_Sum_RawData(i);

        Cite_Number(i) = Row_Sum_RawData(i) - Column_Sum_RawData(i);

    end

end

%%����һ����ֵ50%�Ļ���

for i = 1 : Number_Row

    temp = (Cited_Number(i)+ Cite_Number(i)) / 2;

    Cited_Number(i) = Cited_Number(i) + temp;

    Cite_Number(i) = Cite_Number(i) + temp;

    FillData(i) = FillData(i) + temp;

end



%��ֱ������ϵ������A

for j = 1:Number_Column        

    for i = 1:Number_Row

        A(i,j) = RawData(i,j)/FillData(j);

    end

end





E = eye(Number_Row,Number_Column);

Leontief_Matrix = inv(E - A);

%���ֱ������ϵ������A���ﰺ��������

xlswrite('C:\Users\HP\Desktop\Data\26Mathmatic\A.xls',A,1,'A1');

xlswrite('C:\Users\HP\Desktop\Data\26Mathmatic\Leontief_Matrix.xls',Leontief_Matrix,1,'A1');

Sum_Leontief_Matrix = 0;

Leontief_Matrix_Column_Sum = zeros(Number_Column,1);

Leontief_Matrix_Row_Sum = zeros(Number_Row,1);

for i = 1 : Number_Row

    for j = 1 : Number_Column

        Sum_Leontief_Matrix = Sum_Leontief_Matrix + Leontief_Matrix(i,j);

        Leontief_Matrix_Row_Sum(i) = Leontief_Matrix_Row_Sum(i) + Leontief_Matrix(i,j);



    end

end

for j = 1 : Number_Column

    for i = 1 : Number_Row

        Leontief_Matrix_Column_Sum(j) = Leontief_Matrix_Column_Sum(j) + Leontief_Matrix(i,j);

    end

end



    % ��Ӧ��ϵ�� Ϊĳһ��Ԫ�غ�/�к�ƽ��ֵ

    % ��Ӧ��ѧ�Ƶ��������ö�����һ����λ��i�����ܲ�����������

    disp("����ֱ�����ľ���A����ĸ�Ӧ��ϵ��Ϊ");

    Sensitivity_coefficient = Leontief_Matrix_Row_Sum / (Sum_Leontief_Matrix/Number_Row)



    % Ӱ������ϵ�� Ϊĳһ��Ԫ�غ�/����Ԫ���ܺͣ�

    % ��Ӧ��J��������һ����λ���ö�ȫ��ѧ�Ƶ����󲨼��̶�

      disp("����ֱ�����ľ���A�����Ӱ����ϵ��Ϊ");

    Influence_coefficient = Leontief_Matrix_Column_Sum /(Sum_Leontief_Matrix/Number_Column)