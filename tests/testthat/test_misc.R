
# stan should respect changes to control parameters
data(lodder)
res = phacking_rtma(lodder$yi, lodder$vi, alpha_select = 1e-10, parallelize = FALSE,
                    stan_control = list(adapt_delta = 0.7, max_treedepth = 10) )


expect_equal( 0.7, attr(res$fit, "stan_args")[[4]]$control$adapt_delta )
expect_equal( attr(res$fit, "stan_args")[[4]]$control$max_treedepth, 10 )


# returned counts of affirmatives and nonaffirmatives should be right
# even with a strange choice of alpha_select
alpha = 1e-10
z_alpha = qnorm(1 - alpha/2)
lodder$my_affirm = lodder$yi/sqrt(lodder$vi) > z_alpha

res = phacking_rtma(lodder$yi, lodder$vi, alpha_select = alpha, parallelize = FALSE )

expect_equal(nrow(lodder), res$values$k)
expect_equal(sum(lodder$my_affirm), res$values$k_affirmative)
expect_equal(sum(lodder$my_affirm == 0), res$values$k_nonaffirmative)
expect_equal(z_alpha, res$values$tcrit)



# BREAKS
# try passing only 1 nonaffirmative; should still run
res = phacking_rtma(yi = 0.2, sei = 0.2, parallelize = FALSE )
# throws error:
# Exception: mismatch in number dimensions declared and found in context; processing stage=data initialization; variable name=sei; dims declared=(1); dims found=()  (in 'model_phacking_rtma' at line 53)

# but 2 nonaffirmatives is fine
res = phacking_rtma(yi = rep(0.2, 2), sei = rep(0.2, 2), parallelize = FALSE )
