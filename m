Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235C3761C3F
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 16:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjGYOtp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 10:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjGYOto (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 10:49:44 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC69E78
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 07:49:40 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id ca18e2360f4ac-785ccd731a7so54183739f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 07:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1690296580; x=1690901380;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=md4TPd4OlBPeQYMPMtk1ELWMMk3Pw2mT0mw754qoGcM=;
        b=bAwuYv3RaGSu3LK7LR1jR5gF9dRQo/xEaEkk+ayCmc0lPeny+q7jn6h1Cfy9NuriE+
         vYP657DaxnMjZ1RIwxIb/osIVMePWYNv95MIR7WxZIyoypy96tFdHgwZuYvJGn37u2hZ
         ndw430hYNyjXMnEkQnBxRfT8CO6JRvoLr6QWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690296580; x=1690901380;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=md4TPd4OlBPeQYMPMtk1ELWMMk3Pw2mT0mw754qoGcM=;
        b=ZB8T+E9DWuQLqzVtU/XurSCNIAiMdz4/nX4KUTuRxbic2/3bOV7A5xV7xBgri7oZAx
         j9/kjfvJ1r2qvkrgRwB9BSPdXy12vUkgzYIYNzYI8ZqbGw9A26AyJGifKMDN3VHYJJNb
         cFonBgnZOwdyeF6R9TzbOmrxG5IGWcdBmduMS2oA2OYlO+ECxAq7em9FR4SdRFFKVp7U
         GVt6fDI40Zhrw4pczy8MU/Oyb7PIpfQRCy4+EN7RhmhiV4GROZMBZuKTiuQXuIo/V6g4
         RG7vxqlDgUsxijw7cMWERGShVB2e6m1hGPLfblWtktCvhs6kwHi2/hWgDneso9DYdS9u
         GexQ==
X-Gm-Message-State: ABy/qLY0uIX1cclpZ7uOITN3JTu6kvEwDbV/k+fdTnK0+StR0Om+p5uC
        FJ8/03wSxSl1J4clYs/Z8z3QRg==
X-Google-Smtp-Source: APBJJlFKkh0O6H8TOqkO+cXezrQTPQ0iHY87o/wRfN0YrnwWLBf5CZRX+f8pwVtglC2GLyO5aLoXww==
X-Received: by 2002:a6b:6903:0:b0:780:d65c:d78f with SMTP id e3-20020a6b6903000000b00780d65cd78fmr10534947ioc.2.1690296580175;
        Tue, 25 Jul 2023 07:49:40 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id x25-20020a029719000000b0042b14d9be7bsm3653031jai.22.2023.07.25.07.49.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 07:49:39 -0700 (PDT)
Message-ID: <7bba4db8-eaac-238d-b764-89d0ae2a9bba@linuxfoundation.org>
Date:   Tue, 25 Jul 2023 08:49:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 12/19] selftests/resctrl: Remove
 "malloc_and_init_memory" param from run_fill_buf()
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230717131507.32420-1-ilpo.jarvinen@linux.intel.com>
 <20230717131507.32420-13-ilpo.jarvinen@linux.intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230717131507.32420-13-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/17/23 07:15, Ilpo Järvinen wrote:
