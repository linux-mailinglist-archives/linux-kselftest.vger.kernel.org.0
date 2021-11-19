Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDF04579AF
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Nov 2021 00:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbhKSXpY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Nov 2021 18:45:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbhKSXpY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Nov 2021 18:45:24 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D2BC06173E
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Nov 2021 15:42:21 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id s139so24607333oie.13
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Nov 2021 15:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DRu6Bwch/YgFTmF6G8D+wCGxb7q1uczFUTqctESKlqY=;
        b=g2qplbsvHUdIHPIJWhJSXq3FDsqhljfj1HuAYK50RmvJ7XNXnMi9ptrrSkQfABQS4W
         zf5vuoywAGSavB3AMxLxuAZIkl+tQ+9eeGDKBBQkb7n4mqR8X2RVBQs7UoR59X36c8YA
         xOAWcUwlXnLNWsxbGpcxaTT6pZVoPWOTLEQgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DRu6Bwch/YgFTmF6G8D+wCGxb7q1uczFUTqctESKlqY=;
        b=OSZlahWJ7nwuQaZhVdjBW8tOY+tGu6FfjUL745ebM44kkkRoHzJ5P1sJ2rzjUHd1rC
         NuWceq/q//k7zx0ydgt4pqvibtuj0n0Nc8TwhP5d3z0osJyQMgcfBxV+dlNgAgz7wkd8
         M7BCbQEnphqCD+hDr0bjrUsvF/3a6U2prA+DUk7qDpi+b639z28bYzM9BagjEOjb9LUh
         X0BrljUCnnGKKQBycvZpN/ld0g08eOIRcKExG3q1z0/uBLCQl068Tp2UXR0YKUbrLZIC
         6qal4AW9ZZ44d8+KORKchC/qEVXVrOSDY0JtInKth57MyR2B2N1aE/Nfjjkw/gi3Cxsm
         WkBw==
X-Gm-Message-State: AOAM530q2bcwnAwMLXGtyeIjhNEA3yvb+Yl5aCSVfiiG0ZY1Na3efOIl
        NkDNOxYzdcKuFCw3oue6iitaJQ==
X-Google-Smtp-Source: ABdhPJzPsdXRifHN0lcBnA12Rp39033+9ZX2XCYAKR6uxsEvFnxQfDBiBj9alPZ3mRmlgAUqjq9bIw==
X-Received: by 2002:a05:6808:284:: with SMTP id z4mr3713548oic.60.1637365340887;
        Fri, 19 Nov 2021 15:42:20 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id o26sm258074otj.14.2021.11.19.15.42.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 15:42:20 -0800 (PST)
Subject: Re: [PATCH] openat2: use ARRAY_SIZE instead of ARRAY_LEN
To:     cgel.zte@gmail.com, shuah@kernel.org
Cc:     christian.brauner@ubuntu.com, cyphar@cyphar.com,
        chi.minghao@zte.com.cn, rgb@redhat.com,
        baolin.wang@linux.alibaba.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cm>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211119023025.1945-1-chi.minghao@zte.com.cn>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <2539ff01-dc42-fc14-f02a-c3e24709d60e@linuxfoundation.org>
Date:   Fri, 19 Nov 2021 16:42:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211119023025.1945-1-chi.minghao@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/18/21 7:30 PM, cgel.zte@gmail.com wrote:
> From: chiminghao <chi.minghao@zte.com.cn>

Missing commit log. Please add one and include information on
how you found this problem and tool output.
> 
> ARRAY_SIZE defined in <linux/kernel.h> is safer than self-defined
> macros to get size of an array such as ARRAY_LEN used here.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cm>
> Signed-off-by: chiminghao <chi.minghao@zte.com.cn>
> ---
>   tools/testing/selftests/openat2/openat2_test.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/openat2/openat2_test.c b/tools/testing/selftests/openat2/openat2_test.c
> index 1bddbe934204..c467f85e854e 100644
> --- a/tools/testing/selftests/openat2/openat2_test.c
> +++ b/tools/testing/selftests/openat2/openat2_test.c
> @@ -5,6 +5,7 @@
>    */
>   
>   #define _GNU_SOURCE
> +#include <linux/kernel.h>
>   #include <fcntl.h>
>   #include <sched.h>
>   #include <sys/stat.h>
> @@ -82,14 +83,14 @@ void test_openat2_struct(void)
>   		  .size = sizeof(struct open_how_ext), .err = -E2BIG },
>   	};
>   
> -	BUILD_BUG_ON(ARRAY_LEN(misalignments) != NUM_OPENAT2_STRUCT_VARIATIONS);
> -	BUILD_BUG_ON(ARRAY_LEN(tests) != NUM_OPENAT2_STRUCT_TESTS);
> +	BUILD_BUG_ON(ARRAY_SIZE(misalignments) != NUM_OPENAT2_STRUCT_VARIATIONS);
> +	BUILD_BUG_ON(ARRAY_SIZE(tests) != NUM_OPENAT2_STRUCT_TESTS);
>   
> -	for (int i = 0; i < ARRAY_LEN(tests); i++) {
> +	for (int i = 0; i < ARRAY_SIZE(tests); i++) {
>   		struct struct_test *test = &tests[i];
>   		struct open_how_ext how_ext = test->arg;
>   
> -		for (int j = 0; j < ARRAY_LEN(misalignments); j++) {
> +		for (int j = 0; j < ARRAY_SIZE(misalignments); j++) {
>   			int fd, misalign = misalignments[j];
>   			char *fdpath = NULL;
>   			bool failed;
> @@ -240,9 +241,9 @@ void test_openat2_flags(void)
>   		  .how.resolve = 0, .err = -EINVAL },
>   	};
>   
> -	BUILD_BUG_ON(ARRAY_LEN(tests) != NUM_OPENAT2_FLAG_TESTS);
> +	BUILD_BUG_ON(ARRAY_SIZE(tests) != NUM_OPENAT2_FLAG_TESTS);
>   
> -	for (int i = 0; i < ARRAY_LEN(tests); i++) {
> +	for (int i = 0; i < ARRAY_SIZE(tests); i++) {
>   		int fd, fdflags = -1;
>   		char *path, *fdpath = NULL;
>   		bool failed = false;
> 

thanks,
-- Shuah
