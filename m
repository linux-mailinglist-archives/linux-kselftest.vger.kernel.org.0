Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CCE634247
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Nov 2022 18:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbiKVRO4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Nov 2022 12:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbiKVRO4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Nov 2022 12:14:56 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0275729BD
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Nov 2022 09:14:54 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-3a4c2c83300so54924167b3.13
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Nov 2022 09:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Trw6pRag45zh7xbBzKuk9eUIAumLjV1FB/I5WWUMeXc=;
        b=AJOsT7QLtuXDOuqy8Nd0IGY7ZchJBpJoPvWh9Vj61PSLn6YqfZr843CbYEjqCXumYy
         dLBBDwqSL0uccXO8vUb4PtIE2gttVA6O8zx5TTZ9r5LikYoQkKw1la+JO08szC3HK4Yy
         yFdEUjvlTsyRoNvmp5qFe8kHanUkkAh70rHNjqUaAxmzWHD+89FucUS22ae6nfITrfr6
         txyfXpjPfdRBwebcTlBBIFyVRQX5VyCw18U9e5nb45jhFYFgljqjpSQHAi6JtUDKlHSJ
         zU+gIisrqVQ9gVvfPpgdRcwB9vQ9W54orXzvWCm+XK1pw3HC+Qy4GDzWfY9RMX3V2sxg
         0+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Trw6pRag45zh7xbBzKuk9eUIAumLjV1FB/I5WWUMeXc=;
        b=NL44evswEpsWEgUwexQjZIQwZZfdOcNBa6/9Pcvgv4V1my+GvY6gUGQZO7lJsZQQit
         NJITUhfBYKP2pacmPvJA4KkBQEXdBuHzFxE7Gp6t8emLvvRhFHmRy86UQjFAiC8jfwkY
         QSTlfBr9j0Hf/nRbtKsft+Yg5yaU4Yy9gOuYumkU5Z9e45/THywZ22W5/FhLl0oZnZUt
         +JxYfHN3RpNe0bCgPvP1Us0LSjysRF5tq89fvQGrF7Y3w9dPxuAvDjzqtEfFoGswEMD/
         sgLCpnfLYlAwLSrNHPlOhW9HN6YIez8zeU/CvFKepNwWZ3FgRFu7wsofbASDVxd+A0Kp
         AlUA==
X-Gm-Message-State: ANoB5pl+SKS+ENRMIpwb1ZSnPCek7BSgeemSBy6muDT4XpmhVpl9dRY7
        145P69Vi1YAlqxWt9XIPfmLY70prAzdHclTZiuYrWQ==
X-Google-Smtp-Source: AA0mqf6oO1oQ43wqxjCiE8z46ZjJMYHiF0pORLs1DGtEER+w3Lkn9AfI1AOxTLN0CLxS1gKZ3D/+ojACQvYkZgRs7vs=
X-Received: by 2002:a0d:dc05:0:b0:36a:bc93:587c with SMTP id
 f5-20020a0ddc05000000b0036abc93587cmr23162179ywe.59.1669137293721; Tue, 22
 Nov 2022 09:14:53 -0800 (PST)
MIME-Version: 1.0
References: <20221121184743.1123556-1-rmoar@google.com> <20221121184743.1123556-2-rmoar@google.com>
 <CADYN=9KUBaOG52SRtseLTkgkMzvzyCzCs3tR1vOk4yvkMSTJ2A@mail.gmail.com>
In-Reply-To: <CADYN=9KUBaOG52SRtseLTkgkMzvzyCzCs3tR1vOk4yvkMSTJ2A@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 22 Nov 2022 09:14:42 -0800
Message-ID: <CAGS_qxp7eLWJ+2DdzcdEezw067xxGO+v6VQwJD=jkBR-YKCefQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kunit: improve KTAP compliance of KUnit test output
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Rae Moar <rmoar@google.com>, brendanhiggins@google.com,
        davidgow@google.com, skhan@linuxfoundation.org,
        mauro.chehab@linux.intel.com, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        isabbasso@riseup.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 22, 2022 at 1:17 AM Anders Roxell <anders.roxell@linaro.org> wr=
