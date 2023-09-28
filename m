Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6AB7B26DF
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Sep 2023 22:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbjI1Uxl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Sep 2023 16:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjI1Uxk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Sep 2023 16:53:40 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1E91A3
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Sep 2023 13:53:37 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4053f24c900so6135e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Sep 2023 13:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695934416; x=1696539216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVbF5KgvJWMqO//UWefz7jqGRx5GGVcweE1GpPMLmNQ=;
        b=jqqKf6efLTlMUnz037WY8EmN+Cguz8jpn/+mhtyFe/tBUsMwFTnBJfteUDDNOmxQ3G
         yTONv84Qa4PTB4fPg2OMzzJfuahuT2giEiJmTQKJ3nWkS6OYgyczo2tqOnTIlPhDS5nA
         cD6iOWax9co17B3Kid3AAsxtbE+Cb8po6+rSq2ckdM2r0BPkrWn4I4H/P2qBlSackGN5
         HfcW789I++g3dyUPrxBsPSVIB9D9ZOFUtkwSAz/JFyRUULfwDsuRX7pGqUeLx9jvymod
         8Mcuf6Wqq2SVUzc/qeCOpFeH0x7mz7A+f++plYCzu35X9NoIJdjfKXlBvTWyGDLGRCzp
         GaWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695934416; x=1696539216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JVbF5KgvJWMqO//UWefz7jqGRx5GGVcweE1GpPMLmNQ=;
        b=KHz/rncoi0VUBtXzy6CdKmL0oj11VZftcJ4AmjyuIzko2+Tpejcflx/LUxo9P/+cwL
         8NE8OaxJKdS199nVifQkSqPOJZuU82O355xMTPNPuFJCjU1iLVvCR68eDTzzLHwISz1o
         JAmm42hyZ3Cdw7WRRkrVZ4DsZ+gIZBCyVD7SAUuLCxneATjkUAYK6Rgg9/dFkgvHf0k7
         ilnno01J6o+QC1AkqsB7xUsAdQbsxB++kapI8G8gpSszg9/CctSsBK7EtDZh/XNtJDMT
         439vwhcQIBLK01ATUjOkvPOCAn0wz4Ov9DKxKyAw5dTthoT8B0K9DLp0h4Z0ug4S63Dv
         P8sg==
X-Gm-Message-State: AOJu0Yylt+2Ucyt0s44D19wK9LcIH7SOv560OFJHsdqqec+u/0Gh852l
        G2DeUSLW14G2D/DjJ0CC6tEyZE8wHfVXfn3vUbd4pQ==
X-Google-Smtp-Source: AGHT+IGjdf0KFLisZ2GkteQBRCfgnd2JScoWl1Kg4MGaaLs8e3XKB0BIY5J3daDPxpqZx8bJ0qI3OJJPhpjx1Kf8iGo=
X-Received: by 2002:a05:600c:34c8:b0:405:38d1:e146 with SMTP id
 d8-20020a05600c34c800b0040538d1e146mr404100wmq.4.1695934416021; Thu, 28 Sep
 2023 13:53:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230925175733.1379-1-michal.wajdeczko@intel.com> <20230925175733.1379-4-michal.wajdeczko@intel.com>
