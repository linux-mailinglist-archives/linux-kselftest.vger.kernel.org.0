Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7206E002F
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Apr 2023 22:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjDLUvy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Apr 2023 16:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjDLUvx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Apr 2023 16:51:53 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D96561A1
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Apr 2023 13:51:49 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-54fa9da5e5bso42706057b3.1
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Apr 2023 13:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681332708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCZrhoV+/354OTqly0Uye8DxBZZCQU9aJWnOJaeytLc=;
        b=bzw42xFyehhC/5Xz33OYpW8EGTb98ZqNfHMpuCe9LWxy0N4PBKrKnZX7z0MCl0i0Ah
         W926grTsXGXLXw03b10JyrAE4KEZYltAstbh2CcGXW8NecJuW52H0VHYi9kAdZCY7C/n
         d1+NY4D9INBYy7UmQ1t5o4WKWBjddwpZZC0TKOwpNGMctNlTWYlNmkDASjG2SH4rWdeZ
         IEjQLbfuaZytd86oD1E43Cr5iC3j6760SeiZBvH1cqo/vfQaUZpxOkdi2Yy3TWI0iGcC
         DZB/fnE9dZgnyaZD41/cHWSRdqunahWOPPndCM7v2eeAGFIZn1meOhM0kLMRil7dx7Rf
         iknA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681332708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MCZrhoV+/354OTqly0Uye8DxBZZCQU9aJWnOJaeytLc=;
        b=dCnic38XDlk7JaVv8+//B4Loq7SteXzOOar5GWK2tqHGnf5sNMapPMZ8B5/4Ta3Y3I
         mE3ls6bU2WSnaKFpwiB+3wfNY9sH/yPqGei4bQS+0o7i3kUbYunI4WaRV9qv38L7OCS1
         JTOfTNiz2SE5kTMRCHkUoZZlB5+UnQo16vhUFA14OgWhHUUPmAPICkgRhYKVSNHKNtBM
         xumdZBSdakIxbER94qi1OONWev0PqFV026jbjfaQ2CbZHDVMp+DW+y1aNX1Nbsix3TO/
         spdhKI6sWmQ+yeoLv65xJd0H5dKuD+hRo7CRUFYRrU5OB8JD5U9x/6ecYld6NFWeBu4F
         GgjA==
X-Gm-Message-State: AAQBX9fxbAEUYNRL23QFSMd/gAq1nG18veI1ft3+Xx6VV+eRONyyYicu
        +gkhzrMc2q1f6ZLF5TJtZ2Lffsm4Aqb/ab0lsRGPeu7yY8gHIpRYzOq62g==
X-Google-Smtp-Source: AKy350YzvnHyNAddeUGzN50vhPRImsX6LCGIjUUTPuR8YsUc1kDS7VCY0XvHMEno8hnCe10m5IgJhJgZnQ2aBdEUOQg=
X-Received: by 2002:a81:4520:0:b0:545:7143:2940 with SMTP id
 s32-20020a814520000000b0054571432940mr2791606ywa.0.1681332708140; Wed, 12 Apr
 2023 13:51:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230411160056.1586-1-michal.wajdeczko@intel.com> <20230411160056.1586-2-michal.wajdeczko@intel.com>
In-Reply-To: <20230411160056.1586-2-michal.wajdeczko@intel.com>
From:   Rae Moar <rmoar@google.com>
Date:   Wed, 12 Apr 2023 16:51:36 -0400
Message-ID: <CA+GJov4g+D=9nwcVUsKsmM_4j41J_eBee5Nmt-OmHqhfuEKqsg@mail.gmail.com>
Subject: Re: [PATCH 1/3] kunit/test: Add example test showing parameterized testing
To:     Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Apr 11, 2023 at 12:01=E2=80=AFPM Michal Wajdeczko
<michal.wajdeczko@intel.com> wrote:
>
> Use of parameterized testing is documented [1] but such use case
> is not present in demo kunit test. Add small subtest for that.
>
> [1] https://kernel.org/doc/html/latest/dev-tools/kunit/usage.html#paramet=
erized-testing
>
> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
> Cc: David Gow <davidgow@google.com>
> ---

Hello!

This looks all pretty good to me! I only have one comment. In the KTAP outp=
ut:

        KTAP version 1
        # Subtest: example_params_test
    # example_params_test: initializing
        ok 1 example value 2
    # example_params_test: initializing
        ok 2 example value 1
    # example_params_test: initializing
       ok 3 example value 0 # SKIP unsupported param value
    # example_params_test: pass:2 fail:0 skip:1 total:3
    ok 6 example_params_test

The init method is causing the "# example_params_test: initializing"
to print lines for each case. However, since they are not inline with
the correct indentation and they don't include helpful test data, I
would consider finding a way to remove these.

We could consider removing these lines from the test suite as a whole.
However, they are helpful in that they show how to use the init
function. Maybe check if the test is a param test case in the init
function itself? Let me know what you think.

Thanks!

Rae

>  lib/kunit/kunit-example-test.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-tes=
t.c
> index cd8b7e51d02b..775443f77763 100644
> --- a/lib/kunit/kunit-example-test.c
> +++ b/lib/kunit/kunit-example-test.c
> @@ -167,6 +167,39 @@ static void example_static_stub_test(struct kunit *t=
est)
>         KUNIT_EXPECT_EQ(test, add_one(1), 2);
>  }
>
> +static const struct example_param {
> +       int value;
> +} example_params_array[] =3D {
> +       { .value =3D 2, },
> +       { .value =3D 1, },
> +       { .value =3D 0, },
> +};
> +
> +static void example_param_get_desc(const struct example_param *p, char *=
desc)
> +{
> +       snprintf(desc, KUNIT_PARAM_DESC_SIZE, "example value %d", p->valu=
e);
> +}
> +
> +KUNIT_ARRAY_PARAM(example, example_params_array, example_param_get_desc)=
;
> +
> +/*
> + * This test shows the use of params.
> + */
> +static void example_params_test(struct kunit *test)
> +{
> +       const struct example_param *param =3D test->param_value;
> +
> +       /* By design, param pointer will not be NULL */
> +       KUNIT_ASSERT_NOT_NULL(test, param);
> +
> +       /* Test can be skipped on unsupported param values */
> +       if (!param->value)
> +               kunit_skip(test, "unsupported param value");
> +
> +       /* You can use param values for parameterized testing */
> +       KUNIT_EXPECT_EQ(test, param->value % param->value, 0);
> +}
> +
>  /*
>   * Here we make a list of all the test cases we want to add to the test =
suite
>   * below.
> @@ -183,6 +216,7 @@ static struct kunit_case example_test_cases[] =3D {
>         KUNIT_CASE(example_mark_skipped_test),
>         KUNIT_CASE(example_all_expect_macros_test),
>         KUNIT_CASE(example_static_stub_test),
> +       KUNIT_CASE_PARAM(example_params_test, example_gen_params),
>         {}
>  };
>
> --
> 2.25.1
>
> --
> You received this message because you are subscribed to the Google Groups=
 "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kunit-dev/20230411160056.1586-2-michal.wajdeczko%40intel.com.
