Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF6F773508
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 01:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjHGXc6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Aug 2023 19:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjHGXc5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Aug 2023 19:32:57 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1E718F
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Aug 2023 16:32:55 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fe32ec7201so18145e9.1
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Aug 2023 16:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691451174; x=1692055974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hk5wWJ5y+xcA717b1to0UM3KKGoj2M4JnsBCjlgxkdQ=;
        b=S2p731oYUxk3HCZ8+uLzkqMQ71Elw0yB7hgIuGDH0FUq8jJFU50uik2k2lPajzpwER
         jkARbTqzMzqwrGh5l9yTZrzbvjJWxIzvWTD0dOWTvhVijfvglHW5+D9VPo/acNFSg8TC
         sDNV6PvkfrW4tjJ3Pw4IhvBZ0dqjvqskodh+4j884Qtbz3pLlTc5VkN0GF5OMz35AUvg
         lyrL0e2zsF9KkdhVwpJVEGnXGvE2I4+mpITDoxucZBL5r661e9dlx/t1/Kp2NA+YvQLZ
         sHW5mkoSfGmbHTc11pXQApM9ydkMBLWQkASSV1IckcTFT3iDSvI16gdDXNZ1BHqf5P1c
         WOUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691451174; x=1692055974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hk5wWJ5y+xcA717b1to0UM3KKGoj2M4JnsBCjlgxkdQ=;
        b=jDasnusN74oCaw/LsOzK7tXTIeKKM+KcbTq8k6B7caCErKS7w+io0jkyVHnCa05AJk
         czaN2M5y72o/svP99BPZ0dzj3z8BIJdelNNfpeqNCmmPis6PlSL3r9EEr02dfdhJsyUT
         1KgV7UslJdNIlhNXEsFVQ9PDUYBq8f/L3YyJ+icfWek78JzanPbv+5Fnjt6SB7abizZA
         9MLwtG//22ueiZ4eHNen53QJqgyJAMCUnZOQXvYuFi0xXecxoFcH4TNBgUBOzk0a6KIm
         OmB4RiAdzb7vtUxvxqbh2cUL7QT94yk9B/tlFM2wFjpTZyN4pcUgaejFWCb0xvgzYL3x
         TA/g==
X-Gm-Message-State: AOJu0Ywt8wWszugG2uVbvXgBZM+nH6lZq2GpmHnFh/dEvQ+bsnHelwas
        wdyC3MjZz1qWJJt622LDLmawnM+Szbv2AI/IwiCEjg==
X-Google-Smtp-Source: AGHT+IHs1K3JWUN33cgTUjw6sByW5sJje7kFen+dPM5BLi5mOF92eke+sVgjo73w/c/hnc31anedzBaLVai9u0nUYYY=
X-Received: by 2002:a05:600c:1e2a:b0:3f6:f4b:d4a6 with SMTP id
 ay42-20020a05600c1e2a00b003f60f4bd4a6mr255530wmb.7.1691451173970; Mon, 07 Aug
 2023 16:32:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230807102352.4607-5-janusz.krzysztofik@linux.intel.com> <20230807102352.4607-6-janusz.krzysztofik@linux.intel.com>
In-Reply-To: <20230807102352.4607-6-janusz.krzysztofik@linux.intel.com>
From:   Rae Moar <rmoar@google.com>
Date:   Mon, 7 Aug 2023 19:32:38 -0400
Message-ID: <CA+GJov7Y4Ampk++ACtFV+ntzkBCDQGKexPG1_yWDt7-J=C2y-w@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] kunit: Report the count of test suites in a module
To:     Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        igt-dev@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
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

