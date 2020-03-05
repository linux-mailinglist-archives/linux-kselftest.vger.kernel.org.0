Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8283B17A016
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Mar 2020 07:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbgCEGoU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Mar 2020 01:44:20 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:44970 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgCEGoU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Mar 2020 01:44:20 -0500
Received: by mail-qv1-f65.google.com with SMTP id b13so1954236qvt.11
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Mar 2020 22:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jUsXfxq47fTB69Eo8JioRupR5VCGfY6ptuLWDAnbRk8=;
        b=ctYxfjLo/A+r4dZRBuJIu/kSqGQpprntxrJvCk9FV5NaH6locQvrgp+PKWXl1i8Udq
         KmxJqN/EXANRIs2kJvuZEzZVNqQMPmKQbyFQkg1hq03TVX4lFtQKEO/b2/Yj0CFym9qJ
         L5Lm6cMjTjhw6WM5FApyl47nqWXM5YDHBAqTualP/UqNNqLkj8gWZ8yPK7lTxAGEBa3w
         jt2Lc1h6BRAXO40Pp08QJYAL0gwuPxWxfZo6ILnwgsNayZwgrVbf1kXpj4zYmzMVNpwS
         vYhD17FZQEo5XONsGf190dy0fpLVlhwsZ9CoZq/tbUvtGzUGQx/vhL3+5kRr7u29kED4
         nsWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jUsXfxq47fTB69Eo8JioRupR5VCGfY6ptuLWDAnbRk8=;
        b=iqFMlBqUOJS41l0knhw89RZLDHlnpkdUj1kj9FMQKv9vw8dRIhfN1M9h2E9H5pddSZ
         Clz7fUTH5kpMLE3vUSPaQC6HMJ62kM4lSLLmm+DaZu+ADrfRWP6H8ipplSRXLGz8lbfX
         8tYlqIwjZXMI+NWr3WEKpyiOE5f5mYySAINpmXmfU0cAeZnFGlM1KHP67UIN302hO0sE
         v1Kv+/JVmLUfvkyFevW+nezGyf2C43W12K6LFQkpEXBbFyI67etBaW2qvBxdg7turoZF
         NeXTQCL0XacO4OWGfYdSX4GP2Py+U4csELeUYexJD5ttX+kQLcakez3+R5YUzjUnL1p0
         F8dQ==
X-Gm-Message-State: ANhLgQ1gndhJ+vbG4mKmJg1g63KKhDjaTUT0IMZZLCGqtFVQSPZlD9a8
        uyeihvl7mFGasSgTJGA77CCLnZir6/xH49bgM+0NdA==
X-Google-Smtp-Source: ADFU+vsVJtTi0c4Al9cn4rzjpTYArv7CtyzDoGym5TNUnHVkiEkLAtqeW9IPhoAFm902Z5T54qN6KCjJ49fwIIG2ngg=
X-Received: by 2002:ad4:4bc6:: with SMTP id l6mr5269372qvw.34.1583390658639;
 Wed, 04 Mar 2020 22:44:18 -0800 (PST)
MIME-Version: 1.0
References: <20200227024301.217042-1-trishalfonso@google.com>
 <20200227024301.217042-2-trishalfonso@google.com> <CACT4Y+YFewcbRnY62wLHueVNwyXCSZwO8K7SUR2cg=pxZv8uZA@mail.gmail.com>
 <CAKFsvUJFovti=enpOefqMbtQpeorihQhugH3-1nv0BBwevCwQg@mail.gmail.com>
 <CACT4Y+Y-zoiRfDWw6KJr1BJO_=yTpFsVaHMng5iaRn9HeJMNaw@mail.gmail.com>
 <CAKFsvU+ruKWt-BdVz+OX-T9wNEBetqVFACsG1B9ucMS4zHrMBQ@mail.gmail.com>
 <CACT4Y+b5WaH8OkAJCDeAJcYQ1cbnbqgiF=tTb7CCmtY4UXHc0A@mail.gmail.com> <CAKFsvUK84pD+K5rTbvKXB0MyW9XCknpSfMAO28iQ4S1=WBQK6Q@mail.gmail.com>
