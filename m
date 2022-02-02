Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E644A7A1B
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Feb 2022 22:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238960AbiBBVR3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Feb 2022 16:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbiBBVR2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Feb 2022 16:17:28 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2AFC061714
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Feb 2022 13:17:28 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id d3so444463ilr.10
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Feb 2022 13:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=v7lRfsMhBegD/1btbsX89s1WdSinDl2ooknU0HYVVyQ=;
        b=I7rmtqgPbpuzmgZVgfAWdaS0do6cHgXzIdBJane4QzI4niCbDttiyzEZuE87mvR+9L
         EoYaJIqsKRv6azFEUTPijSqRwn1Bz3W67VDyKD5k8D8Re+FvloMAe+FBeWBueWKeJWuS
         /eGWQDbqbvqhXA4YZy2KvXUiecQ0Gv9maqlmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v7lRfsMhBegD/1btbsX89s1WdSinDl2ooknU0HYVVyQ=;
        b=7apAOdPNWklsq8v+pY41HENOEbPInsfoh5t0Ib5pI1xEKGL8/JWLAdb98VVz1eQP3L
         aQ7fAy+iCX5IBxuF7T1y31Q9yKi426o44tZnXst/U+TJ6uSOIdfUhE96Nd9C/uCOvZKP
         0OWiNdnO5RxReeEgrXOo6+siaO9dwAhJHYTH/6BTQLGDd9TyYejIHDaK9u2749r/c+2M
         fcztUijpM0vK4D4uNqExyFx7yHixhcWP7Wpfaa6Rd0jboX0f6ritTT12okJJ5WArD4LH
         vdGUIz7e9I4apghOERH7l0XG02ZrLXUlqCm1V6ZYRNDxfPhZk0+p7nxWkf9TcEiOxlFf
         3wpA==
X-Gm-Message-State: AOAM530gvnKjNSwizEDbNqTj/mylkDa+z+BPAPMBFcE3h3rLcaRvQH9j
        fvVbyHLWNPMZwDHkgS6uJilqQw==
X-Google-Smtp-Source: ABdhPJwqUTZzWUnX3mGD2RbibfV0TLsAmOLBLYu/6EaPYt62odlBUisCipe6pRl8/11tW/tyFbjP2g==
X-Received: by 2002:a05:6e02:cae:: with SMTP id 14mr18759285ilg.66.1643836647589;
        Wed, 02 Feb 2022 13:17:27 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id w11sm9939858ill.46.2022.02.02.13.17.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 13:17:27 -0800 (PST)
Subject: Re: [PATCH] selftests/seccomp: Fix seccomp failure by adding missing
 headers
To:     Sherry Yang <sherry.yang@oracle.com>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220202201118.13933-1-sherry.yang@oracle.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <203db09a-b048-1c1b-6609-d91e51e3c2f7@linuxfoundation.org>
Date:   Wed, 2 Feb 2022 14:17:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220202201118.13933-1-sherry.yang@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/2/22 1:11 PM, Sherry Yang wrote:
> seccomp_bpf failed on tests 47 global.user_notification_filter_empty
> and 48 global.user_notification_filter_empty_threaded when it's
> tested on updated kernel but with old kernel headers. Because old
> kernel headers don't have definition of macro __NR_clone3 which is
> required for these two tests. Since under selftests/, we can install
> headers once for all tests (the default INSTALL_HDR_PATH is
> usr/include), fix it by adding usr/include to the list of directories
> to be searched. Use "-isystem" to indicate it's a system directory as
> the real kernel headers directories are.
> 
> Signed-off-by: Sherry Yang <sherry.yang@oracle.com>
> Tested-by: Sherry Yang <sherry.yang@oracle.com>
> ---
>   tools/testing/selftests/seccomp/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/seccomp/Makefile b/tools/testing/selftests/seccomp/Makefile
> index 0ebfe8b0e147..585f7a0c10cb 100644
> --- a/tools/testing/selftests/seccomp/Makefile
> +++ b/tools/testing/selftests/seccomp/Makefile
> @@ -1,5 +1,5 @@
>   # SPDX-License-Identifier: GPL-2.0
> -CFLAGS += -Wl,-no-as-needed -Wall
> +CFLAGS += -Wl,-no-as-needed -Wall -isystem ../../../../usr/include/
>   LDFLAGS += -lpthread
>   
>   TEST_GEN_PROGS := seccomp_bpf seccomp_benchmark
> 

Looks good to me. Adding Kees Cook for his review of this change.

thanks,
-- Shuah
