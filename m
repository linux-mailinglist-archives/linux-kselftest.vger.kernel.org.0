Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBF5773D04
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 18:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbjHHQNV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Aug 2023 12:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbjHHQL5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Aug 2023 12:11:57 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398037DAF
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Aug 2023 08:46:55 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-521e046f6c7so12545a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Aug 2023 08:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691509613; x=1692114413;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uJSgChSrn/U9b3lu+z9h2Ks6Tl5EAx7hJMI/Ue9UWSc=;
        b=4jLULWpwXHUG47hkQTMUN6XynE0xNyleEs/YCgNJ2aDyABDqutl80uZ1Wj7sTxOeC3
         3To8eNp3+etC249C3aukJ4mKP0xozsC0lzyK+LLy+cQ94xY2b2FKIVVVz3MTi59ox2YC
         GrVrRFo8/yIq/9SGEMgCbSuK85UywZS3oam5vSSW9o6CcCIZxXMO9NVDxubBt9H9lkrd
         PoZnfPNANbcgUH4rnaDh2zfIAKmIR4taFNC/i1Igb7KmohWUiaAc3LnJSyLx3Hvsm4gK
         NkvdZUyvF+8ZaML7LJ7kSgB+MpTtoDnL/fuQd3UIFojGBB0nbT665rI9NyCImA6dcj1t
         wmEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509613; x=1692114413;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uJSgChSrn/U9b3lu+z9h2Ks6Tl5EAx7hJMI/Ue9UWSc=;
        b=AOfUdkPuY9h3sJ4MNQm6a/gSiCD1M9Gxi8SR46t1utdohdLZH584G2J1UraKd2hVNl
         9cAn6c0frMHFjPoQdt/H2T4SUke4Edn592lSn/fb1RDvVHb9HLwf+WOK6/gScluWWNAl
         fEL0TH9nH1t5aSst2Hsb/bdsXHzdJvwfatSTgMr5uKTCR83Jxsaz7Iz88cLvu0qIJrru
         zVhM1cx5paH0jl7Cn1BDm/aL+Vp5E6o1A9vTXil6l0lN2aPEoNrDuVUDEE82hIp2QDYi
         EeslBNw0nkSyze1Nr/zEoOSBMkVLDUTayHqS1lxJtXTIne0TpbdsKh4xtOR9UewoDdBj
         2dIA==
X-Gm-Message-State: AOJu0YxBoIrLanWq+1tWaOqMSjEzF6cvYALQ8c1ayCODdvKmtZolw69q
        qmaeIlx21dXt0aYryOsnLPNDLmIKOqQHiCvbSeXI4+9gXMTYdnIpV9M=
X-Google-Smtp-Source: AGHT+IGkuUTVJQ/G0MgeQXfUbOK8TmkbDKDsVCMrmdluKtsbEiZZJ4lWuswPzm3mAYboVYwyJB2GlFOAJrm1Fv/LzB8=
X-Received: by 2002:a05:600c:4e4b:b0:3fd:e15:6d5 with SMTP id
 e11-20020a05600c4e4b00b003fd0e1506d5mr309374wmq.2.1691480858460; Tue, 08 Aug
 2023 00:47:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230807102352.4607-5-janusz.krzysztofik@linux.intel.com> <20230807102352.4607-6-janusz.krzysztofik@linux.intel.com>
In-Reply-To: <20230807102352.4607-6-janusz.krzysztofik@linux.intel.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 8 Aug 2023 15:47:25 +0800
Message-ID: <CABVgOS=_rZuP5CJm2_5H27GOkvEGsJ08=qUgj6sSEQPk5ZfGkA@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] kunit: Report the count of test suites in a module
To:     Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        igt-dev@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Rae Moar <rmoar@google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000a7e9d906026b45c6"
X-Spam-Status: No, score=-16.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--000000000000a7e9d906026b45c6
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Aug 2023 at 18:28, Janusz Krzysztofik
<janusz.krzysztofik@linux.intel.com> wrote:
>
> According to KTAP specification[1], results should always start from a
> header that provides a TAP protocol version, followed by a test plan with
> a count of items to be executed.  That pattern should be followed at each
> nesting level.  In the current implementation of the top-most, i.e., test
> suite level, those rules apply only for test suites built into the kernel,
> executed and reported on boot.  Results submitted to dmesg from kunit test
> modules loaded later are missing those top-level headers.
>
> As a consequence, if a kunit test module provides more than one test suite
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
> [1] https://docs.kernel.org/dev-tools/ktap.html#
>
> Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Rae Moar <rmoar@google.com>
> ---