On Mon, Aug 7, 2023 at 6:28=E2=80=AFAM Janusz Krzysztofik
<janusz.krzysztofik@linux.intel.com> wrote:
>
> According to KTAP specification[1], results should always start from a
> header that provides a TAP protocol version, followed by a test plan with
> a count of items to be executed.  That pattern should be followed at each
> nesting level.  In the current implementation of the top-most, i.e., test
> suite level, those rules apply only for test suites built into the kernel=
,
> executed and reported on boot.  Results submitted to dmesg from kunit tes=
t
> modules loaded later are missing those top-level headers.
>
> As a consequence, if a kunit test module provides more than one test suit=
e
> then, without the top level test plan, external tools that are parsing
> dmesg for kunit test output are not able to tell how many test suites
> should be expected and whether to continue parsing after complete output
> from the first test suite is collected.
>
> Submit the top-level headers also from the kunit test module notifier
> initialization callback.
>
> v3: Fix new name of a structure moved to kunit namespace not updated in
>     executor_test functions (lkp@intel.com).
> v2: Use kunit_exec_run_tests() (Mauro, Rae), but prevent it from
>     emitting the headers when called on load of non-test modules.
>

Hello!

This patch looks good. This series also applies cleanly for me now.

I have tested this patch and it works well. I realize this is a bigger
change by exposing the executor function but I think it is overall
cleaner. I am interested in what David Gow thinks about the change.

Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!
Rae

