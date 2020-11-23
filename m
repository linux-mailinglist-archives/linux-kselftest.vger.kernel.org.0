Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9282C1849
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Nov 2020 23:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731113AbgKWWNy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Nov 2020 17:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728895AbgKWWNy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Nov 2020 17:13:54 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3E4C0613CF
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Nov 2020 14:13:54 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id t8so19780557iov.8
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Nov 2020 14:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YbOBzNVExiH64clQRI32BJmv9D/fQUmJHwb5YfTyaEc=;
        b=shaloUoNGlZyIAlKhS4E08L6THzCDtAQOmdPCBHKFHm3dZGLZJeqZ7B500HxM2BPgF
         hdV0c7KN0kg0IIc3E4TWeOn6nkixjiXx5H8l+jp1hnUPWnlLphDVAeHAGcnZRBNUhZWC
         X0x3Rv0G4cpfb2dZE3DXkW48wW4IJy2dFqWbTqOUmFHITmEKypc4f1eVqGMGBTmRgoSS
         F1rvVOrycEtsQ9Ob4SaMUj8HdqHhAwn1/sP2CC3+qIAxu3rss9vDeA/o9B9R78sFl8Uw
         epsQT6BOCw4jpFkPvW1fJ7sBFKAW+ls2kKuzKhdcF00pq+30RYpykwliz1cBLV5kfKs6
         hhig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YbOBzNVExiH64clQRI32BJmv9D/fQUmJHwb5YfTyaEc=;
        b=qcIkVsAWJTaLzWNScarvAwLPwhxch42QRq49CeUW6FebCScEbJ7Mj49N+lAdbWBPI2
         m5mb6iDluksxMgGFuh2GZFqjzOK1dosTlyWECJoOG3+yuoC9KIo5S+4alY6tIzl2By+f
         XnVBZfxzeekBUj5ks3dzhofrDJUSrhiN2Nmw5f0aqDxdKRYhB8CBYaOhJqH1ulCs26nB
         26O+ERzvlGQu5hU7L2NBPl/E8hmEJfW1u6S3xxDdXObNmVhJUg0S9w0NFcqjwRxT9YFu
         nxFxieaLGLI8eaOuX2IezEMrH+i/3bYHQsNnCM672FpKu9BCRBkIt48gPckpSDgd5Wm7
         44Vw==
X-Gm-Message-State: AOAM531WXOR6wqWJW7JVZpHdkURnWF6RP7oUhCKtXQkG74aWTM2Ojwmd
        sHNNJLcsj3eIWRlezRv9uLhSi2nguJxDZOYlrgvrjw==
X-Google-Smtp-Source: ABdhPJwp+twyRELPjRee3jPv4vD6OTveZtl1e0GPwaKoFaW8Av/s71zgKaTh9U9wb3Tj+JOgvS04hUZ6tDmVNRryW8I=
X-Received: by 2002:a6b:750c:: with SMTP id l12mr1568590ioh.57.1606169633317;
 Mon, 23 Nov 2020 14:13:53 -0800 (PST)
MIME-Version: 1.0
References: <20201102213656.2700500-1-dlatypov@google.com> <CAFd5g45GK-sQY-nXcOORoJNu_0JGPY1veZd8PuM0MDtGtDRHSg@mail.gmail.com>
In-Reply-To: <CAFd5g45GK-sQY-nXcOORoJNu_0JGPY1veZd8PuM0MDtGtDRHSg@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 23 Nov 2020 14:13:41 -0800
Message-ID: <CAGS_qxp0zz_J759YR20FFwepffwPQmK-nYmuzb7B_C+kYpJmGg@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kunit: provide guidance for testing many inputs
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 23, 2020 at 10:32 AM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Mon, Nov 2, 2020 at 1:37 PM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > usage.rst goes into a detailed about faking out classes, but currently
> > lacks wording about how one might idiomatically test a range of inputs.
> >
> > Give an example of how one might test a hash function via macros/helper
> > funcs and a table-driven test and very briefly discuss pros and cons.
> >
> > Also highlight the KUNIT_EXPECT_*_MSG() variants (that aren't mentioned
> > elsewhere [1]) which are particularly useful in these situations.
> >
> > It is also criminally underused at the moment, only appearing in 2
> > tests (both written by people involved in KUnit).
> >
> > [1] not even on
> > https://www.kernel.org/doc/html/latest/dev-tools/kunit/api/test.html
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
>
> Aside from the minor comment I made below, I like the patch; it is a
> definite improvement, but I think the test you wrote that ultimately
> led to this documentation fix had more information in it than this
> documentation. I think it only contains the pattern that you outlined
> here, but I think it does include some other best practices. Maybe we
> should add some more documentation patches with more code examples in
> the future?
>
> Anyway, like I said, I think this patch in and of itself looks pretty good.
>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
>
> > ---
> >  Documentation/dev-tools/kunit/usage.rst | 66 +++++++++++++++++++++++++
> >  1 file changed, 66 insertions(+)
> >
> > diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
> > index 62142a47488c..317390df2b96 100644
> > --- a/Documentation/dev-tools/kunit/usage.rst
> > +++ b/Documentation/dev-tools/kunit/usage.rst
> > @@ -451,6 +451,72 @@ We can now use it to test ``struct eeprom_buffer``:
> >                 destroy_eeprom_buffer(ctx->eeprom_buffer);
> >         }
> >
> > +Testing various inputs
> > +----------------------
>
> Since this, by my count, the second test pattern that we are
> introducing here, could we maybe call that out with a subheading or a
> new section or something? It would be nice if we could sort of build
> up a cookbook of testing patterns.

