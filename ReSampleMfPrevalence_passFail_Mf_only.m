% Resample based on pass/fail criteria to compensate for situations where
% likelihood-based method might fail

function likArrayId=ReSampleMfPrevalence_passFail_Mf_only(likelihoodArray, NumRequired)

[m,n] = size(likelihoodArray);
likArrayId = [];
Num0 = 0;
iNum = 0;

%% sorted array wanted, may be subjected to optimization
%% use [B,I] = sort(A) here, I is the index array
%% [B,I] = sort(A,descend)
%% id1 = I[1:500]  % take the 500 elements with greatest values
%% value500 = A(I(500)) % check the value of the 500th elements
                     % it's highly possible that some other elments
                     % of the same value are excluded
%% id1 = [id1,find(likelihoodArray(:,1) == value500)]
                    % add all the elemetns of same value as A(I(500))
%% id1 = unique(id1) % then remove the repeats



likVals = unique(likelihoodArray(:,1));
likVals = likVals(end:-1:1);
[m1,n1] = size(likVals);

while Num0 < NumRequired && iNum < m1  % NumRequired = SIR_samples = 500
    if iNum == 0
        id1 = find(likelihoodArray(:,1) >= likVals(iNum + 1));
    else
        id1 = find(likelihoodArray(:,1) >= likVals(iNum + 1) ...
            & likelihoodArray(:,1) < likVals(iNum));
    end
    if ~isempty(id1)
        likArrayId = [likArrayId; id1];
        Num0 = Num0 + length(id1);
    end
    iNum = iNum + 1;
end
end
