Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA5133577ED
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Apr 2021 00:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbhDGWqx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Apr 2021 18:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhDGWqt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Apr 2021 18:46:49 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC049C061760
        for <linux-kselftest@vger.kernel.org>; Wed,  7 Apr 2021 15:46:39 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id x207so196849oif.1
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Apr 2021 15:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=v9CYBF5Iw/k3vda2gKO3t4S07zzMN0pC5vDg5Hp6IBo=;
        b=R39eI2nipgb2W8+jPBCz3bDsJKVqEAbTmws3XJd7L35txdgd9PwTapmBtRWwPdQBKf
         vStzTIi6vq+c/pBk31x3KwxKN3n4aIZYrfBbYFX9sN0OdWIyIKokxdXx/voDM+1jTU+g
         vuf1fGTLBF4nKc/bTVMu2tX3MoZPn6K94zPXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v9CYBF5Iw/k3vda2gKO3t4S07zzMN0pC5vDg5Hp6IBo=;
        b=smrkRsKEd4FrAiNIUe3Et+fDaxvdTsEl5Tq8aXazejzZdsbq7qE7Y+K42orbZ+CbuK
         Aerm3JQ8B3TaRSy5o5BtZjl7rqlJChj/2nfMkrgIgAOMbUmOCSinGfpgd12rJWwf3zHC
         /x9+wdtYe0sYWJw5oAFjYRjwhNkgpgbIslRva0tmXhuKJz5G+TiEfO4/41Wm0Q09x80p
         4zLTbPlip+FZUq97f6HBfbaD/pphIccfF4OaC29xFMDEM6lFIK+ui3ApEPXoVm7wEf37
         WswBgpS4tsYvUYJkivCUZTw/zRGJntcU1D6nQcy/AoeTtvR92eVNnQSE7sYYaDAkBKqC
         SWHg==
X-Gm-Message-State: AOAM531YyneEnAk2pj2NODopxRIrLCLNUbOEnsu/bGbhxUBmGA4BATCw
        ipsDda6m/P85DrsK3kAZ/OhFdQ==
X-Google-Smtp-Source: ABdhPJwmEqjEsIXQgcKB/LZNh8ClqNZbnNkMsFBy+Q8ObLn5ebow5X6aGTapMsk5QPsQ67+wFx/Ltw==
X-Received: by 2002:aca:7543:: with SMTP id q64mr3893522oic.100.1617835599123;
        Wed, 07 Apr 2021 15:46:39 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id h24sm5814668otg.20.2021.04.07.15.46.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 15:46:38 -0700 (PDT)
Subject: Re: [PATCH v2] selftests/resctrl: Change a few printed messages
To:     Fenghua Yu <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
        Ravi V Shankar <ravi.v.shankar@intel.com>
Cc:     linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210407195728.1436270-1-fenghua.yu@intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <bc53f24b-7ec9-992f-6013-d40459e2b360@linuxfoundation.org>
Date:   Wed, 7 Apr 2021 16:46:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210407195728.1436270-1-fenghua.yu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/7/21 1:57 PM, Fenghua Yu wrote:
> Change a few printed messages to report test progress more clearly.
> 
> Add a missing "\n" at the end of one printed message.
> 
> Suggested-by: Shuah Khan <shuah@kernel.org>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> ---
> Change log:
> v2:
> - Add "Pass:" and "Fail:" sub-strings back (Shuah).
> 
> This is a follow-up patch of recent resctrl selftest patches and can be
> applied cleanly to:
> git git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git
> branch next.
> 
>   tools/testing/selftests/resctrl/cache.c     | 2 +-
>   tools/testing/selftests/resctrl/mba_test.c  | 6 +++---
>   tools/testing/selftests/resctrl/mbm_test.c  | 2 +-
>   tools/testing/selftests/resctrl/resctrlfs.c | 4 ++--
>   4 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
> index 362e3a418caa..68ff856d36f0 100644
> --- a/tools/testing/selftests/resctrl/cache.c
> +++ b/tools/testing/selftests/resctrl/cache.c
> @@ -301,7 +301,7 @@ int show_cache_info(unsigned long sum_llc_val, int no_of_bits,
>   	ret = platform && abs((int)diff_percent) > max_diff_percent &&
>   	      (cmt ? (abs(avg_diff) > max_diff) : true);
>   
> -	ksft_print_msg("%s cache miss rate within %d%%\n",
> +	ksft_print_msg("%s Check cache miss rate within %d%%\n",
>   		       ret ? "Fail:" : "Pass:", max_diff_percent);
>   
>   	ksft_print_msg("Percent diff=%d\n", abs((int)diff_percent));
> diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
> index 26f12ad4c663..1a1bdb6180cf 100644
> --- a/tools/testing/selftests/resctrl/mba_test.c
> +++ b/tools/testing/selftests/resctrl/mba_test.c
> @@ -80,7 +80,7 @@ static void show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
>   		avg_diff = (float)labs(avg_bw_resc - avg_bw_imc) / avg_bw_imc;
>   		avg_diff_per = (int)(avg_diff * 100);
>   
> -		ksft_print_msg("%s MBA: diff within %d%% for schemata %u\n",
> +		ksft_print_msg("%s Check MBA diff within %d%% for schemata %u\n",
>   			       avg_diff_per > MAX_DIFF_PERCENT ?
>   			       "Fail:" : "Pass:",
>   			       MAX_DIFF_PERCENT,
> @@ -93,10 +93,10 @@ static void show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
>   			failed = true;
>   	}
>   
> -	ksft_print_msg("%s schemata change using MBA\n",
> +	ksft_print_msg("%s Check schemata change using MBA\n",
>   		       failed ? "Fail:" : "Pass:");
>   	if (failed)
> -		ksft_print_msg("At least one test failed");
> +		ksft_print_msg("At least one test failed\n");
>   }
>   
>   static int check_results(void)
> diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
> index 02b1ed03f1e5..8392e5c55ed0 100644
> --- a/tools/testing/selftests/resctrl/mbm_test.c
> +++ b/tools/testing/selftests/resctrl/mbm_test.c
> @@ -37,7 +37,7 @@ show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, int span)
>   	avg_diff_per = (int)(avg_diff * 100);
>   
>   	ret = avg_diff_per > MAX_DIFF_PERCENT;
> -	ksft_print_msg("%s MBM: diff within %d%%\n",
> +	ksft_print_msg("%s Check MBM diff within %d%%\n",
>   		       ret ? "Fail:" : "Pass:", MAX_DIFF_PERCENT);
>   	ksft_print_msg("avg_diff_per: %d%%\n", avg_diff_per);
>   	ksft_print_msg("Span (MB): %d\n", span);
> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
> index ade5f2b8b843..5f5a166ade60 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -570,14 +570,14 @@ bool check_resctrlfs_support(void)
>   
>   	fclose(inf);
>   
> -	ksft_print_msg("%s kernel supports resctrl filesystem\n",
> +	ksft_print_msg("%s Check kernel supports resctrl filesystem\n",
>   		       ret ? "Pass:" : "Fail:");
>   
>   	if (!ret)
>   		return ret;
>   
>   	dp = opendir(RESCTRL_PATH);
> -	ksft_print_msg("%s resctrl mountpoint \"%s\" exists\n",
> +	ksft_print_msg("%s Check resctrl mountpoint \"%s\" exists\n",
>   		       dp ? "Pass:" : "Fail:", RESCTRL_PATH);
>   	if (dp)
>   		closedir(dp);
> 

Thank you. Applied to linux-kseftest next branch for 5.13-rc1

thanks,
-- Shuah