ote:
>
> On Mon, 21 Nov 2022 at 19:48, Rae Moar <rmoar@google.com> wrote:
> >
> > Change KUnit test output to better comply with KTAP v1 specifications
> > found here: https://kernel.org/doc/html/latest/dev-tools/ktap.html.
> > 1) Use "KTAP version 1" instead of "TAP version 14" as test output head=
er
> > 2) Remove '-' between test number and test name on test result lines
> > 2) Add KTAP version lines to each subtest header as well
> >
> > Note that the new KUnit output still includes the =E2=80=9C# Subtest=E2=
=80=9D line now
> > located after the KTAP version line. This does not completely match the
> > KTAP v1 spec but since it is classified as a diagnostic line, it is not
> > expected to be disruptive or break any existing parsers. This
> > =E2=80=9C# Subtest=E2=80=9D line comes from the TAP 14 spec
> > (https://testanything.org/tap-version-14-specification.html)
> > and it is used to define the test name before the results.
> >
> > Original output:
> >
> >  TAP version 14
> >  1..1
> >    # Subtest: kunit-test-suite
> >    1..3
> >    ok 1 - kunit_test_1
> >    ok 2 - kunit_test_2
> >    ok 3 - kunit_test_3
> >  # kunit-test-suite: pass:3 fail:0 skip:0 total:3
> >  # Totals: pass:3 fail:0 skip:0 total:3
> >  ok 1 - kunit-test-suite
> >
> > New output:
> >
> >  KTAP version 1
> >  1..1
> >    KTAP version 1
> >    # Subtest: kunit-test-suite
> >    1..3
> >    ok 1 kunit_test_1
> >    ok 2 kunit_test_2
> >    ok 3 kunit_test_3
> >  # kunit-test-suite: pass:3 fail:0 skip:0 total:3
> >  # Totals: pass:3 fail:0 skip:0 total:3
> >  ok 1 kunit-test-suite
> >
> > Signed-off-by: Rae Moar <rmoar@google.com>
> > Reviewed-by: Daniel Latypov <dlatypov@google.com>
> > Reviewed-by: David Gow <davidgow@google.com>
>
> I tried this patch, see the full boot log [1] and I can still see some
>  tests that output the "old" format with 'ok 1 - kunit_test_1', for examp=
le
>
> ok 1 - 1901-12-13 Lower bound of 32bit < 0 timestamp, no extra bits
>
> Isn't this something that should be converted too?

Yes, thanks for catching that.
That's what I get from only looking over the diff this time since I
thought I remembered the code...

We also want this diff to fix a) debugfs, b) subtests.

diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
index 1048ef1b8d6e..de0ee2e03ed6 100644
--- a/lib/kunit/debugfs.c
+++ b/lib/kunit/debugfs.c
@@ -63,7 +63,7 @@ static int debugfs_print_results(struct seq_file
*seq, void *v)
        kunit_suite_for_each_test_case(suite, test_case)
                debugfs_print_result(seq, suite, test_case);

-       seq_printf(seq, "%s %d - %s\n",
+       seq_printf(seq, "%s %d %s\n",
                   kunit_status_to_ok_not_ok(success), 1, suite->name);
        return 0;
 }
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 19344cb501c5..c9d57a1d9524 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -556,7 +556,7 @@ int kunit_run_tests(struct kunit_suite *suite)

                                kunit_log(KERN_INFO, &test,
                                          KUNIT_SUBTEST_INDENT
KUNIT_SUBTEST_INDENT
-                                         "%s %d - %s",
+                                         "%s %d %s",

kunit_status_to_ok_not_ok(test.status),
                                          test.param_index + 1, param_desc)=
;

Daniel
