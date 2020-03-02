Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B92917619D
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Mar 2020 18:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgCBRwp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Mar 2020 12:52:45 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:39385 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbgCBRwm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Mar 2020 12:52:42 -0500
Received: by mail-yw1-f66.google.com with SMTP id x184so614005ywd.6
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Mar 2020 09:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1IOLrEITmD2P6VvJiuWxnVZVe415X+z+1kv5oi6Hs5w=;
        b=Ob7ugNbolYcPYQ1RvjJtJ0j6ieNXbuDYZuyXXFLie3EM4zIZNEuw/jW+FdJJFwdv52
         84g3Wvq7rGW3EoP8iKyZqhcJROlzHsUXVtSD1R1ltJqSdjF+8A/z6QeYocl9NrBNpx3R
         Flc957tzuSZgDdYcTO8nL15zW1KM/5W+deBWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1IOLrEITmD2P6VvJiuWxnVZVe415X+z+1kv5oi6Hs5w=;
        b=nlKHBIm8rnf7t0cAMBCh7VHfpUCK0+ykfZbQm4bEgP7YfAC3d2SZFyifGdjZ0Blnsg
         qhalEaY53j+ALRZl0+u30OxgHTvQmR64QmU3b4Q+d4wE388iBFIXfKjkwIeGdonlMuuP
         t7CCla3sjYHPksqW440yjhFR5LShD/xbwZewQwdqvcO5WWaHWuqrGaGnqLvBvGqbXJ2l
         Q//Xh/sFvEqKzfJcuE7za1zUDJCd3dwdks85O1TZqvhr5b6Bt6Uh3e6FFqh0ntj2fYi4
         5QEsdyrUh0uv/OlqehV5Y7l1vuwMwzcC60WeBmPB15FUUFMW5vV1RzfBpFq/23o1VpB2
         jx1g==
X-Gm-Message-State: ANhLgQ1oBYMAjkUUYeG5VbU5k0qyYw7P0+ZlRuxTNgVpDy3aewkTiAl5
        cAcGFoSsM4zJOy660WlfX484sWUCT6I=
X-Google-Smtp-Source: ADFU+vtTrjoMc5tUiiyE0JH0mOhrWnBS6QqyDly+U6zYsGs1ZXT036o+FBXspqCmHnQNIa3aWaO3BQ==
X-Received: by 2002:a25:e6c5:: with SMTP id d188mr204741ybh.328.1583171559727;
        Mon, 02 Mar 2020 09:52:39 -0800 (PST)
Received: from mail-yw1-f43.google.com (mail-yw1-f43.google.com. [209.85.161.43])
        by smtp.gmail.com with ESMTPSA id v27sm3697517ywh.93.2020.03.02.09.52.37
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2020 09:52:37 -0800 (PST)
Received: by mail-yw1-f43.google.com with SMTP id l5so623812ywd.4
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Mar 2020 09:52:37 -0800 (PST)
X-Received: by 2002:a81:3888:: with SMTP id f130mr517632ywa.138.1583171556864;
 Mon, 02 Mar 2020 09:52:36 -0800 (PST)
MIME-Version: 1.0
References: <20200227024301.217042-1-trishalfonso@google.com>
 <CACT4Y+Z_fGz2zVpco4kuGOVeCK=jv4zH0q9Uj5Hv5TAFxY3yRg@mail.gmail.com>
 <CAKFsvULZqJT3-NxYLsCaHpxemBCdyZN7nFTuQM40096UGqVzgQ@mail.gmail.com> <CACT4Y+YTNZRfKLH1=FibrtGj34MY=naDJY6GWVnpMvgShSLFhg@mail.gmail.com>
In-Reply-To: <CACT4Y+YTNZRfKLH1=FibrtGj34MY=naDJY6GWVnpMvgShSLFhg@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 2 Mar 2020 09:52:25 -0800
X-Gmail-Original-Message-ID: <CAGXu5jKbpbH4sm4sv-74iHa+VzWuvF5v3ci7R-KVt+StRpMESg@mail.gmail.com>
Message-ID: <CAGXu5jKbpbH4sm4sv-74iHa+VzWuvF5v3ci7R-KVt+StRpMESg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] Port KASAN Tests to KUnit
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Patricia Alfonso <trishalfonso@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
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

On Sat, Feb 29, 2020 at 10:39 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Sat, Feb 29, 2020 at 2:56 AM Patricia Alfonso
> <trishalfonso@google.com> wrote:
> > On Thu, Feb 27, 2020 at 6:19 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > >
> > > .On Thu, Feb 27, 2020 at 3:44 AM Patricia Alfonso
> > > > -       pr_info("out-of-bounds in copy_from_user()\n");
> > > > -       unused = copy_from_user(kmem, usermem, size + 1);
> > >
> > > Why is all of this removed?
> > > Most of these tests are hard earned and test some special corner cases.
> > >
> > I just moved it inside IS_MODULE(CONFIG_TEST_KASAN) instead because I
> > don't think there is a way to rewrite this without it being a module.
>
> You mean these are unconditionally crashing the machine? If yes,
> please add a comment about this.
>
> Theoretically we could have a notion of "death tests" similar to gunit:
> https://stackoverflow.com/questions/3698718/what-are-google-test-death-tests
> KUnit test runner wrapper would need to spawn a separete process per
> each such test. Under non-KUnit test runner these should probably be
> disabled by default and only run if specifically requested (a-la
> --gunit_filter/--gunit_also_run_disabled_tests).
> Could also be used to test other things that unconditionally panic,
> e.g. +Kees may be happy for unit tests for some of the
> hardening/fortification features.
> I am not asking to bundle this with this change of course.

A bunch of LKDTM tests can kill the system too. I collected the list
when building the selftest script for LKDTM:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/lkdtm/tests.txt

I'm all for unittests (I have earlier kind-of-unit-tests in
lib/test_user_copy.c lib/test_overflow.c etc), but most of LKDTM is
designed to be full system-behavior testing ("does the system correct
BUG the current thread, when some deeper system state is violated?")

-- 
Kees Cook
