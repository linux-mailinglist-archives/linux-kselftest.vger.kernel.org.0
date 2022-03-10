Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1934D54D7
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Mar 2022 23:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343980AbiCJWuZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Mar 2022 17:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343951AbiCJWuY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Mar 2022 17:50:24 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B41D006B
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Mar 2022 14:49:21 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id dr20so15237921ejc.6
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Mar 2022 14:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X/rtu54ntkVXnZ8WzhCGXP7Ng7Fgx6ahBoAiWoEdfPI=;
        b=Tzc/GE6Ob61G7++79zVEuQGKO+ogy/3CB20AUrZdJUjo1sx41vjLvG+BMIGTdZoxB1
         Erf7uWEqzMBZb2IoSJC/G2Ca4Xi/oPJKvDIWf7s8Py+FL6LIb2g/4VQuTDsFBgXF3n5H
         4Z79gfx785IaI419QwidGq/mlIJ5ubUpuL8AKRkkokYS6pb/ku3dbtr5vK2CQxZwRBOy
         aEZxnbOXpvp8N20npvalpFp89W8dhnrTqiCIxmLGZkimL27HeAmHQhRXuahcpJmUJ9sw
         YPL+GFZ1uWa4nb1oFe0rtrUBQwChHvRd42wsy/ngQ+slNDpqK2d61m8R+Wqe6Il1JmwO
         bqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X/rtu54ntkVXnZ8WzhCGXP7Ng7Fgx6ahBoAiWoEdfPI=;
        b=Ai0V81iXExM4tYlNnhVeHRLZFzHnf54afcStIJfdhCnvts87kTZOs45mHPiznAygaX
         z+ErnS3NFQwHdSy0imIFwR3GUiToe9ZLU4NxPRJ3xqBUcVlJjoYnPrV20n0BH92Gss6q
         w5n4kzyEQKoiovgrZxrJG89+Vs8Y1Vs0Z0FGPR3ZYKSgma/6I064aLsnWZ5hGiHvBTnj
         qWmxRzhlQICxWBRHd4I/el/mkm+Mfwp2oy3wGWDc5UITYWZSnQOYG8/58xnRiUo9iFcF
         EAWumDxWSkus9Bewqauupmq1jrr+r0poTFojnJngu3hsyxGnF1+rl5mGYjNYDES0sas5
         XJ1w==
X-Gm-Message-State: AOAM533MK/ROzYntj7mY5x3kLTQ8veNrzbewa2WjvVwryFQbIRbougu6
        ZlDMBp2FBLZKlFfmhExfKqrmPWxIWaTPt5uayLVMqg==
X-Google-Smtp-Source: ABdhPJwvPdPyuimNpDBevrBCyvPyfsYSzk8kAV9GyxvoX1Uv2iDYVHx2fKq2U6+k0Gl472gvzynfUgHXOpbiBgT0qT0=
X-Received: by 2002:a17:907:eab:b0:6da:8ec5:d386 with SMTP id
 ho43-20020a1709070eab00b006da8ec5d386mr6264799ejc.668.1646952560219; Thu, 10
 Mar 2022 14:49:20 -0800 (PST)
MIME-Version: 1.0
References: <20220310210210.2124637-1-brendanhiggins@google.com>
In-Reply-To: <20220310210210.2124637-1-brendanhiggins@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 10 Mar 2022 17:49:08 -0500
Message-ID: <CAFd5g46NmmNy5ueRjDnCkgjHy75KVUXA0xcTXtXjxLg7mgKJng@mail.gmail.com>
Subject: Re: [RFC v1] kunit: add support for kunit_suites that reference init code
To:     shuah <shuah@kernel.org>, David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Martin Fernandez <martin.fernandez@eclypsium.com>,
        Daniel Gutson <daniel.gutson@eclypsium.com>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

+Jeremy Kerr - Just remembered that Jeremy is doing some work here and
might be somewhat interested.

On Thu, Mar 10, 2022 at 4:02 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> Add support for a new kind of kunit_suite registration macro called
> kunit_test_init_suite(); this new registration macro allows the
> registration of kunit_suites that reference functions marked __init and
> data marked __initdata.
>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>
> This patch is in response to a KUnit user issue[1] in which the user was
> attempting to test some init functions; although this is a functional
> solution as long as KUnit tests only run during the init phase, we will
> need to do more work if we ever allow tests to run after the init phase
> is over; it is for this reason that this patch adds a new registration
> macro rather than simply modifying the existing macros.
>
> [1] https://groups.google.com/g/kunit-dev/c/XDjieRHEneg/m/D0rFCwVABgAJ
>
> ---
>  include/kunit/test.h | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index b26400731c02..1878e585f6d3 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -379,6 +379,27 @@ static inline int kunit_run_all_tests(void)
>
>  #define kunit_test_suite(suite)        kunit_test_suites(&suite)
>
> +/**
> + * kunit_test_init_suites() - used to register one or more &struct kunit_suite
> + *                           containing init functions or init data.
> + *
> + * @__suites: a statically allocated list of &struct kunit_suite.
> + *
> + * This functions identically as &kunit_test_suites() except that it suppresses
> + * modpost warnings for referencing functions marked __init or data marked
> + * __initdata; this is OK because currently KUnit only runs tests upon boot
> + * during the init phase or upon loading a module during the init phase.
> + *
> + * NOTE TO KUNIT DEVS: If we ever allow KUnit tests to be run after boot, these
> + * tests must be excluded.
> + */
> +#define kunit_test_init_suites(__suites...)                            \
> +       __kunit_test_suites(CONCATENATE(__UNIQUE_ID(array), _probe),    \
> +                           CONCATENATE(__UNIQUE_ID(suites), _probe),   \
> +                           ##__suites)
> +
> +#define kunit_test_init_suite(suite)   kunit_test_init_suites(&suite)
> +
>  #define kunit_suite_for_each_test_case(suite, test_case)               \
>         for (test_case = suite->test_cases; test_case->run_case; test_case++)
>
>
> base-commit: 330f4c53d3c2d8b11d86ec03a964b86dc81452f5
> --
> 2.35.1.723.g4982287a31-goog
>
