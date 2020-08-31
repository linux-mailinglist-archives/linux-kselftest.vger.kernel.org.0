Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDFE258382
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Aug 2020 23:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730267AbgHaV3z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Aug 2020 17:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730264AbgHaV3z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Aug 2020 17:29:55 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EC7C061575
        for <linux-kselftest@vger.kernel.org>; Mon, 31 Aug 2020 14:29:54 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id w8so2480999ilj.8
        for <linux-kselftest@vger.kernel.org>; Mon, 31 Aug 2020 14:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ukrTRysPReBmmeihk4CoXLCpd16/lRS5smuSWOxODRo=;
        b=QNusu1YEHzCf+rQCWjp0IkGxE8MyBmTOnXlX6mwtPYEMGKZvkRHr1g1WXp6N2MSDNp
         hPbNsmLHOp2gtrFoLKeQ7Ra8CPbKyiAGFAs5HVjGY/Yo5y2xEsH9VgrL6tQd+8NHROMa
         V6v2ab/reO5XdipVWf9vJGCc7jSOY1woWT89U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ukrTRysPReBmmeihk4CoXLCpd16/lRS5smuSWOxODRo=;
        b=WwqNqfoz0W4CudD7BvIcjscN/1RKBNTAiihrRix3l+stDQXYZhLkF21BR8WzT8NhHb
         xKznsues9MelYtlt9c9/jCYcXvTAvGKE7aZz3VWy8OlIgMtCS2tm8X4DHXB4NNiDV3hL
         TfB36f1+uOscDk8zWBRN3U5rpFhyuZ7D7WSF/eXsHREQZW0FF5CETMPwlDqWowK/LPpd
         ONQ5UrgfPkwId15lycBeiXFfxDOYY/jhkaGByb2nkeMDwehtUyNXKUJvjqqUy6Gd6J1z
         fvCl3dxHBmO+OJr6/lUQAuhFOF+bF/eoB7DLfOr1M4o7tTr0zK637Q0v+M3davrCD0eX
         aivA==
X-Gm-Message-State: AOAM533J3rlAjOs5gM/MXmEdrIO7emxJRaOZOMo54e5TpjwqbHGPIXf1
        pmAOdM7auaGa6Suj1Ian90DrPQ==
X-Google-Smtp-Source: ABdhPJz7TtEbBPoFn/idxbqmirN5xvay9s5X8FVcVKuVjQ5sCkqOOsqp3wP7NjeCDn9J9tdxYgHwQg==
X-Received: by 2002:a92:d08e:: with SMTP id h14mr3087541ilh.1.1598909394319;
        Mon, 31 Aug 2020 14:29:54 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id p18sm4319248iog.1.2020.08.31.14.29.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2020 14:29:53 -0700 (PDT)
Subject: Re: [PATCH 2/2] kunit: ubsan integration
To:     Uriel Guajardo <urielguajardojr@gmail.com>,
        brendanhiggins@google.com
Cc:     urielguajardo@google.com, akpm@linux-foundation.org,
        keescook@chromium.org, rdunlap@infradead.org,
        herbert@gondor.apana.org.au, christian.brauner@ubuntu.com,
        peterz@infradead.org, ardb@kernel.og, arnd@arndb.de,
        julien.grall@arm.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200813205722.1384108-1-urielguajardojr@gmail.com>
 <20200813205722.1384108-2-urielguajardojr@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <5064a46f-f73f-5833-5eb9-f69a0aecea4e@linuxfoundation.org>
Date:   Mon, 31 Aug 2020 15:29:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200813205722.1384108-2-urielguajardojr@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/13/20 2:57 PM, Uriel Guajardo wrote:
> Integrates UBSAN into the KUnit testing framework. It fails KUnit tests
> whenever it reports undefined behavior.
> 
> Signed-off-by: Uriel Guajardo <urielguajardo@google.com>
> ---
>   lib/ubsan.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/lib/ubsan.c b/lib/ubsan.c
> index cb9af3f6b77e..1460e2c828c8 100644
> --- a/lib/ubsan.c
> +++ b/lib/ubsan.c
> @@ -14,6 +14,7 @@
>   #include <linux/types.h>
>   #include <linux/sched.h>
>   #include <linux/uaccess.h>
> +#include <kunit/test.h>
>   
>   #include "ubsan.h"
>   
> @@ -137,6 +138,7 @@ static void ubsan_prologue(struct source_location *loc, const char *reason)
>   {
>   	current->in_ubsan++;
>   
> +	kunit_fail_current_test();
>   	pr_err("========================================"
>   		"========================================\n");
>   	pr_err("UBSAN: %s in %s:%d:%d\n", reason, loc->file_name,
> 

I applied this to linux-kselftest kunit for 5.10-rc1.

thanks,
-- Shuah