> run_fill_buf()'s malloc_and_init_memory parameter is always 1. There's
> also duplicated memory init code for malloc_and_init_memory == 0 case
> in fill_buf() which is unused.
> 
> Remove the malloc_and_init_memory parameter and the duplicated mem init
> code.
> 
> While at it, fix also a typo in run_fill_buf() prototype's argument.
> 
> Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
>   tools/testing/selftests/resctrl/cache.c       |  6 ++--
>   tools/testing/selftests/resctrl/fill_buf.c    | 28 +++----------------
>   tools/testing/selftests/resctrl/resctrl.h     |  3 +-
>   .../testing/selftests/resctrl/resctrl_tests.c | 13 ++++-----
>   tools/testing/selftests/resctrl/resctrlfs.c   | 12 ++++----
>   5 files changed, 19 insertions(+), 43 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
> index 53df66814cd6..63b551c44f1d 100644
> --- a/tools/testing/selftests/resctrl/cache.c
> +++ b/tools/testing/selftests/resctrl/cache.c
> @@ -210,7 +210,7 @@ int measure_cache_vals(struct resctrl_val_param *param, int bm_pid)
>    */
>   int cat_val(struct resctrl_val_param *param)
>   {
> -	int malloc_and_init_memory = 1, memflush = 1, operation = 0, ret = 0;
> +	int memflush = 1, operation = 0, ret = 0;
>   	char *resctrl_val = param->resctrl_val;
>   	pid_t bm_pid;
>   
> @@ -247,8 +247,8 @@ int cat_val(struct resctrl_val_param *param)
>   			if (ret)
>   				break;
>   
> -			if (run_fill_buf(param->span, malloc_and_init_memory,
> -					 memflush, operation, resctrl_val)) {
> +			if (run_fill_buf(param->span, memflush, operation,
> +					 resctrl_val)) {
>   				fprintf(stderr, "Error-running fill buffer\n");
>   				ret = -1;
>   				goto pe_close;
> diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
> index 785cbd8d0148..d8f5505eb9e6 100644
> --- a/tools/testing/selftests/resctrl/fill_buf.c
> +++ b/tools/testing/selftests/resctrl/fill_buf.c
> @@ -138,36 +138,18 @@ static int fill_cache_write(unsigned char *start_ptr, unsigned char *end_ptr,
>   	return 0;
>   }
>   
> -static int
> -fill_cache(size_t buf_size, int malloc_and_init, int memflush,
> -	   int op, char *resctrl_val)
> +static int fill_cache(size_t buf_size, int memflush, int op, char *resctrl_val)
>   {
>   	unsigned char *start_ptr, *end_ptr;
> -	unsigned long long i;
>   	int ret;
>   
> -	if (malloc_and_init)
> -		start_ptr = malloc_and_init_memory(buf_size);
> -	else
> -		start_ptr = malloc(buf_size);
> -
> +	start_ptr = malloc_and_init_memory(buf_size);
>   	if (!start_ptr)
>   		return -1;
>   
>   	startptr = start_ptr;
>   	end_ptr = start_ptr + buf_size;
>   
> -	/*
> -	 * It's better to touch the memory once to avoid any compiler
> -	 * optimizations
> -	 */
> -	if (!malloc_and_init) {
> -		for (i = 0; i < buf_size; i++)
> -			*start_ptr++ = (unsigned char)rand();
> -	}
> -
> -	start_ptr = startptr;
> -
>   	/* Flush the memory before using to avoid "cache hot pages" effect */
>   	if (memflush)
>   		mem_flush(start_ptr, buf_size);
> @@ -188,14 +170,12 @@ fill_cache(size_t buf_size, int malloc_and_init, int memflush,
>   	return 0;
>   }
>   
> -int run_fill_buf(size_t span, int malloc_and_init_memory, int memflush, int op,
> -		 char *resctrl_val)
> +int run_fill_buf(size_t span, int memflush, int op, char *resctrl_val)
>   {
>   	size_t cache_size = span;
>   	int ret;
>   
> -	ret = fill_cache(cache_size, malloc_and_init_memory, memflush, op,
> -			 resctrl_val);
> +	ret = fill_cache(cache_size, memflush, op, resctrl_val);
>   	if (ret) {
>   		printf("\n Error in fill cache\n");
>   		return -1;
> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> index 52068ceea956..3054cc4ef0e3 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -97,8 +97,7 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
>   			    char *resctrl_val);
>   int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu,
>   		    int group_fd, unsigned long flags);
> -int run_fill_buf(size_t span, int malloc_and_init_memory, int memflush, int op,
> -		 char *resctrl_va);
> +int run_fill_buf(size_t span, int memflush, int op, char *resctrl_val);
>   int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param);
>   int mbm_bw_change(size_t span, int cpu_no, char *bw_report, char **benchmark_cmd);
>   void tests_cleanup(void);
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> index bf0cadab36b0..125ed0ca11e3 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -89,7 +89,7 @@ static void run_mbm_test(bool has_ben, char **benchmark_cmd, size_t span,
>   	}
>   
>   	if (!has_ben)
> -		sprintf(benchmark_cmd[5], "%s", MBA_STR);
> +		sprintf(benchmark_cmd[4], "%s", MBA_STR);
>   	res = mbm_bw_change(span, cpu_no, bw_report, benchmark_cmd);
>   	ksft_test_result(!res, "MBM: bw change\n");
>   	if ((get_vendor() == ARCH_INTEL) && res)
> @@ -141,7 +141,7 @@ static void run_cmt_test(bool has_ben, char **benchmark_cmd, int cpu_no)
>   	}
>   
>   	if (!has_ben)
> -		sprintf(benchmark_cmd[5], "%s", CMT_STR);
> +		sprintf(benchmark_cmd[4], "%s", CMT_STR);
>   	res = cmt_resctrl_val(cpu_no, 5, benchmark_cmd);
>   	ksft_test_result(!res, "CMT: test\n");
>   	if ((get_vendor() == ARCH_INTEL) && res)
> @@ -267,16 +267,15 @@ int main(int argc, char **argv)
>   		benchmark_cmd[ben_count] = NULL;
>   	} else {
>   		/* If no benchmark is given by "-b" argument, use fill_buf. */
> -		for (i = 0; i < 6; i++)
> +		for (i = 0; i < 5; i++)
>   			benchmark_cmd[i] = benchmark_cmd_area[i];
>   
>   		strcpy(benchmark_cmd[0], "fill_buf");
>   		sprintf(benchmark_cmd[1], "%zu", span);
>   		strcpy(benchmark_cmd[2], "1");
> -		strcpy(benchmark_cmd[3], "1");
> -		strcpy(benchmark_cmd[4], "0");
> -		strcpy(benchmark_cmd[5], "");
> -		benchmark_cmd[6] = NULL;
> +		strcpy(benchmark_cmd[3], "0");
> +		strcpy(benchmark_cmd[4], "");
> +		benchmark_cmd[5] = NULL;
>   	}

Lots of copying - can the above be simplified. Also seeing this
warning:

WARNING: Prefer strscpy over strcpy - see: https://github.com/KSPP/linux/issues/88
#233: FILE: tools/testing/selftests/resctrl/resctrl_tests.c:276:
+		strcpy(benchmark_cmd[3], "0");

WARNING: Prefer strscpy over strcpy - see: https://github.com/KSPP/linux/issues/88
#234: FILE: tools/testing/selftests/resctrl/resctrl_tests.c:277:
+		strcpy(benchmark_cmd[4], "");

total: 0 errors, 2 warnings, 142 lines checked

I am applying the patch set to linux-kselftest next - please fix
the aboe and send a patch on top of linux-kselftest next

thanks,
-- Shuah

