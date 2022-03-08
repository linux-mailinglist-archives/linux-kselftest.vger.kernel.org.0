Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19DFC4D2368
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Mar 2022 22:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350396AbiCHVjW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Mar 2022 16:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbiCHVjW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Mar 2022 16:39:22 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB6336B74
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Mar 2022 13:38:24 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id q11so608715iod.6
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Mar 2022 13:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iiqBcIu6f71RMtOoo4wLPDFgYhHNPzl3jFLGPGUCerE=;
        b=HZ0QA3I99qa4FgdUpKr0K+9re9GuvvY3hc0kK3hgHHrPLvPvBRJgcyUaw8pmmBBHB5
         u3oGXiTQPJCIcS6OWMqlnVynjmzj+jYZ5STy/LIi9O6jk2qfI8Bg7F6aniLJ/x53/TOX
         9sQJXgzoiYAkA+zbL9SJ0ky/wCw8oNf+2KS+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iiqBcIu6f71RMtOoo4wLPDFgYhHNPzl3jFLGPGUCerE=;
        b=aZSXJ5mCqrJXxmbTrVRccGVICF2EXVFz6M/6+5wk8mXqLc2seFo3U732L7STQ2XCEl
         OrhXm0RPzsdnlJT73A4wPU5PkoHxRr0V5KFOReCfessw4FfTlRg79MS+uuw8lxTUaSqK
         Wb4LSwhkUrK58vh+NVmII+c76LWTCaj58vnbegTGqKjOo/T3s/JEPh0WfV0OBbAxUpHB
         7kNAI7+jWjktzoDiOAUTDt38Yh42V00jdgREmte+3BeHaW9j2SFuEbwgXsZvP/zRJvxd
         eg6CXmKHBkaFAuFUFERcxKa6AEKfWw9avz3VNGrovt1tc6KhmHjfveu78wKGvSa//XFF
         Ywiw==
X-Gm-Message-State: AOAM531yLpArje4ON6eWhOVLc7zeQzbIiDpw0n0ebRQNeSAgQGdKqPMn
        Cm28fJpj0NgX5wp2s+6Kg7C9+g==
X-Google-Smtp-Source: ABdhPJzh4r8PfgNaHjo26ftKeFXvz6W7YYH43AxdoRzfWEpPiHMylu/cULgdT4E1njyB1tgDCKeTzw==
X-Received: by 2002:a05:6638:349f:b0:318:c543:ae1a with SMTP id t31-20020a056638349f00b00318c543ae1amr1956275jal.26.1646775503920;
        Tue, 08 Mar 2022 13:38:23 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id p22-20020a5d8d16000000b006115627b87csm8268ioj.55.2022.03.08.13.38.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 13:38:23 -0800 (PST)
Subject: Re: [PATCH v3] selftests/resctrl: Print a message if the result of
 MBM&CMT tests is failed on Intel cpu
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220304103957.487660-1-tan.shaopeng@jp.fujitsu.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <9647f7ed-6a02-8603-0de4-3292d4d13157@linuxfoundation.org>
Date:   Tue, 8 Mar 2022 14:38:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220304103957.487660-1-tan.shaopeng@jp.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/4/22 3:39 AM, Shaopeng Tan wrote:
> According to "Intel Resource Director Technology (Intel RDT) on
> 2nd Generation Intel Xeon Scalable Processors Reference Manual",
> When the Intel Sub-NUMA Clustering(SNC) feature is enabled,
> Intel CMT and MBM counters may not be accurate.
> 
> However, there does not seem to be an architectural way to detect
> if SNC is enabled.
> 
> If the result of MBM&CMT test fails on Intel CPU,
> print a message to let users know a possible cause of failure.
> 
> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
> Hello,
> 
> In PATCH V2, I tried to detect whether SNC is enabled by NUMA info and
> cpuinfo(socket_num), but it is not reliable and no future-proof.
> 
> I just print a message to let users know a possible cause of "not ok",
> When CMT or MBM test runs on Intel CPU, and the result is "not ok".
> 
> This patch is based on v5.16.

Also need to be rebased on mainline latest

> 
>   tools/testing/selftests/resctrl/resctrl_tests.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> index 973f09a66e1e..ec2bdce7b85f 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -14,8 +14,9 @@
>   #define BENCHMARK_ARG_SIZE	64
>   
>   bool is_amd;
> +bool is_intel;
>   

Why is this a global? I am not seeing a reason. These detect_*()s
could be moved to resctrl.h and get rid of globals.

Instead of adding intel check to detect_amd() add detect_intel()
or is_intel() and have ut return true of it detects intel.


> -void detect_amd(void)
> +void detect_vendor(void)
>   {
>   	FILE *inf = fopen("/proc/cpuinfo", "r");
>   	char *res;
> @@ -29,6 +30,7 @@ void detect_amd(void)
>   		char *s = strchr(res, ':');
>   
>   		is_amd = s && !strcmp(s, ": AuthenticAMD\n");
> +		is_intel = s && !strcmp(s, ": GenuineIntel\n");
>   		free(res);
>   	}
>   	fclose(inf);
> @@ -70,6 +72,8 @@ static void run_mbm_test(bool has_ben, char **benchmark_cmd, int span,
>   		sprintf(benchmark_cmd[5], "%s", MBA_STR);
>   	res = mbm_bw_change(span, cpu_no, bw_report, benchmark_cmd);
>   	ksft_test_result(!res, "MBM: bw change\n");
> +	if (is_intel && res)
> +		ksft_print_msg("Intel CMT and MBM counters may be inaccurate when Sub-NUMA Clustering (SNC) is enabled. Ensure SNC is disabled in the BIOS if this system supports SNC.\n");

This message is rather long. Please make it concise.

>   	mbm_test_cleanup();
>   }
>   
> @@ -106,6 +110,8 @@ static void run_cmt_test(bool has_ben, char **benchmark_cmd, int cpu_no)
>   		sprintf(benchmark_cmd[5], "%s", CMT_STR);
>   	res = cmt_resctrl_val(cpu_no, 5, benchmark_cmd);
>   	ksft_test_result(!res, "CMT: test\n");
> +	if (is_intel && res)
> +		ksft_print_msg("Intel CMT and MBM counters may be inaccurate when Sub-NUMA Clustering (SNC) is enabled. Ensure SNC is disabled in the BIOS if this system supports SNC.\n");

This message is rather long. Please make it concise.

>   	cmt_test_cleanup();
>   }
>   
> @@ -207,8 +213,8 @@ int main(int argc, char **argv)
>   	if (geteuid() != 0)
>   		return ksft_exit_fail_msg("Not running as root, abort testing.\n");
>   
> -	/* Detect AMD vendor */
> -	detect_amd();
> +	/* Detect AMD/INTEL vendor */
> +	detect_vendor();
>   
>   	if (has_ben) {
>   		/* Extract benchmark command from command line. */
> 

thanks,
-- Shuah
