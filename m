Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF4E72AA266
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Nov 2020 05:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbgKGEVR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Nov 2020 23:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbgKGEVR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Nov 2020 23:21:17 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDA7C0613CF
        for <linux-kselftest@vger.kernel.org>; Fri,  6 Nov 2020 20:21:15 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id b1so4748859lfp.11
        for <linux-kselftest@vger.kernel.org>; Fri, 06 Nov 2020 20:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5EQ5yhtsM5FJ1ds4Py9VQndnt4warxwMwsiE54Njo84=;
        b=CddQ03gtblTYRVvKF7bi/MX/kHeGciFqdaHcGMniZASwrJnFdWb1gAdMe/jI8Gyb0B
         Up8zhGBlr88Nn7aBtYFFScgnIHT3CDkzhtxnuloksq7B7absgz3wCIhBFDzOIjAyv5OD
         aT+mAiadzFdtNwGM8gHZiz61bvk7apXJyFbEPbli/G2g1O2nhbUabGifsvmurxjyugeD
         83kg4xBtIHuMfdJetNE0Dr9SlYQ/WmHWBbqJ1tSEZ13BlyUDlMbDoO9oSwJBRt58lfir
         hmIBlYY598rs7N7jW6x/ErKkXb12OSkk5L9KUxjvpWUn68wgOL4p0TySINOss4u41gFq
         z5ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5EQ5yhtsM5FJ1ds4Py9VQndnt4warxwMwsiE54Njo84=;
        b=Sc7Qsg6y5xiJLNjloI7/flhuzwAKAAFnVb2w6/dFBndyjJTPXQ78RsIn/9ri7hEhcT
         0vUqAmKLdDqPuJQDD/xyEv9mR1ThBo9S6qNjb1ymZywxV2r39d8DzUQhSwKIx4fgFlTT
         qE27rREPgq3FYuZ1v7tNGnlTaSEOxAXdnI9XL2RLQ6XaQ6lIiWHls1qrPP2cPdTtTIKD
         aTGCFymElvszxOTMpSfLIcKAXnugdKr0izsD0JTlUnBfLZOWqeWM6yXJcIgvkIM7UZuJ
         /bTr078tjJsM6NGXGyFOwijcFXCZnLq6fWRBum300vABfbE19fnHvJKSjHCWisN4GCjK
         uYDA==
X-Gm-Message-State: AOAM533Gw5i/6TaL3QqGGxBfn3JWF347d7BaHH4ick9kn/QhJGBJFA9+
        Jtwbsfy+plOwy3q9R/Terh5FNLjVazRR3bKyPHIfzw==
X-Google-Smtp-Source: ABdhPJzeoWWYf/2tSb7tqjA7bjSyXyn+kjOeQR9Mk7pPlvVeVG3unfTkEaigRj1wWkGDk3KIF64f5HtuoPJYXUBVZJg=
X-Received: by 2002:a05:6512:110b:: with SMTP id l11mr1762317lfg.234.1604722873677;
 Fri, 06 Nov 2020 20:21:13 -0800 (PST)
MIME-Version: 1.0
References: <20201102213656.2700500-1-dlatypov@google.com>
In-Reply-To: <20201102213656.2700500-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 7 Nov 2020 12:21:01 +0800
Message-ID: <CABVgOSnCkbs+5EEOq7gxUdQUpTL4vOPFvagJoMQ7t0dtg4DQeA@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kunit: provide guidance for testing many inputs
To:     Daniel Latypov <dlatypov@google.com>
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

On Tue, Nov 3, 2020 at 5:37 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> usage.rst goes into a detailed about faking out classes, but currently

Nit: a detailed what?

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

I suspect we'll eventually want to document the _MSG variants here as
well, though it will bloat the page somewhat. In any case, it can be
left to a separate patch.

>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Thanks for writing this -- it's definitely a common test pattern which
it'd be nice to encourage and explain a bit better.

Cheers,
-- David

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
Nit: "various" isn't hugely descriptive here. Maybe something like
"Testing against multiple inputs" would be better?

> +
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

This is a bit of a nitpick, but I don't think this is quite conveying
the usefulness of table-based testing. Maybe it's that a hypothetical
"undo_md5sum" is too unrealistic an example? Maybe, instead of having
both the macro-based and table-driven examples based around md5sum(),
the table-based one could use something more obviously invertible /
reusable, and include both in the example code. E.g, something akin to
toupper() and tolower() or some other conversion function. I think
having a better example here is probably more useful than having both
the table- and macro- driven examples test the same thing.


>  .. _kunit-on-non-uml:
>
>  KUnit on non-UML architectures
>
> base-commit: 77c8473edf7f7664137f555cfcdc8c460bbd947d
> --
> 2.29.1.341.ge80a0c044ae-goog
>
