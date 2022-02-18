Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004D54BC103
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Feb 2022 21:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235377AbiBRUKa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Feb 2022 15:10:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236323AbiBRUK3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Feb 2022 15:10:29 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7599524B2A3
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Feb 2022 12:10:12 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id r7so3467017iot.3
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Feb 2022 12:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YIWJpKEENbFmbXbEyafcxIcJq6TphA9pvUdJgiZAvyE=;
        b=HlutxaM+IbO8xNMZTBAF65o2Cc5yGGegUjfKlJS1Zty5V2H/VvESFd2K1dklflc3BZ
         ukF56mfOCn1pWBx/sK+pnhYEcjKzeVeHKwJr2jtw9f0lreeHxy/qdqFZz80CVvIuVNOd
         yKuIXBusqH+gm6OCwpgcJIb3mJakayN7ht+6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YIWJpKEENbFmbXbEyafcxIcJq6TphA9pvUdJgiZAvyE=;
        b=oAK1zgGwSdGoPG/gQRwaJgyDeGXu6zWQ6sSdpFhBNe6sl8jr6t9OLgLN6ONaDP769v
         p+ofLmFindp1z7HN+Y0E83+tmXtyB2A97ql8RntQ/mczj7USnPSopg69sXFyNZjW9HLi
         /tfpgAwzW0fiwjbN6BggGgz52BOtYWydfl0qBNl//+ia7sAXu2rGQZ7DYZqqN97wlJa1
         NrVZ/N31+GIc4MBzJwLzlh+RKmBNz3sV3zy0Y+szxV7nVu9WqQRUfr2ShD/QeDfENaz0
         9bc5zc2fJFO5VfKdM0Le7NOZoOp7CFx6lw2wUhOE4EAKADwwmhpuOniNu3t2MwUd0ITF
         n0dQ==
X-Gm-Message-State: AOAM532jfGDTWd7umK7AFYFwuiSs1MX5fWey7w9QVPYsPyKu9FINTT/b
        f1F9m9/n40xnavrxDZZJIwZlJPh697r5AQ==
X-Google-Smtp-Source: ABdhPJwqQDwxWISKZBWY0L8hGgo42UBhTa//k+554mx88o/db9mFUtSqS7l2M7uBvWV9mNbGfDmPWg==
X-Received: by 2002:a05:6602:15cf:b0:614:52d4:952 with SMTP id f15-20020a05660215cf00b0061452d40952mr6527679iow.185.1645215011808;
        Fri, 18 Feb 2022 12:10:11 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id y6sm4213205ilv.3.2022.02.18.12.10.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 12:10:11 -0800 (PST)
Subject: Re: [PATCH v3 1/5] selftests/resctrl: Kill child process before
 parent process terminates if SIGTERM is received
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220216022641.2998318-1-tan.shaopeng@jp.fujitsu.com>
 <20220216022641.2998318-2-tan.shaopeng@jp.fujitsu.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f0205a17-fba6-7c06-303d-a6e690c93073@linuxfoundation.org>
Date:   Fri, 18 Feb 2022 13:10:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220216022641.2998318-2-tan.shaopeng@jp.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/15/22 7:26 PM, Shaopeng Tan wrote:
> In kselftest framework, a sub test is run using the timeout utility
> and it will send SIGTERM to the test upon timeout.
> 
> In resctrl_tests, a child process is created by fork() to
> run benchmark but SIGTERM is not set in sigaction().
> If SIGTERM signal is received, the parent process will be killed,
> but the child process still exists.
> 
> kill child process before parent process terminates
> if SIGTERM signal is received.
> 
> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
> Some important feedbacks from v1&v2 are addressed as follows:
> 
> - Change the order so that current patch 3/3 becomes 1/3. Since without
>    the SIGTERM fix, the test would hang if run from the kselftest framework.
>    => I changed the order and the SIGTERM fix now becomes patch [1/5].
> 
> - Describe that the test is run using the timeout utility and
>    it will send SIGTERM to the test upon timeout.
>    => I updated the changelog to include this information.
> 
> - Describe changes in imperative mood, and address this in all patches.
>    See Documentation/process/submitting-patches.rst for more details.
>    => I described all my patches' changelog in imperative mood and
>       deleted "This commit".
> 
> - +	    sigaction(SIGTERM, &sigact, NULL) ||
>    This snippet is preceded with a comment that describes its usage
>    you could also update it with the expanded use of the kselftest framework.
>    => I don't think it is necessary to add other comments.
>       Since the current comment already states "Register CTRL-C handler for parent,
>       as it has to kill benchmark before exiting", So, when SIGTERM comes,
>       the benchmark(child process) should be killed before parent process terminates,
>       but it was missing.
> 
>   tools/testing/selftests/resctrl/resctrl_val.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
> index 95224345c78e..b32b96356ec7 100644
> --- a/tools/testing/selftests/resctrl/resctrl_val.c
> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
> @@ -678,6 +678,7 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
>   	sigemptyset(&sigact.sa_mask);
>   	sigact.sa_flags = SA_SIGINFO;
>   	if (sigaction(SIGINT, &sigact, NULL) ||
> +	    sigaction(SIGTERM, &sigact, NULL) ||
>   	    sigaction(SIGHUP, &sigact, NULL)) {
>   		perror("# sigaction");
>   		ret = errno;
> 

This looks good to me.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
