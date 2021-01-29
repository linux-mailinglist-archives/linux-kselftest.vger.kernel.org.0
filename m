Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5813084B2
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Jan 2021 05:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbhA2EwG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Jan 2021 23:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbhA2Ev7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Jan 2021 23:51:59 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CB5C061574
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Jan 2021 20:51:18 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id b2so10764647lfq.0
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Jan 2021 20:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aeTD92Zxp6kMBRHbnsNWj8wflOE/h037UXyPsCPMjdI=;
        b=tz2Ql4rhaR/3jodhyqwXpqVKiUTqkbTGyoivTEFWpDhi9c9rHfqHzSPzhcJP5NVaeJ
         yEe+ia7Ghe1jZYpKX8Vv3nvCyeWxQUuP2K1gQHa5ZV1WfUVmv5lJXKosV0kIFMD75OXb
         sT7dxTFBCdM3f2utXM9ozb7DNzI+9AILRi4NVD/2is3A0N3v7zjnrQBmO7KS+ZJZW1AC
         Z4ugnvFSMBC6l1ypeHC3X5+hxJ6fbBmTvvTPSJG3RW2NsaEX50a+yrfaPxOsuSJJanWn
         3HnsHCMYPcjdQxfG6BBMe/Nc2amuAkdyX8an4iCA9BNtauMbUCeVNnCpBFyWT7f+t9RT
         hyOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aeTD92Zxp6kMBRHbnsNWj8wflOE/h037UXyPsCPMjdI=;
        b=VtN546irXBnvM9S2u86pAH/ZRcUzmpiNl9k/dL8yvQg9MCHDxMTlOb/4teP9l9t3Ix
         qdsGVIrDeaMa4SaGxnU3DbWFGJWmRg5IHjNM/Da5oczf0HPoSl/+vdH/mXhDVAnSxKSL
         ppSITan0rrQhKzvzFdxuUR9avAgzqwFWoAVoX6FBeUQ314CUo0Lsc9nXIvB5rGE9Ke+B
         Sm0AajvgYJiTlcFrUVpsPUNewLmPAvT+bFwzGCCSEHYSNIZ0yYYZVz4D6dpwUR+oK0gn
         H1Bo3gXT4lxBPzD5x1KLrb6UNiYDseiNDpRkHPWoAU87LKBBz6JbwOVIHAHG6WBv/4pT
         KtzA==
X-Gm-Message-State: AOAM531KiZPtXhQqftmNUfeN2q2PO87j9FQfCKYHxPx5TcNo45B4Zd4l
        t7Nv9CU56v6DD6DpIm8NUKNlJL9Tj7cVMiogHzrsUA==
X-Google-Smtp-Source: ABdhPJyUjrPkPerF+yFxgaoSnEmHiyWD9jkfLyS0RJlUkWRl9u6G4OuMtkvFI/mwjF6TJTSbm4XpmtbJOrgWq77YyS8=
X-Received: by 2002:a19:4801:: with SMTP id v1mr1184621lfa.628.1611895875040;
 Thu, 28 Jan 2021 20:51:15 -0800 (PST)
MIME-Version: 1.0
References: <20210129022555.2411999-1-dlatypov@google.com>
In-Reply-To: <20210129022555.2411999-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 29 Jan 2021 12:51:03 +0800
Message-ID: <CABVgOSmaSz5jNkVTihCg3LbWg+6HGDPoQqjqNZ9_boOfUj_LkA@mail.gmail.com>
Subject: Re: [PATCH] kunit: don't show `1 == 1` in failed assertion messages
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jan 29, 2021 at 10:26 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Currently, given something (fairly dystopian) like
> > KUNIT_EXPECT_EQ(test, 2 + 2, 5)
>
> KUnit will prints a failure message like this.
> >  Expected 2 + 2 == 5, but
> >      2 + 2 == 4
> >      5 == 5
>
> With this patch, the output just becomes
> >  Expected 2 + 2 == 5, but
> >      2 + 2 == 4
>
> This patch is slightly hacky, but it's quite common* to compare an
> expression to a literal integer value, so this can make KUnit less
> chatty in many cases. (This patch also fixes variants like
> KUNIT_EXPECT_GT, LE, et al.).
>
> It also allocates an additional string briefly, but given this only
> happens on test failures, it doesn't seem too bad a tradeoff.
> Also, in most cases it'll realize the lengths are unequal and bail out
> before the allocation.
>
> We could save the result of the formatted string to avoid wasting this
> extra work, but it felt cleaner to leave it as-is.
>
> Edge case: for something silly and unrealistic like
> > KUNIT_EXPECT_EQ(test, 4, 5);
>
> It'll generate this message with a trailing "but"
> >  Expected 2 + 2 == 5, but
> >  <next line of normal output>

I assume this is supposed to say "Expected 4 == 5" here.
(I tested it to make sure, and that's what it did here.)

Personally, I'd ideally like to get rid of the ", but", or even add a
"but 4 != 5" style second line. Particularly in case the next line in
the output might be confused for the rest of a sentence.

That being said, this is a pretty silly edge case: I'd be worried if
we ever saw that case in an actual submitted test. People might see it
a bit while debugging, though: particularly if they're using
KUNIT_EXPECT_EQ(test, 1, 2) as a way of forcing a test to fail. (I've
done this while testing tooling, for instance.)

>
> It didn't feel worth adding a check up-front to see if both sides are
> literals to handle this better.
>
> *A quick grep suggests 100+ comparisons to an integer literal as the
> right hand side.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

I tested this, and it works well: the results are definitely more
human readable. I could see it making things slightly more complicated
for people who wanted to automatically parse assertion errors, but
no-one is doing that, and the extra complexity is pretty minimal
anyway.

One thing which might be worth doing is expanding this to
KUNIT_EXPECT_STREQ() and/or KUNIT_EXPECT_PTR_EQ(). These have slightly
more complicated formatting (quotes, leading 0s, etc), though.
Comparing pointer literals is pretty unlikely to show up, though, so I
don't think it's as important. (I thought that maybe the KASAN shadow
memory tests might use them, but a quick look didn't reveal any.)

For the record, this is what STREQ()/PTR_EQ()/ failures with literals look like:
# example_simple_test: EXPECTATION FAILED at lib/kunit/kunit-example-test.c:31
Expected "abc" == "abd", but
    "abc" == abc
    "abd" == abd
# example_simple_test: EXPECTATION FAILED at lib/kunit/kunit-example-test.c:33
Expected 0x124 == 0x1234, but
    0x124 == 0000000000000124
    0x1234 == 0000000000001234

Either way, though, this is:

Tested-by: David Gow <davidgow@google.com>

Cheers,
-- David