Thanks! This is a long overdue feature, and it seems to work well here.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


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
> @@ -317,6 +323,8 @@ int __kunit_test_suites_init(struct kunit_suite * const * const suites, int num_
>
>  void __kunit_test_suites_exit(struct kunit_suite **suites, int num_suites);
>
> +void kunit_exec_run_tests(struct kunit_suite_set *suite_set, bool builtin);
> +
>  #if IS_BUILTIN(CONFIG_KUNIT)
>  int kunit_run_all_tests(void);
>  #else
> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> index dc295150c4e57..5ef90c334eb0f 100644
> --- a/lib/kunit/executor.c
> +++ b/lib/kunit/executor.c
> @@ -104,13 +104,7 @@ kunit_filter_glob_tests(const struct kunit_suite *const suite, const char *test_
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
> @@ -119,16 +113,17 @@ static void kunit_free_suite_set(struct suite_set suite_set)
>         kfree(suite_set.start);
>  }
>
> -static struct suite_set kunit_filter_suites(const struct suite_set *suite_set,
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
>         int filter_count = 0;
>         struct kunit_suite **copy, **copy_start, *filtered_suite, *new_filtered_suite;
> -       struct suite_set filtered = {NULL, NULL};
> +       struct kunit_suite_set filtered = {NULL, NULL};
>         struct kunit_glob_filter parsed_glob;
>         struct kunit_attr_filter *parsed_filters = NULL;
>
> @@ -230,17 +225,24 @@ static void kunit_handle_shutdown(void)
>
>  }
>
> -static void kunit_exec_run_tests(struct suite_set *suite_set)
> +#endif
> +
> +void kunit_exec_run_tests(struct kunit_suite_set *suite_set, bool builtin)
>  {
>         size_t num_suites = suite_set->end - suite_set->start;
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
> -static void kunit_exec_list_tests(struct suite_set *suite_set, bool include_attr)
> +#if IS_BUILTIN(CONFIG_KUNIT)
> +
> +static void kunit_exec_list_tests(struct kunit_suite_set *suite_set,
> +                                 bool include_attr)
>  {
>         struct kunit_suite * const *suites;
>         struct kunit_case *test_case;
> @@ -265,7 +267,9 @@ static void kunit_exec_list_tests(struct suite_set *suite_set, bool include_attr
>
>  int kunit_run_all_tests(void)
>  {
> -       struct suite_set suite_set = {__kunit_suites_start, __kunit_suites_end};
> +       struct kunit_suite_set suite_set = {
> +               __kunit_suites_start, __kunit_suites_end,
> +       };
>         int err = 0;
>         if (!kunit_enabled()) {
>                 pr_info("kunit: disabled\n");
> @@ -282,7 +286,7 @@ int kunit_run_all_tests(void)
>         }
>
>         if (!action_param)
> -               kunit_exec_run_tests(&suite_set);
> +               kunit_exec_run_tests(&suite_set, true);
>         else if (strcmp(action_param, "list") == 0)
>                 kunit_exec_list_tests(&suite_set, false);
>         else if (strcmp(action_param, "list_attr") == 0)
> diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
> index 3e0a1c99cb4e8..4084071d0eb5b 100644
> --- a/lib/kunit/executor_test.c
> +++ b/lib/kunit/executor_test.c
> @@ -43,8 +43,10 @@ static void parse_filter_test(struct kunit *test)
>  static void filter_suites_test(struct kunit *test)
>  {
>         struct kunit_suite *subsuite[3] = {NULL, NULL};
> -       struct suite_set suite_set = {.start = subsuite, .end = &subsuite[2]};
> -       struct suite_set got;
> +       struct kunit_suite_set suite_set = {
> +               .start = subsuite, .end = &subsuite[2],
> +       };
> +       struct kunit_suite_set got;
>         int err = 0;
>
>         subsuite[0] = alloc_fake_suite(test, "suite1", dummy_test_cases);
> @@ -67,8 +69,10 @@ static void filter_suites_test(struct kunit *test)
>  static void filter_suites_test_glob_test(struct kunit *test)
>  {
>         struct kunit_suite *subsuite[3] = {NULL, NULL};
> -       struct suite_set suite_set = {.start = subsuite, .end = &subsuite[2]};
> -       struct suite_set got;
> +       struct kunit_suite_set suite_set = {
> +               .start = subsuite, .end = &subsuite[2],
> +       };
> +       struct kunit_suite_set got;
>         int err = 0;
>
>         subsuite[0] = alloc_fake_suite(test, "suite1", dummy_test_cases);
> @@ -94,8 +98,10 @@ static void filter_suites_test_glob_test(struct kunit *test)
>  static void filter_suites_to_empty_test(struct kunit *test)
>  {
>         struct kunit_suite *subsuite[3] = {NULL, NULL};
> -       struct suite_set suite_set = {.start = subsuite, .end = &subsuite[2]};
> -       struct suite_set got;
> +       struct kunit_suite_set suite_set = {
> +               .start = subsuite, .end = &subsuite[2],
> +       };
> +       struct kunit_suite_set got;
>         int err = 0;
>
>         subsuite[0] = alloc_fake_suite(test, "suite1", dummy_test_cases);
> @@ -144,8 +150,10 @@ static struct kunit_case dummy_attr_test_cases[] = {
>  static void filter_attr_test(struct kunit *test)
>  {
>         struct kunit_suite *subsuite[3] = {NULL, NULL};
> -       struct suite_set suite_set = {.start = subsuite, .end = &subsuite[2]};
> -       struct suite_set got;
> +       struct kunit_suite_set suite_set = {
> +               .start = subsuite, .end = &subsuite[2],
> +       };
> +       struct kunit_suite_set got;
>         int err = 0;
>
>         subsuite[0] = alloc_fake_suite(test, "normal_suite", dummy_attr_test_cases);
> @@ -179,8 +187,10 @@ static void filter_attr_test(struct kunit *test)
>  static void filter_attr_empty_test(struct kunit *test)
>  {
>         struct kunit_suite *subsuite[3] = {NULL, NULL};
> -       struct suite_set suite_set = {.start = subsuite, .end = &subsuite[2]};
> -       struct suite_set got;
> +       struct kunit_suite_set suite_set = {
> +               .start = subsuite, .end = &subsuite[2],
> +       };
> +       struct kunit_suite_set got;
>         int err = 0;
>
>         subsuite[0] = alloc_fake_suite(test, "suite1", dummy_attr_test_cases);
> @@ -197,8 +207,10 @@ static void filter_attr_empty_test(struct kunit *test)
>  static void filter_attr_skip_test(struct kunit *test)
>  {
>         struct kunit_suite *subsuite[2] = {NULL};
> -       struct suite_set suite_set = {.start = subsuite, .end = &subsuite[1]};
> -       struct suite_set got;
> +       struct kunit_suite_set suite_set = {
> +               .start = subsuite, .end = &subsuite[1],
> +       };
> +       struct kunit_suite_set got;
>         int err = 0;
>
>         subsuite[0] = alloc_fake_suite(test, "suite", dummy_attr_test_cases);
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index cb9797fa6303f..8b2808068497f 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -736,7 +736,11 @@ EXPORT_SYMBOL_GPL(__kunit_test_suites_exit);
>  #ifdef CONFIG_MODULES
>  static void kunit_module_init(struct module *mod)
>  {
> -       __kunit_test_suites_init(mod->kunit_suites, mod->num_kunit_suites);
> +       struct kunit_suite_set suite_set = {
> +               mod->kunit_suites, mod->kunit_suites + mod->num_kunit_suites,
> +       };
> +
> +       kunit_exec_run_tests(&suite_set, false);
>  }
>
>  static void kunit_module_exit(struct module *mod)
> --
> 2.41.0
>

--000000000000a7e9d906026b45c6
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnwYJKoZIhvcNAQcCoIIPkDCCD4wCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz5MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
9IGQSBx2i4m+hGXJpET+MEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQCRI3Z4cAidgFcv
Usqdz765x6KMZSfg/WtFrYg8ewsP2NpCxVM2+EhPyyEQ0k0DhtzdtGoI/Ug+jdFDyCKB9P2+EPLh
iMjMnFILp7Zs4r18ECHlvZuDZfH9m0BchXIxu5jLIuQyKUWrCRDZZEDNr510ZhhVfYSFPA8ms1nk
jyzYFOHYQyv5IfML/3IBFKlON5OZa+V8EZYULYcNkp03DdWglafj7SXZ1/XgAbVYrC381UvrsYN8
jndVvoa1GWwe+NVlIIK7Q3uAjV3qLEDQpaNPg1rr0oAn6YmvTccjVMqj2YNwN+RHhKNzgRGxY5ct
FaN+8fXZhRhpv3bVbAWuPZXoMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABAz5xDls09r2CKyYRqnNbMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDW
39fS2BpQs3E5K678v/zRuFglL4oO6SmXBbbmJPNl9zAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA4MDgxNTQ2NTNaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAlbwTHF75g8emX3gPzv9K
NBjhA8UEppKhTd/q9ZjJ5wCotrozVqkKXd0+OK7IvE7l+2+oChM4UN0It30IrJsRYYfiGxg2ssNO
hG0zdBxE9h5YEkKFqEgl0x1Efeg1hxYU+h6hpvxQdovPLLYulxt7+4h/3b1ZB/wuTW4nkF9xzeV/
FknR+/dV5UyzP7XQ9VdoE/mQegxHzhl3xZseYtyWhXyb9tw8Q0bYUicNZPlEImYMWJyfzpJZCYZA
B0dWlfF3NgcP1IRJjmrdMqR7psCKbPdB+4UtOmmtcw4s0Lvs0C+t4FBanvXlgaqliiNbjXY0XSmP
6x6WiEOEX3k+vq9xAA==
--000000000000a7e9d906026b45c6--
