Return-Path: <linux-kselftest+bounces-16777-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AA996605B
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 13:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB7CD1F29450
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 11:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C5C18FDA7;
	Fri, 30 Aug 2024 11:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dziXI/k2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B48185B51;
	Fri, 30 Aug 2024 11:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725016409; cv=none; b=G5LZnMIi19EeUMtqylAuLhiRG4+tjrSlTYjkZtptzfFeobSJ+r0etL4EbzvYr0g5wvlri4m9VM5xg2OvRzBtyJf2/SNZ4/zw2OZpopC6IRQEHxta+mRvPvzKAg4OIvc2K5NRt2PjNgNhCPrk2mCQLBmMl5UbWESpBtN2+7odsIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725016409; c=relaxed/simple;
	bh=cPAd6pOa+52YdF3m0DIDbXDXk/XF/15iW0uItASFibU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WU3xcQHecXpsTyuI0DN2KdY9oQO1aMmqOCGJRBwAC8JyOjW6SSdConOYHprpUrorVpui6pPLdGdBgHsIV5AY3Kv01rol2lBXd8t2kexJB+WOtknYc79kTNryQoX/r+gpSribuo8v2QFReuZUebM07Un54NK/rK3eaKyxfsF51bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dziXI/k2; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725016407; x=1756552407;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=cPAd6pOa+52YdF3m0DIDbXDXk/XF/15iW0uItASFibU=;
  b=dziXI/k29Saiowyc10DxXOUIW3vd3tlCconfEEwA2aNlb3soPV7LOMC9
   cZuQalQ+yTk39wVi59WFCKvZZSMvamRevMtltX7K7qbnVITTs+mfhqSKt
   hnCf8J/97PRxOqcbEFxXdfAp1TsMTEIDB4RNuuOQ3ufHVyOYZ3G1Phart
   Z9Uo0Ll0gqzd/Lwl3Wdsy3GyCKrFBORxJJuYAGWtKE82TPVIXiSrfoirh
   YKOWRlFDjvM4QzKDxHp2mfw+KAOA8LNk2fiq/E9Mze2iMtOrlw1ZyJa0Z
   F9opGCkiB057ZW4dPN/jb4XnnqdpKNr3nNBF02dBJpDebYEJeotuxHpzL
   g==;
X-CSE-ConnectionGUID: Lmugj2rOQ8O/dluHCQmvgQ==
X-CSE-MsgGUID: aZYmAZGqTNGTznrPjObYew==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="35060405"
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="35060405"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 04:13:26 -0700
X-CSE-ConnectionGUID: bqa0rbfrSSWlLMRa0IqOzA==
X-CSE-MsgGUID: py/zdAtjQgWpvHNG72nEgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="94694391"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.174])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 04:13:22 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 30 Aug 2024 14:13:18 +0300 (EEST)
To: Reinette Chatre <reinette.chatre@intel.com>
cc: fenghua.yu@intel.com, shuah@kernel.org, tony.luck@intel.com, 
    peternewman@google.com, babu.moger@amd.com, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/6] selftests/resctrl: Simplify benchmark parameter
 passing
In-Reply-To: <fdedc12d44db62d85d1345e35a133983ed0af1ac.1724970211.git.reinette.chatre@intel.com>
Message-ID: <da0741fa-463f-ca3c-0731-241f5c97dab3@linux.intel.com>
References: <cover.1724970211.git.reinette.chatre@intel.com> <fdedc12d44db62d85d1345e35a133983ed0af1ac.1724970211.git.reinette.chatre@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 29 Aug 2024, Reinette Chatre wrote:

