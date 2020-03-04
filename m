Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBEFC178A8C
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Mar 2020 07:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgCDGXz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Mar 2020 01:23:55 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:38197 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbgCDGXz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Mar 2020 01:23:55 -0500
Received: by mail-qv1-f66.google.com with SMTP id g16so311040qvz.5
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Mar 2020 22:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9rIcuItk/t0HMMdxbMcrzdoYnAXfgWsnodSuFT2EgNI=;
        b=HBrmEvdVsAvyY8mE22JX9d+oGnKWDDKD/2V00s0FfVmdNkIYiqIAa01Nj5qN2cKJ6h
         nfViDJBV/rE4Gvpb+txw9uCf9da1fWuhyd+pnYkoPAiok+8f06PbMA96EkEwY68frEwh
         gPw9k5y9txAYY832kj2oBOnU/kN6LeM0ZL27ptiE7Vle2Gl23ZBueZNnggwj8rjP3wbd
         slEH9NJKMWvNtAQkWozM+E81TyfLV6DPlVq1ct89+BbYjfzrROYv26Voxu0Sf3lyeDmG
         pYOCtuqr7NzRQHPK4jMzySI/fNcUl71dlDXTTO8J8zZF/EdXgJbW8M3gra5uEjTZSOaW
         53ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9rIcuItk/t0HMMdxbMcrzdoYnAXfgWsnodSuFT2EgNI=;
        b=sOS6u8hLq4h1D+7uVY8AUkLjqKweC5Xi5WcCl+Z3exERPl4kqmrrjVQMsRFcqvwdCG
         3vUlgSLDx1aXLA/L/JtMYujbY4DEF5jNRum7ug9Hc3ixHWY7BdX96NgGhNQVFeWHE93s
         aTPyU56x5PL+cBVMDdYzWXra1wyj9BmtHk80lQFVjo+U+SmtlSkw+VpdDHkiVI4XbLgZ
         2WtPE4DK5vOkuHt9tDJ/MQUTiKW+MKO6r/+TPYu4MWznBPO8CBdKfQP9KuEdfc353K/n
         AspXUEpuqVpT1j2QKsmDTrLlVEDagb4Q5tZThqb5Qw3fbvMhUycTvpl0vhKCRjj0TJHP
         3aow==
X-Gm-Message-State: ANhLgQ1+n3oMWBW47VdKohXTohv/hHdVwkzIMB67XVZQaAZrMw4oDcxn
        upavZcYx/MJS+ZDTiRR/BgN498esOksg+jL96NYolg==
X-Google-Smtp-Source: ADFU+vuRqg+f4hP66/2nwgjx8Y7TUcReJYsdYGYkJLt1h3ZWESqgqRyCvSdkefETTgE2y14bY3hxD7iTIhDC09HT4aI=
X-Received: by 2002:a0c:f892:: with SMTP id u18mr906230qvn.159.1583303032372;
 Tue, 03 Mar 2020 22:23:52 -0800 (PST)
MIME-Version: 1.0
References: <20200227024301.217042-1-trishalfonso@google.com>
 <20200227024301.217042-2-trishalfonso@google.com> <CACT4Y+YFewcbRnY62wLHueVNwyXCSZwO8K7SUR2cg=pxZv8uZA@mail.gmail.com>
 <CAKFsvUJFovti=enpOefqMbtQpeorihQhugH3-1nv0BBwevCwQg@mail.gmail.com>
 <CACT4Y+Y-zoiRfDWw6KJr1BJO_=yTpFsVaHMng5iaRn9HeJMNaw@mail.gmail.com> <CAKFsvU+ruKWt-BdVz+OX-T9wNEBetqVFACsG1B9ucMS4zHrMBQ@mail.gmail.com>
In-Reply-To: <CAKFsvU+ruKWt-BdVz+OX-T9wNEBetqVFACsG1B9ucMS4zHrMBQ@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 4 Mar 2020 07:23:41 +0100
Message-ID: <CACT4Y+b5WaH8OkAJCDeAJcYQ1cbnbqgiF=tTb7CCmtY4UXHc0A@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] KUnit: KASAN Integration
To:     Patricia Alfonso <trishalfonso@google.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 4, 2020 at 2:26 AM Patricia Alfonso <trishalfonso@google.com> wrote:
>
> On Sat, Feb 29, 2020 at 10:29 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Sat, Feb 29, 2020 at 2:23 AM Patricia Alfonso
> > <trishalfonso@google.com> wrote:
> > > >
> > > > On Thu, Feb 27, 2020 at 3:44 AM 'Patricia Alfonso' via kasan-dev
> > > > <kasan-dev@googlegroups.com> wrote:
> > > > >
> > > > > --- a/tools/testing/kunit/kunit_kernel.py
> > > > > +++ b/tools/testing/kunit/kunit_kernel.py
> > > > > @@ -141,7 +141,7 @@ class LinuxSourceTree(object):
> > > > >                 return True
> > > > >
> > > > >         def run_kernel(self, args=[], timeout=None, build_dir=''):
> > > > > -               args.extend(['mem=256M'])
> > > > > +               args.extend(['mem=256M', 'kasan_multi_shot'])
> > > >
> > > > This is better done somewhere else (different default value if
> > > > KASAN_TEST is enabled or something). Or overridden in the KASAN tests.
> > > > Not everybody uses tools/testing/kunit/kunit_kernel.py and this seems
> > > > to be a mandatory part now. This means people will always hit this, be
> > > > confused, figure out they need to flip the value, and only then be
> > > > able to run kunit+kasan.
> > > >
> > > I agree. Is the best way to do this with "bool multishot =
> > > kasan_save_enable_multi_shot();"  and
> > > "kasan_restore_multi_shot(multishot);" inside test_kasan.c like what
> > > was done in the tests before?
> >
> > This will fix KASAN tests, but not non-KASAN tests running under KUNIT
> > and triggering KASAN reports.
> > You set kasan_multi_shot for all KUNIT tests. I am reading this as
> > that we don't want to abort on the first test that triggered a KASAN
> > report. Or not?
>
> I don't think I understand the question, but let me try to explain my
> thinking and see if that resonates with you. We know that the KASAN
> tests will require more than one report, and we want that. For most
> users, since a KASAN error can cause unexpected kernel behavior for
> anything after a KASAN error, it is best for just one unexpected KASAN
> error to be the only error printed to the user, unless they specify
> kasan-multi-shot. The way I understand it, the way to implement this
> is to use  "bool multishot = kasan_save_enable_multi_shot();"  and
> "kasan_restore_multi_shot(multishot);" around the KASAN tests so that
> kasan-multi-shot is temporarily enabled for the tests we expect
> multiple reports. I assume "kasan_restore_multi_shot(multishot);"
> restores the value to what the user input was so after the KASAN tests
> are finished, if the user did not specify kasan-multi-shot and an
> unexpected kasan error is reported, it will print the full report and
> only that first one. Is this understanding correct? If you have a
> better way of implementing this or a better expected behavior, I
> appreciate your thoughts.

Everything you say is correct.
What I tried to point at is that this new behavior is different from
the original behavior of your change. Initially you added
kasan_multi_shot to command line for _all_ kunit tests (not just
KASAN). The question is: do we want kasan_multi_shot for non-KASAN
tests or not?
