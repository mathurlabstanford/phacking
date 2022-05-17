// Generated by rstantools.  Do not edit by hand.

/*
    phacking is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    phacking is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with phacking.  If not, see <http://www.gnu.org/licenses/>.
*/
#ifndef MODELS_HPP
#define MODELS_HPP
#define STAN__SERVICES__COMMAND_HPP
#include <rstan/rstaninc.hpp>
// Code generated by Stan version 2.21.0
#include <stan/model/model_header.hpp>
namespace model_phacking_rtma_namespace {
using std::istream;
using std::string;
using std::stringstream;
using std::vector;
using stan::io::dump;
using stan::math::lgamma;
using stan::model::prob_grad;
using namespace stan::math;
static int current_statement_begin__;
stan::io::program_reader prog_reader__() {
    stan::io::program_reader reader;
    reader.add_event(0, 0, "start", "model_phacking_rtma");
    reader.add_event(93, 91, "end", "model_phacking_rtma");
    return reader;
}
template <typename T0__, typename T1__, typename T3__, typename T4__>
typename boost::math::tools::promote_args<T0__, T1__, T3__, T4__>::type
jeffreys_prior(const T0__& mu,
                   const T1__& tau,
                   const int& k,
                   const std::vector<T3__>& sei,
                   const std::vector<T4__>& tcrit, std::ostream* pstream__) {
    typedef typename boost::math::tools::promote_args<T0__, T1__, T3__, T4__>::type local_scalar_t__;
    typedef local_scalar_t__ fun_return_scalar_t__;
    const static bool propto__ = true;
    (void) propto__;
        local_scalar_t__ DUMMY_VAR__(std::numeric_limits<double>::quiet_NaN());
        (void) DUMMY_VAR__;  // suppress unused var warning
    int current_statement_begin__ = -1;
    try {
        {
        current_statement_begin__ = 6;
        local_scalar_t__ kmm(DUMMY_VAR__);
        (void) kmm;  // dummy to suppress unused var warning
        stan::math::initialize(kmm, DUMMY_VAR__);
        stan::math::fill(kmm, DUMMY_VAR__);
        current_statement_begin__ = 7;
        local_scalar_t__ kms(DUMMY_VAR__);
        (void) kms;  // dummy to suppress unused var warning
        stan::math::initialize(kms, DUMMY_VAR__);
        stan::math::fill(kms, DUMMY_VAR__);
        current_statement_begin__ = 8;
        local_scalar_t__ kss(DUMMY_VAR__);
        (void) kss;  // dummy to suppress unused var warning
        stan::math::initialize(kss, DUMMY_VAR__);
        stan::math::fill(kss, DUMMY_VAR__);
        current_statement_begin__ = 9;
        local_scalar_t__ Si(DUMMY_VAR__);
        (void) Si;  // dummy to suppress unused var warning
        stan::math::initialize(Si, DUMMY_VAR__);
        stan::math::fill(Si, DUMMY_VAR__);
        current_statement_begin__ = 10;
        local_scalar_t__ cz(DUMMY_VAR__);
        (void) cz;  // dummy to suppress unused var warning
        stan::math::initialize(cz, DUMMY_VAR__);
        stan::math::fill(cz, DUMMY_VAR__);
        current_statement_begin__ = 11;
        local_scalar_t__ dnor(DUMMY_VAR__);
        (void) dnor;  // dummy to suppress unused var warning
        stan::math::initialize(dnor, DUMMY_VAR__);
        stan::math::fill(dnor, DUMMY_VAR__);
        current_statement_begin__ = 12;
        local_scalar_t__ pnor(DUMMY_VAR__);
        (void) pnor;  // dummy to suppress unused var warning
        stan::math::initialize(pnor, DUMMY_VAR__);
        stan::math::fill(pnor, DUMMY_VAR__);
        current_statement_begin__ = 13;
        local_scalar_t__ r(DUMMY_VAR__);
        (void) r;  // dummy to suppress unused var warning
        stan::math::initialize(r, DUMMY_VAR__);
        stan::math::fill(r, DUMMY_VAR__);
        current_statement_begin__ = 14;
        validate_non_negative_index("fishinfo", "2", 2);
        validate_non_negative_index("fishinfo", "2", 2);
        Eigen::Matrix<local_scalar_t__, Eigen::Dynamic, Eigen::Dynamic> fishinfo(2, 2);
        stan::math::initialize(fishinfo, DUMMY_VAR__);
        stan::math::fill(fishinfo, DUMMY_VAR__);
        current_statement_begin__ = 17;
        validate_non_negative_index("fishinfototal", "2", 2);
        validate_non_negative_index("fishinfototal", "2", 2);
        Eigen::Matrix<local_scalar_t__, Eigen::Dynamic, Eigen::Dynamic> fishinfototal(2, 2);
        stan::math::initialize(fishinfototal, DUMMY_VAR__);
        stan::math::fill(fishinfototal, DUMMY_VAR__);
        current_statement_begin__ = 18;
        stan::model::assign(fishinfototal, 
                    stan::model::cons_list(stan::model::index_uni(1), stan::model::cons_list(stan::model::index_uni(1), stan::model::nil_index_list())), 
                    0, 
                    "assigning variable fishinfototal");
        current_statement_begin__ = 19;
        stan::model::assign(fishinfototal, 
                    stan::model::cons_list(stan::model::index_uni(1), stan::model::cons_list(stan::model::index_uni(2), stan::model::nil_index_list())), 
                    0, 
                    "assigning variable fishinfototal");
        current_statement_begin__ = 20;
        stan::model::assign(fishinfototal, 
                    stan::model::cons_list(stan::model::index_uni(2), stan::model::cons_list(stan::model::index_uni(1), stan::model::nil_index_list())), 
                    0, 
                    "assigning variable fishinfototal");
        current_statement_begin__ = 21;
        stan::model::assign(fishinfototal, 
                    stan::model::cons_list(stan::model::index_uni(2), stan::model::cons_list(stan::model::index_uni(2), stan::model::nil_index_list())), 
                    0, 
                    "assigning variable fishinfototal");
        current_statement_begin__ = 25;
        for (int i = 1; i <= k; ++i) {
            current_statement_begin__ = 27;
            stan::math::assign(Si, stan::math::sqrt((pow(tau, 2) + pow(get_base1(sei, i, "sei", 1), 2))));
            current_statement_begin__ = 28;
            stan::math::assign(cz, (((get_base1(sei, i, "sei", 1) * get_base1(tcrit, i, "tcrit", 1)) - mu) / Si));
            current_statement_begin__ = 29;
            stan::math::assign(dnor, stan::math::exp(normal_log(cz, 0, 1)));
            current_statement_begin__ = 30;
            stan::math::assign(pnor, stan::math::exp(normal_cdf_log(cz, 0, 1)));
            current_statement_begin__ = 31;
            stan::math::assign(r, (dnor / pnor));
            current_statement_begin__ = 33;
            stan::math::assign(kmm, (pow(Si, -(2)) * (((cz * r) + pow(r, 2)) - 1)));
            current_statement_begin__ = 34;
            stan::math::assign(kms, (((tau * pow(Si, -(3))) * r) * ((pow(cz, 2) + (cz * r)) + 1)));
            current_statement_begin__ = 35;
            stan::math::assign(kss, ((pow(tau, 2) * pow(Si, -(4))) * ((((pow(cz, 3) * r) + (pow(cz, 2) * pow(r, 2))) + (cz * r)) - 2)));
            current_statement_begin__ = 37;
            stan::model::assign(fishinfo, 
                        stan::model::cons_list(stan::model::index_uni(1), stan::model::cons_list(stan::model::index_uni(1), stan::model::nil_index_list())), 
                        -(kmm), 
                        "assigning variable fishinfo");
            current_statement_begin__ = 38;
            stan::model::assign(fishinfo, 
                        stan::model::cons_list(stan::model::index_uni(1), stan::model::cons_list(stan::model::index_uni(2), stan::model::nil_index_list())), 
                        -(kms), 
                        "assigning variable fishinfo");
            current_statement_begin__ = 39;
            stan::model::assign(fishinfo, 
                        stan::model::cons_list(stan::model::index_uni(2), stan::model::cons_list(stan::model::index_uni(1), stan::model::nil_index_list())), 
                        -(kms), 
                        "assigning variable fishinfo");
            current_statement_begin__ = 40;
            stan::model::assign(fishinfo, 
                        stan::model::cons_list(stan::model::index_uni(2), stan::model::cons_list(stan::model::index_uni(2), stan::model::nil_index_list())), 
                        -(kss), 
                        "assigning variable fishinfo");
            current_statement_begin__ = 43;
            stan::math::assign(fishinfototal, add(fishinfototal, fishinfo));
        }
        current_statement_begin__ = 47;
        return stan::math::promote_scalar<fun_return_scalar_t__>(stan::math::sqrt(determinant(fishinfototal)));
        }
    } catch (const std::exception& e) {
        stan::lang::rethrow_located(e, current_statement_begin__, prog_reader__());
        // Next line prevents compiler griping about no return
        throw std::runtime_error("*** IF YOU SEE THIS, PLEASE REPORT A BUG ***");
    }
}
struct jeffreys_prior_functor__ {
    template <typename T0__, typename T1__, typename T3__, typename T4__>
        typename boost::math::tools::promote_args<T0__, T1__, T3__, T4__>::type
    operator()(const T0__& mu,
                   const T1__& tau,
                   const int& k,
                   const std::vector<T3__>& sei,
                   const std::vector<T4__>& tcrit, std::ostream* pstream__) const {
        return jeffreys_prior(mu, tau, k, sei, tcrit, pstream__);
    }
};
#include <stan_meta_header.hpp>
class model_phacking_rtma
  : public stan::model::model_base_crtp<model_phacking_rtma> {
private:
        int k;
        std::vector<double> sei;
        std::vector<double> tcrit;
        std::vector<double> y;
public:
    model_phacking_rtma(stan::io::var_context& context__,
        std::ostream* pstream__ = 0)
        : model_base_crtp(0) {
        ctor_body(context__, 0, pstream__);
    }
    model_phacking_rtma(stan::io::var_context& context__,
        unsigned int random_seed__,
        std::ostream* pstream__ = 0)
        : model_base_crtp(0) {
        ctor_body(context__, random_seed__, pstream__);
    }
    void ctor_body(stan::io::var_context& context__,
                   unsigned int random_seed__,
                   std::ostream* pstream__) {
        typedef double local_scalar_t__;
        boost::ecuyer1988 base_rng__ =
          stan::services::util::create_rng(random_seed__, 0);
        (void) base_rng__;  // suppress unused var warning
        current_statement_begin__ = -1;
        static const char* function__ = "model_phacking_rtma_namespace::model_phacking_rtma";
        (void) function__;  // dummy to suppress unused var warning
        size_t pos__;
        (void) pos__;  // dummy to suppress unused var warning
        std::vector<int> vals_i__;
        std::vector<double> vals_r__;
        local_scalar_t__ DUMMY_VAR__(std::numeric_limits<double>::quiet_NaN());
        (void) DUMMY_VAR__;  // suppress unused var warning
        try {
            // initialize data block variables from context__
            current_statement_begin__ = 52;
            context__.validate_dims("data initialization", "k", "int", context__.to_vec());
            k = int(0);
            vals_i__ = context__.vals_i("k");
            pos__ = 0;
            k = vals_i__[pos__++];
            check_greater_or_equal(function__, "k", k, 0);
            current_statement_begin__ = 53;
            validate_non_negative_index("sei", "k", k);
            context__.validate_dims("data initialization", "sei", "double", context__.to_vec(k));
            sei = std::vector<double>(k, double(0));
            vals_r__ = context__.vals_r("sei");
            pos__ = 0;
            size_t sei_k_0_max__ = k;
            for (size_t k_0__ = 0; k_0__ < sei_k_0_max__; ++k_0__) {
                sei[k_0__] = vals_r__[pos__++];
            }
            current_statement_begin__ = 54;
            validate_non_negative_index("tcrit", "k", k);
            context__.validate_dims("data initialization", "tcrit", "double", context__.to_vec(k));
            tcrit = std::vector<double>(k, double(0));
            vals_r__ = context__.vals_r("tcrit");
            pos__ = 0;
            size_t tcrit_k_0_max__ = k;
            for (size_t k_0__ = 0; k_0__ < tcrit_k_0_max__; ++k_0__) {
                tcrit[k_0__] = vals_r__[pos__++];
            }
            current_statement_begin__ = 55;
            validate_non_negative_index("y", "k", k);
            context__.validate_dims("data initialization", "y", "double", context__.to_vec(k));
            y = std::vector<double>(k, double(0));
            vals_r__ = context__.vals_r("y");
            pos__ = 0;
            size_t y_k_0_max__ = k;
            for (size_t k_0__ = 0; k_0__ < y_k_0_max__; ++k_0__) {
                y[k_0__] = vals_r__[pos__++];
            }
            // initialize transformed data variables
            // execute transformed data statements
            // validate transformed data
            // validate, set parameter ranges
            num_params_r__ = 0U;
            param_ranges_i__.clear();
            current_statement_begin__ = 59;
            num_params_r__ += 1;
            current_statement_begin__ = 60;
            num_params_r__ += 1;
        } catch (const std::exception& e) {
            stan::lang::rethrow_located(e, current_statement_begin__, prog_reader__());
            // Next line prevents compiler griping about no return
            throw std::runtime_error("*** IF YOU SEE THIS, PLEASE REPORT A BUG ***");
        }
    }
    ~model_phacking_rtma() { }
    void transform_inits(const stan::io::var_context& context__,
                         std::vector<int>& params_i__,
                         std::vector<double>& params_r__,
                         std::ostream* pstream__) const {
        typedef double local_scalar_t__;
        stan::io::writer<double> writer__(params_r__, params_i__);
        size_t pos__;
        (void) pos__; // dummy call to supress warning
        std::vector<double> vals_r__;
        std::vector<int> vals_i__;
        current_statement_begin__ = 59;
        if (!(context__.contains_r("mu")))
            stan::lang::rethrow_located(std::runtime_error(std::string("Variable mu missing")), current_statement_begin__, prog_reader__());
        vals_r__ = context__.vals_r("mu");
        pos__ = 0U;
        context__.validate_dims("parameter initialization", "mu", "double", context__.to_vec());
        double mu(0);
        mu = vals_r__[pos__++];
        try {
            writer__.scalar_unconstrain(mu);
        } catch (const std::exception& e) {
            stan::lang::rethrow_located(std::runtime_error(std::string("Error transforming variable mu: ") + e.what()), current_statement_begin__, prog_reader__());
        }
        current_statement_begin__ = 60;
        if (!(context__.contains_r("tau")))
            stan::lang::rethrow_located(std::runtime_error(std::string("Variable tau missing")), current_statement_begin__, prog_reader__());
        vals_r__ = context__.vals_r("tau");
        pos__ = 0U;
        context__.validate_dims("parameter initialization", "tau", "double", context__.to_vec());
        double tau(0);
        tau = vals_r__[pos__++];
        try {
            writer__.scalar_lb_unconstrain(0, tau);
        } catch (const std::exception& e) {
            stan::lang::rethrow_located(std::runtime_error(std::string("Error transforming variable tau: ") + e.what()), current_statement_begin__, prog_reader__());
        }
        params_r__ = writer__.data_r();
        params_i__ = writer__.data_i();
    }
    void transform_inits(const stan::io::var_context& context,
                         Eigen::Matrix<double, Eigen::Dynamic, 1>& params_r,
                         std::ostream* pstream__) const {
      std::vector<double> params_r_vec;
      std::vector<int> params_i_vec;
      transform_inits(context, params_i_vec, params_r_vec, pstream__);
      params_r.resize(params_r_vec.size());
      for (int i = 0; i < params_r.size(); ++i)
        params_r(i) = params_r_vec[i];
    }
    template <bool propto__, bool jacobian__, typename T__>
    T__ log_prob(std::vector<T__>& params_r__,
                 std::vector<int>& params_i__,
                 std::ostream* pstream__ = 0) const {
        typedef T__ local_scalar_t__;
        local_scalar_t__ DUMMY_VAR__(std::numeric_limits<double>::quiet_NaN());
        (void) DUMMY_VAR__;  // dummy to suppress unused var warning
        T__ lp__(0.0);
        stan::math::accumulator<T__> lp_accum__;
        try {
            stan::io::reader<local_scalar_t__> in__(params_r__, params_i__);
            // model parameters
            current_statement_begin__ = 59;
            local_scalar_t__ mu;
            (void) mu;  // dummy to suppress unused var warning
            if (jacobian__)
                mu = in__.scalar_constrain(lp__);
            else
                mu = in__.scalar_constrain();
            current_statement_begin__ = 60;
            local_scalar_t__ tau;
            (void) tau;  // dummy to suppress unused var warning
            if (jacobian__)
                tau = in__.scalar_lb_constrain(0, lp__);
            else
                tau = in__.scalar_lb_constrain(0);
            // model body
            current_statement_begin__ = 65;
            lp_accum__.add(stan::math::log(jeffreys_prior(mu, tau, k, sei, tcrit, pstream__)));
            current_statement_begin__ = 68;
            for (int i = 1; i <= k; ++i) {
                current_statement_begin__ = 69;
                lp_accum__.add(normal_log<propto__>(get_base1(y, i, "y", 1), mu, stan::math::sqrt((pow(tau, 2) + pow(get_base1(sei, i, "sei", 1), 2)))));
                if (get_base1(y, i, "y", 1) > (get_base1(tcrit, i, "tcrit", 1) * get_base1(sei, i, "sei", 1))) lp_accum__.add(-std::numeric_limits<double>::infinity());
                else lp_accum__.add(-normal_cdf_log((get_base1(tcrit, i, "tcrit", 1) * get_base1(sei, i, "sei", 1)), mu, stan::math::sqrt((pow(tau, 2) + pow(get_base1(sei, i, "sei", 1), 2)))));
            }
        } catch (const std::exception& e) {
            stan::lang::rethrow_located(e, current_statement_begin__, prog_reader__());
            // Next line prevents compiler griping about no return
            throw std::runtime_error("*** IF YOU SEE THIS, PLEASE REPORT A BUG ***");
        }
        lp_accum__.add(lp__);
        return lp_accum__.sum();
    } // log_prob()
    template <bool propto, bool jacobian, typename T_>
    T_ log_prob(Eigen::Matrix<T_,Eigen::Dynamic,1>& params_r,
               std::ostream* pstream = 0) const {
      std::vector<T_> vec_params_r;
      vec_params_r.reserve(params_r.size());
      for (int i = 0; i < params_r.size(); ++i)
        vec_params_r.push_back(params_r(i));
      std::vector<int> vec_params_i;
      return log_prob<propto,jacobian,T_>(vec_params_r, vec_params_i, pstream);
    }
    void get_param_names(std::vector<std::string>& names__) const {
        names__.resize(0);
        names__.push_back("mu");
        names__.push_back("tau");
        names__.push_back("log_lik");
        names__.push_back("log_prior");
        names__.push_back("log_post");
    }
    void get_dims(std::vector<std::vector<size_t> >& dimss__) const {
        dimss__.resize(0);
        std::vector<size_t> dims__;
        dims__.resize(0);
        dimss__.push_back(dims__);
        dims__.resize(0);
        dimss__.push_back(dims__);
        dims__.resize(0);
        dimss__.push_back(dims__);
        dims__.resize(0);
        dimss__.push_back(dims__);
        dims__.resize(0);
        dimss__.push_back(dims__);
    }
    template <typename RNG>
    void write_array(RNG& base_rng__,
                     std::vector<double>& params_r__,
                     std::vector<int>& params_i__,
                     std::vector<double>& vars__,
                     bool include_tparams__ = true,
                     bool include_gqs__ = true,
                     std::ostream* pstream__ = 0) const {
        typedef double local_scalar_t__;
        vars__.resize(0);
        stan::io::reader<local_scalar_t__> in__(params_r__, params_i__);
        static const char* function__ = "model_phacking_rtma_namespace::write_array";
        (void) function__;  // dummy to suppress unused var warning
        // read-transform, write parameters
        double mu = in__.scalar_constrain();
        vars__.push_back(mu);
        double tau = in__.scalar_lb_constrain(0);
        vars__.push_back(tau);
        double lp__ = 0.0;
        (void) lp__;  // dummy to suppress unused var warning
        stan::math::accumulator<double> lp_accum__;
        local_scalar_t__ DUMMY_VAR__(std::numeric_limits<double>::quiet_NaN());
        (void) DUMMY_VAR__;  // suppress unused var warning
        if (!include_tparams__ && !include_gqs__) return;
        try {
            if (!include_gqs__ && !include_tparams__) return;
            if (!include_gqs__) return;
            // declare and define generated quantities
            current_statement_begin__ = 78;
            double log_lik;
            (void) log_lik;  // dummy to suppress unused var warning
            stan::math::initialize(log_lik, DUMMY_VAR__);
            stan::math::fill(log_lik, DUMMY_VAR__);
            stan::math::assign(log_lik,0);
            current_statement_begin__ = 79;
            double log_prior;
            (void) log_prior;  // dummy to suppress unused var warning
            stan::math::initialize(log_prior, DUMMY_VAR__);
            stan::math::fill(log_prior, DUMMY_VAR__);
            stan::math::assign(log_prior,stan::math::log(jeffreys_prior(mu, tau, k, sei, tcrit, pstream__)));
            current_statement_begin__ = 80;
            double log_post;
            (void) log_post;  // dummy to suppress unused var warning
            stan::math::initialize(log_post, DUMMY_VAR__);
            stan::math::fill(log_post, DUMMY_VAR__);
            // generated quantities statements
            current_statement_begin__ = 83;
            for (int i = 1; i <= k; ++i) {
                current_statement_begin__ = 85;
                stan::math::assign(log_lik, (log_lik + normal_log(get_base1(y, i, "y", 1), mu, stan::math::sqrt((pow(tau, 2) + pow(get_base1(sei, i, "sei", 1), 2))))));
                current_statement_begin__ = 87;
                stan::math::assign(log_lik, (log_lik + (-(1) * normal_cdf_log((get_base1(tcrit, i, "tcrit", 1) * get_base1(sei, i, "sei", 1)), mu, stan::math::sqrt((pow(tau, 2) + pow(get_base1(sei, i, "sei", 1), 2)))))));
            }
            current_statement_begin__ = 90;
            stan::math::assign(log_post, (log_prior + log_lik));
            // validate, write generated quantities
            current_statement_begin__ = 78;
            vars__.push_back(log_lik);
            current_statement_begin__ = 79;
            vars__.push_back(log_prior);
            current_statement_begin__ = 80;
            vars__.push_back(log_post);
        } catch (const std::exception& e) {
            stan::lang::rethrow_located(e, current_statement_begin__, prog_reader__());
            // Next line prevents compiler griping about no return
            throw std::runtime_error("*** IF YOU SEE THIS, PLEASE REPORT A BUG ***");
        }
    }
    template <typename RNG>
    void write_array(RNG& base_rng,
                     Eigen::Matrix<double,Eigen::Dynamic,1>& params_r,
                     Eigen::Matrix<double,Eigen::Dynamic,1>& vars,
                     bool include_tparams = true,
                     bool include_gqs = true,
                     std::ostream* pstream = 0) const {
      std::vector<double> params_r_vec(params_r.size());
      for (int i = 0; i < params_r.size(); ++i)
        params_r_vec[i] = params_r(i);
      std::vector<double> vars_vec;
      std::vector<int> params_i_vec;
      write_array(base_rng, params_r_vec, params_i_vec, vars_vec, include_tparams, include_gqs, pstream);
      vars.resize(vars_vec.size());
      for (int i = 0; i < vars.size(); ++i)
        vars(i) = vars_vec[i];
    }
    std::string model_name() const {
        return "model_phacking_rtma";
    }
    void constrained_param_names(std::vector<std::string>& param_names__,
                                 bool include_tparams__ = true,
                                 bool include_gqs__ = true) const {
        std::stringstream param_name_stream__;
        param_name_stream__.str(std::string());
        param_name_stream__ << "mu";
        param_names__.push_back(param_name_stream__.str());
        param_name_stream__.str(std::string());
        param_name_stream__ << "tau";
        param_names__.push_back(param_name_stream__.str());
        if (!include_gqs__ && !include_tparams__) return;
        if (include_tparams__) {
        }
        if (!include_gqs__) return;
        param_name_stream__.str(std::string());
        param_name_stream__ << "log_lik";
        param_names__.push_back(param_name_stream__.str());
        param_name_stream__.str(std::string());
        param_name_stream__ << "log_prior";
        param_names__.push_back(param_name_stream__.str());
        param_name_stream__.str(std::string());
        param_name_stream__ << "log_post";
        param_names__.push_back(param_name_stream__.str());
    }
    void unconstrained_param_names(std::vector<std::string>& param_names__,
                                   bool include_tparams__ = true,
                                   bool include_gqs__ = true) const {
        std::stringstream param_name_stream__;
        param_name_stream__.str(std::string());
        param_name_stream__ << "mu";
        param_names__.push_back(param_name_stream__.str());
        param_name_stream__.str(std::string());
        param_name_stream__ << "tau";
        param_names__.push_back(param_name_stream__.str());
        if (!include_gqs__ && !include_tparams__) return;
        if (include_tparams__) {
        }
        if (!include_gqs__) return;
        param_name_stream__.str(std::string());
        param_name_stream__ << "log_lik";
        param_names__.push_back(param_name_stream__.str());
        param_name_stream__.str(std::string());
        param_name_stream__ << "log_prior";
        param_names__.push_back(param_name_stream__.str());
        param_name_stream__.str(std::string());
        param_name_stream__ << "log_post";
        param_names__.push_back(param_name_stream__.str());
    }
}; // model
}  // namespace
typedef model_phacking_rtma_namespace::model_phacking_rtma stan_model;
#ifndef USING_R
stan::model::model_base& new_model(
        stan::io::var_context& data_context,
        unsigned int seed,
        std::ostream* msg_stream) {
  stan_model* m = new stan_model(data_context, seed, msg_stream);
  return *m;
}
#endif
#endif
