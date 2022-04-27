Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F103510E76
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Apr 2022 04:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348034AbiD0B7Y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Apr 2022 21:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357006AbiD0B7X (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Apr 2022 21:59:23 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4862980C
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Apr 2022 18:56:13 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id x18so541185wrc.0
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Apr 2022 18:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=97pZKrStBXSYBapUJT/M4kuhY4iZtj4bD+Xg9diOwgs=;
        b=rCuicpl5pQWnWwLTvxtsD72tfAjz5s1VT/3VljAXt10O9IduciTkg6+1cCMhyFv7jt
         Yi9Btm+rkqM296l4bDr5jpYc4afs47ft46eO8GLYzJvqUhjcmGsnO/dZxo51UiA7Ca5V
         HDt84mh4vBjSXDDEZ1xoVW6lZHvp9TPF2DH12/Rs9b7bCLhV/lcRf7Elp6lNZAjS8fQ4
         NLaaGhSkgHfw//oI6UN1wpQEb2QOjdEGFpJWnfH5rIDS/RNgBDZ4ep94+SV/dOYy4dTA
         d+Xp0+O0bWmwIOac9QHapg4VBzzVUTuxGpGbkRxZv/w4AincxMA4m7vI4j0kvUm0DiTL
         tlRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=97pZKrStBXSYBapUJT/M4kuhY4iZtj4bD+Xg9diOwgs=;
        b=xzAOGGvO9UJ3jNf7RjJf4Tf1Gps6IeIzEiSAwZruiEIomgUflJL8K49QCsyq7iGp/7
         0SzxRsxbeMPUmn7BAnzjr6gaHqKrmByg5Aso/9K4W1wrIo+r9xOmpLZEQwrSoP9JIsPG
         GAHZmHTBQrWnxaiwFVpOBF20TfIpwBR9mg0G0Nx3IOQm8is6wUyYFv5+eF08rTqKbTW1
         TGLMfYVXBoVxNGooAy47MIIlqxG0pzuscVUelIjKfidjVXnUv9ll//EIFno5cEMewREn
         B6Krb3rLTEu+GDbY48Q7TlgyREe04+5Ola+itIlxldbb9E0ZSk+xUHrAZPKoU5HZJ9a8
         KuUQ==
X-Gm-Message-State: AOAM531k1LpRuXg7QVjDLVhXx22QsZd72ciVnG7WOpZzTjgiaVAXdotp
        vnP44lpp42m4RlAdVUoehGkw6lGaUwAn5CwwdOJajg==
X-Google-Smtp-Source: ABdhPJy/eDjbifUqUu3Jbut5maFh6DtcySQcPaWR5qT2c1cGFOXTYWilIEfi7FRyEkWBW79wYCLwDJDL/iQIxA/xn9s=
X-Received: by 2002:a5d:6651:0:b0:20a:df2f:8027 with SMTP id
 f17-20020a5d6651000000b0020adf2f8027mr8326780wrw.269.1651024571464; Tue, 26
 Apr 2022 18:56:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220426181925.3940286-1-dlatypov@google.com> <20220426181925.3940286-2-dlatypov@google.com>
In-Reply-To: <20220426181925.3940286-2-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 27 Apr 2022 09:55:59 +0800
Message-ID: <CABVgOSkqymYzwaQ68AdEC5yake9VT8HkQmqbyi+9-bg1Jk1UAQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] kunit: add ability to specify suite-level init and
 exit functions
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000001edeb405dd991d1f"
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

--0000000000001edeb405dd991d1f
Content-Type: text/plain; charset="UTF-8"

On Wed, Apr 27, 2022 at 2:19 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> KUnit has support for setup/cleanup logic for each test case in a suite.
> But it lacks the ability to specify setup/cleanup for the entire suite
> itself.
>
> This can be used to do setup that is too expensive or cumbersome to do
> for each test.
> Or it can be used to do simpler things like log debug information after
> the suite completes.
> It's a fairly common feature, so the lack of it is noticeable.
>
> Some examples in other frameworks and languages:
> * https://docs.python.org/3/library/unittest.html#setupclass-and-teardownclass
> * https://google.github.io/googletest/reference/testing.html#Test::SetUpTestSuite
>
> Meta:
> This is very similar to this patch here: https://lore.kernel.org/linux-kselftest/20210805043503.20252-3-bvanassche@acm.org/
> The changes from that patch:
> * pass in `struct kunit *` so users can do stuff like
>   `kunit_info(suite, "debug message")`
> * makes sure the init failure is bubbled up as a failure
> * updates kunit-example-test.c to use a suite init
> * Updates kunit/usage.rst to mention the new support
> * some minor cosmetic things
>   * use `suite_{init,exit}` instead of `{init/exit}_suite`
>   * make suite init error message more consistent w/ test init
>   * etc.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Thanks for picking this up again: it's definitely something which has
been obviously missing for a while.

