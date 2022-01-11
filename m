Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F37F948B3D5
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jan 2022 18:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344343AbiAKR20 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Jan 2022 12:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344274AbiAKR2L (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Jan 2022 12:28:11 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E24C06175A
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jan 2022 09:27:39 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id m4so28606107edb.10
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jan 2022 09:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D7/rKBF2z2+95TZSmwkbl9A0yWqNIgVx8BXtOi49ZC4=;
        b=mLGm/drGnGgAWf9cmEbSUWEBikdzDIHuCPZvbz/sQlEpgdrdawiQ547uQ6tW5GZaSX
         k8QLAWCa1jhQjx5/DI16XYb/ZH/kVi0cqvhUVyyXRY+3KB31dPmJG2QMAp5VcLMrxr0R
         58VTMigyBQjD0BkwJzTomlOs0M5M45/bnzp2JHPOI6vbzZG04xd9CdE850St20UFEWDO
         8eBCcL+iMS8GVBkgCOKzpv5RcUVZh3HcAoc1mKRQfcA7jgLpnhFLFFMjTbRZe7q1Y9zH
         k+094CQHyjw9qzjV3jkdChNm8ktqZqnwgwVRJqbKvJiib116JOUN1w5gzrF8rU0JydT1
         P0kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D7/rKBF2z2+95TZSmwkbl9A0yWqNIgVx8BXtOi49ZC4=;
        b=M0wmPbo8yDuQhCM+ji9XjaxywFiCLcfwzDohgEp3T11yVHLCzKqVjzUsz6hrg1oBJ5
         drEzeE75jSajCZEBjaTgtg+/oFraeap9dJRiEPROShJ9HZlfa+53oVDmItN/dhxT+nrL
         7PnisB8Nk0JZa4RUtR6/vFhV5OsK6TQXesP7LbvD2oZSoyDXDZLKg3u7YPVQOqU9VF33
         BLBp2ULoeQ6AqLv86qtCl95vAD8a3gCwvS8/aSMtomoQybh0sqtX58sbNiZa8xCJu9JP
         /Ngqas8YDPlX1oDhXLPyQmxumGvpFsDrhvc4GE+z9GX4xpfOOgSxILM6FJBzDtk70+W2
         1Ukw==
X-Gm-Message-State: AOAM531fzG520ouzfem2ZbxL5XSsGamdLNyo+p4I4YipZSlt/UgBMrmj
        cuNsZ9y/8Ex6SXI6OVfcomKB9r5HJGji1Rd45nkvrw==
X-Google-Smtp-Source: ABdhPJyJ+bJwvfUeX3tH6S43WumwEqoUU7jQ6fcLxmrchpO0xomGv5fEyPtwN/Qhz1J0B5euWfL+JdHUUiHZef2F/B0=
X-Received: by 2002:aa7:dc53:: with SMTP id g19mr5308767edu.294.1641922057283;
 Tue, 11 Jan 2022 09:27:37 -0800 (PST)
MIME-Version: 1.0
References: <20220108012304.1049587-1-dlatypov@google.com> <20220108012304.1049587-2-dlatypov@google.com>
 <CABVgOS=-KS8kdEsDFRuFM672KSvRGYEjtToA2J_-UeHLqcTH1Q@mail.gmail.com>
In-Reply-To: <CABVgOS=-KS8kdEsDFRuFM672KSvRGYEjtToA2J_-UeHLqcTH1Q@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 11 Jan 2022 09:27:26 -0800
Message-ID: <CAGS_qxqJ8E9d9c6o8hf7mWwDqQXCt37-ShPUhkHsCVPnY7HacQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] kunit: add example test case showing off all the
 expect macros
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 10, 2022 at 10:51 PM David Gow <davidgow@google.com> wrote:
>
> On Sat, Jan 8, 2022 at 9:23 AM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > Currently, these macros are only really documented near the bottom of
> > https://www.kernel.org/doc/html/latest/dev-tools/kunit/api/test.html#c.KUNIT_FAIL.
> >
> > E.g. it's likely someone might just not realize that
> > KUNIT_EXPECT_STREQ() exists and instead use KUNIT_EXPECT_FALSE(strcmp())
> > or similar.
> >
> > This can also serve as a basic smoketest that the KUnit assert machinery
> > still works for all the macros.
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > ---
>
> I think this is a great idea. I will note that this definitely isn't a
> full test _of_ the assertion macros (in that it only exercises the
> success case), so keeping it as an example is probably best.
>
> A few possible ideas below, but I'm happy enough with this as-is regardless.

Applied the ideas locally.
It led to this diffstat
 lib/kunit/kunit-example-test.c | 42 +++++++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

So it's now a bit shorter and 8 of the added lines are new comments.