> [1] https://docs.kernel.org/dev-tools/ktap.html#
>
> Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Rae Moar <rmoar@google.com>
> ---
>  include/kunit/test.h      |  8 ++++++++
>  lib/kunit/executor.c      | 42 +++++++++++++++++++++------------------
>  lib/kunit/executor_test.c | 36 ++++++++++++++++++++++-----------
>  lib/kunit/test.c          |  6 +++++-
>  4 files changed, 60 insertions(+), 32 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 011e0d6bb506c..3d002e6b252f2 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -256,6 +256,12 @@ struct kunit_suite {
>         int suite_init_err;
>  };
>
> +/* Stores an array of suites, end points one past the end */
> +struct kunit_suite_set {
> +       struct kunit_suite * const *start;
> +       struct kunit_suite * const *end;
> +};
> +
>  /**
>   * struct kunit - represents a running instance of a test.
>   *
> @@ -317,6 +323,8 @@ int __kunit_test_suites_init(struct kunit_suite * con=
st * const suites, int num_
>
>  void __kunit_test_suites_exit(struct kunit_suite **suites, int num_suite=
s);
>
> +void kunit_exec_run_tests(struct kunit_suite_set *suite_set, bool builti=
n);
> +
>  #if IS_BUILTIN(CONFIG_KUNIT)
>  int kunit_run_all_tests(void);
>  #else
> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> index dc295150c4e57..5ef90c334eb0f 100644
> --- a/lib/kunit/executor.c
> +++ b/lib/kunit/executor.c
> @@ -104,13 +104,7 @@ kunit_filter_glob_tests(const struct kunit_suite *co=
nst suite, const char *test_
>  static char *kunit_shutdown;
>  core_param(kunit_shutdown, kunit_shutdown, charp, 0644);
>
> -/* Stores an array of suites, end points one past the end */
> -struct suite_set {
> -       struct kunit_suite * const *start;
> -       struct kunit_suite * const *end;
> -};
> -
> -static void kunit_free_suite_set(struct suite_set suite_set)
> +static void kunit_free_suite_set(struct kunit_suite_set suite_set)
>  {
>         struct kunit_suite * const *suites;
>
> @@ -119,16 +113,17 @@ static void kunit_free_suite_set(struct suite_set s=
uite_set)
>         kfree(suite_set.start);
>  }
>
> -static struct suite_set kunit_filter_suites(const struct suite_set *suit=
e_set,
> -                                           const char *filter_glob,
> -                                               char *filters,
> -                                               char *filter_action,
> -                                           int *err)
> +static struct kunit_suite_set
> +kunit_filter_suites(const struct kunit_suite_set *suite_set,
> +                   const char *filter_glob,
> +                   char *filters,
> +                   char *filter_action,
> +                   int *err)
>  {
>         int i, j, k;
>         int filter_count =3D 0;
>         struct kunit_suite **copy, **copy_start, *filtered_suite, *new_fi=
ltered_suite;
> -       struct suite_set filtered =3D {NULL, NULL};
> +       struct kunit_suite_set filtered =3D {NULL, NULL};
>         struct kunit_glob_filter parsed_glob;
>         struct kunit_attr_filter *parsed_filters =3D NULL;
>
> @@ -230,17 +225,24 @@ static void kunit_handle_shutdown(void)
>
>  }
>
> -static void kunit_exec_run_tests(struct suite_set *suite_set)
> +#endif
> +
> +void kunit_exec_run_tests(struct kunit_suite_set *suite_set, bool builti=
n)
>  {
>         size_t num_suites =3D suite_set->end - suite_set->start;
>
> -       pr_info("KTAP version 1\n");
> -       pr_info("1..%zu\n", num_suites);
> +       if (builtin || num_suites) {
> +               pr_info("KTAP version 1\n");
> +               pr_info("1..%zu\n", num_suites);
> +       }
>
>         __kunit_test_suites_init(suite_set->start, num_suites);
>  }
>
> -static void kunit_exec_list_tests(struct suite_set *suite_set, bool incl=
ude_attr)
> +#if IS_BUILTIN(CONFIG_KUNIT)
> +
> +static void kunit_exec_list_tests(struct kunit_suite_set *suite_set,
> +                                 bool include_attr)
>  {
>         struct kunit_suite * const *suites;
>         struct kunit_case *test_case;
> @@ -265,7 +267,9 @@ static void kunit_exec_list_tests(struct suite_set *s=
uite_set, bool include_attr
>
>  int kunit_run_all_tests(void)
>  {
> -       struct suite_set suite_set =3D {__kunit_suites_start, __kunit_sui=
tes_end};
> +       struct kunit_suite_set suite_set =3D {
> +               __kunit_suites_start, __kunit_suites_end,
> +       };
>         int err =3D 0;
>         if (!kunit_enabled()) {
>                 pr_info("kunit: disabled\n");
> @@ -282,7 +286,7 @@ int kunit_run_all_tests(void)
>         }
>
>         if (!action_param)
> -               kunit_exec_run_tests(&suite_set);
> +               kunit_exec_run_tests(&suite_set, true);
>         else if (strcmp(action_param, "list") =3D=3D 0)
>                 kunit_exec_list_tests(&suite_set, false);
>         else if (strcmp(action_param, "list_attr") =3D=3D 0)
> diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
> index 3e0a1c99cb4e8..4084071d0eb5b 100644
> --- a/lib/kunit/executor_test.c
> +++ b/lib/kunit/executor_test.c
> @@ -43,8 +43,10 @@ static void parse_filter_test(struct kunit *test)
>  static void filter_suites_test(struct kunit *test)
>  {
>         struct kunit_suite *subsuite[3] =3D {NULL, NULL};
> -       struct suite_set suite_set =3D {.start =3D subsuite, .end =3D &su=
bsuite[2]};
> -       struct suite_set got;
> +       struct kunit_suite_set suite_set =3D {
> +               .start =3D subsuite, .end =3D &subsuite[2],
> +       };
> +       struct kunit_suite_set got;
>         int err =3D 0;
>
>         subsuite[0] =3D alloc_fake_suite(test, "suite1", dummy_test_cases=
);
> @@ -67,8 +69,10 @@ static void filter_suites_test(struct kunit *test)
>  static void filter_suites_test_glob_test(struct kunit *test)
>  {
>         struct kunit_suite *subsuite[3] =3D {NULL, NULL};
> -       struct suite_set suite_set =3D {.start =3D subsuite, .end =3D &su=
bsuite[2]};
> -       struct suite_set got;
> +       struct kunit_suite_set suite_set =3D {
> +               .start =3D subsuite, .end =3D &subsuite[2],
> +       };
> +       struct kunit_suite_set got;
>         int err =3D 0;
>
>         subsuite[0] =3D alloc_fake_suite(test, "suite1", dummy_test_cases=
);
> @@ -94,8 +98,10 @@ static void filter_suites_test_glob_test(struct kunit =
*test)
>  static void filter_suites_to_empty_test(struct kunit *test)
>  {
>         struct kunit_suite *subsuite[3] =3D {NULL, NULL};
> -       struct suite_set suite_set =3D {.start =3D subsuite, .end =3D &su=
bsuite[2]};
> -       struct suite_set got;
> +       struct kunit_suite_set suite_set =3D {
> +               .start =3D subsuite, .end =3D &subsuite[2],
> +       };
> +       struct kunit_suite_set got;
>         int err =3D 0;
>
>         subsuite[0] =3D alloc_fake_suite(test, "suite1", dummy_test_cases=
);
> @@ -144,8 +150,10 @@ static struct kunit_case dummy_attr_test_cases[] =3D=
 {
>  static void filter_attr_test(struct kunit *test)
>  {
>         struct kunit_suite *subsuite[3] =3D {NULL, NULL};
> -       struct suite_set suite_set =3D {.start =3D subsuite, .end =3D &su=
bsuite[2]};
> -       struct suite_set got;
> +       struct kunit_suite_set suite_set =3D {
> +               .start =3D subsuite, .end =3D &subsuite[2],
> +       };
> +       struct kunit_suite_set got;
>         int err =3D 0;
>
>         subsuite[0] =3D alloc_fake_suite(test, "normal_suite", dummy_attr=
_test_cases);
> @@ -179,8 +187,10 @@ static void filter_attr_test(struct kunit *test)
>  static void filter_attr_empty_test(struct kunit *test)
>  {
>         struct kunit_suite *subsuite[3] =3D {NULL, NULL};
> -       struct suite_set suite_set =3D {.start =3D subsuite, .end =3D &su=
bsuite[2]};
> -       struct suite_set got;
> +       struct kunit_suite_set suite_set =3D {
> +               .start =3D subsuite, .end =3D &subsuite[2],
> +       };
> +       struct kunit_suite_set got;
>         int err =3D 0;
>
>         subsuite[0] =3D alloc_fake_suite(test, "suite1", dummy_attr_test_=
cases);
> @@ -197,8 +207,10 @@ static void filter_attr_empty_test(struct kunit *tes=
t)
>  static void filter_attr_skip_test(struct kunit *test)
>  {
>         struct kunit_suite *subsuite[2] =3D {NULL};
> -       struct suite_set suite_set =3D {.start =3D subsuite, .end =3D &su=
bsuite[1]};
> -       struct suite_set got;
> +       struct kunit_suite_set suite_set =3D {
> +               .start =3D subsuite, .end =3D &subsuite[1],
> +       };
> +       struct kunit_suite_set got;
>         int err =3D 0;
>
>         subsuite[0] =3D alloc_fake_suite(test, "suite", dummy_attr_test_c=
ases);
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index cb9797fa6303f..8b2808068497f 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -736,7 +736,11 @@ EXPORT_SYMBOL_GPL(__kunit_test_suites_exit);
>  #ifdef CONFIG_MODULES
>  static void kunit_module_init(struct module *mod)
>  {
> -       __kunit_test_suites_init(mod->kunit_suites, mod->num_kunit_suites=
);
> +       struct kunit_suite_set suite_set =3D {
> +               mod->kunit_suites, mod->kunit_suites + mod->num_kunit_sui=
tes,
> +       };
> +
> +       kunit_exec_run_tests(&suite_set, false);
>  }
>
>  static void kunit_module_exit(struct module *mod)
> --
> 2.41.0
>