In-Reply-To: <20230925175733.1379-4-michal.wajdeczko@intel.com>
From:   Rae Moar <rmoar@google.com>
Date:   Thu, 28 Sep 2023 16:53:23 -0400
Message-ID: <CA+GJov5L=0tMb+VdHgS+LgFWsQ6dJtVPVb6O2X=1Xa1yR1jzVA@mail.gmail.com>
Subject: Re: [PATCH 3/4] kunit: Fix indentation of parameterized tests messages
To:     Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Sep 25, 2023 at 1:58=E2=80=AFPM Michal Wajdeczko
<michal.wajdeczko@intel.com> wrote:
>
> When running parametrized test cases, diagnostic messages
> are not properly aligned with the test result lines:
>
>     $ ./tools/testing/kunit/kunit.py run --raw_output \
>         --kunitconfig ./lib/kunit/.kunitconfig *.example_params*
>
>     KTAP version 1
>     1..1
>     # example: initializing suite
>         KTAP version 1
>         # Subtest: example
>         # module: kunit_example_test
>         1..1
>             KTAP version 1
>             # Subtest: example_params_test
>         # example_params_test: initializing
>         # example_params_test: cleaning up
>             ok 1 example value 3 # SKIP unsupported param value 3
>         # example_params_test: initializing
>         # example_params_test: cleaning up
>             ok 2 example value 2
>         # example_params_test: initializing
>         # example_params_test: cleaning up
>             ok 3 example value 1
>         # example_params_test: initializing
>         # example_params_test: cleaning up
>             ok 4 example value 0 # SKIP unsupported param value 0
>         # example_params_test: pass:2 fail:0 skip:2 total:4
>         ok 1 example_params_test
>     # example: exiting suite
>     # Totals: pass:2 fail:0 skip:2 total:4
>     ok 1 example
>
> Add test level attribute and use it to generate proper indent
> at the runtime:
>
>     KTAP version 1
>     1..1
>     # example: initializing suite
>         KTAP version 1
>         # Subtest: example
>         # module: kunit_example_test
>         1..1
>             KTAP version 1
>             # Subtest: example_params_test
>             # example_params_test: initializing
>             # example_params_test: cleaning up
>             ok 1 example value 3 # SKIP unsupported param value 3
>             # example_params_test: initializing
>             # example_params_test: cleaning up
>             ok 2 example value 2
>             # example_params_test: initializing
>             # example_params_test: cleaning up
>             ok 3 example value 1
>             # example_params_test: initializing
>             # example_params_test: cleaning up
>             ok 4 example value 0 # SKIP unsupported param value 0
>         # example_params_test: pass:2 fail:0 skip:2 total:4
>         ok 1 example_params_test
>     # example: exiting suite
>     # Totals: pass:2 fail:0 skip:2 total:4
>     ok 1 example
>
> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>

Hello!

Great to see these changes! Just a few comments below.

Thanks!
-Rae

