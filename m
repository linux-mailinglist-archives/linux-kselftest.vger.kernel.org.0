Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 709F825837C
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Aug 2020 23:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730239AbgHaV3R (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Aug 2020 17:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728956AbgHaV3Q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Aug 2020 17:29:16 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB88C061575
        for <linux-kselftest@vger.kernel.org>; Mon, 31 Aug 2020 14:29:16 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id g128so7577875iof.11
        for <linux-kselftest@vger.kernel.org>; Mon, 31 Aug 2020 14:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=va7gdVSZd9oGcktmFSi4633m1KmqtF16W8cC99ywrMo=;
        b=WjlB03xtnU+43wht78tHLoS8a424N3Kd+/ROTOPBFZ7Kk02fAInH1cmTngPOuY1KNe
         UeIBt8RalhfROJkDxcePklvzDqg8TmWtuYWfvTRq58aE+XIrld97k8ukOw8yPapfzKPS
         U7adjw89nSoej8pbAX+2Gj0ZNyJPVqhqYmxqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=va7gdVSZd9oGcktmFSi4633m1KmqtF16W8cC99ywrMo=;
        b=ZrQW+Q69R+ywbx4tYD8E+ImUuHxIPArPWcJe1ymldY44VpYZP1dsq+b/3kyx9qws9R
         7gM/3m3tfDj0u6W5z0W5tksuhLNVTA8jgzC1UCv9E4oOHHmVWJ0Ye/1kQymhAI2Uyc84
         AXCU3xjIci1mYuV3yZ0kMUcie9HdrPXCLIbbrCqRDWa2FoNhFSHSX2Tb2fhRVkAQjCAN
         TXVO9Qogd40tRKIbkmshhUuu2gtQCpmQvsWu0u1O+YK87en72Wb5qgS4s2OXxKhg42Dx
         i40R2DjcxbDYJ7eWbDSRBB2NSvXZYywOcOhBySVFfzvG30iwX8/2QqzRhY217P/WXNTl
         yLsg==
X-Gm-Message-State: AOAM5332W51pKri+mQu2AjQf7H/4TASBGAY0LHGfZiyc0zEwsZWujGwR
        sxB3jA8qDqFWtJnbtsK6Ct8ob2rNEGmVhg==
X-Google-Smtp-Source: ABdhPJy48awb963u3Jr6eP4TskOJYw/H3bcAOBQuCF1AsS/1fowlxgVQDhdVetgBTVCcuH5yHNXHFg==
X-Received: by 2002:a6b:d811:: with SMTP id y17mr2890886iob.16.1598909355836;
        Mon, 31 Aug 2020 14:29:15 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id j66sm4476366ili.71.2020.08.31.14.29.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2020 14:29:15 -0700 (PDT)
Subject: Re: [PATCH 1/2] kunit: support failure from dynamic analysis tools
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
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ae0e6555-5c10-4133-a975-3c28dca01d2f@linuxfoundation.org>
Date:   Mon, 31 Aug 2020 15:29:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200813205722.1384108-1-urielguajardojr@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/13/20 2:57 PM, Uriel Guajardo wrote:
> Adds an API to allow dynamic analysis tools to fail the currently
> running KUnit test case.
> 
> - Always places the kunit test in the task_struct to allow other tools
> to access the currently running KUnit test.
> 
> - Creates a new header file to avoid circular dependencies that could be
> created from the test.h file.
> 
> Requires KASAN-KUnit integration patch to access the kunit test from
> task_struct:
> https://lore.kernel.org/linux-kselftest/20200606040349.246780-2-davidgow@google.com/
> 
> Signed-off-by: Uriel Guajardo <urielguajardo@google.com>
> ---
>   include/kunit/test-bug.h | 24 ++++++++++++++++++++++++
>   include/kunit/test.h     |  1 +
>   lib/kunit/test.c         | 10 ++++++----
>   3 files changed, 31 insertions(+), 4 deletions(-)
>   create mode 100644 include/kunit/test-bug.h
> 
> diff --git a/include/kunit/test-bug.h b/include/kunit/test-bug.h
> new file mode 100644
> index 000000000000..283c19ec328f
> --- /dev/null
> +++ b/include/kunit/test-bug.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * KUnit API allowing dynamic analysis tools to interact with KUnit tests
> + *
> + * Copyright (C) 2020, Google LLC.
> + * Author: Uriel Guajardo <urielguajardo@google.com>
> + */
> +
> +#ifndef _KUNIT_TEST_BUG_H
> +#define _KUNIT_TEST_BUG_H
> +
> +#if IS_ENABLED(CONFIG_KUNIT)
> +
> +extern void kunit_fail_current_test(void);
> +
> +#else
> +
> +static inline void kunit_fail_current_test(void)
> +{
> +}
> +
> +#endif
> +
> +#endif /* _KUNIT_TEST_BUG_H */
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 3391f38389f8..81bf43a1abda 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -11,6 +11,7 @@
>   
>   #include <kunit/assert.h>
>   #include <kunit/try-catch.h>
> +#include <kunit/test-bug.h>
>   #include <linux/kernel.h>
>   #include <linux/module.h>
>   #include <linux/slab.h>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index dcc35fd30d95..d8189d827368 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -16,6 +16,12 @@
>   #include "string-stream.h"
>   #include "try-catch-impl.h"
>   
> +void kunit_fail_current_test(void)
> +{
> +	if (current->kunit_test)
> +		kunit_set_failure(current->kunit_test);
> +}
> +
>   static void kunit_print_tap_version(void)
>   {
>   	static bool kunit_has_printed_tap_version;
> @@ -284,9 +290,7 @@ static void kunit_try_run_case(void *data)
>   	struct kunit_suite *suite = ctx->suite;
>   	struct kunit_case *test_case = ctx->test_case;
>   
> -#if (IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT))
>   	current->kunit_test = test;
> -#endif /* IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT) */
>   
>   	/*
>   	 * kunit_run_case_internal may encounter a fatal error; if it does,
> @@ -602,9 +606,7 @@ void kunit_cleanup(struct kunit *test)
>   		spin_unlock(&test->lock);
>   		kunit_remove_resource(test, res);
>   	}
> -#if (IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT))
>   	current->kunit_test = NULL;
> -#endif /* IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT)*/
>   }
>   EXPORT_SYMBOL_GPL(kunit_cleanup);
>   
> 

Is this patch still needed. Doesn't apply on top of Linux 5.9. From
q quick review, doesn't looks like it is needed. Not seeing any
CONFIG_KASAN's in lib/kunit/test.c

Here is the .rej

--- lib/kunit/test.c
+++ lib/kunit/test.c
@@ -290,9 +296,7 @@ static void kunit_try_run_case(void *data)
         struct kunit_suite *suite = ctx->suite;
         struct kunit_case *test_case = ctx->test_case;

-#if (IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT))
         current->kunit_test = test;
-#endif /* IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT) */

         /*
          * kunit_run_case_internal may encounter a fatal error; if it does,
@@ -608,9 +612,7 @@ void kunit_cleanup(struct kunit *test)
                 spin_unlock(&test->lock);
                 kunit_remove_resource(test, res);
         }
-#if (IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT))
         current->kunit_test = NULL;
-#endif /* IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT)*/
  }
  EXPORT_SYMBOL_GPL(kunit_cleanup);

If this is still needed, please send me rebased patch.

thanks,
-- Shuah

