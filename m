Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80F902B2390
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Nov 2020 19:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbgKMSVh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Nov 2020 13:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgKMSVh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Nov 2020 13:21:37 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF1CC0617A6
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Nov 2020 10:21:37 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id l12so9325277ilo.1
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Nov 2020 10:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=79wbZoE3GOyuxGWKfedfZYeqkSHAT4uL/MrnpeM74QQ=;
        b=XicMtrDj3dd1//eikUVoP+OEKSK5r7Ovb2VtsTPyZmpYmfZnIjNfCudn4WdL8H9+cc
         kVR9eN7Re0bnD+P/MAOA5n0PuXpNjRNUraR3M8ssFfhSPnW+B5LmY4pZvUMwhX459DT2
         cjBNHhk+rZuwMEu3itugnytO6y35fzbky0l/bi0QFjzN7w+1XZdJEs0L+2ofY6GH1rTF
         QorhYU9IvIMt5Eer0p/CRlzGaiR4QbD8qN8SPvq42a1h2vjkRzm2/WOAUHKXso/M27rv
         /E19htNtm/MHIj3N7h+YQYluuFaGFMXYr03xbHKmN+pJTBgJXrgJikcH8yoSc3eY/UvS
         K66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=79wbZoE3GOyuxGWKfedfZYeqkSHAT4uL/MrnpeM74QQ=;
        b=j6D8Mv6Gzv7uSh2w0QbsPUNiM9dPchbDX5BanUH88tASeWoiCcFktFWSf+Ksy+xdI7
         4ROgMuT7ZpSQcrjuamk+6Vq5I6NqmUYte88uTacHLuutvrLKV4y+IYu0TlI0lLTA+Hfl
         DX0oUcOEv5z7QGPBSDIkUbsUfb/m7Kq3P9fDzJfPM3GxKW0KHCsceG7VcSqTddXjfuqz
         D7+lisK/EqEJ9j3YYBehMZtaF/Nj9lErcGvQw+M8D2s6X85rtXRZt7WA+UDbmk9WOBgE
         u2FsY9tsgC9tl/RT8Sm383Ne9DYTHu/6VQweFHUkDYLRLUFIm3eRNRGQ1u18WHCIbkx+
         bZrA==
X-Gm-Message-State: AOAM531uAr644ze1sP7CScQ7FQMT5oDAupQ2t75ZbS+PzwnH6fsQVg0k
        hBP7okNyPfBSC3qh9SZQNEe/4nOBgMrH2LCEMyoOwQ==
X-Google-Smtp-Source: ABdhPJxqWNHlfEFT0soeAX+8qUeACIvDckTcYuYaZrjQumMierhE7yj7EFHyOH81XDRqnxq9PLzrjirJgzoDDFBBIfA=
X-Received: by 2002:a92:b311:: with SMTP id p17mr869050ilh.194.1605291696308;
 Fri, 13 Nov 2020 10:21:36 -0800 (PST)
MIME-Version: 1.0
References: <20201102213656.2700500-1-dlatypov@google.com> <CABVgOSnCkbs+5EEOq7gxUdQUpTL4vOPFvagJoMQ7t0dtg4DQeA@mail.gmail.com>
In-Reply-To: <CABVgOSnCkbs+5EEOq7gxUdQUpTL4vOPFvagJoMQ7t0dtg4DQeA@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 13 Nov 2020 10:21:24 -0800
Message-ID: <CAGS_qxqmrC19csfmOx_Reerfubo7OHdwDF+Ra-MBaN8X-Sbobw@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kunit: provide guidance for testing many inputs
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 6, 2020 at 8:21 PM David Gow <davidgow@google.com> wrote:
>
> On Tue, Nov 3, 2020 at 5:37 AM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > usage.rst goes into a detailed about faking out classes, but currently
>
> Nit: a detailed what?

Thanks for the catch, added "detailed section" locally.

>
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
>
> I suspect we'll eventually want to document the _MSG variants here as
> well, though it will bloat the page somewhat. In any case, it can be
> left to a separate patch.

Agreed.

>
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > ---
>
> Thanks for writing this -- it's definitely a common test pattern which
> it'd be nice to encourage and explain a bit better.

Apologies for the delayed response.
Noting here that having talked offline with David, this section will
have to change for parameterized testing (which is basically just
formalized support for table-driven tests).
But it seems it'll take a while to resolve the debate on TAP output,
so this docs change shouldn't be blocked on that going in.

>
> Cheers,
> -- David
>
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
> Nit: "various" isn't hugely descriptive here. Maybe something like
> "Testing against multiple inputs" would be better?

Changed.
As you can tell from the name of this patch ("many inputs"), I had
been unsure what to put here.
"multiple inputs" works fine, I think.
 I had initially changed from that, since I had wanted to convey that
these patterns are more useful when you have a larger number of inputs
to go through.
But in hindsight "multiple inputs" is just more clear.

>
> > +
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
>
> This is a bit of a nitpick, but I don't think this is quite conveying
> the usefulness of table-based testing. Maybe it's that a hypothetical
> "undo_md5sum" is too unrealistic an example? Maybe, instead of having
> both the macro-based and table-driven examples based around md5sum(),
> the table-based one could use something more obviously invertible /
> reusable, and include both in the example code. E.g, something akin to
> toupper() and tolower() or some other conversion function. I think
> having a better example here is probably more useful than having both
> the table- and macro- driven examples test the same thing.

Heh, I was worried about this a bit as well.
Perhaps an inverse md5 breaks "suspension of disbelief" too much, even
in this hypothetical context.

I had considered toupper()/tolower() but they aren't truly inverses,
e.g. tolower(toupper("Hello")), and felt a bit too trivial perhaps.
I'm also unsure I would test these functions on strs as opposed to
chars (unless we're dealing with non-ascii), whereas I probably would
test a checksum like this.
I wouldn't be too opposed to switching over to tolower/toupper().

But perhaps something like

struct sha_test_case {
  const char *str;
  const char *sha1, *sha256;
};

and reusing the same table would be good enough to demonstrate a
different kind of "reuse" that is somewhat common for table-driven
tests?

>
>
> >  .. _kunit-on-non-uml:
> >
> >  KUnit on non-UML architectures
> >
> > base-commit: 77c8473edf7f7664137f555cfcdc8c460bbd947d
> > --
> > 2.29.1.341.ge80a0c044ae-goog
> >
