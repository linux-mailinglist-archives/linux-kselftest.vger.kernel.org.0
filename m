Return-Path: <linux-kselftest+bounces-20120-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B869A3960
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 11:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7375E284A92
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 09:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AEA190054;
	Fri, 18 Oct 2024 09:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LKw6eYbs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C278418FDC8;
	Fri, 18 Oct 2024 09:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729242225; cv=none; b=Ea08NGUn70F229WPJw+MN2KryuMdF1QwSeL6w80PXteaMVzYN4qjR7yVK4DZHJxRAWejySc28XLG4ja12IaGnnuFUJMVFzbWmWlkwvsq+jOIR4NCcuJARw81cAKre3Z5y8qiKqWkZgvavNVzlgYrjAiLP0/TryHMcKqATfT7Hms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729242225; c=relaxed/simple;
	bh=4qPvqCT4SMMJPksZFS6OUPQUP8KstJG6f0k5WTRepZs=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LQjHV+4RoUzkF9eSIYAnzejv1kEamI2muvhqUOLvqbAb7FuVnaElIH0GS9yBhMJvE4gU608YJQjF4WVuI/+c73oeBmfrrmlJqsJh/bnkTFLs6eJyNig8j4oLFHO1tyf5kdimGCNC19uWhLbup4tM2Rv6NkpvF+Ll7TdIgxUt/NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LKw6eYbs; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729242223; x=1760778223;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=4qPvqCT4SMMJPksZFS6OUPQUP8KstJG6f0k5WTRepZs=;
  b=LKw6eYbsXY6iWSPh838RZJ4jbUvJHSe2XZLVCsnJb0WVMZAYuv2zhiuU
   9hxz/cLZvc6nD5W7kAlVhFYQU3lNbNtOzUXWtSRJv3hqb0XIfm4pXZTgh
   GMaBoTndpNZ+iGPhw8AkBXrcEUShbjifoPYWY6nzSvT2QLENJGg8uL6d3
   Id1N0i3ps1djvFEMb1QcwAc31QungNiBEAPmQQ8Z3wyg1+Jt4P14IjM/Z
   HVeNj1gMAfzW1VsU1J3UaSaphWrpfpctg0XdZykO6AyCQLrA8WVHOCdVb
   2smclFmaziUrg8hmid3ilO50Xqpo+sWo5UgZlUwM6T/D5UFvrqrurX5rO
   w==;
X-CSE-ConnectionGUID: KRnAEx4tRWC07TtlUGhS7w==
X-CSE-MsgGUID: olLorQ0zSgOOTLGVSGvAoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="28901227"
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="28901227"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 02:03:42 -0700
X-CSE-ConnectionGUID: SNjgkgxqQb6smJ8ljtEswg==
X-CSE-MsgGUID: HBgsDRnoS+GpB/xESUR0JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="83885540"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.217])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 02:03:38 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 18 Oct 2024 12:03:29 +0300 (EEST)
To: Reinette Chatre <reinette.chatre@intel.com>
cc: fenghua.yu@intel.com, shuah@kernel.org, tony.luck@intel.com, 
    peternewman@google.com, babu.moger@amd.com, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3 10/15] selftests/resctrl: Make benchmark parameter
 passing robust
In-Reply-To: <ae8f92a2de3cf509aa9ffebe3d08019999318dc1.1729218182.git.reinette.chatre@intel.com>
Message-ID: <63a2f1e4-2934-6d02-4621-2d224b9981cb@linux.intel.com>
References: <cover.1729218182.git.reinette.chatre@intel.com> <ae8f92a2de3cf509aa9ffebe3d08019999318dc1.1729218182.git.reinette.chatre@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 17 Oct 2024, Reinette Chatre wrote:

