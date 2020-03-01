Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22ACF174C10
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Mar 2020 07:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbgCAG3U (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 1 Mar 2020 01:29:20 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43188 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgCAG3T (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 1 Mar 2020 01:29:19 -0500
Received: by mail-qk1-f195.google.com with SMTP id q18so7096604qki.10
        for <linux-kselftest@vger.kernel.org>; Sat, 29 Feb 2020 22:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UfUac2pOIQmqTpyyGG2W9XwtOZbpDu9LEjx7cpEyrZg=;
        b=pCSbN2e3Mm4pNp7g6N5hKQxc7G5FqfEZ/6N/FbYgI+NaTqvSPxcjxJSpYV6rCVsvQy
         ZNQ1Z7p6mfHx90tkNorEfvC4v+SwcA0G+UYoRwOcxm/JdVR3qAvz8qrpQUExX9UAqRZS
         PezoKqcMSgEgByqeJbPE8nKoFIcstlzB2x+w2kf90u2PUCiDK5LFvjPBxkLM40GvR/mb
         oSHod7cYUtAePjsOXYZluoKGmPex0euZTbIr7vag8eSWjjmJ7tgABSbkse5rizqi6+tw
         cYfr+JJwVofhn4kAcPVqXNGs+PN11yua58WEvn8Sor7NjDgNHCoEC+1YvH9Z8Q542m5H
         ySAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UfUac2pOIQmqTpyyGG2W9XwtOZbpDu9LEjx7cpEyrZg=;
        b=kMw9isYhYHqtiBK71oq3MTjFygVEoCX/OO+LUKCs1/yq+j8e68Y+KuIrBAH4bYb6YE
         l0ktYIef+hn1nYYch4LtuO0NgzVCLfqkx27Yshka5tVB+ITAaDY7LztGsNP6VM3W/GrT
         zkB+3nNQE4gKNa3e6BWdKOdHdDiPnMrrXcp4VLKEWzZPQ08j3/RV79+YFnt2cweW55wu
         4owIedpSS1aHqjOdyryZeIZlkn8Bxf+LYORb5HjRhTovjKptsDHmwGi8RpwGnGxquaUg
         PspclrTcimN4Urjs5bPIqlDdh1H/prAnNFEamCDoX0MFgF2wmE92nzHxdYJzW7S/4FY9
         0fEw==
X-Gm-Message-State: APjAAAXDsKs5jFeSWGRscsL4lc4jO//oV+G8ocPm6n0Yghed2IuAcZrI
        IV+M4QFEYn6I9qs7+ZuO0GixRFlFzF4Y4WBn/5ewEw==
X-Google-Smtp-Source: APXvYqwa6S/h+fq5wA1PB0+OZP5ZIF+wJeuXjDfZV6l/ek9M1Hs4KxnOgp3vVhuRpnXIScGUa+0ARGzfOo2O/VflhAk=
X-Received: by 2002:a37:88b:: with SMTP id 133mr10838393qki.256.1583044158382;
 Sat, 29 Feb 2020 22:29:18 -0800 (PST)
MIME-Version: 1.0
References: <20200227024301.217042-1-trishalfonso@google.com>
 <20200227024301.217042-2-trishalfonso@google.com> <CACT4Y+YFewcbRnY62wLHueVNwyXCSZwO8K7SUR2cg=pxZv8uZA@mail.gmail.com>
 <CAKFsvUJFovti=enpOefqMbtQpeorihQhugH3-1nv0BBwevCwQg@mail.gmail.com>
In-Reply-To: <CAKFsvUJFovti=enpOefqMbtQpeorihQhugH3-1nv0BBwevCwQg@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 1 Mar 2020 07:29:07 +0100
Message-ID: <CACT4Y+Y-zoiRfDWw6KJr1BJO_=yTpFsVaHMng5iaRn9HeJMNaw@mail.gmail.com>
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

On Sat, Feb 29, 2020 at 2:23 AM Patricia Alfonso
<trishalfonso@google.com> wrote:
> >
> > On Thu, Feb 27, 2020 at 3:44 AM 'Patricia Alfonso' via kasan-dev
> > <kasan-dev@googlegroups.com> wrote:
> > >
> > > Integrate KASAN into KUnit testing framework.
> > >  - Fail tests when KASAN reports an error that is not expected
> > >  - Use KUNIT_EXPECT_KASAN_FAIL to expect a KASAN error in KASAN tests
> > >  - KUnit struct added to current task to keep track of the current test
> > > from KASAN code
> > >  - Booleans representing if a KASAN report is expected and if a KASAN
> > >  report is found added to kunit struct
> > >  - This prints "line# has passed" or "line# has failed"
> > >
> > > Signed-off-by: Patricia Alfonso <trishalfonso@google.com>
> > > ---
> > > If anyone has any suggestions on how best to print the failure
> > > messages, please share!
> > >
> > > One issue I have found while testing this is the allocation fails in
> > > kmalloc_pagealloc_oob_right() sometimes, but not consistently. This
> > > does cause the test to fail on the KUnit side, as expected, but it
> > > seems to skip all the tests before this one because the output starts
> > > with this failure instead of with the first test, kmalloc_oob_right().
> >
> > I don't follow this... we don't check output in any way, so how does
> > output affect execution?...
> >
> I'm sorry. I think I was just reading the results wrong before - no
> wonder I was confused!
>
> I just recreated the error and it does work as expected.
>
> >
> > > --- a/tools/testing/kunit/kunit_kernel.py
> > > +++ b/tools/testing/kunit/kunit_kernel.py
> > > @@ -141,7 +141,7 @@ class LinuxSourceTree(object):
> > >                 return True
> > >
> > >         def run_kernel(self, args=[], timeout=None, build_dir=''):
> > > -               args.extend(['mem=256M'])
> > > +               args.extend(['mem=256M', 'kasan_multi_shot'])
> >
> > This is better done somewhere else (different default value if
> > KASAN_TEST is enabled or something). Or overridden in the KASAN tests.
> > Not everybody uses tools/testing/kunit/kunit_kernel.py and this seems
> > to be a mandatory part now. This means people will always hit this, be
> > confused, figure out they need to flip the value, and only then be
> > able to run kunit+kasan.
> >
> I agree. Is the best way to do this with "bool multishot =
> kasan_save_enable_multi_shot();"  and
> "kasan_restore_multi_shot(multishot);" inside test_kasan.c like what
> was done in the tests before?

This will fix KASAN tests, but not non-KASAN tests running under KUNIT
and triggering KASAN reports.
You set kasan_multi_shot for all KUNIT tests. I am reading this as
that we don't want to abort on the first test that triggered a KASAN
report. Or not?
