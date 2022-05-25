
# passing only affirmatives should result in error
# achieve this by setting an extremely small alpha_select
data(lodder)
expect_equal( any(lodder$yi/sqrt(lodder$vi) < -9 ), FALSE )
res = phacking_rtma(lodder$yi, lodder$vi, alpha_select = 1e-10, parallelize = FALSE )

res$values$k
res$values$k_affirmative
