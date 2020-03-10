Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B76DA180B56
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Mar 2020 23:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbgCJWSj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Mar 2020 18:18:39 -0400
Received: from mga01.intel.com ([192.55.52.88]:2057 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbgCJWSi (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Mar 2020 18:18:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 15:18:37 -0700
X-IronPort-AV: E=Sophos;i="5.70,538,1574150400"; 
   d="scan'208";a="242472766"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.251.10.135]) ([10.251.10.135])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 10 Mar 2020 15:18:36 -0700
Subject: Re: [PATCH V1 11/13] selftests/resctrl: Change Cache Quality
 Monitoring (CQM) test
To:     Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        tony.luck@intel.com, babu.moger@amd.com, james.morse@arm.com,
        ravi.v.shankar@intel.com, fenghua.yu@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1583657204.git.sai.praneeth.prakhya@intel.com>
 <26086dda86f062bba4116878a012a553503924b2.1583657204.git.sai.praneeth.prakhya@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <e7bd79cf-4da8-7a61-ac09-4d124315fa93@intel.com>
Date:   Tue, 10 Mar 2020 15:18:36 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <26086dda86f062bba4116878a012a553503924b2.1583657204.git.sai.praneeth.prakhya@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Sai,

On 3/6/2020 7:40 PM, Sai Praneeth Prakhya wrote:
> The present CQM test runs fill_buff continuously with some user specified

Should this not be referred to as Cache Monitoring Technology (CMT)
instead? There is a significant usage of "cqm" throughout this series of
tests and creates confusion with it not being the accurate acronym for
it as is currently done with cat, mbm, and mba. From what I can tell AMD
does not refer to it as CQM either.

I understand the resctrl code uses cqm internally, that may be for
historical reasons, but that usage seems to be limited to the code
itself and not leaking to the user as done here.

> buffer size and reads cqm_llc_occupancy every 1 second and tests if resctrl
> reported value is in 15% range of buffer that fill_buff is working on. If
> the difference is greater than 15% the test fails. This test assumes that
> the buffer fill_buff is working on will be identity mapped into cache from
> memory i.e. there won't be any overlap. But that might not always be true
> because of the way cache indexing works (two physical addresses could get
> indexed into the same cache line). If this happens, cqm_llc_occupancy will
> be less than buffer size and we cannot guarantee the percentage by which
> this might be less. Another issue with the test case is that, although it
> has 15% of guard band, the cache occupied by code (or other parts) of the
> process may not be within this range. While we are actively looking into
> approximating llc_occupancy through perf, fix this test case with the help
> of CAT.
> 
> The new CQM test runs fill_buff continuously with a buffer size that is
> much greater than cache size and uses CAT to change schemata (from 1 bit to
> max_bits available without shareable bits). For every change in schemata,
> it then averages cqm_llc_occupancy and checks if it is less than allocated
> cache size (with 5% guard band). If the average cqm_llc_occupancy is less
> than allocated cache size, the test passes. Please note that there is no
> lower bound on the expected cqm_llc_occupancy because presently that cannot
> be determined.
> 
> Note:
> The new test case assumes that
> 1. The system supports CAT
> 2. CAT is working as expected on the system
> 
> Reported-by: Reinette Chatre <reinette.chatre@intel.com>
> Suggested-by: Tony Luck <tony.luck@intel.com>
> Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
> ---
>  tools/testing/selftests/resctrl/cache.c         |   4 +
>  tools/testing/selftests/resctrl/cqm_test.c      | 203 +++++++++++++++---------
>  tools/testing/selftests/resctrl/resctrl.h       |   3 +-
>  tools/testing/selftests/resctrl/resctrl_tests.c |   6 +-
>  tools/testing/selftests/resctrl/resctrl_val.c   |  22 +--
>  tools/testing/selftests/resctrl/resctrlfs.c     |   6 +-
>  6 files changed, 143 insertions(+), 101 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
> index e30cdd7b851c..ca794ad6fcfc 100644
> --- a/tools/testing/selftests/resctrl/cache.c
> +++ b/tools/testing/selftests/resctrl/cache.c
> @@ -224,11 +224,15 @@ int measure_cache_vals(struct resctrl_val_param *param, int bm_pid)
>  
>  	/* Measure llc occupancy from resctrl */
>  	if (!strcmp(param->resctrl_val, "cqm")) {
> +		/* Sleep for a second so that benchmark gets to run */
> +		sleep(1);
> +
>  		ret = get_llc_occu_resctrl(&llc_occu_resc);
>  		if (ret < 0)
>  			return ret;
>  		llc_value = llc_occu_resc;
>  	}
> +