One comment below, but I don't mind if you'd prefer to leave things as-is.

Reviewed-by: David Gow <davidgow@google.com>

>  Documentation/dev-tools/kunit/usage.rst | 19 +++++++++++--------
>  include/kunit/test.h                    |  4 ++++
>  lib/kunit/kunit-example-test.c          | 14 ++++++++++++++
>  lib/kunit/test.c                        | 23 ++++++++++++++++++++---
>  4 files changed, 49 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
> index 1c83e7d60a8a..d62a04255c2e 100644
> --- a/Documentation/dev-tools/kunit/usage.rst
> +++ b/Documentation/dev-tools/kunit/usage.rst
> @@ -125,8 +125,8 @@ We need many test cases covering all the unit's behaviors. It is common to have
>  many similar tests. In order to reduce duplication in these closely related
>  tests, most unit testing frameworks (including KUnit) provide the concept of a
>  *test suite*. A test suite is a collection of test cases for a unit of code
> -with a setup function that gets invoked before every test case and then a tear
> -down function that gets invoked after every test case completes. For example:
> +with optional setup and teardown functions that run before/after the whole
> +suite and/or every test case. For example:
>
>  .. code-block:: c
>
> @@ -141,16 +141,19 @@ down function that gets invoked after every test case completes. For example:
>                 .name = "example",
>                 .init = example_test_init,
>                 .exit = example_test_exit,
> +               .suite_init = example_suite_init,
> +               .suite_exit = example_suite_exit,
>                 .test_cases = example_test_cases,
>         };
>         kunit_test_suite(example_test_suite);
>
> -In the above example, the test suite ``example_test_suite`` would run the test
> -cases ``example_test_foo``, ``example_test_bar``, and ``example_test_baz``. Each
> -would have ``example_test_init`` called immediately before it and
> -``example_test_exit`` called immediately after it.
> -``kunit_test_suite(example_test_suite)`` registers the test suite with the
> -KUnit test framework.
> +In the above example, the test suite ``example_test_suite`` would first run
> +``example_suite_init``, then run the test cases ``example_test_foo``,
> +``example_test_bar``, and ``example_test_baz``. Each would have
> +``example_test_init`` called immediately before it and ``example_test_exit``
> +called immediately after it. Finally, ``example_suite_exit`` would be called
> +after everything else. ``kunit_test_suite(example_test_suite)`` registers the
> +test suite with the KUnit test framework.
>
>  .. note::
>     A test case will only run if it is associated with a test suite.
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 97cd76461886..5d288f3d8f68 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -153,6 +153,8 @@ static inline char *kunit_status_to_ok_not_ok(enum kunit_status status)
>   * struct kunit_suite - describes a related collection of &struct kunit_case
>   *
>   * @name:      the name of the test. Purely informational.
> + * @suite_init:        called once per test suite before the test cases.
> + * @suite_exit:        called once per test suite after all test cases.
>   * @init:      called before every test case.
>   * @exit:      called after every test case.
>   * @test_cases:        a null terminated array of test cases.
> @@ -167,6 +169,8 @@ static inline char *kunit_status_to_ok_not_ok(enum kunit_status status)
>   */
>  struct kunit_suite {
>         const char name[256];
> +       int (*suite_init)(struct kunit_suite *suite);
> +       void (*suite_exit)(struct kunit_suite *suite);
>         int (*init)(struct kunit *test);
>         void (*exit)(struct kunit *test);
>         struct kunit_case *test_cases;
> diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
> index 91b1df7f59ed..f8fe582c9e36 100644
> --- a/lib/kunit/kunit-example-test.c
> +++ b/lib/kunit/kunit-example-test.c
> @@ -40,6 +40,17 @@ static int example_test_init(struct kunit *test)
>         return 0;
>  }
>
> +/*
> + * This is run once before all test cases in the suite.
> + * See the comment on example_test_suite for more information.
> + */
> +static int example_test_init_suite(struct kunit_suite *suite)
> +{
> +       kunit_info(suite, "initializing suite\n");
> +
> +       return 0;
> +}
> +
>  /*
>   * This test should always be skipped.
>   */
> @@ -142,17 +153,20 @@ static struct kunit_case example_test_cases[] = {
>   * may be specified which runs after every test case and can be used to for
>   * cleanup. For clarity, running tests in a test suite would behave as follows:
>   *
> + * suite.suite_init(suite);
>   * suite.init(test);
>   * suite.test_case[0](test);
>   * suite.exit(test);
>   * suite.init(test);
>   * suite.test_case[1](test);
>   * suite.exit(test);
> + * suite.suite_exit(suite);
>   * ...;
>   */
>  static struct kunit_suite example_test_suite = {
>         .name = "example",
>         .init = example_test_init,
> +       .suite_init = example_test_init_suite,
>         .test_cases = example_test_cases,
>  };
>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 64ee6a9d8003..b66e395c795a 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -192,10 +192,13 @@ EXPORT_SYMBOL_GPL(kunit_suite_has_succeeded);
>
>  static size_t kunit_suite_counter = 1;
>
> -static void kunit_print_suite_end(struct kunit_suite *suite)
> +static void kunit_print_suite_end(struct kunit_suite *suite, int init_err)

A part of me feels that it'd be nicer to have the init_err be part of
struct kunit_suite, and have kunit_suite_has_succeeded() take it into
account. It could go either way, though -- WDYT?


>  {
> +       enum kunit_status status =
> +               init_err ? KUNIT_FAILURE : kunit_suite_has_succeeded(suite);
> +
>         kunit_print_ok_not_ok((void *)suite, false,
> -                             kunit_suite_has_succeeded(suite),
> +                             status,
>                               kunit_suite_counter++,
>                               suite->name,
>                               suite->status_comment);
> @@ -497,6 +500,16 @@ int kunit_run_tests(struct kunit_suite *suite)
>         struct kunit_case *test_case;
>         struct kunit_result_stats suite_stats = { 0 };
>         struct kunit_result_stats total_stats = { 0 };
> +       int suite_init_err = 0;
> +
> +       if (suite->suite_init) {
> +               suite_init_err = suite->suite_init(suite);
> +               if (suite_init_err != 0) {
> +                       kunit_err(suite, KUNIT_SUBTEST_INDENT
> +                                 "# failed to initialize (%d)", suite_init_err);
> +                       goto suite_end;
> +               }
> +       }
>
>         kunit_print_suite_start(suite);
>
> @@ -551,8 +564,12 @@ int kunit_run_tests(struct kunit_suite *suite)
>                 kunit_accumulate_stats(&total_stats, param_stats);
>         }
>
> +       if (suite->suite_exit)
> +               suite->suite_exit(suite);
> +
>         kunit_print_suite_stats(suite, suite_stats, total_stats);
> -       kunit_print_suite_end(suite);
> +suite_end:
> +       kunit_print_suite_end(suite, suite_init_err);
>
>         return 0;
>  }
> --
> 2.36.0.rc2.479.g8af0fa9b8e-goog
>

