Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D55B24A8FD
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Aug 2020 00:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgHSWT2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Aug 2020 18:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgHSWT1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Aug 2020 18:19:27 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367FDC061757
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Aug 2020 15:19:27 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id r4so93689pls.2
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Aug 2020 15:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wEwuGuxy3L1peQcMWumktXpMLRWDaCI5Cf0WrWRd6zw=;
        b=WfuwtID2xw/sfgpss0NykPiguykx52NA0uDLG9CW4XVt8heA/aPzSz8PaxP5kT537m
         yQNgqCVv9apq2LBARtOlRd2bmtqQk02FPRfkGjZCugG45YK9m1tULgb9hvXV3+f2efpy
         uhzJGhVF1LIwksH+a26Rez8lLURl8t9iWnefXcS6ySMF7eoyI3qa2+ESF9B1L1BE+TgY
         wnMcw1UwNIso5bAakEkyQe2XQUxuq54pza+ag1BaYK25ygyqb9TB3jC898W57wK5/tZ3
         pBq3gIrl2d2bOyI0/RhiimejMOwZ57u0zE/zJVUk9dfNcnv3JAuKjIfjF/1MTAPzOIkS
         05zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wEwuGuxy3L1peQcMWumktXpMLRWDaCI5Cf0WrWRd6zw=;
        b=oWWhjY3RzUR/mHLN8CGYBm6D5yR9NaMdwTozekxJoxowaYC0Qu4KFDmBF8TEslFOhZ
         OpVijQ1Uia+5TLnq5z2bbwspa2M5E5/Qd4Yzl74ccnUtJonBv5HNyyjXomtZPSo/8mPh
         b/ZxrQWDAVdOew09PKHIKNojU/Nx8d+fJUy/JUoJVUMxSD8b907uzeL4Znn+IcI4KgyY
         wvdO3BeZ/SPMm93ZH7dSERjx3aplrvE76C/yt//m/tvkRJ+frk8T9QgoWOVISR4jH8bt
         CwxHPHk3J/pNl28Cb04IZvaAOnTrF7/n0isd66rNCnf9vXNf8Uk1ozBho+u6HV1bxr94
         oufw==
X-Gm-Message-State: AOAM533QJS9gCuCm8oU7OrfBcCG5U2/1niLJFwNOmByqN0TYcjTvptDe
        mRqILvbJM5OdU6vC2ngUxdHVWtlC9jZWr2wrEfc+h/IL1Vs=
X-Google-Smtp-Source: ABdhPJzuhuLM8NaTwbrzmE6x6jcsmLPFH8/RUzfbUEP9eJiOY/4t0CS0i0UyKt1dqKc2UI61OHmSEt2MLtsUaopZcTs=
X-Received: by 2002:a17:902:7405:: with SMTP id g5mr197199pll.325.1597875566488;
 Wed, 19 Aug 2020 15:19:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200819194634.68976-1-vitor@massaru.org> <CAFd5g45AuxZYY_92rOXwtVjmbaGuts+DV6WpqhHNxWYNotxq+g@mail.gmail.com>
 <CADQ6JjU_ppjnPU6=_eOiwjQe-FKn1Rpf-p+WDEA57rXGF80PEQ@mail.gmail.com> <CADQ6JjVx1q+BOnbb-PQ_hYcVmx63bF4zUZSxPkJoOEMNwSyY7w@mail.gmail.com>
In-Reply-To: <CADQ6JjVx1q+BOnbb-PQ_hYcVmx63bF4zUZSxPkJoOEMNwSyY7w@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 19 Aug 2020 15:19:15 -0700
Message-ID: <CAFd5g47Kurp-cbi7-Xnk6yt5FKWYaNg4dWcMJdYAnjMzmonvJg@mail.gmail.com>
Subject: Re: [PATCH] kunit: fix: kunit_binary_assert_format() only prints
 signed int
To:     Vitor Massaru Iha <vitor@massaru.org>
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

On Wed, Aug 19, 2020 at 3:01 PM Vitor Massaru Iha <vitor@massaru.org> wrote:
>
> Hi Brendan,
>
> Actually https://patchwork.kernel.org/patch/11724995/
> solves my problem with unsigned int, since I can customize
> the Expected message with this patch.
>
> I think you can ignore this patch :)

Got it. Sounds good :-)

> On Wed, Aug 19, 2020 at 6:37 PM Vitor Massaru Iha <vitor@massaru.org> wrote:
> >
> > On Wed, Aug 19, 2020 at 6:30 PM Brendan Higgins
> > <brendanhiggins@google.com> wrote:
> > >
> > > On Wed, Aug 19, 2020 at 12:46 PM Vitor Massaru Iha <vitor@massaru.org> wrote:
> > > >
> > > > Some tests, such as overflow_kunit(), uses unsigned int,
> > > > But kunit_binary_assert_format() only prints signed int,
> > > > this commit also deals with the unsigned int print.
> >
> > Oops, Thanks!
> > I'll fix it.
> >
> > > >
> > > > Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> > > > ---
> > > >  lib/kunit/assert.c | 15 +++++++++++++--
> > > >  1 file changed, 13 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
> > > > index 202f9fdeed0e..3ae90c09986a 100644
> > > > --- a/lib/kunit/assert.c
> > > > +++ b/lib/kunit/assert.c
> > > > @@ -104,12 +104,23 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
> > > >                                   binary_assert->left_text,
> > > >                                   binary_assert->operation,
> > > >                                   binary_assert->right_text);
> > > > -               string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld\n",
> > > > +
> > > > +               if (binary_assert->left_value - 1 < 0) {
> > > > +                       string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld\n",
> > > > +                                 binary_assert->left_text,
> > > > +                                 binary_assert->left_value);
> > > > +                       string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld",
> > > > +                                 binary_assert->right_text,
> > > > +                                 binary_assert->right_value);
> > > > +               }
> > > > +               else {
> > > > +                       string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %llu\n",
> > > >                                   binary_assert->left_text,
> > > >                                   binary_assert->left_value);
> > > > -               string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld",
> > > > +                       string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %llu",
> > > >                                   binary_assert->right_text,
> > > >                                   binary_assert->right_value);
> > > > +               }
> > >
> > > I agree that you found a bug here; however, I disagree that this is
> > > the correct fix. Given that the value is stored as a long long; isn't
> > > the value always stored as a signed value? So if the value overflows,
> > > won't it still not pass the check you have here?
> > >
> > > >         }
> > > >         kunit_assert_print_msg(assert, stream);
> > > >  }
> > > >
> > > > base-commit: d43c7fb05765152d4d4a39a8ef957c4ea14d8847
> > > > prerequisite-patch-id: bf4b0962b0b955e4e45f5d25fece889562118158
> > > > --
> > > > 2.26.2
> > > >
