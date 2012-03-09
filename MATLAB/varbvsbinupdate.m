% [ALPHA,MU,XR] = VARBVSBINUPDATE(X,SA,LOGODDS,STATS,ALPHA0,MU0,XR0,I) runs
% a single iteration of the coordinate ascent updates to maximize the
% variational lower bound for Bayesian variable selection in logistic
% regression. It adjusts the fully-factorized variational approximation to
% the posterior distribution of the coefficients in a logistic regression
% model of a binary outcome or trait, with spike and slab priors on the
% coefficients.
%
% All inputs to this function are required. Input X is an N x P matrix of
% observations about the variables (or features), where N is the number of
% samples, and P is the number of variables. Y is the vector of observations
% about the binary trait; it is a vector of length N. Unlike function
% VARBVSUPDATE, Y and X must *not* be centered. Instead, we will account for
% the intercept as we update the variational approximation.
%
% This routine is implemented with the assumption that X is a single
% floating-point precision matrix (type HELP SINGLE), as opposed to MATLAB's
% default of double precision. This is useful for large data sets, because
% single precision requires half of the number of bits as double
% floating-point precision. If X is provided in another numerical
% representation, an error is reported.
%
% Input scalar SA specifies the prior variance of the coefficients. LOGODDS
% is the prior log-odds of inclusion for each variable. It is equal to
% LOGODDS = LOG(Q./(1-Q)), where Q is the prior probability that each
% variable is included in the linear model of Y. LOGODDS is a vector of
% length P. Note that a residual variance parameter SIGMA is not needed to
% model a binary trait. Input STATS is the STRUCT output from UPDATESTATS.
%
% Inputs ALPHA0, MU0 are the current parameters of the variational
% approximation; under the variational approximation, the ith regression
% coefficient is normal with probability ALPHA0(i), and MU0(i) is the mean
% of the coefficient given that it is included in the model. Inputs XR0 must
% be XR0 = X*(ALPHA0.*MU0).
%
% Input I specifies the order in which the coordinates are updated. It may
% be a vector of any length. Each entry of I must be an integer between 1
% and P.
%
% There are three outputs. Output vectors ALPHA and MU are the updated
% variational parameters, and XR = X*(ALPHA.*MU). The computational
% complexity of VARBVSBINUPDATE is O(N*LENGTH(I)).