>
> Reviewed-by: David Gow <davidgow@google.com>
>
> >  lib/kunit/kunit-example-test.c | 46 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 46 insertions(+)
> >
> > diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
> > index 51099b0ca29c..182a64c12541 100644
> > --- a/lib/kunit/kunit-example-test.c
> > +++ b/lib/kunit/kunit-example-test.c
> > @@ -69,6 +69,51 @@ static void example_mark_skipped_test(struct kunit *test)
> >         /* This line should run */
> >         kunit_info(test, "You should see this line.");
> >  }
> > +
> > +/*
> > + * This test shows off all the KUNIT_EXPECT macros.
> > + */
> > +static void example_all_expect_macros_test(struct kunit *test)
> > +{
> > +       KUNIT_EXPECT_TRUE(test, true);
> > +       KUNIT_EXPECT_FALSE(test, false);
>
> _Maybe_ it's worth having a comment for each of these groups ('boolean
> assertions', 'integer assertions', 'pointer assertions', etc)?

Good idea, done.

>
> > +
> > +       KUNIT_EXPECT_EQ(test, 1, 1);
> > +       KUNIT_EXPECT_GE(test, 1, 1);
> > +       KUNIT_EXPECT_LE(test, 1, 1);
> > +       KUNIT_EXPECT_NE(test, 1, 0);
> > +       KUNIT_EXPECT_GT(test, 1, 0);
> > +       KUNIT_EXPECT_LT(test, 0, 1);
> > +
> > +       KUNIT_EXPECT_NOT_ERR_OR_NULL(test, test);
> > +       KUNIT_EXPECT_PTR_EQ(test, NULL, NULL);
> > +       KUNIT_EXPECT_PTR_NE(test, test, NULL);
> > +
> > +       KUNIT_EXPECT_STREQ(test, "hi", "hi");
> > +       KUNIT_EXPECT_STRNEQ(test, "hi", "bye");
> > +
> > +       /*
> > +        * There are also _MSG variants of all of the above that let you include
> > +        * additional text on failure.
> > +        */
>
> There are also the ASSERT vs EXPECT variations. While it may be
> excessive to also include all of these, particularly in an example, it
> might be worth mentioning them in a comment somewhere?

I've gone ahead and added a section with one example

+       /*
+        * There are also ASSERT variants of all of the above that abort test
+        * execution if they fail. Useful for memory allocations, etc.
+        */
+       KUNIT_ASSERT_GT(test, sizeof(char), 0);
+


>
> Alternatively, if this is bloating the example too much, we could have
> only one example each of the ASSERT and _MSG variants.
>
> > +       KUNIT_EXPECT_TRUE_MSG(test, true, "msg");
> > +       KUNIT_EXPECT_FALSE_MSG(test, false, "msg");
>
> Part of me feels that a better message than "msg" would be nice to
> have here, but I can't think of a good one. Maybe (particularly for
> the less obvious integer/string/pointer macros below), having a
> description of what's being asserted?


I've gone ahead and added truncated this down to one example

+       KUNIT_EXPECT_GT_MSG(test, sizeof(int), 0, "Your ints are 0-bit?!");
+       KUNIT_ASSERT_GT_MSG(test, sizeof(int), 0, "Your ints are 0-bit?!");

>
>
>
> > +
> > +       KUNIT_EXPECT_EQ_MSG(test, 1, 1, "msg");
> > +       KUNIT_EXPECT_GE_MSG(test, 1, 1, "msg");
> > +       KUNIT_EXPECT_LE_MSG(test, 1, 1, "msg");
> > +       KUNIT_EXPECT_NE_MSG(test, 1, 0, "msg");
> > +       KUNIT_EXPECT_GT_MSG(test, 1, 0, "msg");
> > +       KUNIT_EXPECT_LT_MSG(test, 0, 1, "msg");
> > +
> > +       KUNIT_EXPECT_NOT_ERR_OR_NULL_MSG(test, test, "msg");
> > +       KUNIT_EXPECT_PTR_EQ_MSG(test, NULL, NULL, "msg");
> > +       KUNIT_EXPECT_PTR_NE_MSG(test, test, NULL, "msg");
> > +
> > +       KUNIT_EXPECT_STREQ_MSG(test, "hi", "hi", "msg");
> > +       KUNIT_EXPECT_STRNEQ_MSG(test, "hi", "bye", "msg");
> > +}
> > +
> >  /*
> >   * Here we make a list of all the test cases we want to add to the test suite
> >   * below.
> > @@ -83,6 +128,7 @@ static struct kunit_case example_test_cases[] = {
> >         KUNIT_CASE(example_simple_test),
> >         KUNIT_CASE(example_skip_test),
> >         KUNIT_CASE(example_mark_skipped_test),
> > +       KUNIT_CASE(example_all_expect_macros_test),
> >         {}
> >  };
> >
> > --
> > 2.34.1.575.g55b058a8bb-goog
> >
