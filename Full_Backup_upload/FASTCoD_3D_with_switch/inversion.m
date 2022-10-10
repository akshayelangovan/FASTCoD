function child = inversion(child,Pi)
Gene_no = length(child.Gene);
ub = Gene_no - 1;
lb = 1;
Cross_P1 = round (  (ub - lb) *rand() + lb  );

Cross_P2 = Cross_P1;

while Cross_P2 == Cross_P1
    Cross_P2 = round (  (ub - lb) *rand() + lb  );
end

if Cross_P1 > Cross_P2
    temp =  Cross_P1;
    Cross_P1 =  Cross_P2;
    Cross_P2 = temp;
end

Part1 = child.Gene(1:Cross_P1);
Part2 = child.Gene(Cross_P1 + 1 :Cross_P2);
Part3 = child.Gene(Cross_P2+1:end);

R1 = rand();
if R1<Pi
    Part2 = flip(Part2);
end

child.Gene = [Part1 , Part2 , Part3];
