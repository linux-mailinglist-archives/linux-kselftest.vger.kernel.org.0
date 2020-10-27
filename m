Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A80F29CAC6
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Oct 2020 21:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439164AbgJ0Uz3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Oct 2020 16:55:29 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:34392 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438826AbgJ0Uz3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Oct 2020 16:55:29 -0400
Received: by mail-il1-f195.google.com with SMTP id v18so2804483ilg.1
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Oct 2020 13:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2slrL7wxKDL6C3qZAIpONFQniDi9xXeWL3B+tXxc7dg=;
        b=ND261IM/rmVihdxvsGd8Ekym5o3J13WDTbfJtM0M9KPYF/HpuESCRYJX2aAwKoq8nP
         8amwJQXYCwhp08MbBe6wGFnCtpP3ryApGu3NEt+8kHkHBnKwV3ebokbPqOAijKht6Wga
         +b2NRZj/ofqyj0vJdqL5N2lVm5SdP+FsbedTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2slrL7wxKDL6C3qZAIpONFQniDi9xXeWL3B+tXxc7dg=;
        b=mnaCDhCZvBAUKmfOx70qYpNircF7ZU8f8Wff7kC/EJ/fT01I4w+CPCA2S1dWN+keRg
         0RHfIphqkJMg2Xe2GXzTQ83Kh/syRf5B+3c1G44H40R6kQkqR6lrjqvly+2sLoUardts
         BUxX8BzRmofXMW482VvuD0WPyHLW7TiArsOgizFU4e71KtgET2fjAS5RYZ3ccyPgF7Y5
         N4Yakjt0vqlhTYK4ukExzOGKHRSwkNS1Z9Gr3TfIeQsMekCjZJRVMINeN/C6NTbEgR3C
         wvOGv7W73VIXjGo1H55t0MofGJCqCkhVec0etNKYtaGSV4aqxeEnnt+bpTHvq71HRcKp
         fk2A==
X-Gm-Message-State: AOAM531zqz0zHDsJufmSvaNZ7arXrpPqFbuua8/qn0YC5P9Hhv8tgJNe
        2Xq6zB6RLc70AmpGD6Ui87mbAQ==
X-Google-Smtp-Source: ABdhPJyYlBvJtZiHG8ojhTaBWV7S0f4xkcuFJEmjHlfEYJJDVtD4GNSMVYr84yKCbLZhIhL5jGhzIg==
X-Received: by 2002:a92:a008:: with SMTP id e8mr3646993ili.83.1603832127643;
        Tue, 27 Oct 2020 13:55:27 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id m15sm1498537ila.32.2020.10.27.13.55.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 13:55:27 -0700 (PDT)
Subject: Re: [PATCH v3 01/21] selftests/resctrl: Rename CQM test as CMT test
To:     Fenghua Yu <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ravi V Shankar <ravi.v.shankar@intel.com>
Cc:     linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20201020235126.1871815-1-fenghua.yu@intel.com>
 <20201020235126.1871815-2-fenghua.yu@intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <d4d6ad8c-5add-f644-db76-4c74a9c4fd9e@linuxfoundation.org>
Date:   Tue, 27 Oct 2020 14:55:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201020235126.1871815-2-fenghua.yu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/20/20 5:51 PM, Fenghua Yu wrote:
> CMT (Cache Monitoring Technology) [1] is a H/W feature that reports cache
> occupancy of a process. resctrl selftest suite has a unit test to test CMT
> for LLC but the test is named as CQM (Cache Quality Monitoring).
> Furthermore, the unit test source file is named as cqm_test.c and several
> functions, variables, comments, preprocessors and statements widely use
> "cqm" as either suffix or prefix. This rampant misusage of CQM for CMT
> might confuse someone who is newly looking at resctrl selftests because
> this feature is named CMT in the Intel Software Developer's Manual.
> 
> Hence, rename all the occurrences (unit test source file name, functions,
> variables, comments and preprocessors) of cqm with cmt.
> 
> [1] Please see Intel SDM, Volume 3, chapter 17 and section 18 for more
>      information on CMT.

