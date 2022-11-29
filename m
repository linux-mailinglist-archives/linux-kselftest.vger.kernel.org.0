Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47F963CAB0
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Nov 2022 22:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235700AbiK2Vyu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Nov 2022 16:54:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237012AbiK2Vyt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Nov 2022 16:54:49 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B7950D5E
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Nov 2022 13:54:48 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id h206so11099157iof.10
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Nov 2022 13:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ur6a/CzXJIypB8RYZUhojWApn7N1bPxeoQ/GZe4dipA=;
        b=gzcqXxjvNW6BZ3wOYM5yYHr3eUcD+l8Qw/s4DjB26DCMtvo7UxZ7DmoJwVC5fA0lGp
         HVtjdK7eTE11no/FnqNrxB4rOX88+GRSvf4RfZjf9a5mqSvRxhikadM6e7jIwlpDLQC+
         iZFYPlxx3eAI8oNhhgr7OuWohSNVbuIq5JL8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ur6a/CzXJIypB8RYZUhojWApn7N1bPxeoQ/GZe4dipA=;
        b=SOg2moCF0sN2MSkZcjXyMTq8gprvwY2JBBoTLK20UovaAfAr80EqhoLZKziM38+R/J
         52TctUWYlcJa5sezffSxxBhoe4lib8wvDfP0eEQ9sbHaQyspqpGQVPqIFZN429S++2VV
         JOiZCA8muECcW7Efa5cvYZllkjPsyJ22Ezc6WONniLvJSVdKc4cCVW28tpK3/JkQmq5s
         /87WcDv7c7cO58LVwcPNpb5iiDGrA0cdK+bxPr+J2ojjWpCofH2gFkJlu4X+heBQW6CL
         U3E1/M4utN017Tax5iAll4Wp2KZuwHFZarPepS9kW3OICFv8ojcQAOlrtjliaq46/gKz
         SXpA==
X-Gm-Message-State: ANoB5plUrUgOQy6Psgp9v7FxHR6qvo/NCgu30UdsNF8/KqUSbxzwKBR4
        UIcrYJcRsKOTiPn4l3BmYW/vlQ==
X-Google-Smtp-Source: AA0mqf7LHtE52CmTARBNuYJtjnj/4Aq5OQqGdnW1PT00LdzNDs4Ib56U1AUEE6p4ZUYmZ0aWlAZiWA==
X-Received: by 2002:a05:6638:1a98:b0:375:61b2:825a with SMTP id ce24-20020a0566381a9800b0037561b2825amr28405190jab.147.1669758887713;
        Tue, 29 Nov 2022 13:54:47 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id b36-20020a0295a7000000b0037612be6830sm5491192jai.140.2022.11.29.13.54.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 13:54:46 -0800 (PST)
Message-ID: <45793334-f890-d0e6-dd3a-6335ed0628f8@linuxfoundation.org>
Date:   Tue, 29 Nov 2022 14:54:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 3/3] selftests: Make a warning if getcpu is missing on
 32bit.
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Roland Mainz <roland.mainz@nrubsig.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20221125094216.3663444-1-bigeasy@linutronix.de>
 <20221125094216.3663444-4-bigeasy@linutronix.de>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221125094216.3663444-4-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/25/22 02:42, Sebastian Andrzej Siewior wrote:
> The vsyscall for getcpu has been wired up on 32bit so it can be warned
> now if missing.
> 
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: linux-kselftest@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>   tools/testing/selftests/x86/test_vsyscall.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/x86/test_vsyscall.c b/tools/testing/selftests/x86/test_vsyscall.c
> index 5b45e6986aeab..47cab972807c4 100644
> --- a/tools/testing/selftests/x86/test_vsyscall.c
> +++ b/tools/testing/selftests/x86/test_vsyscall.c
> @@ -92,11 +92,8 @@ static void init_vdso(void)
>   		printf("[WARN]\tfailed to find time in vDSO\n");
>   
>   	vdso_getcpu = (getcpu_t)dlsym(vdso, "__vdso_getcpu");
> -	if (!vdso_getcpu) {
> -		/* getcpu() was never wired up in the 32-bit vDSO. */
> -		printf("[%s]\tfailed to find getcpu in vDSO\n",
> -		       sizeof(long) == 8 ? "WARN" : "NOTE");
> -	}
> +	if (!vdso_getcpu)
> +		printf("[WARN]\tfailed to find getcpu in vDSO\n");
>   }
>   
>   static int init_vsys(void)

Assuming this is going through x86 tree due to dependencies, here is
my ack

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

Let me know if you would like to me pick this up.

thanks,
-- Shuah
