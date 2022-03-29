Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F1A4EB0B9
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Mar 2022 17:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237870AbiC2Pft (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Mar 2022 11:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbiC2Pfs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Mar 2022 11:35:48 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D82F3614A
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Mar 2022 08:34:05 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id g21so8206628iom.13
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Mar 2022 08:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7qR3fDUn27oEpIIwllpz0r6x3BaHEzNUBswJgaydd30=;
        b=Xs4ynKIhvp3D1ePFI2vsI4ssLq9kdvadUuhx+61w0ctFKA1xkx2NcV30/RTf+Xf6Zg
         DWmwFNCA+/CfwLTDQgkociwIOsBIYU9VFTHMZCUJSElPfKstdZx2O5wCNkKT7hfyb+eN
         WODxrjNZ6Yrlr042p9ZqwITkMNAvHkhuJ/X4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7qR3fDUn27oEpIIwllpz0r6x3BaHEzNUBswJgaydd30=;
        b=Z63mSY3VlzAIW4iT7MNaJpkxI4UDdfXmr6GEUdzr50s/esXtW4kdVb+ZAMj4Lj6obe
         7/o7q+JIm/LUx5hXLRXhGJSjOBc3EUF/Qn72l2S32DiDF1YW3cBnVskI+0ikwKnsWHzp
         BZFr1Zmv4ewkXPRir9xqT+ejn/fghRCtuV0/bhbdYnAqeul66pGhPad+yVBGiiyG3VaZ
         0+K5MOt9o3diUMOnlhDlc/Sw6XnCc6TYHfBLnXmNBG05xCQBoZOAIO+GMZBR5q28tqUL
         u9BwsA9BHpfHZSjOgI1VMhFF2Mg9gmnGQVLDl1XYaJzb8cY6sU+krgs3DUm06CEy3tAg
         mY/g==
X-Gm-Message-State: AOAM531/q1ZbWENJWhiv7n5rBntnySs/kPtpT00Ev9tIr/bBx4vvj2aB
        EV/1fhJs9ksra2ESfeQbs61V5Q==
X-Google-Smtp-Source: ABdhPJx2AX43o3h+uLCcArpQc0SLggOdgUuSo3WSpuxdG7Aq+zqPu2dleJYlmXJt6pCLFDzzYVKUpw==
X-Received: by 2002:a05:6638:1f3:b0:319:f6cf:339b with SMTP id t19-20020a05663801f300b00319f6cf339bmr15837859jaq.69.1648568044279;
        Tue, 29 Mar 2022 08:34:04 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id y12-20020a056602164c00b00645cdfb42dasm9958465iow.30.2022.03.29.08.34.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 08:34:03 -0700 (PDT)
Subject: Re: [PATCH v5 1/2] selftests/resctrl: Extend CPU vendor detection
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220323080928.1586408-1-tan.shaopeng@jp.fujitsu.com>
 <20220323080928.1586408-2-tan.shaopeng@jp.fujitsu.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <503c663c-1cb1-0a0e-0d0f-eb4a560377c3@linuxfoundation.org>
Date:   Tue, 29 Mar 2022 09:34:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220323080928.1586408-2-tan.shaopeng@jp.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/23/22 2:09 AM, Shaopeng Tan wrote:
> Currently, the resctrl_tests only has a function to detect AMD vendor.
> Since when the Intel Sub-NUMA Clustering feature is enabled,
> Intel CMT and MBM counters may not be accurate,
> the resctrl_tests also need a function to detect Intel vendor.
> And in the future, resctrl_tests will need a function to detect different
> vendors, such as Arm.
> 
> Extend the function to detect Intel vendor as well. Also,
> this function can be easily extended to detect other vendors.
> 
> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
>   tools/testing/selftests/resctrl/cat_test.c    |  2 +-
>   tools/testing/selftests/resctrl/resctrl.h     |  5 ++-
>   .../testing/selftests/resctrl/resctrl_tests.c | 41 ++++++++++++-------
>   tools/testing/selftests/resctrl/resctrlfs.c   |  2 +-
>   4 files changed, 33 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
> index cd4f68388e0f..1c5e90c63254 100644
> --- a/tools/testing/selftests/resctrl/cat_test.c
> +++ b/tools/testing/selftests/resctrl/cat_test.c
> @@ -89,7 +89,7 @@ static int check_results(struct resctrl_val_param *param)
>   
>   	return show_cache_info(sum_llc_perf_miss, no_of_bits, param->span / 64,
>   			       MAX_DIFF, MAX_DIFF_PERCENT, NUM_OF_RUNS,
> -			       !is_amd, false);
> +			       get_vendor() == ARCH_INTEL, false);
>   }
>   
>   void cat_test_cleanup(void)
> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> index 1ad10c47e31d..f0ded31fb3c7 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -34,6 +34,9 @@
>   #define L3_MON_PATH		"/sys/fs/resctrl/info/L3_MON"
>   #define L3_MON_FEATURES_PATH	"/sys/fs/resctrl/info/L3_MON/mon_features"
>   
> +#define ARCH_INTEL     1
> +#define ARCH_AMD       2
> +
>   #define PARENT_EXIT(err_msg)			\
>   	do {					\
>   		perror(err_msg);		\
> @@ -75,8 +78,8 @@ struct resctrl_val_param {
>   extern pid_t bm_pid, ppid;
>   
>   extern char llc_occup_path[1024];
> -extern bool is_amd;
>   
> +int get_vendor(void);
>   bool check_resctrlfs_support(void);
>   int filter_dmesg(void);
>   int remount_resctrlfs(bool mum_resctrlfs);
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> index 973f09a66e1e..3e7cdf1125df 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -13,25 +13,41 @@
>   #define BENCHMARK_ARGS		64
>   #define BENCHMARK_ARG_SIZE	64
>   
> -bool is_amd;
> -
> -void detect_amd(void)
> +static int detect_vendor(void)
>   {
>   	FILE *inf = fopen("/proc/cpuinfo", "r");
> +	int vendor_id = 0;
> +	char *s = NULL;
>   	char *res;
>   
>   	if (!inf)
> -		return;
> +		return vendor_id;
>   
>   	res = fgrep(inf, "vendor_id");
>   
> -	if (res) {
> -		char *s = strchr(res, ':');
> +	if (res)
> +		s = strchr(res, ':');
> +
> +	if (s && !strcmp(s, ": GenuineIntel\n"))
> +		vendor_id = ARCH_INTEL;
> +	else if (s && !strcmp(s, ": AuthenticAMD\n"))
> +		vendor_id = ARCH_AMD;
>   
> -		is_amd = s && !strcmp(s, ": AuthenticAMD\n");
> -		free(res);
> -	}
>   	fclose(inf);
> +	free(res);
> +	return vendor_id;
> +}
> +
> +int get_vendor(void)
> +{
> +	static int vendor = -1;
> +
> +	if (vendor == -1)
> +		vendor = detect_vendor();
> +	if (vendor == 0)
> +		ksft_print_msg("Can not get vendor info...\n");
> +
> +	return vendor;
>   }
>   
>   static void cmd_help(void)
> @@ -207,9 +223,6 @@ int main(int argc, char **argv)
>   	if (geteuid() != 0)
>   		return ksft_exit_fail_msg("Not running as root, abort testing.\n");
>   
> -	/* Detect AMD vendor */
> -	detect_amd();
> -
>   	if (has_ben) {
>   		/* Extract benchmark command from command line. */
>   		for (i = ben_ind; i < argc; i++) {
> @@ -241,10 +254,10 @@ int main(int argc, char **argv)
>   
>   	ksft_set_plan(tests ? : 4);
>   
> -	if (!is_amd && mbm_test)
> +	if ((get_vendor() == ARCH_INTEL) && mbm_test)
>   		run_mbm_test(has_ben, benchmark_cmd, span, cpu_no, bw_report);
>   
> -	if (!is_amd && mba_test)
> +	if ((get_vendor() == ARCH_INTEL) && mba_test)
>   		run_mba_test(has_ben, benchmark_cmd, span, cpu_no, bw_report);
>   
>   	if (cmt_test)
> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
> index 5f5a166ade60..6f543e470ad4 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -106,7 +106,7 @@ int get_resource_id(int cpu_no, int *resource_id)
>   	char phys_pkg_path[1024];
>   	FILE *fp;
>   
> -	if (is_amd)
> +	if (get_vendor() == ARCH_AMD)
>   		sprintf(phys_pkg_path, "%s%d/cache/index3/id",
>   			PHYS_ID_PATH, cpu_no);
>   	else
> 

Looks good to me.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
