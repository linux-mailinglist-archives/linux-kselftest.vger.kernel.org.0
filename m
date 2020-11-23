Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 550272C1338
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Nov 2020 19:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730488AbgKWScw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Nov 2020 13:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730127AbgKWScv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Nov 2020 13:32:51 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B692FC061A4D
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Nov 2020 10:32:51 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id l17so4596037pgk.1
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Nov 2020 10:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S7/hBpw1jQOsZMLR0IbK2KfjxCPz/Q4abhld7R5NsEg=;
        b=SH8NHO+1xWkDR50tGl49lWYygXwiwAVbL6pWVt8cexJe28y12AH98PlDBb+bNEmajh
         hG7cMe1ewLuLJW0fE5LMuM029fASO1fiq3GYgsB9MzhTb9EH09QxyXJ2Y3adyNM7raSt
         7JLMETAAAXHYGhTObezN0F7mDbBfkRcf5fwZuQ5ULQbgaiGddNe2oTIrk0FVxDyHtvZk
         ruB+evS+yNP1GAG2Xy17Hjhnz996natTnFA8Jyp9ERYCD/Hi5Ke257PiKonhAsU1uI1h
         63f+VQhxDoe6VQNePqy8gDEG/Y7iem69ebDNTuQ06PVHaJKLsLIjLO9NZsmJo5TXcwk8
         iSmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S7/hBpw1jQOsZMLR0IbK2KfjxCPz/Q4abhld7R5NsEg=;
        b=i/GGmjvkQTerlv9+rggyL4iZT1NHL6006rjdvXnwCf1VeeJNc9qzn6FeSvW8+OAXJb
         bonSIZAjBi+ogpxAv0b6LHAG6hGU4PVB+JtfXSWBmKIXIK/pmXDqifhSTjMHKhn0jw85
         /mDNWXmmn/VHjL3/sSJgT+M5Rd43Xfz4gTLrb92NLYsNce8L+JoBsYpTdT0MjTEJutvV
         S7QlpsdrVZ77ozcc9S3QvTZ/q8dgw/rJ5KH6AuKuEh+C/KSe+HE7aXyJmCfzcS7CZXLA
         VEQjF6kLGJnaBU2VO4TiHlzKGEyW6uiyqQr/FCvjZuWEuO4pGGulhrgmduaqwLrCuCt8
         oQMA==
X-Gm-Message-State: AOAM530d3bQK2qlhhl725JZyIkbus7ZH+csa3CysW0vdrONQNpD+TiIz
        Nzu8Eqfv/dkpdWSRQYUJe3Hz0+cQpDaf5YfKaG7T9w==
X-Google-Smtp-Source: ABdhPJwp/eni12FlnqhdbmPy5+kG09MywIckNKy1/Sk5R3WAhaS9ew0U7snU5Ja4SQmVa02m84SeiDXupBLBMirZDx8=
X-Received: by 2002:a63:1e5e:: with SMTP id p30mr620564pgm.159.1606156370956;
 Mon, 23 Nov 2020 10:32:50 -0800 (PST)
MIME-Version: 1.0
References: <20201102213656.2700500-1-dlatypov@google.com>
In-Reply-To: <20201102213656.2700500-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 23 Nov 2020 10:32:39 -0800
Message-ID: <CAFd5g45GK-sQY-nXcOORoJNu_0JGPY1veZd8PuM0MDtGtDRHSg@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kunit: provide guidance for testing many inputs
To:     Daniel Latypov <dlatypov@google.com>
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

On Mon, Nov 2, 2020 at 1:37 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> usage.rst goes into a detailed about faking out classes, but currently
> lacks wording about how one might idiomatically test a range of inputs.
>
> Give an example of how one might test a hash function via macros/helper
> funcs and a table-driven test and very briefly discuss pros and cons.
>
> Also highlight the KUNIT_EXPECT_*_MSG() variants (that aren't mentioned
> elsewhere [1]) which are particularly useful in these situations.
>
> It is also criminally underused at the moment, only appearing in 2
> tests (both written by people involved in KUnit).
>
> [1] not even on
> https://www.kernel.org/doc/html/latest/dev-tools/kunit/api/test.html
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Aside from the minor comment I made below, I like the patch; it is a
definite improvement, but I think the test you wrote that ultimately
led to this documentation fix had more information in it than this
documentation. I think it only contains the pattern that you outlined
here, but I think it does include some other best practices. Maybe we
should add some more documentation patches with more code examples in
the future?

