Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3AA24A89C
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Aug 2020 23:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgHSViK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Aug 2020 17:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbgHSViJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Aug 2020 17:38:09 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C985EC061757
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Aug 2020 14:38:08 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id u6so32921ybf.1
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Aug 2020 14:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=13XolofnMqkZ3K9umi/DCyCMfPlDNJF7Y24BCXktKJ8=;
        b=WKjKspycM95F+F/+s0p/Unh0lcBokeMnwMmc9RErG+o9e8Jx0hs7UTYn8Rc2pePZS2
         p/XReRBXb2dv18poh+WHfBY58jOk/+0ot2ozdWDwSHRlLFdQxd0k3GxevhJCbC3mhZPA
         CZTIzdoHs9+EJPVjywLJYny1Hs36Ia7bQIU4bUnjv0Mr5TweqLCqVdLNYaeozkFHNeXc
         Ql4qhAAaN0alQjJD0DkmhvVi0P2E5w6Wj/uegDWd1qg5aKLPHhvXMB3rAi/9TzCBg503
         rPVE3F0v6bs1qBPL6EG9ImyQ9besK61pjiJk5D4hTHon/+B/DeowJY0M2nnVNaofbVSM
         dWsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=13XolofnMqkZ3K9umi/DCyCMfPlDNJF7Y24BCXktKJ8=;
        b=Qy0hY3jaQbuA+PtPVQ4bxLwlojgmWj1AFNJpF/0aMN6fRDHfN1JsdrdvfQ9/7lnEIj
         yT6roq5nq9aiAo8ID1ERgwZJAd/tEEnDTT7ykCB5wsRziMLJcxwc0cdu7yLHtxmLBy3V
         evuwzNiYnBOMxNSwdKBfyP7zHtbLQck5RVrOF1t7GXYsZ46nzir0wgamKmltAyqtbUII
         9O60FIALLPCZQzn0GKmzQ2SLcuQwWPOW5Fkl64imFAVXYITlC9v5ZhOpYV/HW/3bOW93
         miWVeG8GRG08zGu2X2oiQQLXh7nBtCOutIWWET6gb6wHvwRm7S9SxFj8Mo4pZbmIW8od
         y7iQ==
X-Gm-Message-State: AOAM532vz1j6jE+YEQ8T7PNVcVarV4RQ4ywfFKDJicTHX7f2lgYeuX1R
        TGU9mO/V8bWq9jTozJZoR7cp3/R27kT7knoKflxJfQ==
X-Google-Smtp-Source: ABdhPJzGHDDZHjLK2LJTsnoVbyhxAgGYhcmzSmSQlpqSOKuWguwYH45MdXfW6BiVNriYDmSpTMChM80CRZYl6j4SSc0=
X-Received: by 2002:a25:2fcc:: with SMTP id v195mr542457ybv.119.1597873087805;
 Wed, 19 Aug 2020 14:38:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200819194634.68976-1-vitor@massaru.org> <CAFd5g45AuxZYY_92rOXwtVjmbaGuts+DV6WpqhHNxWYNotxq+g@mail.gmail.com>
In-Reply-To: <CAFd5g45AuxZYY_92rOXwtVjmbaGuts+DV6WpqhHNxWYNotxq+g@mail.gmail.com>
From:   Vitor Massaru Iha <vitor@massaru.org>
Date:   Wed, 19 Aug 2020 18:37:31 -0300
Message-ID: <CADQ6JjU_ppjnPU6=_eOiwjQe-FKn1Rpf-p+WDEA57rXGF80PEQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: fix: kunit_binary_assert_format() only prints
 signed int
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 19, 2020 at 6:30 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Wed, Aug 19, 2020 at 12:46 PM Vitor Massaru Iha <vitor@massaru.org> wrote:
> >
> > Some tests, such as overflow_kunit(), uses unsigned int,
> > But kunit_binary_assert_format() only prints signed int,
> > this commit also deals with the unsigned int print.

Oops, Thanks!
I'll fix it.

> >
> > Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> > ---
> >  lib/kunit/assert.c | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> >
> > diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
> > index 202f9fdeed0e..3ae90c09986a 100644
> > --- a/lib/kunit/assert.c
> > +++ b/lib/kunit/assert.c
> > @@ -104,12 +104,23 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
> >                                   binary_assert->left_text,
> >                                   binary_assert->operation,
> >                                   binary_assert->right_text);
> > -               string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld\n",
> > +
> > +               if (binary_assert->left_value - 1 < 0) {
> > +                       string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld\n",
> > +                                 binary_assert->left_text,
> > +                                 binary_assert->left_value);
> > +                       string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld",
> > +                                 binary_assert->right_text,
> > +                                 binary_assert->right_value);
> > +               }
> > +               else {
> > +                       string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %llu\n",
> >                                   binary_assert->left_text,
> >                                   binary_assert->left_value);
> > -               string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld",
> > +                       string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %llu",
> >                                   binary_assert->right_text,
> >                                   binary_assert->right_value);
> > +               }
>
> I agree that you found a bug here; however, I disagree that this is
> the correct fix. Given that the value is stored as a long long; isn't
> the value always stored as a signed value? So if the value overflows,
> won't it still not pass the check you have here?
>
> >         }
> >         kunit_assert_print_msg(assert, stream);
> >  }
> >
> > base-commit: d43c7fb05765152d4d4a39a8ef957c4ea14d8847
> > prerequisite-patch-id: bf4b0962b0b955e4e45f5d25fece889562118158
> > --
> > 2.26.2
> >
