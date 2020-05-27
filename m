Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436871E35E9
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 May 2020 04:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbgE0CvK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 May 2020 22:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgE0CvI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 May 2020 22:51:08 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE67C03E97A
        for <linux-kselftest@vger.kernel.org>; Tue, 26 May 2020 19:51:07 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u26so1255845wmn.1
        for <linux-kselftest@vger.kernel.org>; Tue, 26 May 2020 19:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LaRXr+sBaHv3EXaCNPBVevZdSo0W53kZX/a6MHQcNAw=;
        b=taXQRZ/fukL/Xp/nEBmp4FkEAWeFNEOYvkZ+XKF6Qw1gcNsYrGoEOuQ4Dc7A5FiVx4
         uQYP8l3qhuuPlz09vw9kALkhk6K6btuipVqh6XSp8GqCsHKX71CAN8BBhrNG5SFhV9ZY
         2kwBiEVk4aMd4yVi7VXSOsTIYofB1HMvrXLd4oHLxX8IQayIfoA61G5c8czFEKTIBoUB
         ESZMWBCGXuxpKQKHYqYcox+TcvoTVK7/dZrO6Gb7AODIrS+nIPwskZMWr8in+Mva4Pz8
         ToXXxJxO99AB7mbbBl2YhDOgBadREX9QBSqy+fl1ZbwOG2M+OVEHopnOaEMxlCDgRpTE
         /Dwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LaRXr+sBaHv3EXaCNPBVevZdSo0W53kZX/a6MHQcNAw=;
        b=lzyKTR7N9kJHYKnk3LTpaKE+viAzSwXQ1aDQ5+vB164eS3xVjTRQ7m0C+0z/TCl2eK
         LFwfDaoFmnRuZdqjFoEWS6DMbCesBP/af+q3Sy5xpKJvmZVz7cyBM4603HrE/MUbP8Yi
         d7RhCBYtbOd4lcBLEqCEZztkAZIZtxGreUmtu7FGM/wPelg1VAp3709OpkE0JMAKauG+
         IOmcIVVttf5VDv/w14EfeF1dTmS8O7mxMptB8shPsRA0fXd3lWlLiNaqy7S1bMC30WLT
         GxXiiwRbnhI9gGQ70GljGtC0ybaTe5a23IdNV2XYURDz7deNBjUJp8bTN/W8XlZvt92o
         LLsg==
X-Gm-Message-State: AOAM53189BMxgYCjQ3TzKFzaRluKTLqoxdHvEjFxgh5+G/LDWW54W7uH
        zY0G3P0EDnvS08FQBTinAGABdRG2I6ogKILQSXs5Vw==
X-Google-Smtp-Source: ABdhPJwcK7J1/giQO4WA8Tn0mGtyHoieXK2CJmlWlrLI2oh4XSxm1ooyE+i1yYs+QyrlNSTGlrkmJXdT6FEUW7gSutA=
X-Received: by 2002:a05:600c:34e:: with SMTP id u14mr2056425wmd.16.1590547865534;
 Tue, 26 May 2020 19:51:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200424061342.212535-1-davidgow@google.com> <alpine.LRH.2.21.2005031101130.20090@localhost>
 <26d96fb9-392b-3b20-b689-7bc2c6819e7b@kernel.org>
In-Reply-To: <26d96fb9-392b-3b20-b689-7bc2c6819e7b@kernel.org>
From:   David Gow <davidgow@google.com>
Date:   Wed, 27 May 2020 10:50:53 +0800
Message-ID: <CABVgOS=MueiJ6AHH6QUSWjipSezi1AvggxBCrh0Q9P_wa55XZQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] KUnit-KASAN Integration
To:     shuah <shuah@kernel.org>
Cc:     Alan Maguire <alan.maguire@oracle.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Patricia Alfonso <trishalfonso@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, May 23, 2020 at 6:30 AM shuah <shuah@kernel.org> wrote:
>
> On 5/3/20 4:09 AM, Alan Maguire wrote:
> > On Thu, 23 Apr 2020, David Gow wrote:
> >
> >> This patchset contains everything needed to integrate KASAN and KUnit.
> >>
> >> KUnit will be able to:
> >> (1) Fail tests when an unexpected KASAN error occurs
> >> (2) Pass tests when an expected KASAN error occurs
> >>
> >> Convert KASAN tests to KUnit with the exception of copy_user_test
> >> because KUnit is unable to test those.
> >>
> >> Add documentation on how to run the KASAN tests with KUnit and what to
> >> expect when running these tests.
> >>
> >> This patchset depends on:
> >> - "[PATCH v3 kunit-next 0/2] kunit: extend kunit resources API" [1]
> >> - "[PATCH v3 0/3] Fix some incompatibilites between KASAN and
> >>    FORTIFY_SOURCE" [2]
> >>
> >> Changes from v6:
> >>   - Rebased on top of kselftest/kunit
> >>   - Rebased on top of Daniel Axtens' fix for FORTIFY_SOURCE
> >>     incompatibilites [2]
> >>   - Removed a redundant report_enabled() check.
> >>   - Fixed some places with out of date Kconfig names in the
> >>     documentation.
> >>
> >
> > Sorry for the delay in getting to this; I retested the
> > series with the above patchsets pre-applied; all looks
> > good now, thanks!  Looks like Daniel's patchset has a v4
> > so I'm not sure if that will have implications for applying
> > your changes on top of it (haven't tested it yet myself).
> >
> > For the series feel free to add
> >
> > Tested-by: Alan Maguire <alan.maguire@oracle.com>
> >
> > I'll try and take some time to review v7 shortly, but I wanted
> > to confirm the issues I saw went away first in case you're
> > blocked.  The only remaining issue I see is that we'd need the
> > named resource patchset to land first; it would be good
> > to ensure the API it provides is solid so you won't need to
> > respin.
> >
> > Thanks!
> >
> > Alan
> >
> >> Changes from v5:
> >>   - Split out the panic_on_warn changes to a separate patch.
> >>   - Fix documentation to fewer to the new Kconfig names.
> >>   - Fix some changes which were in the wrong patch.
> >>   - Rebase on top of kselftest/kunit (currently identical to 5.7-rc1)
> >>
> >
>
> Hi Brendan,
>
> Is this series ready to go inot Linux 5.8-rc1? Let me know.
> Probably needs rebase on top of kselftest/kunit. I applied
> patches from David and Vitor
>
> thanks,
> -- Shuah
>

Hi Shuah,

I think the only things holding this up are the missing dependencies:
the "extend kunit resources API" patches[1] for KUnit (which look
ready to me), and the "Fix some incompatibilities between KASAN and
FORTIFY_SOURCE" changes[2] on the KASAN side (which also seem ready).

This patchset may need a (likely rather trivial) rebase on top of
whatever versions of those end up merged: I'm happy to do that if
necessary.

Cheers,
-- David

[1]: https://lore.kernel.org/linux-kselftest/1585313122-26441-1-git-send-email-alan.maguire@oracle.com/T/#t
[2]: http://lkml.iu.edu/hypermail/linux/kernel/2004.3/00735.html