Anyway, like I said, I think this patch in and of itself looks pretty good.

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

> ---
>  Documentation/dev-tools/kunit/usage.rst | 66 +++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
>
> diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
> index 62142a47488c..317390df2b96 100644
> --- a/Documentation/dev-tools/kunit/usage.rst
> +++ b/Documentation/dev-tools/kunit/usage.rst
> @@ -451,6 +451,72 @@ We can now use it to test ``struct eeprom_buffer``:
>                 destroy_eeprom_buffer(ctx->eeprom_buffer);
>         }
>
> +Testing various inputs
> +----------------------

Since this, by my count, the second test pattern that we are
introducing here, could we maybe call that out with a subheading or a
new section or something? It would be nice if we could sort of build
up a cookbook of testing patterns.

> +Testing just a few inputs might not be enough to have confidence that the code
> +works correctly, e.g. for a hash function.
> +
> +In such cases, it can be helpful to have a helper macro or function, e.g. this
> +fictitious example for ``md5sum(1)``
> +
> +.. code-block:: c
> +
> +       /* Note: the cast is to satisfy overly strict type-checking. */
> +       #define TEST_MD5(in, want) \
> +               md5sum(in, out); \
> +               KUNIT_EXPECT_STREQ_MSG(test, (char *)out, want, "md5sum(%s)", in);
> +
> +       char out[16];
> +       TEST_MD5("hello world",   "5eb63bbbe01eeed093cb22bb8f5acdc3");
> +       TEST_MD5("hello world!",  "fc3ff98e8c6a0d3087d515c0473f8677");
> +
> +Note the use of ``KUNIT_EXPECT_STREQ_MSG`` to give more context when it fails
> +and make it easier to track down. (Yes, in this example, ``want`` is likely
> +going to be unique enough on its own).
> +
> +The ``_MSG`` variants are even more useful when the same expectation is called
> +multiple times (in a loop or helper function) and thus the line number isn't
> +enough to identify what failed, like below.
> +
> +In some cases, it can be helpful to write a *table-driven test* instead, e.g.
> +
> +.. code-block:: c
> +
> +       int i;
> +       char out[16];
> +
> +       struct md5_test_case {
> +               const char *str;
> +               const char *md5;
> +       };
> +
> +       struct md5_test_case cases[] = {
> +               {
> +                       .str = "hello world",
> +                       .md5 = "5eb63bbbe01eeed093cb22bb8f5acdc3",
> +               },
> +               {
> +                       .str = "hello world!",
> +                       .md5 = "fc3ff98e8c6a0d3087d515c0473f8677",
> +               },
> +       };
> +       for (i = 0; i < ARRAY_SIZE(cases); ++i) {
> +               md5sum(cases[i].str, out);
> +               KUNIT_EXPECT_STREQ_MSG(test, (char *)out, cases[i].md5,
> +                                     "md5sum(%s)", cases[i].str);
> +       }
> +
> +
> +There's more boilerplate involved, but it can:
> +
> +* be more readable when there are multiple inputs/outputs thanks to field names,
> +
> +  * E.g. see ``fs/ext4/inode-test.c`` for an example of both.
> +* reduce duplication if test cases can be shared across multiple tests.
> +
> +  * E.g. if we had a magical ``undo_md5sum`` function, we could reuse ``cases``.
> +
>  .. _kunit-on-non-uml:
>
>  KUnit on non-UML architectures
>
> base-commit: 77c8473edf7f7664137f555cfcdc8c460bbd947d
> --
> 2.29.1.341.ge80a0c044ae-goog
>
