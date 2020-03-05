Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACBBE179C9A
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Mar 2020 01:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388484AbgCEAIH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Mar 2020 19:08:07 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33312 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388389AbgCEAIG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Mar 2020 19:08:06 -0500
Received: by mail-wr1-f68.google.com with SMTP id x7so4852436wrr.0
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Mar 2020 16:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rhh6IhNFfdTMDzn5raC/7ABRe9JvD2oPC8LGUlDP/90=;
        b=a+BKBCwqATbbXKlq1XXUlr635AZcS0pPhF7mDq2OWsaulwzm32OMpK2HPMcx+eX5oT
         gUrk5/cYzS5OYDOwQaU+oY7zSw78IWeRutxEivfKKDdjqb7+NOngq3aPQv/V30IAhDjo
         ao9s8z32Qj2c/pqHgXqqY8XLi/qlGHmxzgO0ev02GkhjYJVSfAeba7I3DqVc0Q0I1Sbn
         jRybY4Ta0iPONmo8C9SIgtFtUncQtyLtLqeOX7J+31GiVLPJI2CA+RzgYZtJSAQ1A3WM
         7llZZYEeQX0+GVNYKrQ4NOIwcZxXIAiF5jovY2JOfvTAjD5gBfNg+f6FBGw/vHzTkWdp
         yadw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rhh6IhNFfdTMDzn5raC/7ABRe9JvD2oPC8LGUlDP/90=;
        b=NcyTdLB1rOzGrdNhuJsEFHxGa2NzqLJc/2VhDMg//84gy0vMsUmsvrDmAtRxNefb64
         tJlpRFIe5AfQBsIPeqNL7ZD5Oi7MX041BPsInWjGzskJhdENTJI8Umag36oeyZpzEzMZ
         9NYgJv+X0e4A5i290tG5/kNPYnVnEHRBDepScd76D7ZFpn3koxBuP+7uGr7D4zs0W2Da
         pvMYrr7Sw2uuxaEutir/dFdWWGSQSEVwYOY3FCcqH6+mJmlCbhFxtDILTR3bx86ua9C2
         O2jA45uA1NJjTU1CXPMhXaGu4uoxbrLvhQBkLscuK3A/JpI3DTKmHuuWNBoTZmUZIB99
         eUrg==
X-Gm-Message-State: ANhLgQ3sq2iEgvQncmEGZYWK6UzZmzhTXvjUyVtU91+2GU/XgSZhmGmO
        LFqNZDNAlZPeJpa1U7qKj63gKohlepcUYz4HrMT04g==
X-Google-Smtp-Source: ADFU+vvTEJ1ZXYsJgUnLdCTiXOza2fR11hrZeHoPhLSw4Kq9qUMS/vOiA+MuBs83FO2V9MfxDXHldeSHqCJU3F64z3s=
X-Received: by 2002:adf:ee02:: with SMTP id y2mr720131wrn.23.1583366884150;
 Wed, 04 Mar 2020 16:08:04 -0800 (PST)
MIME-Version: 1.0
References: <20200227024301.217042-1-trishalfonso@google.com>
 <20200227024301.217042-2-trishalfonso@google.com> <CACT4Y+YFewcbRnY62wLHueVNwyXCSZwO8K7SUR2cg=pxZv8uZA@mail.gmail.com>
 <CAKFsvUJFovti=enpOefqMbtQpeorihQhugH3-1nv0BBwevCwQg@mail.gmail.com>
 <CACT4Y+Y-zoiRfDWw6KJr1BJO_=yTpFsVaHMng5iaRn9HeJMNaw@mail.gmail.com>
 <CAKFsvU+ruKWt-BdVz+OX-T9wNEBetqVFACsG1B9ucMS4zHrMBQ@mail.gmail.com> <CACT4Y+b5WaH8OkAJCDeAJcYQ1cbnbqgiF=tTb7CCmtY4UXHc0A@mail.gmail.com>
