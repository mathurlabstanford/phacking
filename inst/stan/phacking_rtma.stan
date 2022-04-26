functions{

	real jeffreys_prior(real mu, real tau, int k, real[] sei, real[] tcrit, real[] affirm){

	  // these will be overwritten for EACH observation
		real mustarL;
		real mustarU;
		real alphaL;
		real alphaU;
		real kmm;
		real kms;
		real kss;
		matrix[2,2] fishinfo;
    real sigma;
		real LL;
		real UU;
		// will just be set to 1
		int n;


		// this will be the TOTALS for all observations
		matrix[2,2] fishinfototal;
		fishinfototal[1,1] = 0;
  	fishinfototal[1,2] = 0;
  	fishinfototal[2,1] = 0;
  	fishinfototal[2,2] = 0;


		// MM: build a Fisher info matrix for EACH observation
		for (i in 1:k) {

		  // MARGINAL SD for this one observation
		  sigma = sqrt(tau^2 + sei[i]^2);

		  // depending on whether study is affirmative, set truncation limits
		  // for THIS study, given its SE
		  if ( affirm[i] == 0 ) {
		  		UU = tcrit[i] * sei[i];
		  		// standardized truncation limits
		  		mustarL = -999;
  		    mustarU = (UU - mu) / sigma;
		  } else if ( affirm[i] == 1 ) {
		      LL = tcrit[i] * sei[i];
		      // standardized truncation limits
		  		mustarL = (LL - mu) / sigma;
  		    mustarU = 999;
		  }

  		// because EACH fisher info below has n=1 only
  		n = 1;

  		// beginning of stuff that is not modified at all from TNE,
  		//  *except* for the change-of-variables terms in kms and kss applied in a
  		//   final code block
  		// note that normal_lpdf, etc., parameterize in terms of SD, not var
  		//  the (0,1) below are *not* start values for MCMC
  		alphaL = exp( normal_lpdf(mustarL | 0, 1) -
  	                log_diff_exp( normal_lcdf(mustarU | 0, 1),
  	                normal_lcdf(mustarL | 0, 1) ) );

  		alphaU = exp( normal_lpdf(mustarU | 0, 1) -
   	                log_diff_exp( normal_lcdf(mustarU | 0, 1),
   	                normal_lcdf(mustarL | 0, 1) ) );

  		// second derivatives for Fisher info
  		// wrt sigma, not tau
  		kmm = -n/sigma^2 + n/sigma^2 * ((alphaU-alphaL)^2 + alphaU*mustarU- alphaL*mustarL);
  		kms = -2*n/sigma^2 * (alphaL - alphaU) +
  	   		  n/sigma^2 * (alphaL - alphaU + (alphaU*mustarU^2 - alphaL*mustarL^2) +
  			  				(alphaL-alphaU) * (alphaL*mustarL - alphaU*mustarU));
  		kss = n/sigma^2 - 3*n/sigma^2 * (1 + mustarL*alphaL - mustarU*alphaU) +
  	   			n/sigma^2 * (mustarU*alphaU*(mustarU^2 - 2) - mustarL*alphaL*(mustarL^2 - 2) +
  								(alphaU*mustarU - alphaL*mustarL)^2);


  		// change of variables to get derivs wrt tau
  		kms = kms * tau / sqrt(tau^2 + sei[i]^2);
  		kss = kss * tau^2 / (tau^2 + sei[i]^2);

  		fishinfo[1,1] = -kmm;
      fishinfo[1,2] = -kms;
      fishinfo[2,1] = -kms;
      fishinfo[2,2] = -kss;

  		// MM: add the new fisher info to the total one
  		fishinfototal = fishinfototal + fishinfo;
		}
		return sqrt(determinant(fishinfototal));
	}
}

data{
	int<lower=0> k;
  real sei[k];
  real tcrit[k];
  real affirm[k];
	real y[k];
}

parameters{
  real mu;
	real<lower=0> tau;
}


model{
  // this is to remove prior, as a sanity check:
  // target += 0;
  //see 'foundational ideas' here: https://vasishth.github.io/bayescogsci/book/sec-firststan.html
	target += log( jeffreys_prior(mu, tau, k, sei, tcrit, affirm) );
	for(i in 1:k) {
      if ( affirm[i] == 0 ) {
        y[i] ~ normal( mu, sqrt(tau^2 + sei[i]^2) ) T[ , tcrit[i] * sei[i] ];
      } else if ( affirm[i] == 1 ) {
        y[i] ~ normal( mu, sqrt(tau^2 + sei[i]^2) ) T[ tcrit[i] * sei[i] , ];
      }
	}
}

// this chunk doesn't actually affect the model that's being fit to the data;
//  it's just re-calculating the prior, lkl, and post to return to user
// Stan docs: 'Nothing in the generated quantities block affects the sampled parameter values. The block is executed only after a sample has been generated'

generated quantities{
  real log_lik = 0;
  real log_prior = log( jeffreys_prior(mu, tau, k, sei, tcrit, affirm) );
  real log_post;
  // this is just an intermediate quantity for log_lik
  // will be equal to UU or LL above, depending on affirm status
  real critScaled;

  // versions that are evaluated at a SPECIFIC (mu=2, tau=2) so that we can compare
  //  to R functions for MAP, MLE, etc.
  real log_lik_sanity = 0;
  real log_prior_sanity = log( jeffreys_prior(2, 2, k, sei, tcrit, affirm) );

  for ( i in 1:k ){
    log_lik += normal_lpdf( y[i] | mu, sqrt(tau^2 + sei[i]^2) );
    log_lik_sanity += normal_lpdf( y[i] | 2, sqrt(2^2 + sei[i]^2) );

    critScaled = tcrit[i] * sei[i];

    // https://mc-stan.org/docs/2_20/reference-manual/sampling-statements-section.html
    // see 'Truncation with upper bounds in Stan' section
    // nonaffirm case:
    if ( y[i] <= critScaled ) {
    // from sanity checks in doParallel, I know this matches joint_nll_2
      log_lik += -1 * normal_lcdf(critScaled | mu, sqrt(tau^2 + sei[i]^2) );
      log_lik_sanity += -1 * normal_lcdf(critScaled | 2, sqrt(2^2 + sei[i]^2) );

    // affirm case:
    } else if ( y[i] > critScaled ) {
      log_lik += -1 * log( 1 - normal_cdf( critScaled, mu, sqrt(tau^2 + sei[i]^2) ) );
      log_lik_sanity += -1 * log( 1 - normal_cdf( critScaled, 2, sqrt(2^2 + sei[i]^2) ) );
    }
  }
  log_post = log_prior + log_lik;
}
