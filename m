Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23FBC615FB3
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Nov 2022 10:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiKBJ3P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Nov 2022 05:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiKBJ3O (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Nov 2022 05:29:14 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4843256
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Nov 2022 02:29:13 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d10so15881639pfh.6
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Nov 2022 02:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e/LpNA2XkrZd/P1C5jUW2C9ri+5Ug2DmDuhYFjerMn4=;
        b=QCD1TPOZZn+fBI7T153LS5r9TxHVKJnuBcW5Q686Cpn2TQbGzJ55JXxu9yxstl5WR0
         0e0RIx+9d0T5X/VNFuTPsW4zpaIrIEUMuTHelfwuzsmXGkmioSV7w5/3e6QZlrApB3H3
         D4LDShuwnAtn6Ap3Rx9OPZGilS01eB78pX96g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e/LpNA2XkrZd/P1C5jUW2C9ri+5Ug2DmDuhYFjerMn4=;
        b=mesbilIDF5/o7WTGK4vcFw6BfYOEYshBi9UPsqdzmZKY0F2VoMEf+8xYJs5DDs5/wu
         PVy30wRP/uXEhX4ZahJKsR58ya5ezPwJwAxTld3AxB1f34XWqb72JbBkJOfuTM/ITs+7
         imb23dgeA7rpJ8nc3LFoiSVhC/u8ma++GYVDYumKWHxWr3bw7+APzvQVQDbT2RNrSnN0
         PlWqRa9WNAWKKKsJsOa3rh3CkDT8rhqTIL3NxdBGPSj4AH5D0PNXi5pe+cX16s82iP5k
         mik/rlYr/2UvTO5IXCMnUQlmBCVA+G1JPR/vLCsxLkLiUc9Jg8YgnUcxHMLBVfhxharc
         TYOg==
X-Gm-Message-State: ACrzQf2OiyvTPMfqQodvJ68YC9Vbr+cCVOjjiEdDbzrhcF45tvcVEQ4G
        oa7a3MIeKA0ltIO4YyjKtuRH2A==
X-Google-Smtp-Source: AMsMyM7CaXqBaokXJ069u2tiyq/rKMTNn1whUU0PaDONfoAQYSWcpOe/l+HeMNhyhNtV7z47NOPPtQ==
X-Received: by 2002:a05:6a00:24c3:b0:56c:dd9c:dab4 with SMTP id d3-20020a056a0024c300b0056cdd9cdab4mr24274738pfv.36.1667381353253;
        Wed, 02 Nov 2022 02:29:13 -0700 (PDT)
Received: from [192.168.0.168] ([103.99.10.63])
        by smtp.gmail.com with ESMTPSA id c12-20020a056a00008c00b00565b259a52asm8042791pfj.1.2022.11.02.02.29.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 02:29:12 -0700 (PDT)
Message-ID: <52154117-ee1c-9ea9-bce6-04e02124ea1b@linuxfoundation.org>
Date:   Wed, 2 Nov 2022 03:29:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 3/5] selftests/resctrl: Flush stdout file buffer before
 executing fork()
Content-Language: en-US
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20221101094341.3383073-1-tan.shaopeng@jp.fujitsu.com>
 <20221101094341.3383073-4-tan.shaopeng@jp.fujitsu.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221101094341.3383073-4-tan.shaopeng@jp.fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/1/22 03:43, Shaopeng Tan wrote:
> When a process has buffered output, a child process created by fork()
> will also copy buffered output. When using kselftest framework,
> the output (resctrl test result message) will be printed multiple times.
> 
> Add fflush() to flush out the buffered output before executing fork().
> 
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
>   tools/testing/selftests/resctrl/cat_test.c    | 1 +
>   tools/testing/selftests/resctrl/resctrl_val.c | 1 +
>   tools/testing/selftests/resctrl/resctrlfs.c   | 1 +
>   3 files changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
> index 1c5e90c63254..6a8306b0a109 100644
> --- a/tools/testing/selftests/resctrl/cat_test.c
> +++ b/tools/testing/selftests/resctrl/cat_test.c
> @@ -167,6 +167,7 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
>   		return errno;
>   	}
>   
> +	fflush(stdout);
>   	bm_pid = fork();
>   
>   	/* Set param values for child thread which will be allocated bitmask
> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
> index b32b96356ec7..6948843bf995 100644
> --- a/tools/testing/selftests/resctrl/resctrl_val.c
> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
> @@ -629,6 +629,7 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
>   	 * Fork to start benchmark, save child's pid so that it can be killed
>   	 * when needed
>   	 */
> +	fflush(stdout);
>   	bm_pid = fork();
>   	if (bm_pid == -1) {
>   		perror("# Unable to fork");
> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
> index 8546bc9f1786..d95688298469 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -678,6 +678,7 @@ int filter_dmesg(void)
>   		perror("pipe");
>   		return ret;
>   	}
> +	fflush(stdout);
>   	pid = fork();
>   	if (pid == 0) {
>   		close(pipefds[0]);

Good find. Looks good to me.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