Good point, I noticed now the "Organization of this document" section
would need to be updated.
Perhaps something like

-This document is organized into two main sections: Testing and Isolating
-Behavior. The first covers what unit tests are and how to use KUnit to write
-them. The second covers how to use KUnit to isolate code and make it possible
-to unit test code that was otherwise un-unit-testable.
+This document is organized into two main sections: Testing and Common Patterns.
+The first covers what unit tests are and how to use KUnit to write them. The
+second covers common testing patterns, e.g. how to isolate code and make it
+possible to unit test code that was otherwise un-unit-testable.

I'll send out a V2 shortly, changing the example per David's
suggestion and with the above.

>
> > +Testing just a few inputs might not be enough to have confidence that the code
> > +works correctly, e.g. for a hash function.
> > +
> > +In such cases, it can be helpful to have a helper macro or function, e.g. this
> > +fictitious example for ``md5sum(1)``
> > +
> > +.. code-block:: c
> > +
> > +       /* Note: the cast is to satisfy overly strict type-checking. */
> > +       #define TEST_MD5(in, want) \
> > +               md5sum(in, out); \
> > +               KUNIT_EXPECT_STREQ_MSG(test, (char *)out, want, "md5sum(%s)", in);
> > +
> > +       char out[16];
> > +       TEST_MD5("hello world",   "5eb63bbbe01eeed093cb22bb8f5acdc3");
> > +       TEST_MD5("hello world!",  "fc3ff98e8c6a0d3087d515c0473f8677");
> > +
> > +Note the use of ``KUNIT_EXPECT_STREQ_MSG`` to give more context when it fails
> > +and make it easier to track down. (Yes, in this example, ``want`` is likely
> > +going to be unique enough on its own).
> > +
> > +The ``_MSG`` variants are even more useful when the same expectation is called
> > +multiple times (in a loop or helper function) and thus the line number isn't
> > +enough to identify what failed, like below.
> > +
> > +In some cases, it can be helpful to write a *table-driven test* instead, e.g.
> > +
> > +.. code-block:: c
> > +
> > +       int i;
> > +       char out[16];
> > +
> > +       struct md5_test_case {
> > +               const char *str;
> > +               const char *md5;
> > +       };
> > +
> > +       struct md5_test_case cases[] = {
> > +               {
> > +                       .str = "hello world",
> > +                       .md5 = "5eb63bbbe01eeed093cb22bb8f5acdc3",
> > +               },
> > +               {
> > +                       .str = "hello world!",
> > +                       .md5 = "fc3ff98e8c6a0d3087d515c0473f8677",
> > +               },
> > +       };
> > +       for (i = 0; i < ARRAY_SIZE(cases); ++i) {
> > +               md5sum(cases[i].str, out);
> > +               KUNIT_EXPECT_STREQ_MSG(test, (char *)out, cases[i].md5,
> > +                                     "md5sum(%s)", cases[i].str);
> > +       }
> > +
> > +
> > +There's more boilerplate involved, but it can:
> > +
> > +* be more readable when there are multiple inputs/outputs thanks to field names,
> > +
> > +  * E.g. see ``fs/ext4/inode-test.c`` for an example of both.
> > +* reduce duplication if test cases can be shared across multiple tests.
> > +
> > +  * E.g. if we had a magical ``undo_md5sum`` function, we could reuse ``cases``.
> > +
> >  .. _kunit-on-non-uml:
> >
> >  KUnit on non-UML architectures
> >
> > base-commit: 77c8473edf7f7664137f555cfcdc8c460bbd947d
> > --
> > 2.29.1.341.ge80a0c044ae-goog
> >
