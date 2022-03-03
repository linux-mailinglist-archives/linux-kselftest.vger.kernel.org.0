Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E324CC6A6
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Mar 2022 20:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbiCCT7a (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Mar 2022 14:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235683AbiCCT73 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Mar 2022 14:59:29 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C6B107D04
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Mar 2022 11:58:43 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id j5so4920406ila.2
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Mar 2022 11:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Dc0/cXuKBhE+v21Fkw/yBa8klzDWAfQShrPlFuUudE8=;
        b=StdlfoMfm7t/BujrCf01iGVCqB04gnay5aosRl0GOSXllZ+llLA0WF8v5UTttOmKfQ
         5R9fBxSrQeKgAUHZWUqV3v6TRHUvfOIH095mu2twXeRcTSH/y+KiKQwyq/KviBXhssUB
         ho6LgxCIl1WxMHjccr1naXtsuVhZn9y6q//t0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dc0/cXuKBhE+v21Fkw/yBa8klzDWAfQShrPlFuUudE8=;
        b=d9Gh9X5bd2xF8gDo9WtuhSjqxBobwMJyvzW6DSEIsE1LV6fKEHfESReeoJ1+XRBpcS
         pJag2oWP7tqM/JkXyL0yri06i9T3MMMUb50l5FneFVv7CqnLpENIfqiJ86o2/LPtjX8d
         dJ1tliFoLWnkkpjVX7v/32HYJFcZ7F5xgrM5+OYe3/tl6k5FprxCon6g0aC7GILYACGh
         n8CFkKeRVfHjOw7Ngar8gfRrtzM8QimTV6SE7Ga3bOI0Uuhq66ZMbYKK1FPi9vckgCZ0
         jdqV9QGXIySrav33+OroBD4np8NOvjFfQiSXW9Sa20d60Ib/TLroyJQLY0QxEl8MseeI
         e9ZQ==
X-Gm-Message-State: AOAM533LlOaiPwMvZF8BHlnI3WXt95Bhqf5J6gwECqy9W+EWc47IZjGw
        mTAedrcVRLHgGUipBqjV7mB7BA==
X-Google-Smtp-Source: ABdhPJxb3BE7VjErTKZL17yHyLkTjNG3kinSMhqezJVGMwfYr1VETlpbuVtkRAnMzIYadLLYqXmWSQ==
X-Received: by 2002:a05:6e02:20c3:b0:2c2:9e23:8263 with SMTP id 3-20020a056e0220c300b002c29e238263mr32162282ilq.248.1646337522515;
        Thu, 03 Mar 2022 11:58:42 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id c18-20020a05660221d200b00640a0083089sm2685366ioc.30.2022.03.03.11.58.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 11:58:42 -0800 (PST)
Subject: Re: [PATCH] kselftest/arm64: Log the PIDs of the parent and child in
 sve-ptrace
To:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220303192817.2732509-1-broonie@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <02711bbf-9081-6f92-8c7d-5d09b86a4f37@linuxfoundation.org>
Date:   Thu, 3 Mar 2022 12:58:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220303192817.2732509-1-broonie@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/3/22 12:28 PM, Mark Brown wrote:
> If the test triggers a problem it may well result in a log message from
> the kernel such as a WARN() or BUG(). If these include a PID it can help
> with debugging to know if it was the parent or child process that triggered
> the issue, since the test is just creating a new thread the process name
> will be the same either way. Print the PIDs of the parent and child on
> startup so users have this information to hand should it be needed.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   tools/testing/selftests/arm64/fp/sve-ptrace.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/arm64/fp/sve-ptrace.c b/tools/testing/selftests/arm64/fp/sve-ptrace.c
> index 4bd333768cc4..4c418b2021e0 100644
> --- a/tools/testing/selftests/arm64/fp/sve-ptrace.c
> +++ b/tools/testing/selftests/arm64/fp/sve-ptrace.c
> @@ -487,6 +487,8 @@ static int do_parent(pid_t child)
>   	unsigned int vq, vl;
>   	bool vl_supported;
>   
> +	ksft_print_msg("Parent is %d, child is %d\n", getpid(), child);
> +
>   	/* Attach to the child */
>   	while (1) {
>   		int sig;
> 

Nice addition. Thanks for the patch.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