--0000000000001edeb405dd991d1f
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
G7p3AiuB2sgfq6cOpbO5MEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQBsL34EJkCtu9Nu
2+R6l1Qzno5Gl+N2Cm6/YLujukDGYa1JW27txXiilR9dGP7yl60HYyG2Exd5i6fiLDlaNEw0SqzE
dw9ZSIak3Qvm2UybR8zcnB0deCUiwahqh7ZncEPlhnPpB08ETEUtwBEqCEnndNEkIN67yz4kniCZ
jZstNF/BUnI3864fATiXSbnNqBwlJS3YkoaCTpbI9qNTrf5VIvnbryT69xJ6f25yfmxrXNJJe5OG
ncB34Cwnb7xQyk+uRLZ465yUBkbjk9pC/yamL0O7SOGYUclrQl2c5zzGuVBD84YcQGDOK6gSPj6w
QuBfOooZPOyZZZ8AMih7J980MYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABQeVybOOpR4bOOXZYL5T3MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCe
aCx3wigWoxOgqxPAycuMPahwqeDPdAYO/LqQPVl/lzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA0MjcwMTU2MTFaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAg256gYY+1U0ZmQU0hZ/w
RrQd9xdu2EQJ6MAK6SCu9OWIRu8fKj/bNbncKFdO0Y1KJJzWpFAxrdX0S2y8K3ksVMlRKXkLa6OW
hofaeJoxZLw+dMbKCrJninjlMErbGbc7AWoN3POdikMNjwsQP9qCeQ38jL8UygO0iV1bJz5pKYXl
q9pCgOHNDta+rlsoheZYWBH5FzxUXoxUHXNMQfp3WPJ/0aEcomZti7lQIoR2Q14ZsgZZS/lOOFJu
dCiTkoeiAYf1FufCuSMrQ7UfIsLI5XCfTOtkKvZ3HEnnn9bKxj7fG3V8PUC5cdGjdinehj8omD1u
Mt3FdPtEMSgvBdAwbA==
--0000000000001edeb405dd991d1f--