In-Reply-To: <CACT4Y+b5WaH8OkAJCDeAJcYQ1cbnbqgiF=tTb7CCmtY4UXHc0A@mail.gmail.com>
From:   Patricia Alfonso <trishalfonso@google.com>
Date:   Wed, 4 Mar 2020 16:07:52 -0800
Message-ID: <CAKFsvUK84pD+K5rTbvKXB0MyW9XCknpSfMAO28iQ4S1=WBQK6Q@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] KUnit: KASAN Integration
To:     Dmitry Vyukov <dvyukov@google.com>
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

On Tue, Mar 3, 2020 at 10:23 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Wed, Mar 4, 2020 at 2:26 AM Patricia Alfonso <trishalfonso@google.com> wrote:
> >
> > On Sat, Feb 29, 2020 at 10:29 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > >
> > > On Sat, Feb 29, 2020 at 2:23 AM Patricia Alfonso
> > > <trishalfonso@google.com> wrote:
> > > > >
> > > > > On Thu, Feb 27, 2020 at 3:44 AM 'Patricia Alfonso' via kasan-dev
> > > > > <kasan-dev@googlegroups.com> wrote:
> > > > > >
> > > > > > --- a/tools/testing/kunit/kunit_kernel.py
> > > > > > +++ b/tools/testing/kunit/kunit_kernel.py
> > > > > > @@ -141,7 +141,7 @@ class LinuxSourceTree(object):
> > > > > >                 return True
> > > > > >
> > > > > >         def run_kernel(self, args=[], timeout=None, build_dir=''):
> > > > > > -               args.extend(['mem=256M'])
> > > > > > +               args.extend(['mem=256M', 'kasan_multi_shot'])
> > > > >
> > > > > This is better done somewhere else (different default value if
> > > > > KASAN_TEST is enabled or something). Or overridden in the KASAN tests.
> > > > > Not everybody uses tools/testing/kunit/kunit_kernel.py and this seems
> > > > > to be a mandatory part now. This means people will always hit this, be
> > > > > confused, figure out they need to flip the value, and only then be
> > > > > able to run kunit+kasan.
> > > > >
> > > > I agree. Is the best way to do this with "bool multishot =
> > > > kasan_save_enable_multi_shot();"  and
> > > > "kasan_restore_multi_shot(multishot);" inside test_kasan.c like what
> > > > was done in the tests before?
> > >
> > > This will fix KASAN tests, but not non-KASAN tests running under KUNIT
> > > and triggering KASAN reports.
> > > You set kasan_multi_shot for all KUNIT tests. I am reading this as
> > > that we don't want to abort on the first test that triggered a KASAN
> > > report. Or not?
> >
> > I don't think I understand the question, but let me try to explain my
> > thinking and see if that resonates with you. We know that the KASAN
> > tests will require more than one report, and we want that. For most
> > users, since a KASAN error can cause unexpected kernel behavior for
> > anything after a KASAN error, it is best for just one unexpected KASAN
> > error to be the only error printed to the user, unless they specify
> > kasan-multi-shot. The way I understand it, the way to implement this
> > is to use  "bool multishot = kasan_save_enable_multi_shot();"  and
> > "kasan_restore_multi_shot(multishot);" around the KASAN tests so that
> > kasan-multi-shot is temporarily enabled for the tests we expect
> > multiple reports. I assume "kasan_restore_multi_shot(multishot);"
> > restores the value to what the user input was so after the KASAN tests
> > are finished, if the user did not specify kasan-multi-shot and an
> > unexpected kasan error is reported, it will print the full report and
> > only that first one. Is this understanding correct? If you have a
> > better way of implementing this or a better expected behavior, I
> > appreciate your thoughts.
>
> Everything you say is correct.
> What I tried to point at is that this new behavior is different from
> the original behavior of your change. Initially you added
> kasan_multi_shot to command line for _all_ kunit tests (not just
> KASAN). The question is: do we want kasan_multi_shot for non-KASAN
> tests or not?

Ah, yes. I thought your first comment was suggesting I change it from
printing all KASAN tests by default because the intended behavior of
KASAN is to only print the first report. I think I'll pose the
question back to you. Do we want kasan_multi_shot for non-KASAN tests?
For functionality sake, it is only required for the KASAN tests so
this is more of a judgement call for the user experience.

--
Best,
Patricia Alfonso
