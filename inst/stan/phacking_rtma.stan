functions{

	real jeffreys_prior(real mu, real tau, int k, real[] sei, real[] tcrit){

    // variables that will be recalculated for each observation
		real kmm;
		real kms;
		real kss;
    real Si;
    real cz;
    real dnor;
    real pnor;
    real r;
    matrix[2,2] fishinfo;

		// will become the total Fisher info across all observations
		matrix[2,2] fishinfototal;
		fishinfototal[1,1] = 0;
  	fishinfototal[1,2] = 0;
  	fishinfototal[2,1] = 0;
  	fishinfototal[2,2] = 0;


		// build a Fisher info matrix for EACH observation
		for (i in 1:k) {

		  Si = sqrt( tau^2 + sei[i]^2 );
      cz = (sei[i] * tcrit[i] - mu) / Si;
      dnor = exp( normal_lpdf(cz | 0, 1 ) );
      pnor = exp( normal_lcdf(cz | 0, 1 ) );
      r = dnor/pnor;

      kmm = Si^(-2)*(cz*r + r^2 - 1);
      kms = tau*Si^(-3)*r*( cz^2 + cz*r + 1 );
      kss = ( tau^2 * Si^(-4) ) * ( cz^3*r + cz^2*r^2 + cz*r - 2 );

  		fishinfo[1,1] = -kmm;
      fishinfo[1,2] = -kms;
      fishinfo[2,1] = -kms;
      fishinfo[2,2] = -kss;

  		// add this observation's Fisher info to the total
  		fishinfototal = fishinfototal + fishinfo;
		}

    // Jeffreys prior
		return sqrt(determinant(fishinfototal));
	}
}

data{
	int<lower=0> k;
  real sei[k];
  real tcrit[k];
	real y[k];
}

parameters{
  real mu;
	real<lower=0> tau;
}


model{
	target += log( jeffreys_prior(mu, tau, k, sei, tcrit) );

	// right-truncated normal density
	for(i in 1:k) {
      y[i] ~ normal( mu, sqrt(tau^2 + sei[i]^2) ) T[ , tcrit[i] * sei[i] ];
	}
}

// this chunk doesn't actually affect the model that's being fit to the data;
//  it's just re-calculating the prior, lkl, and post to return to user
// Stan docs: 'Nothing in the generated quantities block affects the sampled parameter values.
//  The block is executed only after a sample has been generated'
generated quantities{
  real log_lik = 0;
  real log_prior = log( jeffreys_prior(mu, tau, k, sei, tcrit) );
  real log_post;

  // calculate joint log-likelihood
  for ( i in 1:k ){
    // untruncated part of density
    log_lik += normal_lpdf( y[i] | mu, sqrt(tau^2 + sei[i]^2) );
    // Mills ratio part of density
    log_lik += -1 * normal_lcdf( tcrit[i] * sei[i] | mu, sqrt(tau^2 + sei[i]^2) );
  }

  log_post = log_prior + log_lik;
}