Extra newline here

>  	ret = print_results_cache(param->filename, bm_pid, llc_value);
>  	if (ret)
>  		return ret;
> diff --git a/tools/testing/selftests/resctrl/cqm_test.c b/tools/testing/selftests/resctrl/cqm_test.c
> index f27b0363e518..3406c04ff110 100644
> --- a/tools/testing/selftests/resctrl/cqm_test.c
> +++ b/tools/testing/selftests/resctrl/cqm_test.c
> @@ -13,73 +13,74 @@
>  
>  #define RESULT_FILE_NAME	"result_cqm"
>  #define NUM_OF_RUNS		5
> -#define MAX_DIFF		2000000
> -#define MAX_DIFF_PERCENT	15
> +#define MAX_DIFF_PERCENT	5
>  
> -int count_of_bits;
>  char cbm_mask[256];
> -unsigned long long_mask;
> -unsigned long cache_size;
>  
> -static int cqm_setup(struct resctrl_val_param *p)
> -{
> -	/* Run NUM_OF_RUNS times */
> -	if (p->num_of_runs >= NUM_OF_RUNS)
> -		return -1;
> -
> -	p->num_of_runs++;
> -
> -	return 0;
> -}
> +static int count_of_bits, count_of_shareable_bits;
> +static unsigned long cache_size, shareable_mask;
>  
> -static void show_cache_info(unsigned long sum_llc_occu_resc, int no_of_bits,
> -			    unsigned long span)
> +static void show_cache_info(unsigned long *llc_occu_resc)
>  {
> -	unsigned long avg_llc_occu_resc = 0;
> -	float diff_percent;
> -	long avg_diff = 0;
> -	bool res;
> +	int bits, runs;
> +	bool failed = false;
>  
> -	avg_llc_occu_resc = sum_llc_occu_resc / (NUM_OF_RUNS - 1);
> -	avg_diff = (long)abs(span - avg_llc_occu_resc);
> -
> -	diff_percent = (((float)span - avg_llc_occu_resc) / span) * 100;
> +	printf("# Results are displayed in (Bytes)\n");

Why are the parentheses used in "(Bytes)"? Printing the numbers in
parentheses does not add value ... but it does not seem to be done
either. Perhaps just "Results are displayed in bytes"?

>  
> -	if ((abs((int)diff_percent) <= MAX_DIFF_PERCENT) ||
> -	    (abs(avg_diff) <= MAX_DIFF))
> -		res = true;
> -	else
> -		res = false;
> +	for (bits = 0; bits < count_of_bits - count_of_shareable_bits; bits++) {
> +		unsigned long avg_llc_occu_resc, sum_llc_occu_resc = 0;
> +		unsigned long alloc_llc, mask = 0;
> +		int llc_occu_diff, i;
> +
> +		/*
> +		 * The first run is discarded due to inaccurate value from
> +		 * phase transition.
> +		 */
> +		for (runs = NUM_OF_RUNS * bits + 1;
> +		     runs < NUM_OF_RUNS * bits + NUM_OF_RUNS; runs++)
> +			sum_llc_occu_resc += llc_occu_resc[runs];
> +
> +		avg_llc_occu_resc = sum_llc_occu_resc / (NUM_OF_RUNS - 1);
> +		alloc_llc = cache_size * ((float)(bits + 1) / count_of_bits);
> +		llc_occu_diff = avg_llc_occu_resc - alloc_llc;
> +
> +		for (i = 0; i < bits + 1; i++) {
> +			mask <<= 1;
> +			mask |= 1;
> +		}
>  
> -	printf("%sok CQM: diff within %d, %d\%%\n", res ? "" : "not ",
> -	       MAX_DIFF, (int)MAX_DIFF_PERCENT);
> +		if (llc_occu_diff > 0 &&
> +		    llc_occu_diff > alloc_llc * ((float)MAX_DIFF_PERCENT / 100))
> +			failed = true;
>  
> -	printf("# diff: %ld\n", avg_diff);
> -	printf("# percent diff=%d\n", abs((int)diff_percent));
> -	printf("# Results are displayed in (Bytes)\n");
> -	printf("# Number of bits: %d\n", no_of_bits);
> -	printf("# Avg_llc_occu_resc: %lu\n", avg_llc_occu_resc);
> -	printf("# llc_occu_exp (span): %lu\n", span);
> +		printf("%sok CQM: diff within %d%% for mask %lx\n",
> +		       failed ? "not " : "", MAX_DIFF_PERCENT, mask);
> +		printf("# alloc_llc_cache_size: %lu\n", alloc_llc);
> +		printf("# avg_llc_occu_resc: %lu\n", avg_llc_occu_resc);
> +		tests_run++;
> +	}
>  
> +	printf("%sok schemata change for CQM%s\n", failed ? "not " : "",
> +	       failed ? " # at least one test failed" : "");
>  	tests_run++;
>  }
>  
> -static int check_results(struct resctrl_val_param *param, int no_of_bits)
> +static int check_results(void)
>  {
> -	char *token_array[8], temp[512];
> -	unsigned long sum_llc_occu_resc = 0;
> -	int runs = 0;
> +	char *token_array[8], output[] = RESULT_FILE_NAME, temp[512];
> +	unsigned long llc_occu_resc[count_of_bits * NUM_OF_RUNS];
> +	int runs;
>  	FILE *fp;
>  
> -	printf("# checking for pass/fail\n");
> -	fp = fopen(param->filename, "r");
> +	fp = fopen(output, "r");
>  	if (!fp) {
> -		perror("# Error in opening file\n");
> +		perror(output);
>  
>  		return errno;
>  	}
>  
> -	while (fgets(temp, 1024, fp)) {
> +	runs = 0;
> +	while (fgets(temp, sizeof(temp), fp)) {
>  		char *token = strtok(temp, ":\t");
>  		int fields = 0;
>  
> @@ -88,13 +89,14 @@ static int check_results(struct resctrl_val_param *param, int no_of_bits)
>  			token = strtok(NULL, ":\t");
>  		}
>  
> -		/* Field 3 is llc occ resc value */
> -		if (runs > 0)
> -			sum_llc_occu_resc += strtoul(token_array[3], NULL, 0);
> +		/* Field 3 is resctrl LLC occupancy value */
> +		llc_occu_resc[runs] = strtoul(token_array[3], NULL, 0);
>  		runs++;
>  	}
> +
>  	fclose(fp);
> -	show_cache_info(sum_llc_occu_resc, no_of_bits, param->span);
> +
> +	show_cache_info(llc_occu_resc);
>  
>  	return 0;
>  }
> @@ -104,62 +106,107 @@ void cqm_test_cleanup(void)
>  	remove(RESULT_FILE_NAME);
>  }
>  
> -int cqm_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
> +/*
> + * Change schemata from 1 to count_of_bits - 1. Write schemata to specified
> + * con_mon grp, mon_grp in resctrl FS. For each allocation, run "NUM_OF_RUNS"
> + * times to get average values.
> + */
> +static int cqm_setup(struct resctrl_val_param *p)
>  {
> -	int ret, mum_resctrlfs;
> +	static int runs_per_allocation = 0, num_of_bits = 1;
> +	unsigned long mask = 0;
> +	char schemata[64];
> +	int i, ret;
>  
> -	cache_size = 0;
> -	mum_resctrlfs = 1;
> +	if (runs_per_allocation >= NUM_OF_RUNS)
> +		runs_per_allocation = 0;
>  
> -	ret = remount_resctrlfs(mum_resctrlfs);
> -	if (ret)
> -		return ret;
> +	/* Only set up schemata once every NUM_OF_RUNS of allocations */
> +	if (runs_per_allocation++ != 0)
> +		return 0;
>  
> -	if (!validate_resctrl_feature_request("cqm"))
> +	if (num_of_bits > count_of_bits - count_of_shareable_bits)
>  		return -1;
>  
> -	ret = get_cbm_mask("L3");
> -	if (ret)
> -		return ret;
> -
> -	long_mask = strtoul(cbm_mask, NULL, 16);
> +	/* Prepare cbm mask without any shareable bits */
> +	for (i = 0; i < num_of_bits; i++) {
> +		mask <<= 1;
> +		mask |= 1;
> +	}
> +	mask = ~shareable_mask & mask;

If I understand correctly this function assumes that the shareable bits
will also be the high order bits of the schemata. I do not believe that
this is part of a spec. It also does not seem as though the code follows
what the comment at the top of the function states. The comment states
"Change schemata from 1 to count_of_bits - 1" while the code seems to
change schemata from 1 to count_of_bits - count_of_shareable_bits ...

>  
> -	ret = get_cache_size(cpu_no, "L3", &cache_size);
> +	sprintf(schemata, "%lx", mask);
> +	ret = write_schemata(p->ctrlgrp, schemata, p->cpu_no, "cat");
>  	if (ret)
>  		return ret;
> -	printf("cache size :%lu\n", cache_size);
>  
> -	count_of_bits = count_bits(long_mask);
> +	p->mask = mask;
> +	num_of_bits++;
>  
> -	if (n < 1 || n > count_of_bits) {
> -		printf("Invalid input value for numbr_of_bits n!\n");
> -		printf("Please Enter value in range 1 to %d\n", count_of_bits);
> -		return -1;
> -	}
> +	return 0;
> +}
>  
> +int cqm_schemata_change(int cpu_no, int span, char *cache_type,
> +			char **benchmark_cmd)
> +{
>  	struct resctrl_val_param param = {
>  		.resctrl_val	= "cqm",
>  		.ctrlgrp	= "c1",
>  		.mongrp		= "m1",
>  		.cpu_no		= cpu_no,
> +		.span		= span,

This function received the new function parameter "span" to be used here
... I am having trouble finding where this member is used within this
test. Could you please help me navigate to this?

>  		.mum_resctrlfs	= 0,
>  		.filename	= RESULT_FILE_NAME,
> -		.mask		= ~(long_mask << n) & long_mask,
> -		.span		= cache_size * n / count_of_bits,
>  		.num_of_runs	= 0,
> -		.setup		= cqm_setup,
> +		.setup		= cqm_setup
>  	};
> +	int ret;
> +	char schemata[64];
> +	unsigned long long_mask;
>  
> -	if (strcmp(benchmark_cmd[0], "fill_buf") == 0)
> -		sprintf(benchmark_cmd[1], "%lu", param.span);
> +	ret = remount_resctrlfs(1);
> +	if (ret)
> +		return ret;

Here resctrl is remounted and followed by some changes to the root
group's schemata. That is followed by a call to resctrl_val that
attempts to remount resctrl again that will undo all the configurations
inbetween.

>  
> -	remove(RESULT_FILE_NAME);
> +	/* Check for both 'cat' and 'cqm' because CQM is validated using CAT */
> +	if (!validate_resctrl_feature_request("cqm"))
> +		return -1;
> +
> +	if (!validate_resctrl_feature_request("cat"))
> +		return -1;
> +
> +	ret = get_cache_size(cpu_no, cache_type, &cache_size);
> +	if (ret)
> +		return ret;
> +	printf("# cache size: %lu\n", cache_size);
> +
> +	ret = get_cbm_mask(cache_type);
> +	if (ret)
> +		return ret;
> +
> +	long_mask = strtoul(cbm_mask, NULL, 16);
> +	count_of_bits = count_bits(long_mask);
> +
> +	/*
> +	 * Change root con_mon grp schemata to minimum (i.e. '1' bit) so that
> +	 * test could use all other bits
> +	 */
> +	sprintf(schemata, "%x", 1);
> +	ret = write_schemata("", schemata, cpu_no, "cqm");
> +	if (ret)
> +		return ret;

... here the schemata is written to resctrl

> +
> +	ret = get_shareable_mask(cache_type, &shareable_mask);
> +	if (ret)
> +		return ret;
> +
> +	count_of_shareable_bits = count_bits(shareable_mask);
>  
>  	ret = resctrl_val(benchmark_cmd, &param);
>  	if (ret)
>  		return ret;

here is the call to resctrl_val() that attempts to remount resctrl.

>  
> -	ret = check_results(&param, n);
> +	ret = check_results();
>  	if (ret)
>  		return ret;
>  
> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> index 79148cbbd7a4..cb67ad689475 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -103,7 +103,8 @@ int setup_critical_process(pid_t pid, struct resctrl_val_param *param);
>  int run_critical_process(pid_t pid, struct resctrl_val_param *param);
>  void cat_test_cleanup(void);
>  int cat_perf_miss_val(int cpu_no, int no_of_bits, char *cache_type);
> -int cqm_resctrl_val(int cpu_no, int n, char **benchmark_cmd);
> +int cqm_schemata_change(int cpu_no, int span, char *cache_type,
> +			char **benchmark_cmd);
>  unsigned int count_bits(unsigned long n);
>  void cqm_test_cleanup(void);
>  int get_core_sibling(int cpu_no);
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> index 60db128312a6..3c408c636b6d 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -180,9 +180,11 @@ int main(int argc, char **argv)
>  
>  	if (cqm_test) {
>  		printf("# Starting CQM test ...\n");
> -		if (!has_ben)
> +		if (!has_ben) {
> +			sprintf(benchmark_cmd[1], "%d", span);
>  			sprintf(benchmark_cmd[5], "%s", "cqm");
> -		res = cqm_resctrl_val(cpu_no, no_of_bits, benchmark_cmd);
> +		}
> +		res = cqm_schemata_change(cpu_no, span, "L3", benchmark_cmd);
>  		printf("%sok CQM: test\n", res ? "not " : "");
>  		cqm_test_cleanup();
>  		tests_run++;
> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
> index 271cb5c976f5..c59fad6cb9b0 100644
> --- a/tools/testing/selftests/resctrl/resctrl_val.c
> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
> @@ -705,29 +705,21 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
>  		goto out;
>  	}
>  
> -	/* Give benchmark enough time to fully run */
> -	sleep(1);
> -
>  	/* Test runs until the callback setup() tells the test to stop. */
>  	while (1) {
> +		ret = param->setup(param);
> +		if (ret) {
> +			ret = 0;
> +			break;
> +		}
> +
> +		/* Measure vals sleeps for a second */
>  		if ((strcmp(resctrl_val, "mbm") == 0) ||
>  		    (strcmp(resctrl_val, "mba") == 0)) {
> -			ret = param->setup(param);
> -			if (ret) {
> -				ret = 0;
> -				break;
> -			}
> -
>  			ret = measure_vals(param, &bw_resc_start);
>  			if (ret)
>  				break;
>  		} else if (strcmp(resctrl_val, "cqm") == 0) {
> -			ret = param->setup(param);
> -			if (ret) {
> -				ret = 0;
> -				break;
> -			}
> -			sleep(1);
>  			ret = measure_cache_vals(param, bm_pid);
>  			if (ret)
>  				break;

This change affects not just the cache monitoring test. Could this
change be extracted into its own patch to be clear what is done here and
how it impacts the other tests?

> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
> index 52452bb0178a..bd81a13ff9df 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -365,11 +365,7 @@ void run_benchmark(int signum, siginfo_t *info, void *ucontext)
>  		memflush =  atoi(benchmark_cmd[3]);
>  		operation = atoi(benchmark_cmd[4]);
>  		sprintf(resctrl_val, "%s", benchmark_cmd[5]);
> -
> -		if (strcmp(resctrl_val, "cqm") != 0)
> -			buffer_span = span * MB;
> -		else
> -			buffer_span = span;
> +		buffer_span = span * MB;

This change seems to change the buffer_span used by the other tests. It
is not obvious why this change is made to other tests while this commit
intends to focus on the cache monitoring test. Perhaps this can be split
into a separate patch to make this clear?

>  
>  		if (run_fill_buf(buffer_span, malloc_and_init_memory, memflush,
>  				 operation, resctrl_val))
> 

Reinette
