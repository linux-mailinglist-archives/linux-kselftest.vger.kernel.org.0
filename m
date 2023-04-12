Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06EDA6DFFC8
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Apr 2023 22:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjDLU2a (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Apr 2023 16:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjDLU23 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Apr 2023 16:28:29 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B149F114
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Apr 2023 13:28:28 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id n203so1402718ybg.6
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Apr 2023 13:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681331308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+aUZ9ayjHDjQECrUm843lDN3BOqqfJ0QMYhbNwLySUs=;
        b=kFo3YCjKb73p/pfXKgc0ySBmxOS/5eNVzEodWhI5VeGTvIIdgfkh6lMlFqp6mnVYyc
         YPJn8laCVukG2lTxjhUVgVFkeId+iMtncaBvrFLlGtMX9l+V4jmTgHRoiRlH6FiNRrKT
         QlgeYId9aDLM7yssJGgYOUWFukVR6KGoMCPMsHmILF4eZ1RkCV2mszmIeXRtuPL3UmkO
         cd7S14sw9Go2WhuWjHasxQCyn6IwDE84gAqtne8ExIjSqi9zhQra8FWrWCHakWPsUQfl
         FkbKmc6NxRb+wSzZKjSfPt5G1UxF0n8k8Ow3nyKXjJb93l5L058rynt15DTUja+pxwtk
         0nRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681331308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+aUZ9ayjHDjQECrUm843lDN3BOqqfJ0QMYhbNwLySUs=;
        b=GSgz9SBGlAaoGm13RAjZ+MSZxf5YsMH8XSqyiGat9NiUvwHi560//51/eWjGod/xPn
         pPlEGa5QsTN6/Ttkl36aSTo3tyMoE0RRWO2XCVTvX0Ud+BZyuSrtgE+MEfOib+volwKt
         velEZYMXch/6/fanyorYRIdTfdLCV+nbrSGKYPhN26kEuNb7rXXH54A3n7+Y6O9v2YcM
         qpZ4dEYKBNeiHMvAiys5cLSudEx3ECZMaHI33xnuxTBRUMceYnPthMxz/mYTMsPNlKTO
         a2G/psIWprPakzhVpATr7o8r9VdJ7dbmMDMZ7c/rkgztAvNBnSU1aJwg+hNm9tVeswaY
         nOvA==
X-Gm-Message-State: AAQBX9dwPWqpwayS3ix5F/TYXfq9IU/oics7p91oGzyHgjX6k0AbE5TR
        qL/AUnNwn/H93NgRKcSa/EB3Y0FJPARtynkn9i/uEQ==
X-Google-Smtp-Source: AKy350Z+lfnmZ+Oz6XlirSrkEwkBBsYn5NNdh1LUUexoYrcx7bD8rwfm4+hOnSWFd3qWjlc4dl7xNNtS6lZ42aEcmeY=
X-Received: by 2002:a25:d657:0:b0:b76:ae61:b68b with SMTP id
 n84-20020a25d657000000b00b76ae61b68bmr9840484ybg.5.1681331307759; Wed, 12 Apr
 2023 13:28:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230411160056.1586-1-michal.wajdeczko@intel.com> <20230411160056.1586-4-michal.wajdeczko@intel.com>
In-Reply-To: <20230411160056.1586-4-michal.wajdeczko@intel.com>
From:   Rae Moar <rmoar@google.com>
Date:   Wed, 12 Apr 2023 16:28:15 -0400
Message-ID: <CA+GJov53J4WhXXUSrGDPZ-hqogL0eYOzaf_RgGQ1paj=_EtLUA@mail.gmail.com>
Subject: Re: [PATCH 3/3] kunit: Update reporting function to support results
 from subtests
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
> There is function to report status of either suite or test, but it
> doesn't support parameterized subtests that have to log report on
> its own. Extend it to also accept subtest level results to avoid
> code duplication.
>
> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
> Cc: David Gow <davidgow@google.com>
> ---
>  lib/kunit/test.c | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 5679197b5f8a..692fce258c5b 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -154,8 +154,14 @@ static void kunit_print_suite_start(struct kunit_sui=
te *suite)
>                   kunit_suite_num_test_cases(suite));
>  }
>
> +enum kunit_test_or_suite {
> +       KUNIT_SUITE =3D 0,
> +       KUNIT_TEST,
> +       KUNIT_SUBTEST,
> +};
> +