> The benchmark used during the CMT, MBM, and MBA tests can be provided by
> the user via (-b) parameter, if not provided the default "fill_buf"
> benchmark is used. The user is additionally able to override
> any of the "fill_buf" default parameters when running the tests with
> "-b fill_buf <fill_buf parameters>".
> 
> The "fill_buf" parameters are managed as an array of strings. Using an
> array of strings is complex because it requires transformations to/from
> strings at every producer and consumer. This is made worse for the
> individual tests where the default benchmark parameters values may not
> be appropriate and additional data wrangling is required. For example,
> the CMT test duplicates the entire array of strings in order to replace
> one of the parameters.
> 
> More issues appear when combining the usage of an array of strings with
> the use case of user overriding default parameters by specifying
> "-b fill_buf <parameters>". This use case is fragile with opportunities
> to trigger a SIGSEGV because of opportunities for NULL pointers to exist
> in the array of strings. For example, by running below (thus by specifying
> "fill_buf" should be used but all parameters are NULL):
> 	$ sudo resctrl_tests -t mbm -b fill_buf
> 
> Replace the "array of strings" parameters used for "fill_buf" with
> new struct fill_buf_param that contains the "fill_buf" parameters that
> can be used directly without transformations to/from strings. Two
> instances of struct fill_buf_param may exist at any point in time:
> 	* If the user provides new parameters to "fill_buf", the
> 	  user parameter structure (struct user_params) will point to a
> 	  fully initialized and immutable struct fill_buf_param
> 	  containing the user provided parameters.
> 	* If "fill_buf" is the benchmark that should be used by a test,
> 	  then the test parameter structure (struct resctrl_val_param)
> 	  will point to a fully initialized struct fill_buf_param. The
> 	  latter may contain (a) the user provided parameters verbatim,
> 	  (b) user provided parameters adjusted to be appropriate for
> 	  the test, or (c) the default parameters for "fill_buf" that
> 	  is appropriate for the test if the user did not provide
> 	  "fill_buf" parameters nor an alternate benchmark.
> 
> The existing behavior of CMT test is to use test defined value for the
> buffer size even if the user provides another value via command line.
> This behavior is maintained since the test requires that the buffer size
> matches the size of the cache allocated, and the amount of cache
> allocated can instead be changed by the user with the "-n" command line
> parameter.
> 
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
> Changes since V2:
> - Use empty initializers. (Ilpo)
> - Let memflush be bool instead of int. (Ilpo)
> - Make user input checks more robust. (Ilpo)
> - Assign values as part of local variable definition. (Ilpo)
> 
> Changes since V1:
> - Maintain original behavior where user can override "fill_buf"
>   parameters via command line ... but only those that can actually
>   be changed. (Ilpo)
> - Fix parsing issues associated with original behavior to ensure
>   any parameter is valid before any attempt to use it.
> - Move patch earlier in series to highlight that this fixes existing
>   issues.
> - Make struct fill_buf_param dynamic to support user provided
>   parameters as well as test specific parameters.
> - Rewrite changelog.
> ---
>  tools/testing/selftests/resctrl/cmt_test.c    |  32 ++----
>  tools/testing/selftests/resctrl/fill_buf.c    |   4 +-
>  tools/testing/selftests/resctrl/mba_test.c    |  13 ++-
>  tools/testing/selftests/resctrl/mbm_test.c    |  22 ++--
>  tools/testing/selftests/resctrl/resctrl.h     |  59 +++++++---
>  .../testing/selftests/resctrl/resctrl_tests.c | 103 ++++++++++++++----
>  tools/testing/selftests/resctrl/resctrl_val.c |  41 ++++---
>  7 files changed, 178 insertions(+), 96 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
> index 0c045080d808..4c3cf2c25a38 100644
> --- a/tools/testing/selftests/resctrl/cmt_test.c
> +++ b/tools/testing/selftests/resctrl/cmt_test.c
> @@ -116,15 +116,13 @@ static void cmt_test_cleanup(void)
>  
>  static int cmt_run_test(const struct resctrl_test *test, const struct user_params *uparams)
>  {
> -	const char * const *cmd = uparams->benchmark_cmd;
> -	const char *new_cmd[BENCHMARK_ARGS];
> +	struct fill_buf_param fill_buf = {};
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
> @@ -155,32 +153,26 @@ static int cmt_run_test(const struct resctrl_test *test, const struct user_param
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
> +	if (uparams->fill_buf) {
> +		fill_buf.buf_size = span;
> +		fill_buf.memflush = uparams->fill_buf->memflush;
> +		param.fill_buf = &fill_buf;
> +	} else if (!uparams->benchmark_cmd[0]) {
> +		fill_buf.buf_size = span;
> +		fill_buf.memflush = true;
> +		param.fill_buf = &fill_buf;
>  	}
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
> diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
> index e4f1cea317f1..39545f9369e8 100644
> --- a/tools/testing/selftests/resctrl/fill_buf.c
> +++ b/tools/testing/selftests/resctrl/fill_buf.c
> @@ -102,7 +102,7 @@ void fill_cache_read(unsigned char *buf, size_t buf_size, bool once)
>  	*value_sink = ret;
>  }
>  
> -unsigned char *alloc_buffer(size_t buf_size, int memflush)
> +unsigned char *alloc_buffer(size_t buf_size, bool memflush)
>  {
>  	void *buf = NULL;
>  	uint64_t *p64;
> @@ -130,7 +130,7 @@ unsigned char *alloc_buffer(size_t buf_size, int memflush)
>  	return buf;
>  }
>  
> -int run_fill_buf(size_t buf_size, int memflush)
> +int run_fill_buf(size_t buf_size, bool memflush)
>  {
>  	unsigned char *buf;
>  
> diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
> index be0ead73e55d..74d95c460bd0 100644
> --- a/tools/testing/selftests/resctrl/mba_test.c
> +++ b/tools/testing/selftests/resctrl/mba_test.c
> @@ -172,11 +172,22 @@ static int mba_run_test(const struct resctrl_test *test, const struct user_param
>  		.setup		= mba_setup,
>  		.measure	= mba_measure,
>  	};
> +	struct fill_buf_param fill_buf = {};
>  	int ret;
>  
>  	remove(RESULT_FILE_NAME);
>  
> -	ret = resctrl_val(test, uparams, uparams->benchmark_cmd, &param);
> +	if (uparams->fill_buf) {
> +		fill_buf.buf_size = uparams->fill_buf->buf_size;
> +		fill_buf.memflush = uparams->fill_buf->memflush;
> +		param.fill_buf = &fill_buf;
> +	} else if (!uparams->benchmark_cmd[0]) {
> +		fill_buf.buf_size = DEFAULT_SPAN;
> +		fill_buf.memflush = true;
> +		param.fill_buf = &fill_buf;
> +	}
> +
> +	ret = resctrl_val(test, uparams, &param);
>  	if (ret)
>  		return ret;
>  
> diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
> index f516a2da1163..72261413c868 100644
> --- a/tools/testing/selftests/resctrl/mbm_test.c
> +++ b/tools/testing/selftests/resctrl/mbm_test.c
> @@ -139,26 +139,26 @@ static int mbm_run_test(const struct resctrl_test *test, const struct user_param
>  		.setup		= mbm_setup,
>  		.measure	= mbm_measure,
>  	};
> -	char *endptr = NULL;
> -	size_t span = 0;
> +	struct fill_buf_param fill_buf = {};
>  	int ret;
>  
>  	remove(RESULT_FILE_NAME);
>  
> -	if (uparams->benchmark_cmd[0] && strcmp(uparams->benchmark_cmd[0], "fill_buf") == 0) {
> -		if (uparams->benchmark_cmd[1]) {
> -			errno = 0;
> -			span = strtoul(uparams->benchmark_cmd[1], &endptr, 10);
> -			if (errno || *endptr != '\0')
> -				return -errno;
> -		}
> +	if (uparams->fill_buf) {
> +		fill_buf.buf_size = uparams->fill_buf->buf_size;
> +		fill_buf.memflush = uparams->fill_buf->memflush;
> +		param.fill_buf = &fill_buf;
> +	} else if (!uparams->benchmark_cmd[0]) {
> +		fill_buf.buf_size = DEFAULT_SPAN;
> +		fill_buf.memflush = true;
> +		param.fill_buf = &fill_buf;
>  	}
>  
> -	ret = resctrl_val(test, uparams, uparams->benchmark_cmd, &param);
> +	ret = resctrl_val(test, uparams, &param);
>  	if (ret)
>  		return ret;
>  
> -	ret = check_results(span);
> +	ret = check_results(param.fill_buf ? param.fill_buf->buf_size : 0);
>  	if (ret && (get_vendor() == ARCH_INTEL))
>  		ksft_print_msg("Intel MBM may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
>  
> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> index 82801245e4c1..c9336f9c2cae 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -43,16 +43,36 @@
>  
>  #define DEFAULT_SPAN		(250 * MB)
>  
> +/*
> + * fill_buf_param:	"fill_buf" benchmark parameters
> + * @buf_size:		Size (in bytes) of buffer used in benchmark.
> + *			"fill_buf" allocates and initializes buffer of
> + *			@buf_size. User can change value via command line.
> + * @memflush:		If false the buffer will not be flushed after
> + *			allocation and initialization, otherwise the
> + *			buffer will be flushed. User can change value via
> + *			command line (via integers with 0 interpreted as
> + *			false and anything else as true).
> + */
> +struct fill_buf_param {
> +	size_t		buf_size;
> +	bool		memflush;
> +};
> +
>  /*
>   * user_params:		User supplied parameters
>   * @cpu:		CPU number to which the benchmark will be bound to
>   * @bits:		Number of bits used for cache allocation size
>   * @benchmark_cmd:	Benchmark command to run during (some of the) tests
> + * @fill_buf:		Pointer to user provided parameters for "fill_buf",
> + *			NULL if user did not provide parameters and test
> + *			specific defaults should be used.
>   */
>  struct user_params {
>  	int cpu;
>  	int bits;
>  	const char *benchmark_cmd[BENCHMARK_ARGS];
> +	const struct fill_buf_param *fill_buf;
>  };
>  
>  /*
> @@ -87,21 +107,29 @@ struct resctrl_test {
>   * @init:		Callback function to initialize test environment
>   * @setup:		Callback function to setup per test run environment
>   * @measure:		Callback that performs the measurement (a single test)
> + * @fill_buf:		Parameters for default "fill_buf" benchmark.
> + *			Initialized with user provided parameters, possibly
> + *			adapted to be relevant to the test. If user does
> + *			not provide parameters for "fill_buf" nor a
> + *			replacement benchmark then initialized with defaults
> + *			appropriate for test. NULL if user provided
> + *			benchmark.
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
> +	struct fill_buf_param	*fill_buf;
>  };
>  
>  struct perf_event_read {
> @@ -138,10 +166,10 @@ int write_schemata(const char *ctrlgrp, char *schemata, int cpu_no,
>  int write_bm_pid_to_resctrl(pid_t bm_pid, const char *ctrlgrp, const char *mongrp);
>  int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu,
>  		    int group_fd, unsigned long flags);
> -unsigned char *alloc_buffer(size_t buf_size, int memflush);
> +unsigned char *alloc_buffer(size_t buf_size, bool memflush);
>  void mem_flush(unsigned char *buf, size_t buf_size);
>  void fill_cache_read(unsigned char *buf, size_t buf_size, bool once);
> -int run_fill_buf(size_t buf_size, int memflush);
> +int run_fill_buf(size_t buf_size, bool memflush);
>  int initialize_read_mem_bw_imc(void);
>  int measure_read_mem_bw(const struct user_params *uparams,
>  			struct resctrl_val_param *param, pid_t bm_pid);
> @@ -149,7 +177,6 @@ void initialize_mem_bw_resctrl(const struct resctrl_val_param *param,
>  			       int domain_id);
>  int resctrl_val(const struct resctrl_test *test,
>  		const struct user_params *uparams,
> -		const char * const *benchmark_cmd,
>  		struct resctrl_val_param *param);
>  unsigned long create_bit_mask(unsigned int start, unsigned int len);
>  unsigned int count_contiguous_bits(unsigned long val, unsigned int *start);
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> index 0f91c475b255..88768f4d4961 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -148,6 +148,78 @@ static void run_single_test(const struct resctrl_test *test, const struct user_p
>  	test_cleanup(test);
>  }
>  
> +/*
> + * Allocate and initialize a struct fill_buf_param with user provided
> + * (via "-b fill_buf <fill_buf parameters>") parameters.
> + *
> + * Use defaults (that may not be appropriate for all tests) for any
> + * fill_buf parameters omitted by the user.
> + *
> + * Historically it may have been possible for user space to provide
> + * additional parameters, "operation" ("read" vs "write") in
> + * benchmark_cmd[3] and "once" (run "once" or until terminated) in
> + * benchmark_cmd[4]. Changing these parameters have never been
> + * supported with the default of "read" operation and running until
> + * terminated built into the tests. Any unsupported values for
> + * (original) "fill_buf" parameters are treated as failure.
> + *
> + * Return: On failure, forcibly exits the test on any parsing failure,
> + *         returns NULL if no parsing needed (user did not actually provide
> + *         "-b fill_buf").
> + *         On success, returns pointer to newly allocated and fully
> + *         initialized struct fill_buf_param that caller must free.
> + */
> +static struct fill_buf_param *alloc_fill_buf_param(struct user_params *uparams)
> +{
> +	struct fill_buf_param *fill_param = NULL;
> +	char *endptr = NULL;
> +
> +	if (!uparams->benchmark_cmd[0] || strcmp(uparams->benchmark_cmd[0], "fill_buf"))
> +		return NULL;
> +
> +	fill_param = malloc(sizeof(*fill_param));
> +	if (!fill_param)
> +		ksft_exit_skip("Unable to allocate memory for fill_buf parameters.\n");
> +
> +	if (uparams->benchmark_cmd[1]) {
> +		errno = 0;
> +		fill_param->buf_size = strtoul(uparams->benchmark_cmd[1], &endptr, 10);
> +		if (errno || *endptr != '\0') {

Same here as with the patch 2 (and also in the checks below), both empty 
string and extra character checks are necessary.

> +			free(fill_param);
> +			ksft_exit_skip("Unable to parse benchmark buffer size.\n");
> +		}
> +	} else {
> +		fill_param->buf_size = DEFAULT_SPAN;
> +	}
> +
> +	if (uparams->benchmark_cmd[2]) {
> +		errno = 0;
> +		fill_param->memflush = strtol(uparams->benchmark_cmd[2], &endptr, 10) != 0;
> +		if (errno || *endptr != '\0') {
> +			free(fill_param);
> +			ksft_exit_skip("Unable to parse benchmark memflush parameter.\n");
> +		}
> +	} else {
> +		fill_param->memflush = true;
> +	}
> +
> +	if (uparams->benchmark_cmd[3]) {
> +		if (strcmp(uparams->benchmark_cmd[3], "0")) {
> +			free(fill_param);
> +			ksft_exit_skip("Only read operations supported.\n");
> +		}
> +	}
> +
> +	if (uparams->benchmark_cmd[4]) {
> +		if (strcmp(uparams->benchmark_cmd[4], "false")) {
> +			free(fill_param);
> +			ksft_exit_skip("fill_buf is required to run until termination.\n");
> +		}
> +	}
> +
> +	return fill_param;
> +}

-- 
 i.


> +
>  static void init_user_params(struct user_params *uparams)
>  {
>  	memset(uparams, 0, sizeof(*uparams));
> @@ -158,11 +230,11 @@ static void init_user_params(struct user_params *uparams)
>  
>  int main(int argc, char **argv)
>  {
> +	struct fill_buf_param *fill_param = NULL;
>  	int tests = ARRAY_SIZE(resctrl_tests);
>  	bool test_param_seen = false;
>  	struct user_params uparams;
> -	char *span_str = NULL;
> -	int ret, c, i;
> +	int c, i;
>  
>  	init_user_params(&uparams);
>  
> @@ -239,6 +311,10 @@ int main(int argc, char **argv)
>  	}
>  last_arg:
>  
> +	fill_param = alloc_fill_buf_param(&uparams);
> +	if (fill_param)
> +		uparams.fill_buf = fill_param;
> +
>  	ksft_print_header();
>  
>  	/*
> @@ -257,32 +333,11 @@ int main(int argc, char **argv)
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
> -		/*
> -		 * Third parameter was previously used for "operation"
> -		 * (read/write) of which only (now default) "read"/"0"
> -		 * works.
> -		 * Fourth parameter was previously used to indicate
> -		 * how long "fill_buf" should run for, with "false"
> -		 * ("fill_buf" will keep running until terminated)
> -		 * the only option that works.
> -		 */
> -		uparams.benchmark_cmd[3] = NULL;
> -		uparams.benchmark_cmd[4] = NULL;
> -	}
> -
>  	ksft_set_plan(tests);
>  
>  	for (i = 0; i < ARRAY_SIZE(resctrl_tests); i++)
>  		run_single_test(resctrl_tests[i], &uparams);
>  
> -	free(span_str);
> +	free(fill_param);
>  	ksft_finished();
>  }
> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
> index c4ebf70a46ef..00b3808d3bca 100644
> --- a/tools/testing/selftests/resctrl/resctrl_val.c
> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
> @@ -535,6 +535,11 @@ int measure_read_mem_bw(const struct user_params *uparams,
>  	return ret;
>  }
>  
> +struct benchmark_info {
> +	const struct user_params *uparams;
> +	struct resctrl_val_param *param;
> +};
> +
>  /*
>   * run_benchmark - Run a specified benchmark or fill_buf (default benchmark)
>   *		   in specified signal. Direct benchmark stdio to /dev/null.
> @@ -544,12 +549,11 @@ int measure_read_mem_bw(const struct user_params *uparams,
>   */
>  static void run_benchmark(int signum, siginfo_t *info, void *ucontext)
>  {
> -	char **benchmark_cmd;
> -	int ret, memflush;
> -	size_t span;
> +	struct benchmark_info *benchmark_info = info->si_ptr;
> +	const struct user_params *uparams = benchmark_info->uparams;
> +	struct resctrl_val_param *param = benchmark_info->param;
>  	FILE *fp;
> -
> -	benchmark_cmd = info->si_ptr;
> +	int ret;
>  
>  	/*
>  	 * Direct stdio of child to /dev/null, so that only parent writes to
> @@ -561,16 +565,13 @@ static void run_benchmark(int signum, siginfo_t *info, void *ucontext)
>  		parent_exit(ppid);
>  	}
>  
> -	if (strcmp(benchmark_cmd[0], "fill_buf") == 0) {
> -		/* Execute default fill_buf benchmark */
> -		span = strtoul(benchmark_cmd[1], NULL, 10);
> -		memflush =  atoi(benchmark_cmd[2]);
> -
> -		if (run_fill_buf(span, memflush))
> +	if (param->fill_buf) {
> +		if (run_fill_buf(param->fill_buf->buf_size,
> +				 param->fill_buf->memflush))
>  			fprintf(stderr, "Error in running fill buffer\n");
> -	} else {
> +	} else if (uparams->benchmark_cmd[0]) {
>  		/* Execute specified benchmark */
> -		ret = execvp(benchmark_cmd[0], benchmark_cmd);
> +		ret = execvp(uparams->benchmark_cmd[0], (char **)uparams->benchmark_cmd);
>  		if (ret)
>  			ksft_perror("execvp");
>  	}
> @@ -585,16 +586,15 @@ static void run_benchmark(int signum, siginfo_t *info, void *ucontext)
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
> +	struct benchmark_info benchmark_info;
>  	struct sigaction sigact;
>  	int ret = 0, pipefd[2];
>  	char pipe_message = 0;
> @@ -610,6 +610,9 @@ int resctrl_val(const struct resctrl_test *test,
>  		return ret;
>  	}
>  
> +	benchmark_info.uparams = uparams;
> +	benchmark_info.param = param;
> +
>  	/*
>  	 * If benchmark wasn't successfully started by child, then child should
>  	 * kill parent, so save parent's pid
> @@ -671,13 +674,7 @@ int resctrl_val(const struct resctrl_test *test,
>  
>  	ksft_print_msg("Benchmark PID: %d\n", (int)bm_pid);
>  
> -	/*
> -	 * The cast removes constness but nothing mutates benchmark_cmd within
> -	 * the context of this process. At the receiving process, it becomes
> -	 * argv, which is mutable, on exec() but that's after fork() so it
> -	 * doesn't matter for the process running the tests.
> -	 */
> -	value.sival_ptr = (void *)benchmark_cmd;
> +	value.sival_ptr = (void *)&benchmark_info;
>  
>  	/* Taskset benchmark to specified cpu */
>  	ret = taskset_benchmark(bm_pid, uparams->cpu, NULL);
> 

