Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296AE78F63B
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Sep 2023 01:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbjHaXz2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 31 Aug 2023 19:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjHaXz2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 31 Aug 2023 19:55:28 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D866AE67
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Aug 2023 16:55:24 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so2149a12.0
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Aug 2023 16:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693526123; x=1694130923; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TzKuvxVjpLuG4/D3ETobtmmczrwzc2VsfRbIMnqDDlw=;
        b=fU9u1ZE2aCwTMm4TaIwMR1j/NISUCynZcB13BvGDm0YMDtICquQ4BaA6Gzq36Pjx4W
         3UkT6MqXrf8iXIj7JToDalJmI4vztj9H6MEbV4uzQXDsNGeKKM+g3saNT9b44TtZxuqD
         O8DKdrYh6DUY0ZqB2L2UbAUtdjPdfaPqXMktO+D5D6KjQqKKrTzIlr54vEuS4cV7WhrX
         GcHn5b649KyDCoLiDYsEmyNYGrgZ+ypxgmVvbftScWHrGyw+R8hhkAQvR4DpNMRS/sVG
         C4WdNicitEJ/0RQImVi6iS2GahF0+0ZpHE5kMwVjPZpLlq4bL0xN0Yr+brxTDoBfTB4x
         zeAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693526123; x=1694130923;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TzKuvxVjpLuG4/D3ETobtmmczrwzc2VsfRbIMnqDDlw=;
        b=M4iWYGYpe7P+Lg15TRdOCvKVa5+pvPrsb44txSFYPIlpSIUhiViuZ+5Gd5zhq8Xbre
         qLkWowwHFo7pjpoiHw115QJfqMnNES7uVwmq/T01IgZ11jIEG0Dw0dB3BNZNjHGKyAmj
         6LY82Fv/MFC19umrsE39OM/jTjAbp2zNMpCSvS6yP+udcKVeEMcXIyA99nqGY2tvIgPj
         p/qaIYGdOuXlhwqHkVGV/rOMi6lGwoqiMzx49Ve5FMWYhX2uDq5uOj7I5qdnPrd/SjM5
         9lIqWxLpaPr5rfs3A38s1RIlJ/a4H7u3Ygx4WfnsVN2LIfGx256rsgWU80IbrlXk+wfi
         z3aQ==
X-Gm-Message-State: AOJu0YwYE+pxdrYKK4aOT/1CTFyka5rMPaULDVCvsxMRk9KRsdgsOkUK
        o/29O/n+zlae+8b2qAGw/UZN/O8bCVSihpi4RJR48A==
X-Google-Smtp-Source: AGHT+IFybbZH10Fb/r7tMdKRzzQm8Y3SYWPDLGFTwwDp7psJmHd4RtskpcL1018SfucK/pfWHC1I56L/M6RjnWarazc=
X-Received: by 2002:a50:c356:0:b0:51e:16c5:2004 with SMTP id
 q22-20020a50c356000000b0051e16c52004mr74144edb.6.1693526122598; Thu, 31 Aug
 2023 16:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230831214847.209-1-michal.wajdeczko@intel.com>
In-Reply-To: <20230831214847.209-1-michal.wajdeczko@intel.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 1 Sep 2023 07:55:08 +0800
Message-ID: <CABVgOSmiBvTpjzHngPZyJpjn7+sL_=eUEHaMStjgh7tK+pr+Vg@mail.gmail.com>
Subject: Re: [PATCH] kunit: Reset test status on each param iteration
To:     Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 1 Sept 2023 at 05:49, Michal Wajdeczko
<michal.wajdeczko@intel.com> wrote:
>
> If we skip one parametrized test case then test status remains
> SKIP for all subsequent test params leading to wrong reports:
>
> $ ./tools/testing/kunit/kunit.py run \
>         --kunitconfig ./lib/kunit/.kunitconfig *.example_params*
>         --raw_output \
>
> [ ] Starting KUnit Kernel (1/1)...
> KTAP version 1
> 1..1
>     # example: initializing suite
>     KTAP version 1
>     # Subtest: example
>     # module: kunit_example_test
>     1..1
>         KTAP version 1
>         # Subtest: example_params_test
>     # example_params_test: initializing
>     # example_params_test: cleaning up
>         ok 1 example value 3 # SKIP unsupported param value 3
>     # example_params_test: initializing
>     # example_params_test: cleaning up
>         ok 2 example value 2 # SKIP unsupported param value 3
>     # example_params_test: initializing
>     # example_params_test: cleaning up
>         ok 3 example value 1 # SKIP unsupported param value 3
>     # example_params_test: initializing
>     # example_params_test: cleaning up
>         ok 4 example value 0 # SKIP unsupported param value 0
>     # example_params_test: pass:0 fail:0 skip:4 total:4
>     ok 1 example_params_test # SKIP unsupported param value 0
>     # example: exiting suite
> ok 1 example # SKIP
>
> Reset test status and status comment after each param iteration
> to avoid using stale results.
>
> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> ---

Nice catch, thanks!

This looks good to me.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  lib/kunit/kunit-example-test.c | 5 +++--
>  lib/kunit/test.c               | 6 ++++--
>  2 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
> index 01a769f35e1d..6bb5c2ef6696 100644
> --- a/lib/kunit/kunit-example-test.c
> +++ b/lib/kunit/kunit-example-test.c
> @@ -190,6 +190,7 @@ static void example_static_stub_test(struct kunit *test)
>  static const struct example_param {
>         int value;
>  } example_params_array[] = {
> +       { .value = 3, },
>         { .value = 2, },
>         { .value = 1, },
>         { .value = 0, },
> @@ -213,8 +214,8 @@ static void example_params_test(struct kunit *test)
>         KUNIT_ASSERT_NOT_NULL(test, param);
>
>         /* Test can be skipped on unsupported param values */
> -       if (!param->value)
> -               kunit_skip(test, "unsupported param value");
> +       if (!is_power_of_2(param->value))
> +               kunit_skip(test, "unsupported param value %d", param->value);
>
>         /* You can use param values for parameterized testing */
>         KUNIT_EXPECT_EQ(test, param->value % param->value, 0);

I'm a little tempted to change this to something more power-of-two
specific now, like param->value & (param->value - 1). Thoughts?

> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 49698a168437..a53fd7e6d5bf 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -648,12 +648,14 @@ int kunit_run_tests(struct kunit_suite *suite)
>                                                       param_desc,
>                                                       test.status_comment);
>
> +                               kunit_update_stats(&param_stats, test.status);
> +
>                                 /* Get next param. */
>                                 param_desc[0] = '\0';
>                                 test.param_value = test_case->generate_params(test.param_value, param_desc);
>                                 test.param_index++;
> -
> -                               kunit_update_stats(&param_stats, test.status);
> +                               test.status = KUNIT_SUCCESS;
> +                               test.status_comment[0] = '\0';
>                         }
>                 }
>
> --
> 2.25.1
>
