
# stan should respect changes to control parameters
data(lodder)
res = phacking_rtma(lodder$yi, lodder$vi, alpha_select = 1e-10, parallelize = FALSE,
                    stan_control = list(adapt_delta = 15, max_treedepth = 10) )
res$

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
