Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84204634800
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Nov 2022 21:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbiKVUTn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Nov 2022 15:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbiKVUTm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Nov 2022 15:19:42 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F6428E08
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Nov 2022 12:19:41 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id e205so17002555oif.11
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Nov 2022 12:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJeM2QZ9j6Bl1KYDD45QbX15tSP8xUPz8dxNHtRGie0=;
        b=SJhuMMaSp6msJ0PsB556c5ah3uZu7a10YngHgwsZfuGDB8+IF/LJYOqzGIhX52Sqnh
         acj5Uc5MxbBqHpuvgO/xmEsUWBOXnTL9JOwQmaT4jWTgAYV8Zf/vt4UFcQx7lPJOyCex
         y81jzFq1ki8KZ+JPC9h/sjVY4plAq19ncn+IccWU0PzEpSNsk1FXhp44fZvll2ffWsRz
         Vz1ZzxFiAIOh97C7LqM0knQbx+mo59/ByP/U7J5Q2HXKa8BzC9Mtu6NlEgAUR2+Tj2l9
         OL2xSSxY6WsL0FGRgRLj6ByyizeMe1cqwJmp6pttKjVEFi5kchTfcPhiv3Vbu5CdOMOb
         azww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJeM2QZ9j6Bl1KYDD45QbX15tSP8xUPz8dxNHtRGie0=;
        b=OjUpWwlaB6FX0M4G2ozEEKqwUBq/YwydWxPMq/kcOiKXPRfwsAamoYp+1oW7TE/dqZ
         0gnZJjczUEHa6SiDYygMKvn/Ya7PcME95Tv6pzaUCnFotECKGef2icrmim352WsuPzuX
         9BODj7im55hKBy67xhQ3eCWtGTKz2Px4OfZlifG/B4K2w/jCPlIRAj0jc3JAVYHnwcB8
         XZkooDm6s1Gw/vJNcRs9KUaZAomhsY9sDsoyvQ5oXPzUpDB/WfMsZ2GNizjHecx1cAM6
         5c0/CvFDyKmStJXYe7AM8F6xNc3/MyXgP/WfCyy6mzAjfP+3qd7tToa9bxk7hrFJizYi
         cJzA==
X-Gm-Message-State: ANoB5plLj7LAacUDIBnwSjA9nl24VMZb7h1TYGCkuh0igm5gF48+7HYW
        zIsFBMzTZ0RXE6VDdFZgXjw9LiozJgFGKJ5CaifuIw==
X-Google-Smtp-Source: AA0mqf6ZAbjJ7gQ7mlzp85IXiOHOKc/bQHBSbghmcmvRAlU5CeViWuctX+g7H3VZdwHKT6naUZDnNUpPqjg627seies=
X-Received: by 2002:a54:441a:0:b0:35a:4390:1b8b with SMTP id
 k26-20020a54441a000000b0035a43901b8bmr2549926oiw.122.1669148380657; Tue, 22
 Nov 2022 12:19:40 -0800 (PST)
MIME-Version: 1.0
References: <20221121184743.1123556-1-rmoar@google.com> <20221121184743.1123556-2-rmoar@google.com>
 <CADYN=9KUBaOG52SRtseLTkgkMzvzyCzCs3tR1vOk4yvkMSTJ2A@mail.gmail.com> <CAGS_qxp7eLWJ+2DdzcdEezw067xxGO+v6VQwJD=jkBR-YKCefQ@mail.gmail.com>
In-Reply-To: <CAGS_qxp7eLWJ+2DdzcdEezw067xxGO+v6VQwJD=jkBR-YKCefQ@mail.gmail.com>
From:   Rae Moar <rmoar@google.com>
Date:   Tue, 22 Nov 2022 15:19:28 -0500
Message-ID: <CA+GJov7v8hbJ6A2ehfpZvG3+e181D0JrJRYDTQc9_QMM4G0HQA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kunit: improve KTAP compliance of KUnit test output
To:     Daniel Latypov <dlatypov@google.com>,
        Anders Roxell <anders.roxell@linaro.org>
Cc:     brendanhiggins@google.com, davidgow@google.com,
        skhan@linuxfoundation.org, mauro.chehab@linux.intel.com,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, isabbasso@riseup.net
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

