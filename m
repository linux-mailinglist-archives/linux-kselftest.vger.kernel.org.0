Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3149356EBC
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Apr 2021 16:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbhDGOdg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Apr 2021 10:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbhDGOdf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Apr 2021 10:33:35 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB960C06175F
        for <linux-kselftest@vger.kernel.org>; Wed,  7 Apr 2021 07:33:25 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id x187-20020a4a41c40000b02901b664cf3220so4592324ooa.10
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Apr 2021 07:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+xPsdblmGzem/7lcmqnJl9sL6OnLBtSMGGgOJbe8nUM=;
        b=I0xNFJ1ENsf5lwfbo5u9d4dnnXTLBmTO/oHDY2aT3VYgtrMNZEQYySZ2KK92oZQkkG
         iWAkPX1i7HHnG6NfTRXB+F6HZY05YVr7Jq2RNpGBLU/yq8MQyB7dtXuGSf8kdC21S0qG
         SrViWMP22KrKoQPd0haL3RBz19TN2rlujp3pQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+xPsdblmGzem/7lcmqnJl9sL6OnLBtSMGGgOJbe8nUM=;
        b=mt8xkqkkWPeDsF+p4ufJRGPD7l8dORhnAbLjIlWfLuTgserd3uzCUy1zsOPWqrPqgo
         zmxdOrurQbZLwJHjGnvI+M9Vdn0GfFSKwUmC/nhRjVGU6n2S+6uoswyuBZJZ5L7QTJeH
         Bvr1SztG0CRtaVkEwgmGRLCd8Dg+GINqIljRCEem5zlF34gBZ33cNG/UrzbRd6jtVBuH
         XkN0W+LlRuMeJsHyJV73lKOsKJbnn8d7bGHG4uEybkUAG1gOXhEAngHxUw0hDfoXssdo
         b6fCcvhztuEnFfikLfubve59bZw1BWljdPemtzY7T80QNDDRxTf1+ekXugtQkyO63pzM
         5C6g==
X-Gm-Message-State: AOAM530+CLjEsZGxKKKu2zhXLGMTm84bA9UUwLRLmeI53Ez/bDKB9zdh
        uGLAhv9MOTLouzUFtFmnzAG9Zg==
X-Google-Smtp-Source: ABdhPJxCy5mdQg6UXu6kWlLFCHoVnQbZ9mjgZJhQg9DXI1Wj9k6o+8n5FBSjX3S73s4RAizE9x2i/Q==
X-Received: by 2002:a4a:4cd6:: with SMTP id a205mr3305504oob.4.1617806005313;
        Wed, 07 Apr 2021 07:33:25 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id h59sm5427570otb.29.2021.04.07.07.33.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 07:33:24 -0700 (PDT)
Subject: Re: [PATCH] selftests/resctrl: Change a few printed messages
To:     Fenghua Yu <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
        Ravi V Shankar <ravi.v.shankar@intel.com>