In-Reply-To: <CAKFsvUK84pD+K5rTbvKXB0MyW9XCknpSfMAO28iQ4S1=WBQK6Q@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 5 Mar 2020 07:44:07 +0100
Message-ID: <CACT4Y+a+SLAetVsquiitua9v0pnhQD-C5AWFekvZ8h-m0y1xuQ@mail.gmail.com>
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

On Thu, Mar 5, 2020 at 1:08 AM Patricia Alfonso <trishalfonso@google.com> wrote:
> > > On Sat, Feb 29, 2020 at 10:29 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > > >
> > > > On Sat, Feb 29, 2020 at 2:23 AM Patricia Alfonso
> > > > <trishalfonso@google.com> wrote:
> > > > > >
> > > > > > On Thu, Feb 27, 2020 at 3:44 AM 'Patricia Alfonso' via kasan-dev
> > > > > > <kasan-dev@googlegroups.com> wrote:
> > > > > > >
> > > > > > > --- a/tools/testing/kunit/kunit_kernel.py
> > > > > > > +++ b/tools/testing/kunit/kunit_kernel.py
> > > > > > > @@ -141,7 +141,7 @@ class LinuxSourceTree(object):
> > > > > > >                 return True
> > > > > > >
> > > > > > >         def run_kernel(self, args=[], timeout=None, build_dir=''):
> > > > > > > -               args.extend(['mem=256M'])
> > > > > > > +               args.extend(['mem=256M', 'kasan_multi_shot'])
> > > > > >
> > > > > > This is better done somewhere else (different default value if
> > > > > > KASAN_TEST is enabled or something). Or overridden in the KASAN tests.
> > > > > > Not everybody uses tools/testing/kunit/kunit_kernel.py and this seems
> > > > > > to be a mandatory part now. This means people will always hit this, be
> > > > > > confused, figure out they need to flip the value, and only then be
> > > > > > able to run kunit+kasan.
> > > > > >
> > > > > I agree. Is the best way to do this with "bool multishot =
> > > > > kasan_save_enable_multi_shot();"  and
> > > > > "kasan_restore_multi_shot(multishot);" inside test_kasan.c like what
> > > > > was done in the tests before?
> > > >
> > > > This will fix KASAN tests, but not non-KASAN tests running under KUNIT
> > > > and triggering KASAN reports.
> > > > You set kasan_multi_shot for all KUNIT tests. I am reading this as
> > > > that we don't want to abort on the first test that triggered a KASAN
> > > > report. Or not?
> > >
> > > I don't think I understand the question, but let me try to explain my
> > > thinking and see if that resonates with you. We know that the KASAN
> > > tests will require more than one report, and we want that. For most
> > > users, since a KASAN error can cause unexpected kernel behavior for
> > > anything after a KASAN error, it is best for just one unexpected KASAN
> > > error to be the only error printed to the user, unless they specify
> > > kasan-multi-shot. The way I understand it, the way to implement this
> > > is to use  "bool multishot = kasan_save_enable_multi_shot();"  and
> > > "kasan_restore_multi_shot(multishot);" around the KASAN tests so that
> > > kasan-multi-shot is temporarily enabled for the tests we expect
> > > multiple reports. I assume "kasan_restore_multi_shot(multishot);"
> > > restores the value to what the user input was so after the KASAN tests
> > > are finished, if the user did not specify kasan-multi-shot and an
> > > unexpected kasan error is reported, it will print the full report and
> > > only that first one. Is this understanding correct? If you have a
> > > better way of implementing this or a better expected behavior, I
> > > appreciate your thoughts.
> >
> > Everything you say is correct.
> > What I tried to point at is that this new behavior is different from
> > the original behavior of your change. Initially you added
> > kasan_multi_shot to command line for _all_ kunit tests (not just
> > KASAN). The question is: do we want kasan_multi_shot for non-KASAN
> > tests or not?
>
> Ah, yes. I thought your first comment was suggesting I change it from
> printing all KASAN tests by default because the intended behavior of
> KASAN is to only print the first report. I think I'll pose the
> question back to you. Do we want kasan_multi_shot for non-KASAN tests?
> For functionality sake, it is only required for the KASAN tests so
> this is more of a judgement call for the user experience.

Good question. I don't see strong arguments either way. So I guess we
can leave the current version (only for kasan tests) and wait when/if
somebody has real arguments. I wanted to point to change in behavior
and understand if it's intentional/accidental.
