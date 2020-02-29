Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC0C017441F
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Feb 2020 02:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgB2BXW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Feb 2020 20:23:22 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56261 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgB2BXV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Feb 2020 20:23:21 -0500
Received: by mail-wm1-f67.google.com with SMTP id q9so5366112wmj.5
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Feb 2020 17:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i/7YNCxPMBaPfRc0r6hwDsD4AYhHuz/+hoGyVq9vhR0=;
        b=Irm3kkRLYMDUDnNN3uPknJSw6y6RPEolglih7qe1Xv0+i5lIJVxspusNEcB/2ZQGds
         NvZ4AoOZQcDlOnv+9Ibvb2DNpNICXcYiY40+86thILBIrsXTg9ulcNAtvJbW9ZLi+CMn
         LKJ/FMnlD2cIEdwDlogDNQBxPO+INsL5AXGgiN5Mb92+XhtrHQLefbhLqNrj/GRBF/pD
         1GeCTfYEvaf3JUN4fX9kg2xaAycWqEMPwYr41eugmvLVgwWmb9YSGDFWrKFMuP+LuEw2
         bHNg4RDSSakp3qzEmmkTU2F4MaSWAhG718xG6TdXIDLPyKv8koZnwLqrb1kXEPAqyA2m
         8OuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i/7YNCxPMBaPfRc0r6hwDsD4AYhHuz/+hoGyVq9vhR0=;
        b=FUKRuJbp8daA3AM+uNzuFQQ7AM1wqyFGKFdTaB6SKp/WqV2On6Zr3BmIpd5nsz0vbk
         /PlgL1yySOHr3V0rUKoa+ch0j/systjw++464MtsW6v+EgZOagk8BvCYh0+p5OoAw1MC
         QhU/Pnz3FD2thRBhvs1e3DvDy9VQPeFjNGux3CtBM5XmG/1/7JQLMw8RouDBWgZIxBqY
         sdYv/PgzOegNyC98e4v5UAGEFL/h9hiCOc/9zG6unb+Li/ohCydmVpgiGWhAnAznSGWX
         5wLozU9rj5W3wFYg1kHWJh99hYAfQGVHQ2aH3Ad/ZhUp39zs/ZJ0SpjYTxfAGut3KaZW
         bDfQ==
X-Gm-Message-State: APjAAAVrGC4HogksWt3LS2q95d6ya8ThC3en5EMQCmCHtx3AQc1Hodvp
        WKvQgsZxlFEUr0cqh4Yo1trX3cM4vEYtter/mSOT9Q==
X-Google-Smtp-Source: APXvYqzQhxXCwL795xtkqGSlBVQ1HoOyROAl6OSEGKhT6D00L+2+s+oVhuOu/ADLRgmKmQtZKuqq+BDvu+dhn85KPro=
X-Received: by 2002:a1c:3204:: with SMTP id y4mr7078376wmy.166.1582939398894;
 Fri, 28 Feb 2020 17:23:18 -0800 (PST)
MIME-Version: 1.0
References: <20200227024301.217042-1-trishalfonso@google.com>
 <20200227024301.217042-2-trishalfonso@google.com> <CACT4Y+YFewcbRnY62wLHueVNwyXCSZwO8K7SUR2cg=pxZv8uZA@mail.gmail.com>
In-Reply-To: <CACT4Y+YFewcbRnY62wLHueVNwyXCSZwO8K7SUR2cg=pxZv8uZA@mail.gmail.com>
From:   Patricia Alfonso <trishalfonso@google.com>
Date:   Fri, 28 Feb 2020 17:23:07 -0800
Message-ID: <CAKFsvUJFovti=enpOefqMbtQpeorihQhugH3-1nv0BBwevCwQg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] KUnit: KASAN Integration
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>, vincent.guittot@linaro.org,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 27, 2020 at 6:43 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Thu, Feb 27, 2020 at 3:44 AM 'Patricia Alfonso' via kasan-dev
> <kasan-dev@googlegroups.com> wrote:
> >
> > Integrate KASAN into KUnit testing framework.
> >  - Fail tests when KASAN reports an error that is not expected
> >  - Use KUNIT_EXPECT_KASAN_FAIL to expect a KASAN error in KASAN tests
> >  - KUnit struct added to current task to keep track of the current test
> > from KASAN code
> >  - Booleans representing if a KASAN report is expected and if a KASAN
> >  report is found added to kunit struct
> >  - This prints "line# has passed" or "line# has failed"
> >
> > Signed-off-by: Patricia Alfonso <trishalfonso@google.com>
> > ---
> > If anyone has any suggestions on how best to print the failure
> > messages, please share!
> >
> > One issue I have found while testing this is the allocation fails in
> > kmalloc_pagealloc_oob_right() sometimes, but not consistently. This
> > does cause the test to fail on the KUnit side, as expected, but it
> > seems to skip all the tests before this one because the output starts
> > with this failure instead of with the first test, kmalloc_oob_right().
>
> I don't follow this... we don't check output in any way, so how does
> output affect execution?...
>
I'm sorry. I think I was just reading the results wrong before - no
wonder I was confused!

I just recreated the error and it does work as expected.

>
> > --- a/tools/testing/kunit/kunit_kernel.py
> > +++ b/tools/testing/kunit/kunit_kernel.py
> > @@ -141,7 +141,7 @@ class LinuxSourceTree(object):
> >                 return True
> >
> >         def run_kernel(self, args=[], timeout=None, build_dir=''):
> > -               args.extend(['mem=256M'])
> > +               args.extend(['mem=256M', 'kasan_multi_shot'])
>
> This is better done somewhere else (different default value if
> KASAN_TEST is enabled or something). Or overridden in the KASAN tests.
> Not everybody uses tools/testing/kunit/kunit_kernel.py and this seems
> to be a mandatory part now. This means people will always hit this, be
> confused, figure out they need to flip the value, and only then be
> able to run kunit+kasan.
>
I agree. Is the best way to do this with "bool multishot =
kasan_save_enable_multi_shot();"  and
"kasan_restore_multi_shot(multishot);" inside test_kasan.c like what
was done in the tests before?

-- 
Thank you,
Patricia Alfonso