> ---
>  include/kunit/test.h |  3 ++-
>  lib/kunit/test.c     | 52 ++++++++++++++++++++------------------------
>  2 files changed, 26 insertions(+), 29 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 158876c4cb43..4804d539e10f 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -276,6 +276,7 @@ struct kunit {
>         void *priv;
>
>         /* private: internal use only. */
> +       unsigned int level; /* Helps in proper log indent */
>         const char *name; /* Read only after initialization! */
>         struct string_stream *log; /* Points at case log after initializa=
tion */
>         struct kunit_try_catch try_catch;
> @@ -519,7 +520,7 @@ enum {
>  #define kunit_level(test_or_suite)                                     \
>         _Generic((test_or_suite),                                       \
>                  struct kunit_suite * : KUNIT_LEVEL_SUITE,              \
> -                struct kunit * : KUNIT_LEVEL_CASE)
> +                struct kunit * : ((struct kunit *)(test_or_suite))->leve=
l)
>
>  #define kunit_indent_level(test_or_suite)                              \
>         (KUNIT_INDENT_LEN * kunit_level(test_or_suite))
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index d10e6d610e20..43c3efc286e4 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -99,14 +99,13 @@ static void kunit_print_test_stats(struct kunit *test=
,
>         if (!kunit_should_print_stats(stats))
>                 return;
>
> -       kunit_log(KERN_INFO, test,
> -                 KUNIT_SUBTEST_INDENT
> -                 "# %s: pass:%lu fail:%lu skip:%lu total:%lu",
> -                 test->name,
> -                 stats.passed,
> -                 stats.failed,
> -                 stats.skipped,
> -                 stats.total);
> +       kunit_log_indent(KERN_INFO, test,
> +                        "# %s: pass:%lu fail:%lu skip:%lu total:%lu",
> +                        test->name,
> +                        stats.passed,
> +                        stats.failed,
> +                        stats.skipped,
> +                        stats.total);

I would prefer if we keep the same indentation level as before.
Otherwise looks good.

>  }
>
>  /* Append formatted message to log. */
> @@ -154,7 +153,6 @@ static void kunit_print_suite_start(struct kunit_suit=
e *suite)
>  }
>
>  static void kunit_print_ok_not_ok(struct kunit *test,
> -                                 unsigned int test_level,
>                                   enum kunit_status status,
>                                   size_t test_number,
>                                   const char *description,
> @@ -163,12 +161,6 @@ static void kunit_print_ok_not_ok(struct kunit *test=
,
>         const char *directive_header =3D (status =3D=3D KUNIT_SKIPPED) ? =
" # SKIP " : "";
>         const char *directive_body =3D (status =3D=3D KUNIT_SKIPPED) ? di=
rective : "";
>
> -       /*
> -        * When test is NULL assume that results are from the suite
> -        * and today suite results are expected at level 0 only.
> -        */
> -       WARN(!test && test_level, "suite test level can't be %u!\n", test=
_level);
> -
>         /*
>          * We do not log the test suite results as doing so would
>          * mean debugfs display would consist of an incorrect test
> @@ -182,12 +174,11 @@ static void kunit_print_ok_not_ok(struct kunit *tes=
t,
>                         test_number, description, directive_header,
>                         directive_body);
>         else
> -               kunit_log(KERN_INFO, test,
> -                         "%*s%s %zd %s%s%s",
> -                         KUNIT_INDENT_LEN * test_level, "",
> -                         kunit_status_to_ok_not_ok(status),
> -                         test_number, description, directive_header,
> -                         directive_body);
> +               kunit_log_indent(KERN_INFO, test,
> +                                "%s %zd %s%s%s",
> +                                kunit_status_to_ok_not_ok(status),
> +                                test_number, description, directive_head=
er,
> +                                directive_body);

Again, I would prefer we keep the same indentation as before as it
matches the rest of the file.


>  }
>
>  enum kunit_status kunit_suite_has_succeeded(struct kunit_suite *suite)
> @@ -213,7 +204,7 @@ static size_t kunit_suite_counter =3D 1;
>
>  static void kunit_print_suite_end(struct kunit_suite *suite)
>  {
> -       kunit_print_ok_not_ok(NULL, KUNIT_LEVEL_SUITE,
> +       kunit_print_ok_not_ok(NULL,
>                               kunit_suite_has_succeeded(suite),
>                               kunit_suite_counter++,
>                               suite->name,
> @@ -322,6 +313,7 @@ void kunit_init_test(struct kunit *test, const char *=
name, struct string_stream
>  {
>         spin_lock_init(&test->lock);
>         INIT_LIST_HEAD(&test->resources);
> +       test->level =3D KUNIT_LEVEL_CASE;
>         test->name =3D name;
>         test->log =3D log;
>         if (test->log)
> @@ -584,14 +576,15 @@ int kunit_run_tests(struct kunit_suite *suite)
>                         kunit_run_case_catch_errors(suite, test_case, &te=
st);
>                         kunit_update_stats(&param_stats, test.status);
>                 } else {
> +                       /* Parameterized test is one level up from simple=
 test-case. */
> +                       test.level++;
> +
>                         /* Get initial param. */
>                         param_desc[0] =3D '\0';
>                         test.param_value =3D test_case->generate_params(N=
ULL, param_desc);
>                         test_case->status =3D KUNIT_SKIPPED;
> -                       kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT =
KUNIT_SUBTEST_INDENT
> -                                 "KTAP version 1\n");
> -                       kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT =
KUNIT_SUBTEST_INDENT
> -                                 "# Subtest: %s", test_case->name);
> +                       kunit_log_indent(KERN_INFO, &test, "KTAP version =
1\n");
> +                       kunit_log_indent(KERN_INFO, &test, "# Subtest: %s=
", test_case->name);
>
>                         while (test.param_value) {
>                                 kunit_run_case_catch_errors(suite, test_c=
ase, &test);
> @@ -601,7 +594,7 @@ int kunit_run_tests(struct kunit_suite *suite)
>                                                  "param-%d", test.param_i=
ndex);
>                                 }
>
> -                               kunit_print_ok_not_ok(&test, KUNIT_LEVEL_=
CASE_PARAM,
> +                               kunit_print_ok_not_ok(&test,
>                                                       test.status,
>                                                       test.param_index + =
1,
>                                                       param_desc,
> @@ -616,13 +609,16 @@ int kunit_run_tests(struct kunit_suite *suite)
>                                 test.status =3D KUNIT_SUCCESS;
>                                 test.status_comment[0] =3D '\0';
>                         }
> +
> +                       /* Return to parent (test-case) level. */
> +                       test.level--;
>                 }
>
>                 kunit_print_attr((void *)test_case, true, KUNIT_LEVEL_CAS=
E);
>
>                 kunit_print_test_stats(&test, param_stats);
>
> -               kunit_print_ok_not_ok(&test, KUNIT_LEVEL_CASE, test_case-=
>status,
> +               kunit_print_ok_not_ok(&test, test_case->status,
>                                       kunit_test_case_num(suite, test_cas=
e),
>                                       test_case->name,
>                                       test.status_comment);
> --
> 2.25.1
>
