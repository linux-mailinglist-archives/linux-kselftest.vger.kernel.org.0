Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9076378EC
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Nov 2022 13:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiKXMa3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Nov 2022 07:30:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiKXMaX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Nov 2022 07:30:23 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2407BA3
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Nov 2022 04:30:22 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id x2so2381488edd.2
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Nov 2022 04:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3ToCxHFkrbDmCA2BRprg5ULzLvGItBwucRXFh126ws=;
        b=tFXlfbFI2uobL9a5FjnUW4JP5jEhtHmYu+qgNQta37prpc/H9l//pMxC0gZC6yodqp
         o/uCt4XtLanHT/tNzARWSzH2jE1sgjvT+KAymMz+6hGHW2FqToVtsn/Rfh2tL5U1Yr0v
         x2U39psemo8NZxsDn66w2YhpkjQ59SAZqBjymWKRKVv/4e7wIaQMq+bruP3IMG+WW7Y/
         o9XmgMMoVA7Hu3TMCgL8ZDUpjb7Ndaz1uHQ4Y+1i407i55ZDWdiq7i4j3U40q8ajbtAC
         jwRZlRDja5cWcamrqFJnQ3Jvnd1GnhDFWDfl+R/qIwe2/2LSQwOQwhGMMn+WSsperKOc
         CEpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O3ToCxHFkrbDmCA2BRprg5ULzLvGItBwucRXFh126ws=;
        b=L0rJjbFb1ZlqrWf3+6BTOtZwJIMHAkwSoNDwAEaGIXwIAfIVUGugIQTqoZOPNn5gql
         iWPwY5goCAJYGSJ6NYmZmBTxHLDceBjNl5AVkMXt7LHeSvFZdSpQ6UOnT0drTJDuMpRK
         00YArVnjpIodPw6YHnsnqr4ehayKE6ajV0Dxl25Gw3ldTwoC5WQ2GumaCwvrIlpm4QrW
         8dGDFvB8Am+XwQEe3xLGGMXB2twtdGNxflh2s01k285sj6JChWekUb8wp6UWAf1xYNbS
         8PoAE7LeIipCvcZ0dxLzU4/qF5vRSkQdiq81YpBN98cKNkNfp5/DTXSex/IgiQowhYwt
         srMw==
X-Gm-Message-State: ANoB5pnrlHwzCsgrUinSFiorVcpiAk6SCm+bcdHvT2TVhnT22rKLQtmt
        CEMHM5ZCePL1kgKcaIUohLsp0N+WSGmj0ftriyxZQA==
X-Google-Smtp-Source: AA0mqf5TFuoIP9GTOnmyF9Xfb1ZGnFvrjlgOAixvsyKc3HTIuiBZKi7XJjXSPd7s4e8e/YExCrPnFzZf3hKKHC0lrz4=
X-Received: by 2002:aa7:db90:0:b0:459:aa70:d4fd with SMTP id
 u16-20020aa7db90000000b00459aa70d4fdmr28864721edt.162.1669293020539; Thu, 24
 Nov 2022 04:30:20 -0800 (PST)
MIME-Version: 1.0
References: <20221123182558.2203639-1-rmoar@google.com> <20221123182558.2203639-2-rmoar@google.com>
In-Reply-To: <20221123182558.2203639-2-rmoar@google.com>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Thu, 24 Nov 2022 13:30:09 +0100
Message-ID: <CADYN=9LOKq-Zf2Z_QnEvt6iB==fJdSnNbnH4k1SYe5VPs0k5Sw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] kunit: improve KTAP compliance of KUnit test output
To:     Rae Moar <rmoar@google.com>
Cc:     brendanhiggins@google.com, davidgow@google.com,
        dlatypov@google.com, skhan@linuxfoundation.org,
        mauro.chehab@linux.intel.com, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        isabbasso@riseup.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 23 Nov 2022 at 19:26, Rae Moar <rmoar@google.com> wrote:
>
> Change KUnit test output to better comply with KTAP v1 specifications
> found here: https://kernel.org/doc/html/latest/dev-tools/ktap.html.
> 1) Use "KTAP version 1" instead of "TAP version 14" as test output header
> 2) Remove '-' between test number and test name on test result lines
> 2) Add KTAP version lines to each subtest header as well
>
> Note that the new KUnit output still includes the =E2=80=9C# Subtest=E2=
=80=9D line now
> located after the KTAP version line. This does not completely match the
> KTAP v1 spec but since it is classified as a diagnostic line, it is not
> expected to be disruptive or break any existing parsers. This
> =E2=80=9C# Subtest=E2=80=9D line comes from the TAP 14 spec
> (https://testanything.org/tap-version-14-specification.html) and it is
> used to define the test name before the results.
>
> Original output:
>
>  TAP version 14
>  1..1
>    # Subtest: kunit-test-suite
>    1..3
>    ok 1 - kunit_test_1
>    ok 2 - kunit_test_2
>    ok 3 - kunit_test_3
>  # kunit-test-suite: pass:3 fail:0 skip:0 total:3
>  # Totals: pass:3 fail:0 skip:0 total:3
>  ok 1 - kunit-test-suite
>
> New output:
>
>  KTAP version 1
>  1..1
>    KTAP version 1
>    # Subtest: kunit-test-suite
>    1..3
>    ok 1 kunit_test_1
>    ok 2 kunit_test_2
>    ok 3 kunit_test_3
>  # kunit-test-suite: pass:3 fail:0 skip:0 total:3
>  # Totals: pass:3 fail:0 skip:0 total:3
>  ok 1 kunit-test-suite
>
> Signed-off-by: Rae Moar <rmoar@google.com>
> Reviewed-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: David Gow <davidgow@google.com>

Tested-by: Anders Roxell <anders.roxell@linaro.org>

Cheers,
Anders
> ---
>
> Changes since v2:
> https://lore.kernel.org/all/20221121184743.1123556-2-rmoar@google.com/
> - Made fixes discussed on the v2 patch to now correctly output test
>   results after second level testing
>
> Changes since v1:
> https://lore.kernel.org/all/20221104194705.3245738-1-rmoar@google.com/
> - Switch order of patches to make changes to the parser before making
>   changes to the test output
> - Change location of the new KTAP version line in subtest header to be
>   before the subtest header line
>
>  lib/kunit/debugfs.c  | 2 +-
>  lib/kunit/executor.c | 6 +++---
>  lib/kunit/test.c     | 9 ++++++---
>  3 files changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
> index 1048ef1b8d6e..de0ee2e03ed6 100644
> --- a/lib/kunit/debugfs.c
> +++ b/lib/kunit/debugfs.c
> @@ -63,7 +63,7 @@ static int debugfs_print_results(struct seq_file *seq, =
void *v)
>         kunit_suite_for_each_test_case(suite, test_case)
>                 debugfs_print_result(seq, suite, test_case);
>
> -       seq_printf(seq, "%s %d - %s\n",
> +       seq_printf(seq, "%s %d %s\n",
>                    kunit_status_to_ok_not_ok(success), 1, suite->name);
>         return 0;
>  }
> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> index 9bbc422c284b..74982b83707c 100644
> --- a/lib/kunit/executor.c
> +++ b/lib/kunit/executor.c
> @@ -166,7 +166,7 @@ static void kunit_exec_run_tests(struct suite_set *su=
ite_set)
>  {
>         size_t num_suites =3D suite_set->end - suite_set->start;
>
> -       pr_info("TAP version 14\n");
> +       pr_info("KTAP version 1\n");
>         pr_info("1..%zu\n", num_suites);
>
>         __kunit_test_suites_init(suite_set->start, num_suites);
> @@ -177,8 +177,8 @@ static void kunit_exec_list_tests(struct suite_set *s=
uite_set)
>         struct kunit_suite * const *suites;
>         struct kunit_case *test_case;
>
> -       /* Hack: print a tap header so kunit.py can find the start of KUn=
it output. */
> -       pr_info("TAP version 14\n");
> +       /* Hack: print a ktap header so kunit.py can find the start of KU=
nit output. */
> +       pr_info("KTAP version 1\n");
>
>         for (suites =3D suite_set->start; suites < suite_set->end; suites=
++)
>                 kunit_suite_for_each_test_case((*suites), test_case) {
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 90640a43cf62..1c9d8d962d67 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -149,6 +149,7 @@ EXPORT_SYMBOL_GPL(kunit_suite_num_test_cases);
>
>  static void kunit_print_suite_start(struct kunit_suite *suite)
>  {
> +       kunit_log(KERN_INFO, suite, KUNIT_SUBTEST_INDENT "KTAP version 1\=
n");
>         kunit_log(KERN_INFO, suite, KUNIT_SUBTEST_INDENT "# Subtest: %s",
>                   suite->name);
>         kunit_log(KERN_INFO, suite, KUNIT_SUBTEST_INDENT "1..%zd",
> @@ -175,13 +176,13 @@ static void kunit_print_ok_not_ok(void *test_or_sui=
te,
>          * representation.
>          */
>         if (suite)
> -               pr_info("%s %zd - %s%s%s\n",
> +               pr_info("%s %zd %s%s%s\n",
>                         kunit_status_to_ok_not_ok(status),
>                         test_number, description, directive_header,
>                         (status =3D=3D KUNIT_SKIPPED) ? directive : "");
>         else
>                 kunit_log(KERN_INFO, test,
> -                         KUNIT_SUBTEST_INDENT "%s %zd - %s%s%s",
> +                         KUNIT_SUBTEST_INDENT "%s %zd %s%s%s",
>                           kunit_status_to_ok_not_ok(status),
>                           test_number, description, directive_header,
>                           (status =3D=3D KUNIT_SKIPPED) ? directive : "")=
;
> @@ -542,6 +543,8 @@ int kunit_run_tests(struct kunit_suite *suite)
>                         /* Get initial param. */
>                         param_desc[0] =3D '\0';
>                         test.param_value =3D test_case->generate_params(N=
ULL, param_desc);
> +                       kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT =
KUNIT_SUBTEST_INDENT
> +                                 "KTAP version 1\n");
>                         kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT =
KUNIT_SUBTEST_INDENT
>                                   "# Subtest: %s", test_case->name);
>
> @@ -555,7 +558,7 @@ int kunit_run_tests(struct kunit_suite *suite)
>
>                                 kunit_log(KERN_INFO, &test,
>                                           KUNIT_SUBTEST_INDENT KUNIT_SUBT=
EST_INDENT
> -                                         "%s %d - %s",
> +                                         "%s %d %s",
>                                           kunit_status_to_ok_not_ok(test.=
status),
>                                           test.param_index + 1, param_des=
c);
>
> --
> 2.38.1.584.g0f3c55d4c2-goog
>