On Tue, Nov 22, 2022 at 12:14 PM Daniel Latypov <dlatypov@google.com> wrote=
:
>
> On Tue, Nov 22, 2022 at 1:17 AM Anders Roxell <anders.roxell@linaro.org> =
wrote:
> >
> > On Mon, 21 Nov 2022 at 19:48, Rae Moar <rmoar@google.com> wrote:
> > >
> > > Change KUnit test output to better comply with KTAP v1 specifications
> > > found here: https://kernel.org/doc/html/latest/dev-tools/ktap.html.
> > > 1) Use "KTAP version 1" instead of "TAP version 14" as test output he=
ader
> > > 2) Remove '-' between test number and test name on test result lines
> > > 2) Add KTAP version lines to each subtest header as well
> > >
> > > Note that the new KUnit output still includes the =E2=80=9C# Subtest=
=E2=80=9D line now
> > > located after the KTAP version line. This does not completely match t=
he
> > > KTAP v1 spec but since it is classified as a diagnostic line, it is n=
ot
> > > expected to be disruptive or break any existing parsers. This
> > > =E2=80=9C# Subtest=E2=80=9D line comes from the TAP 14 spec
> > > (https://testanything.org/tap-version-14-specification.html)
> > > and it is used to define the test name before the results.
> > >
> > > Original output:
> > >
> > >  TAP version 14
> > >  1..1
> > >    # Subtest: kunit-test-suite
> > >    1..3
> > >    ok 1 - kunit_test_1
> > >    ok 2 - kunit_test_2
> > >    ok 3 - kunit_test_3
> > >  # kunit-test-suite: pass:3 fail:0 skip:0 total:3
> > >  # Totals: pass:3 fail:0 skip:0 total:3
> > >  ok 1 - kunit-test-suite
> > >
> > > New output:
> > >
> > >  KTAP version 1
> > >  1..1
> > >    KTAP version 1
> > >    # Subtest: kunit-test-suite
> > >    1..3
> > >    ok 1 kunit_test_1
> > >    ok 2 kunit_test_2
> > >    ok 3 kunit_test_3
> > >  # kunit-test-suite: pass:3 fail:0 skip:0 total:3
> > >  # Totals: pass:3 fail:0 skip:0 total:3
> > >  ok 1 kunit-test-suite
> > >
> > > Signed-off-by: Rae Moar <rmoar@google.com>
> > > Reviewed-by: Daniel Latypov <dlatypov@google.com>
> > > Reviewed-by: David Gow <davidgow@google.com>
> >
> > I tried this patch, see the full boot log [1] and I can still see some
> >  tests that output the "old" format with 'ok 1 - kunit_test_1', for exa=
mple
> >
> > ok 1 - 1901-12-13 Lower bound of 32bit < 0 timestamp, no extra bits
> >
> > Isn't this something that should be converted too?

Hello! Sorry for missing that. You are definitely right. Those results shou=
ld
be converted as well.

>
> Yes, thanks for catching that.
> That's what I get from only looking over the diff this time since I
> thought I remembered the code...
>
> We also want this diff to fix a) debugfs, b) subtests.
>
> diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
> index 1048ef1b8d6e..de0ee2e03ed6 100644
> --- a/lib/kunit/debugfs.c
> +++ b/lib/kunit/debugfs.c
> @@ -63,7 +63,7 @@ static int debugfs_print_results(struct seq_file
> *seq, void *v)
>         kunit_suite_for_each_test_case(suite, test_case)
>                 debugfs_print_result(seq, suite, test_case);
>
> -       seq_printf(seq, "%s %d - %s\n",
> +       seq_printf(seq, "%s %d %s\n",
>                    kunit_status_to_ok_not_ok(success), 1, suite->name);
>         return 0;
>  }
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 19344cb501c5..c9d57a1d9524 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -556,7 +556,7 @@ int kunit_run_tests(struct kunit_suite *suite)
>
>                                 kunit_log(KERN_INFO, &test,
>                                           KUNIT_SUBTEST_INDENT
> KUNIT_SUBTEST_INDENT
> -                                         "%s %d - %s",
> +                                         "%s %d %s",
>
> kunit_status_to_ok_not_ok(test.status),
>                                           test.param_index + 1, param_des=
c);
>
> Daniel

Thanks Daniel!

I think that should do the trick with the addition of adding the "KTAP
version 1" line, which you can do with the following diff:

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index c9d57a1d9524..1c9d8d962d67 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -543,6 +543,8 @@ int kunit_run_tests(struct kunit_suite *suite)
                        /* Get initial param. */
                        param_desc[0] =3D '\0';
                        test.param_value =3D
test_case->generate_params(NULL, param_desc);
+                       kunit_log(KERN_INFO, &test,
KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
+                                 "KTAP version 1\n");
                        kunit_log(KERN_INFO, &test,
KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
                                  "# Subtest: %s", test_case->name);

Going to run through some more examples to make sure this version
works otherwise I will make a v3 with the addition of fixing any merge
conflicts.

Rae