Link please?

> 
> Fixes: 78941183d1b1 ("selftests/resctrl: Add Cache QoS Monitoring (CQM) selftest")

Why is this a fix though? Quote the commit in the commit log and
please remove Fixes tag. No need to confuse tools that look for
Fixes tag to select patches for stables.

> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> ---
>   tools/testing/selftests/resctrl/README        |  4 +--
>   tools/testing/selftests/resctrl/cache.c       |  4 +--
>   .../resctrl/{cqm_test.c => cmt_test.c}        | 20 +++++++-------
>   tools/testing/selftests/resctrl/resctrl.h     |  4 +--
>   .../testing/selftests/resctrl/resctrl_tests.c | 26 +++++++++----------
>   tools/testing/selftests/resctrl/resctrl_val.c | 12 ++++-----
>   tools/testing/selftests/resctrl/resctrlfs.c   | 10 +++----
>   7 files changed, 40 insertions(+), 40 deletions(-)
>   rename tools/testing/selftests/resctrl/{cqm_test.c => cmt_test.c} (89%)
> 
> diff --git a/tools/testing/selftests/resctrl/README b/tools/testing/selftests/resctrl/README
> index 6e5a0ffa18e8..4b36b25b6ac0 100644
> --- a/tools/testing/selftests/resctrl/README
> +++ b/tools/testing/selftests/resctrl/README
> @@ -46,8 +46,8 @@ ARGUMENTS
>   Parameter '-h' shows usage information.
>   
>   usage: resctrl_tests [-h] [-b "benchmark_cmd [options]"] [-t test list] [-n no_of_bits]
> -        -b benchmark_cmd [options]: run specified benchmark for MBM, MBA and CQM default benchmark is builtin fill_buf
> -        -t test list: run tests specified in the test list, e.g. -t mbm, mba, cqm, cat
> +        -b benchmark_cmd [options]: run specified benchmark for MBM, MBA and CMT default benchmark is builtin fill_buf
> +        -t test list: run tests specified in the test list, e.g. -t mbm, mba, cmt, cat
>           -n no_of_bits: run cache tests using specified no of bits in cache bit mask
>           -p cpu_no: specify CPU number to run the test. 1 is default
>           -h: help
> diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
> index 38dbf4962e33..4d73edd81293 100644
> --- a/tools/testing/selftests/resctrl/cache.c
> +++ b/tools/testing/selftests/resctrl/cache.c
> @@ -111,7 +111,7 @@ static int get_llc_perf(unsigned long *llc_perf_miss)
>   
>   /*
>    * Get LLC Occupancy as reported by RESCTRL FS
> - * For CQM,
> + * For CMT,
>    * 1. If con_mon grp and mon grp given, then read from mon grp in
>    * con_mon grp
>    * 2. If only con_mon grp given, then read from con_mon grp
> @@ -192,7 +192,7 @@ int measure_cache_vals(struct resctrl_val_param *param, int bm_pid)
>   	/*
>   	 * Measure llc occupancy from resctrl.
>   	 */
> -	if (!strcmp(param->resctrl_val, "cqm")) {
> +	if (!strcmp(param->resctrl_val, "cmt")) {
>   		ret = get_llc_occu_resctrl(&llc_occu_resc);
>   		if (ret < 0)
>   			return ret;
> diff --git a/tools/testing/selftests/resctrl/cqm_test.c b/tools/testing/selftests/resctrl/cmt_test.c
> similarity index 89%
> rename from tools/testing/selftests/resctrl/cqm_test.c
> rename to tools/testing/selftests/resctrl/cmt_test.c
> index c8756152bd61..13b01e010238 100644
> --- a/tools/testing/selftests/resctrl/cqm_test.c
> +++ b/tools/testing/selftests/resctrl/cmt_test.c
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /*
> - * Cache Monitoring Technology (CQM) test
> + * Cache Monitoring Technology (CMT) test
>    *
>    * Copyright (C) 2018 Intel Corporation
>    *
> @@ -11,7 +11,7 @@
>   #include "resctrl.h"
>   #include <unistd.h>
>   
> -#define RESULT_FILE_NAME	"result_cqm"
> +#define RESULT_FILE_NAME	"result_cmt"
>   #define NUM_OF_RUNS		5
>   #define MAX_DIFF		2000000
>   #define MAX_DIFF_PERCENT	15
> @@ -21,7 +21,7 @@ char cbm_mask[256];
>   unsigned long long_mask;
>   unsigned long cache_size;
>   
> -static int cqm_setup(int num, ...)
> +static int cmt_setup(int num, ...)
>   {
>   	struct resctrl_val_param *p;
>   	va_list param;
> @@ -58,7 +58,7 @@ static void show_cache_info(unsigned long sum_llc_occu_resc, int no_of_bits,
>   	else
>   		res = false;
>   
> -	printf("%sok CQM: diff within %d, %d\%%\n", res ? "" : "not",
> +	printf("%sok CMT: diff within %d, %d\%%\n", res ? "" : "not",
>   	       MAX_DIFF, (int)MAX_DIFF_PERCENT);
>   
>   	printf("# diff: %ld\n", avg_diff);
> @@ -106,12 +106,12 @@ static int check_results(struct resctrl_val_param *param, int no_of_bits)
>   	return 0;
>   }
>   
> -void cqm_test_cleanup(void)
> +void cmt_test_cleanup(void)
>   {
>   	remove(RESULT_FILE_NAME);
>   }
>   
> -int cqm_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
> +int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
>   {
>   	int ret, mum_resctrlfs;
>   
> @@ -122,7 +122,7 @@ int cqm_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
>   	if (ret)
>   		return ret;
>   
> -	if (!validate_resctrl_feature_request("cqm"))
> +	if (!validate_resctrl_feature_request("cmt"))
>   		return -1;
>   
>   	ret = get_cbm_mask("L3");
> @@ -145,7 +145,7 @@ int cqm_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
>   	}
>   
>   	struct resctrl_val_param param = {
> -		.resctrl_val	= "cqm",
> +		.resctrl_val	= "cmt",
>   		.ctrlgrp	= "c1",
>   		.mongrp		= "m1",
>   		.cpu_no		= cpu_no,
> @@ -154,7 +154,7 @@ int cqm_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
>   		.mask		= ~(long_mask << n) & long_mask,
>   		.span		= cache_size * n / count_of_bits,
>   		.num_of_runs	= 0,
> -		.setup		= cqm_setup,
> +		.setup		= cmt_setup,
>   	};
>   
>   	if (strcmp(benchmark_cmd[0], "fill_buf") == 0)
> @@ -170,7 +170,7 @@ int cqm_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
>   	if (ret)
>   		return ret;
>   
> -	cqm_test_cleanup();
> +	cmt_test_cleanup();
>   
>   	return 0;
>   }
> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> index 39bf59c6b9c5..68522b19b235 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -98,9 +98,9 @@ void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
>   int cat_val(struct resctrl_val_param *param);
>   void cat_test_cleanup(void);
>   int cat_perf_miss_val(int cpu_no, int no_of_bits, char *cache_type);
> -int cqm_resctrl_val(int cpu_no, int n, char **benchmark_cmd);
> +int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd);
>   unsigned int count_bits(unsigned long n);
> -void cqm_test_cleanup(void);
> +void cmt_test_cleanup(void);
>   int get_core_sibling(int cpu_no);
>   int measure_cache_vals(struct resctrl_val_param *param, int bm_pid);
>   
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> index 425cc85ac883..35a91cab1b88 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -37,10 +37,10 @@ void detect_amd(void)
>   static void cmd_help(void)
>   {
>   	printf("usage: resctrl_tests [-h] [-b \"benchmark_cmd [options]\"] [-t test list] [-n no_of_bits]\n");
> -	printf("\t-b benchmark_cmd [options]: run specified benchmark for MBM, MBA and CQM");
> +	printf("\t-b benchmark_cmd [options]: run specified benchmark for MBM, MBA and CMT");
>   	printf("\t default benchmark is builtin fill_buf\n");
>   	printf("\t-t test list: run tests specified in the test list, ");
> -	printf("e.g. -t mbm, mba, cqm, cat\n");
> +	printf("e.g. -t mbm, mba, cmt, cat\n");
>   	printf("\t-n no_of_bits: run cache tests using specified no of bits in cache bit mask\n");
>   	printf("\t-p cpu_no: specify CPU number to run the test. 1 is default\n");
>   	printf("\t-h: help\n");
> @@ -50,13 +50,13 @@ void tests_cleanup(void)
>   {
>   	mbm_test_cleanup();
>   	mba_test_cleanup();
> -	cqm_test_cleanup();
> +	cmt_test_cleanup();
>   	cat_test_cleanup();
>   }
>   
>   int main(int argc, char **argv)
>   {
> -	bool has_ben = false, mbm_test = true, mba_test = true, cqm_test = true;
> +	bool has_ben = false, mbm_test = true, mba_test = true, cmt_test = true;
>   	int res, c, cpu_no = 1, span = 250, argc_new = argc, i, no_of_bits = 5;
>   	char *benchmark_cmd[BENCHMARK_ARGS], bw_report[64], bm_type[64];
>   	char benchmark_cmd_area[BENCHMARK_ARGS][BENCHMARK_ARG_SIZE];
> @@ -82,15 +82,15 @@ int main(int argc, char **argv)
>   
>   			mbm_test = false;
>   			mba_test = false;
> -			cqm_test = false;
> +			cmt_test = false;
>   			cat_test = false;
>   			while (token) {
>   				if (!strcmp(token, "mbm")) {
>   					mbm_test = true;
>   				} else if (!strcmp(token, "mba")) {
>   					mba_test = true;
> -				} else if (!strcmp(token, "cqm")) {
> -					cqm_test = true;
> +				} else if (!strcmp(token, "cmt")) {
> +					cmt_test = true;
>   				} else if (!strcmp(token, "cat")) {
>   					cat_test = true;

Why not use strncmp() here. Also, this code can be cleaned up.
This is error prone. It appears there is a link to these tokens
and offset in the benchmark_cmd[].

>   				} else {
> @@ -178,13 +178,13 @@ int main(int argc, char **argv)
>   		tests_run++;
>   	}
>   
> -	if (cqm_test) {
> -		printf("# Starting CQM test ...\n");
> +	if (cmt_test) {
> +		printf("# Starting CMT test ...\n");
>   		if (!has_ben)
> -			sprintf(benchmark_cmd[5], "%s", "cqm");
> -		res = cqm_resctrl_val(cpu_no, no_of_bits, benchmark_cmd);
> -		printf("%sok CQM: test\n", res ? "not " : "");
> -		cqm_test_cleanup();
> +			sprintf(benchmark_cmd[5], "%s", "cmt");

Like here. Why not add defines that make it easier to read.

> +		res = cmt_resctrl_val(cpu_no, no_of_bits, benchmark_cmd);
> +		printf("%sok CMT: test\n", res ? "not " : "");
> +		cmt_test_cleanup();
>   		tests_run++;
>   	}
>   
> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
> index 520fea3606d1..270cd95e0026 100644
> --- a/tools/testing/selftests/resctrl/resctrl_val.c
> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
> @@ -492,7 +492,7 @@ static int print_results_bw(char *filename,  int bm_pid, float bw_imc,
>   	return 0;
>   }
>   
> -static void set_cqm_path(const char *ctrlgrp, const char *mongrp, char sock_num)
> +static void set_cmt_path(const char *ctrlgrp, const char *mongrp, char sock_num)
>   {
>   	if (strlen(ctrlgrp) && strlen(mongrp))
>   		sprintf(llc_occup_path,	CON_MON_LCC_OCCUP_PATH,	RESCTRL_PATH,
> @@ -512,7 +512,7 @@ static void set_cqm_path(const char *ctrlgrp, const char *mongrp, char sock_num)
>    * @ctrlgrp:			Name of the control monitor group (con_mon grp)
>    * @mongrp:			Name of the monitor group (mon grp)
>    * @cpu_no:			CPU number that the benchmark PID is binded to
> - * @resctrl_val:		Resctrl feature (Eg: cat, cqm.. etc)
> + * @resctrl_val:		Resctrl feature (Eg: cat, cmt.. etc)
>    */
>   static void initialize_llc_occu_resctrl(const char *ctrlgrp, const char *mongrp,
>   					int cpu_no, char *resctrl_val)
> @@ -524,8 +524,8 @@ static void initialize_llc_occu_resctrl(const char *ctrlgrp, const char *mongrp,
>   		return;
>   	}
>   
> -	if (strcmp(resctrl_val, "cqm") == 0)
> -		set_cqm_path(ctrlgrp, mongrp, resource_id);
> +	if (strcmp(resctrl_val, "cmt") == 0)
> +		set_cmt_path(ctrlgrp, mongrp, resource_id);

Why aren't these strncmp()s. Also these command strings are hard coded
over a over again. Why not add defines for these.

>   }
>   
>   static int
> @@ -682,7 +682,7 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
>   
>   		initialize_mem_bw_resctrl(param->ctrlgrp, param->mongrp,
>   					  param->cpu_no, resctrl_val);
> -	} else if (strcmp(resctrl_val, "cqm") == 0)
> +	} else if (strcmp(resctrl_val, "cmt") == 0)
>   		initialize_llc_occu_resctrl(param->ctrlgrp, param->mongrp,
>   					    param->cpu_no, resctrl_val);
>   
> @@ -721,7 +721,7 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
>   			ret = measure_vals(param, &bw_resc_start);
>   			if (ret)
>   				break;
> -		} else if (strcmp(resctrl_val, "cqm") == 0) {
> +		} else if (strcmp(resctrl_val, "cmt") == 0) {
>   			ret = param->setup(1, param);
>   			if (ret) {
>   				ret = 0;
> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
> index 19c0ec4045a4..727e667e2cc9 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -334,7 +334,7 @@ void run_benchmark(int signum, siginfo_t *info, void *ucontext)
>   		operation = atoi(benchmark_cmd[4]);
>   		sprintf(resctrl_val, "%s", benchmark_cmd[5]);
>   
> -		if (strcmp(resctrl_val, "cqm") != 0)
> +		if (strcmp(resctrl_val, "cmt") != 0)
>   			buffer_span = span * MB;
>   		else
>   			buffer_span = span;
> @@ -458,8 +458,8 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
>   	if (ret)
>   		goto out;
>   
> -	/* Create mon grp and write pid into it for "mbm" and "cqm" test */
> -	if ((strcmp(resctrl_val, "cqm") == 0) ||
> +	/* Create mon grp and write pid into it for "mbm" and "cmt" test */
> +	if ((strcmp(resctrl_val, "cmt") == 0) ||
>   	    (strcmp(resctrl_val, "mbm") == 0)) {
>   		if (strlen(mongrp)) {
>   			sprintf(monitorgroup_p, "%s/mon_groups", controlgroup);
> @@ -507,7 +507,7 @@ int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
>   
>   	if ((strcmp(resctrl_val, "mba") != 0) &&
>   	    (strcmp(resctrl_val, "cat") != 0) &&
> -	    (strcmp(resctrl_val, "cqm") != 0))
> +	    (strcmp(resctrl_val, "cmt") != 0))
>   		return -ENOENT;
>   
>   	if (!schemata) {
> @@ -528,7 +528,7 @@ int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
>   	else
>   		sprintf(controlgroup, "%s/schemata", RESCTRL_PATH);
>   
> -	if (!strcmp(resctrl_val, "cat") || !strcmp(resctrl_val, "cqm"))
> +	if (!strcmp(resctrl_val, "cat") || !strcmp(resctrl_val, "cmt"))
>   		sprintf(schema, "%s%d%c%s", "L3:", resource_id, '=', schemata);
>   	if (strcmp(resctrl_val, "mba") == 0)
>   		sprintf(schema, "%s%d%c%s", "MB:", resource_id, '=', schemata);
> 

Let's clean this test up.
thanks,
-- Shuah