> The benchmark used during the CMT, MBM, and MBA tests can be provided by
> the user via (-b) parameter to the tests, if not provided the default
> "fill_buf" benchmark is used.
> 
> The "fill_buf" benchmark requires parameters and these are managed as
> an array of strings.
> 
> Using an array of strings to manage the "fill_buf" parameters is
> complex because it requires transformations to/from strings at every
> producer and consumer. This is made worse for the individual tests
> where the default benchmark parameters values may not be appropriate and
> additional data wrangling is required. For example, the CMT test
> duplicates the entire array of strings in order to replace one of
> the parameters.
> 
> Replace the "array of strings" parameters used for "fill_buf" with a
> struct that contains the "fill_buf" parameters that can be used directly
> without transformations to/from strings. Make these parameters
> part of the parameters associated with each test so that each test can
> set benchmark parameters that are appropriate for it.
> 
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
>  tools/testing/selftests/resctrl/cmt_test.c    | 28 +++--------
>  tools/testing/selftests/resctrl/mba_test.c    |  7 ++-
>  tools/testing/selftests/resctrl/mbm_test.c    |  9 +++-
>  tools/testing/selftests/resctrl/resctrl.h     | 49 +++++++++++++------
>  .../testing/selftests/resctrl/resctrl_tests.c | 15 +-----
>  tools/testing/selftests/resctrl/resctrl_val.c | 38 +++++---------
>  6 files changed, 69 insertions(+), 77 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
> index 0c045080d808..f09d5dfab38c 100644
> --- a/tools/testing/selftests/resctrl/cmt_test.c
> +++ b/tools/testing/selftests/resctrl/cmt_test.c
> @@ -116,15 +116,12 @@ static void cmt_test_cleanup(void)
>  
>  static int cmt_run_test(const struct resctrl_test *test, const struct user_params *uparams)
>  {
> -	const char * const *cmd = uparams->benchmark_cmd;
> -	const char *new_cmd[BENCHMARK_ARGS];
>  	unsigned long cache_total_size = 0;
>  	int n = uparams->bits ? : 5;
>  	unsigned long long_mask;
> -	char *span_str = NULL;
>  	int count_of_bits;
>  	size_t span;
> -	int ret, i;
> +	int ret;
>  
>  	ret = get_full_cbm("L3", &long_mask);
>  	if (ret)
> @@ -155,32 +152,21 @@ static int cmt_run_test(const struct resctrl_test *test, const struct user_param
>  
>  	span = cache_portion_size(cache_total_size, param.mask, long_mask);
>  
> -	if (strcmp(cmd[0], "fill_buf") == 0) {
> -		/* Duplicate the command to be able to replace span in it */
> -		for (i = 0; uparams->benchmark_cmd[i]; i++)
> -			new_cmd[i] = uparams->benchmark_cmd[i];
> -		new_cmd[i] = NULL;
> -
> -		ret = asprintf(&span_str, "%zu", span);
> -		if (ret < 0)
> -			return -1;
> -		new_cmd[1] = span_str;
> -		cmd = new_cmd;
> -	}
> +	param.fill_buf.buf_size = span;
> +	param.fill_buf.memflush = 1;
> +	param.fill_buf.operation = 0;
> +	param.fill_buf.once = false;
>  
>  	remove(RESULT_FILE_NAME);
>  
> -	ret = resctrl_val(test, uparams, cmd, &param);
> +	ret = resctrl_val(test, uparams, &param);
>  	if (ret)
> -		goto out;
> +		return ret;
>  
>  	ret = check_results(&param, span, n);
>  	if (ret && (get_vendor() == ARCH_INTEL))
>  		ksft_print_msg("Intel CMT may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
>  
> -out:
> -	free(span_str);
> -
>  	return ret;
>  }
>  
> diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
> index ab8496a4925b..8ad433495f61 100644
> --- a/tools/testing/selftests/resctrl/mba_test.c
> +++ b/tools/testing/selftests/resctrl/mba_test.c
> @@ -174,7 +174,12 @@ static int mba_run_test(const struct resctrl_test *test, const struct user_param
>  
>  	remove(RESULT_FILE_NAME);
>  
> -	ret = resctrl_val(test, uparams, uparams->benchmark_cmd, &param);
> +	param.fill_buf.buf_size = DEFAULT_SPAN;
> +	param.fill_buf.memflush = 1;
> +	param.fill_buf.operation = 0;
> +	param.fill_buf.once = false;
> +
> +	ret = resctrl_val(test, uparams, &param);
>  	if (ret)
>  		return ret;
>  
> diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
> index 6b5a3b52d861..b6883f274c74 100644
> --- a/tools/testing/selftests/resctrl/mbm_test.c
> +++ b/tools/testing/selftests/resctrl/mbm_test.c
> @@ -142,11 +142,16 @@ static int mbm_run_test(const struct resctrl_test *test, const struct user_param
>  
>  	remove(RESULT_FILE_NAME);
>  
> -	ret = resctrl_val(test, uparams, uparams->benchmark_cmd, &param);
> +	param.fill_buf.buf_size = DEFAULT_SPAN;
> +	param.fill_buf.memflush = 1;
> +	param.fill_buf.operation = 0;
> +	param.fill_buf.once = false;
> +
> +	ret = resctrl_val(test, uparams, &param);
>  	if (ret)
>  		return ret;
>  
> -	ret = check_results(DEFAULT_SPAN);
> +	ret = check_results(param.fill_buf.buf_size);
>  	if (ret && (get_vendor() == ARCH_INTEL))
>  		ksft_print_msg("Intel MBM may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
>  
> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> index 0afbc4dd18e4..0e5456165a6a 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -79,6 +79,26 @@ struct resctrl_test {
>  	void		(*cleanup)(void);
>  };
>  
> +/*
> + * fill_buf_param:	"fill_buf" benchmark parameters
> + * @buf_size:		Size (in bytes) of buffer used in benchmark.
> + *			"fill_buf" allocates and initializes buffer of
> + *			@buf_size.
> + * @operation:		If 0, then only read operations are performed on
> + *			the buffer, if 1 then only write operations are
> + *			performed on the buffer.
> + * @memflush:		1 if buffer should be flushed after
> + *			allocation and initialization.
> + * @once:		Benchmark will perform @operation once if true,
> + *			infinitely (until terminated) if false.
> + */
> +struct fill_buf_param {
> +	size_t		buf_size;
> +	int		operation;
> +	int		memflush;
> +	int		once;
> +};
> +
>  /*
>   * resctrl_val_param:	resctrl test parameters
>   * @ctrlgrp:		Name of the control monitor group (con_mon grp)
> @@ -87,21 +107,23 @@ struct resctrl_test {
>   * @init:		Callback function to initialize test environment
>   * @setup:		Callback function to setup per test run environment
>   * @measure:		Callback that performs the measurement (a single test)
> + * @fill_buf:		Parameters for default "fill_buf" benchmark
>   */
>  struct resctrl_val_param {
> -	const char	*ctrlgrp;
> -	const char	*mongrp;
> -	char		filename[64];
> -	unsigned long	mask;
> -	int		num_of_runs;
> -	int		(*init)(const struct resctrl_val_param *param,
> -				int domain_id);
> -	int		(*setup)(const struct resctrl_test *test,
> -				 const struct user_params *uparams,
> -				 struct resctrl_val_param *param);
> -	int		(*measure)(const struct user_params *uparams,
> -				   struct resctrl_val_param *param,
> -				   pid_t bm_pid);
> +	const char		*ctrlgrp;
> +	const char		*mongrp;
> +	char			filename[64];
> +	unsigned long		mask;
> +	int			num_of_runs;
> +	int			(*init)(const struct resctrl_val_param *param,
> +					int domain_id);
> +	int			(*setup)(const struct resctrl_test *test,
> +					 const struct user_params *uparams,
> +					 struct resctrl_val_param *param);
> +	int			(*measure)(const struct user_params *uparams,
> +					   struct resctrl_val_param *param,
> +					   pid_t bm_pid);
> +	struct fill_buf_param	fill_buf;
>  };
>  
>  struct perf_event_read {
> @@ -151,7 +173,6 @@ void initialize_mem_bw_resctrl(const struct resctrl_val_param *param,
>  			       int domain_id);
>  int resctrl_val(const struct resctrl_test *test,
>  		const struct user_params *uparams,
> -		const char * const *benchmark_cmd,
>  		struct resctrl_val_param *param);
>  unsigned long create_bit_mask(unsigned int start, unsigned int len);
>  unsigned int count_contiguous_bits(unsigned long val, unsigned int *start);
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> index ecbb7605a981..ce8fcc769d57 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -162,7 +162,7 @@ int main(int argc, char **argv)
>  	bool test_param_seen = false;
>  	struct user_params uparams;
>  	char *span_str = NULL;
> -	int ret, c, i;
> +	int c, i;
>  
>  	init_user_params(&uparams);
>  
> @@ -257,19 +257,6 @@ int main(int argc, char **argv)
>  
>  	filter_dmesg();
>  
> -	if (!uparams.benchmark_cmd[0]) {
> -		/* If no benchmark is given by "-b" argument, use fill_buf. */
> -		uparams.benchmark_cmd[0] = "fill_buf";
> -		ret = asprintf(&span_str, "%u", DEFAULT_SPAN);
> -		if (ret < 0)
> -			ksft_exit_fail_msg("Out of memory!\n");
> -		uparams.benchmark_cmd[1] = span_str;
> -		uparams.benchmark_cmd[2] = "1";
> -		uparams.benchmark_cmd[3] = "0";
> -		uparams.benchmark_cmd[4] = "false";
> -		uparams.benchmark_cmd[5] = NULL;
> -	}
> -
>  	ksft_set_plan(tests);
>  
>  	for (i = 0; i < ARRAY_SIZE(resctrl_tests); i++)
> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
> index 574b72604f95..9a5a9a67e059 100644
> --- a/tools/testing/selftests/resctrl/resctrl_val.c
> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
> @@ -612,21 +612,17 @@ int measure_mem_bw(const struct user_params *uparams,
>   *			the benchmark
>   * @test:		test information structure
>   * @uparams:		user supplied parameters
> - * @benchmark_cmd:	benchmark command and its arguments
>   * @param:		parameters passed to resctrl_val()
>   *
>   * Return:		0 when the test was run, < 0 on error.
>   */
>  int resctrl_val(const struct resctrl_test *test,
>  		const struct user_params *uparams,
> -		const char * const *benchmark_cmd,
>  		struct resctrl_val_param *param)
>  {
> -	int domain_id, operation = 0, memflush = 1;
> -	size_t span = DEFAULT_SPAN;
>  	unsigned char *buf = NULL;
>  	cpu_set_t old_affinity;
> -	bool once = false;
> +	int domain_id;
>  	int ret = 0;
>  	pid_t ppid;
>  
> @@ -666,21 +662,9 @@ int resctrl_val(const struct resctrl_test *test,
>  	 * how this impacts "write" benchmark, but no test currently
>  	 * uses this.
>  	 */
> -	if (strcmp(benchmark_cmd[0], "fill_buf") == 0) {
> -		span = strtoul(benchmark_cmd[1], NULL, 10);
> -		memflush =  atoi(benchmark_cmd[2]);
> -		operation = atoi(benchmark_cmd[3]);
> -		if (!strcmp(benchmark_cmd[4], "true")) {
> -			once = true;
> -		} else if (!strcmp(benchmark_cmd[4], "false")) {
> -			once = false;
> -		} else {
> -			ksft_print_msg("Invalid once parameter\n");
> -			ret = -EINVAL;
> -			goto reset_affinity;
> -		}
> -
> -		buf = alloc_buffer(span, memflush);
> +	if (!uparams->benchmark_cmd[0]) {
> +		buf = alloc_buffer(param->fill_buf.buf_size,
> +				   param->fill_buf.memflush);
>  		if (!buf) {
>  			ret = -ENOMEM;
>  			goto reset_affinity;
> @@ -699,13 +683,17 @@ int resctrl_val(const struct resctrl_test *test,
>  	 * terminated.
>  	 */
>  	if (bm_pid == 0) {
> -		if (strcmp(benchmark_cmd[0], "fill_buf") == 0) {
> -			if (operation == 0)
> -				fill_cache_read(buf, span, once);
> +		if (!uparams->benchmark_cmd[0]) {
> +			if (param->fill_buf.operation == 0)
> +				fill_cache_read(buf,
> +						param->fill_buf.buf_size,
> +						param->fill_buf.once);
>  			else
> -				fill_cache_write(buf, span, once);
> +				fill_cache_write(buf,
> +						 param->fill_buf.buf_size,
> +						 param->fill_buf.once);
>  		} else {
> -			execvp(benchmark_cmd[0], (char **)benchmark_cmd);
> +			execvp(uparams->benchmark_cmd[0], (char **)uparams->benchmark_cmd);
>  		}
>  		exit(EXIT_SUCCESS);
>  	}
> 

If I didn't miss anything important, this change takes away the ability to
alter fill_buf's parameters using -b option which to me felt the most 
useful way to use that parameter. The current code of course was lacks 
many safeguards for that case but still felt an useful feature.

I suggest that while parsing -b parameter, check if it starts with 
"fill_buf", and if it does, parse the argument into fill_buf_param in 
user_params which will override the default fill_buf parameters.

While parsing, adding new sanity checks wouldn't be a bad idea.

It might be some parameters might be better to be overridden always by the 
tests, e.g. "once" but specifying "operation" (W instead or R) or 
"buf_size" seems okay use cases to me.

-- 
 i.