Cc:     linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210406005242.3248706-1-fenghua.yu@intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <67062f6c-d09a-f8e0-4d22-49c4452d0552@linuxfoundation.org>
Date:   Wed, 7 Apr 2021 08:33:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210406005242.3248706-1-fenghua.yu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/5/21 6:52 PM, Fenghua Yu wrote:
> A few printed messages contain pass/fail strings which should be shown
> in test results. Remove the pass/fail strings in the messages to avoid
> confusion.
> 
> Add "\n" at the end of one printed message.
> 
> Suggested-by: Shuah Khan <shuah@kernel.org>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> ---
> This is a follow-up patch of recent resctrl selftest patches and can be
> applied cleanly to:
> git git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git
> branch next.
> 
>   tools/testing/selftests/resctrl/cache.c     | 3 +--
>   tools/testing/selftests/resctrl/mba_test.c  | 9 +++------
>   tools/testing/selftests/resctrl/mbm_test.c  | 3 +--
>   tools/testing/selftests/resctrl/resctrlfs.c | 7 ++-----
>   4 files changed, 7 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
> index 362e3a418caa..310bbc997c60 100644
> --- a/tools/testing/selftests/resctrl/cache.c
> +++ b/tools/testing/selftests/resctrl/cache.c
> @@ -301,8 +301,7 @@ int show_cache_info(unsigned long sum_llc_val, int no_of_bits,
>   	ret = platform && abs((int)diff_percent) > max_diff_percent &&
>   	      (cmt ? (abs(avg_diff) > max_diff) : true);
>   
> -	ksft_print_msg("%s cache miss rate within %d%%\n",
> -		       ret ? "Fail:" : "Pass:", max_diff_percent);
> +	ksft_print_msg("Check cache miss rate within %d%%\n", max_diff_percent);

You need %s and pass in the ret ? "Fail:" : "Pass:" result for the
message to read correctly.

I am seeing:

# Check kernel support for resctrl filesystem

It should say the following:

# Fail Check kernel support for resctrl filesystem


Same for other such messages.
>   
>   	ksft_print_msg("Percent diff=%d\n", abs((int)diff_percent));
>   	ksft_print_msg("Number of bits: %d\n", no_of_bits);
> diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
> index 26f12ad4c663..a909a745754f 100644
> --- a/tools/testing/selftests/resctrl/mba_test.c
> +++ b/tools/testing/selftests/resctrl/mba_test.c
> @@ -80,9 +80,7 @@ static void show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
>   		avg_diff = (float)labs(avg_bw_resc - avg_bw_imc) / avg_bw_imc;
>   		avg_diff_per = (int)(avg_diff * 100);
>   
> -		ksft_print_msg("%s MBA: diff within %d%% for schemata %u\n",
> -			       avg_diff_per > MAX_DIFF_PERCENT ?
> -			       "Fail:" : "Pass:",
> +		ksft_print_msg("Check MBA diff within %d%% for schemata %u\n",
>   			       MAX_DIFF_PERCENT,
>   			       ALLOCATION_MAX - ALLOCATION_STEP * allocation);
>   
> @@ -93,10 +91,9 @@ static void show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
>   			failed = true;
>   	}
>   
> -	ksft_print_msg("%s schemata change using MBA\n",
> -		       failed ? "Fail:" : "Pass:");
> +	ksft_print_msg("Check schemata change using MBA\n");
>   	if (failed)
> -		ksft_print_msg("At least one test failed");
> +		ksft_print_msg("At least one test failed\n");
>   }
>   
>   static int check_results(void)
> diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
> index 02b1ed03f1e5..e2e7ee4ec630 100644
> --- a/tools/testing/selftests/resctrl/mbm_test.c
> +++ b/tools/testing/selftests/resctrl/mbm_test.c
> @@ -37,8 +37,7 @@ show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, int span)
>   	avg_diff_per = (int)(avg_diff * 100);
>   
>   	ret = avg_diff_per > MAX_DIFF_PERCENT;
> -	ksft_print_msg("%s MBM: diff within %d%%\n",
> -		       ret ? "Fail:" : "Pass:", MAX_DIFF_PERCENT);
> +	ksft_print_msg("Check MBM diff within %d%%\n", MAX_DIFF_PERCENT);

Here

>   	ksft_print_msg("avg_diff_per: %d%%\n", avg_diff_per);
>   	ksft_print_msg("Span (MB): %d\n", span);
>   	ksft_print_msg("avg_bw_imc: %lu\n", avg_bw_imc);
> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
> index ade5f2b8b843..91cb3c48a7da 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -570,15 +570,12 @@ bool check_resctrlfs_support(void)
>   
>   	fclose(inf);
>   
> -	ksft_print_msg("%s kernel supports resctrl filesystem\n",
> -		       ret ? "Pass:" : "Fail:");
> -
> +	ksft_print_msg("Check kernel support for resctrl filesystem\n");

Here

>   	if (!ret)
>   		return ret;
>   
>   	dp = opendir(RESCTRL_PATH);
> -	ksft_print_msg("%s resctrl mountpoint \"%s\" exists\n",
> -		       dp ? "Pass:" : "Fail:", RESCTRL_PATH);
> +	ksft_print_msg("Check resctrl mountpoint \"%s\"\n", RESCTRL_PATH);

Here

>   	if (dp)
>   		closedir(dp);
>   
> 

thanks,
-- Shuah