Hi Michal!

Since KUnit's goal is to progress toward supporting arbitrary levels
of testing, I like the idea of starting to adjust these helper
functions to allow for greater levels of testing.

However, I'm not sure about this kunit_test_or_suite enum. If our goal
is to support an arbitrary number of levels of tests then this enum
still limits us to a finite number of levels. However, if we only want
to focus on supporting parameterized tests (which is our direct goal),
this could be the right solution.

Maybe instead we could use an integer denoting the test level instead?
This would remove the limit but would also remove the nice names of
the levels.

I'm curious what others opinions are on these ideas?

A bit of a nit: if we do use this enum I wonder if we could clarify
the name to be kunit_test_level as the current name of
kunit_test_or_suite seems to indicate to me a binary of two options
rather than three.

>  static void kunit_print_ok_not_ok(void *test_or_suite,
> -                                 bool is_test,
> +                                 enum kunit_test_or_suite is_test,

Similar to above, I think the name of is_test could be clarified. It
is currently a bit confusing to me as they are all tests. Maybe
test_level?

>                                   enum kunit_status status,
>                                   size_t test_number,
>                                   const char *description,
> @@ -180,7 +186,9 @@ static void kunit_print_ok_not_ok(void *test_or_suite=
,
>                         (status =3D=3D KUNIT_SKIPPED) ? directive : "");
>         else
>                 kunit_log(KERN_INFO, test,
> -                         KUNIT_SUBTEST_INDENT "%s %zd %s%s%s",
> +                         "%.*s%s %zd %s%s%s",
> +                         (int) strlen(KUNIT_SUBTEST_INDENT) * is_test,

I would consider saving the length of KUNIT_SUBTEST_INDENT as a macro.
Maybe KUNIT_INDENT_LEN?

> +                         KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT,
>                           kunit_status_to_ok_not_ok(status),
>                           test_number, description, directive_header,
>                           (status =3D=3D KUNIT_SKIPPED) ? directive : "")=
;
> @@ -209,7 +217,7 @@ static size_t kunit_suite_counter =3D 1;
>
>  static void kunit_print_suite_end(struct kunit_suite *suite)
>  {
> -       kunit_print_ok_not_ok((void *)suite, false,
> +       kunit_print_ok_not_ok((void *)suite, KUNIT_SUITE,
>                               kunit_suite_has_succeeded(suite),
>                               kunit_suite_counter++,
>                               suite->name,
> @@ -554,13 +562,11 @@ int kunit_run_tests(struct kunit_suite *suite)
>                                                  "param-%d", test.param_i=
ndex);
>                                 }
>
> -                               kunit_log(KERN_INFO, &test,
> -                                         KUNIT_SUBTEST_INDENT KUNIT_SUBT=
EST_INDENT
> -                                         "%s %d %s%s%s",
> -                                         kunit_status_to_ok_not_ok(test.=
status),
> -                                         test.param_index + 1, param_des=
c,
> -                                         test.status =3D=3D KUNIT_SKIPPE=
D ? " # SKIP " : "",
> -                                         test.status =3D=3D KUNIT_SKIPPE=
D ? test.status_comment : "");
> +                               kunit_print_ok_not_ok(&test, KUNIT_SUBTES=
T,
> +                                                     test.status,
> +                                                     test.param_index + =
1,
> +                                                     param_desc,
> +                                                     test.status_comment=
);
>
>                                 /* Get next param. */
>                                 param_desc[0] =3D '\0';
> @@ -574,7 +580,7 @@ int kunit_run_tests(struct kunit_suite *suite)
>
>                 kunit_print_test_stats(&test, param_stats);
>
> -               kunit_print_ok_not_ok(&test, true, test_case->status,
> +               kunit_print_ok_not_ok(&test, KUNIT_TEST, test_case->statu=
s,
>                                       kunit_test_case_num(suite, test_cas=
e),
>                                       test_case->name,
>                                       test.status_comment);
> --
> 2.25.1
>
> --
> You received this message because you are subscribed to the Google Groups=
 "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kunit-dev/20230411160056.1586-4-michal.wajdeczko%40intel.com.
