function likelihood = likelihood_using_ranks_by_passFail_Mf_Only(mfPrev,Bounds)

% Bounds = MfBounds, the 95% CI derived in get_the95LU_bounds_agedata
likelihood = 0;

for j = 1:length(Bounds(:,1)) % loop through data of all age groups

    % check if model-generated mf falls in 95% CI bounds of data
    % problems: here the mid-age is used, is it sufficient? just use
    % age 5 on behalf of group 0-10... etc.
    % or use weighted mfPrev instead, same as LikArray1
    % counts all the passes, could be optimized here for the sums up
    id = find(100*mfPrev(Bounds(j,1)*12,1) >= Bounds(j,2) & ...
        100*mfPrev(Bounds(j,1)*12,1) <= Bounds(j,3));

    % count how many age groups "pass"
    if ~isempty(id)
        likelihood = likelihood + 1;
    end
end

end
