Return-Path: <linux-kselftest+bounces-8787-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6788B0F89
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 18:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3FF8B22799
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 16:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA58E16078B;
	Wed, 24 Apr 2024 16:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qpzLpI7q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E0513D893;
	Wed, 24 Apr 2024 16:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713975062; cv=none; b=QsUPEtkzgSte2EJkeAgWa20RCAnsX21XE4EJGz82DKin63w75hKCvEUgWx9EbI1mia/fmE2rqEnZdhfTK5wf+LuPLvu64BdsyZlJxWQJEJxpnKpntsUxoSa8Ey1IYhZNs8kYu5t2EwC38PSBvFuRe4GUxlfEkJHBEDy673knh+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713975062; c=relaxed/simple;
	bh=snJ2kvjLv4JICSYewZZ7ktNbZE4ctWt0P+tOpimZtcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+ALYj4Qy21vA5vdHfZtV/0H41Byqpfc6mmF+rn6JNnSmQPkxEdehyMbt5NaeGntulBIKxdO3nGnZWejzKuxaHuRAQ5yE7XU3m47keP5rcYO36uabgnHzGh8gFT8HSKZNhP3LZym1izf5xyMF5xsry2+8UX50rcx3g4Ac9fwx1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qpzLpI7q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB337C113CD;
	Wed, 24 Apr 2024 16:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713975062;
	bh=snJ2kvjLv4JICSYewZZ7ktNbZE4ctWt0P+tOpimZtcE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qpzLpI7qtDPWXFkwyiJfjsLgzkghRxg5EU30laQ4HsaEFeJQCMEZzz2TxGbDFiiNn
	 HR/obA0SxGCTNB08q3crTlYR2cIbgRwvbf6i0IEUhHNAO7WTaa69KCdL3RoBRoRwkt
	 HyZYJeDgMSE5zC8eBkjuXc/RW498CyroWd/74+8/ZZ12aADi3NdbN0yrtR09t9bCzg
	 R0AxKWfwrz1PJPfaAZRBvobVRt2Kdob/dlNkT4kX5D7bsi0/MoRItAbIL2+e6wgzS0
	 PaH4h+6b3V7AVejh0hMccLIMfvkkHA27eZ022P5siOviPSiZ1wt/mu3u1AN9W9BTmE
	 EqeWGh0N324ew==
Date: Wed, 24 Apr 2024 09:10:59 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: shuah@kernel.org, tglx@linutronix.de, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: Make ksft_exit functions return void instead
 of int
Message-ID: <20240424161059.GA904896@dev-arch.thelio-3990X>
References: <20240417-ksft-exit-int-to-void-v1-1-eff48fdbab39@kernel.org>
 <bb5fd480-bd43-42c9-b326-2ee7addcda33@linuxfoundation.org>
 <20240424150513.GA304587@dev-arch.thelio-3990X>
 <ba14458b-8f69-4947-ade2-d77e3290d4ed@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba14458b-8f69-4947-ade2-d77e3290d4ed@linuxfoundation.org>

On Wed, Apr 24, 2024 at 10:00:12AM -0600, Shuah Khan wrote:
> On 4/24/24 09:05, Nathan Chancellor wrote:
> > On Wed, Apr 24, 2024 at 07:44:31AM -0600, Shuah Khan wrote:
> > > On 4/17/24 09:37, Nathan Chancellor wrote:
> > > > Commit f7d5bcd35d42 ("selftests: kselftest: Mark functions that
> > > > unconditionally call exit() as __noreturn") marked functions that call
> > > > exit() as __noreturn but it did not change the return type of these
> > > > functions from 'void' to 'int' like it should have (since a noreturn
> > > > function by definition cannot return an integer because it does not
> > > > return...) because there are many tests that return the result of the
> > > > ksft_exit function, even though it has never been used due to calling
> > > > exit().
> > > > 
> > > > Prior to adding __noreturn, the compiler would not know that the functions
> > > > that call exit() will not return, so code like
> > > > 
> > > >     void ksft_exit_fail(void)
> > > >     {
> > > >       exit(1);
> > > >     }
> > > > 
> > > >     void ksft_exit_pass(void)
> > > >     {
> > > >       exit(0);
> > > >     }
> > > > 
> > > >     int main(void)
> > > >     {
> > > >       int ret;
> > > > 
> > > >       ret = foo();
> > > >       if (ret)
> > > >         ksft_exit_fail();
> > > >       ksft_exit_pass();
> > > >     }
> > > > 
> > > > would cause the compiler to complain that main() does not return an
> > > > integer, even though when ksft_exit_pass() is called, exit() will cause
> > > > the program to terminate. So ksft_exit_...() returns int to make the
> > > > compiler happy.
> > > > 
> > > >     int ksft_exit_fail(void)
> > > >     {
> > > >       exit(1);
> > > >     }
> > > > 
> > > >     int ksft_exit_pass(void)
> > > >     {
> > > >       exit(0);
> > > >     }
> > > > 
> > > >     int main(void)
> > > >     {
> > > >       int ret;
> > > > 
> > > >       ret = foo();
> > > >       if (ret)
> > > >         return ksft_exit_fail();
> > > >       return ksft_exit_pass();
> > > >     }
> > > > 
> > > > While this results in no warnings, it is weird semantically and it has
> > > > issues as noted in the aforementioned __noreturn change. Now that
> > > > __noreturn has been added to these functions, it is much cleaner to
> > > > change the functions to 'void' and eliminate the return statements, as
> > > > it has been made clear to the compiler that these functions terminate
> > > > the program. Drop the return before all instances of ksft_exit_...() in
> > > > a mechanical way. Only two manually changes were made to transform
> > > > 
> > > >     return !ret ? ksft_exit_pass() : ksft_exit_fail();
> > > > 
> > > > into the more idiomatic
> > > > 
> > > >     if (ret)
> > > >       ksft_exit_fail();
> > > >     ksft_exit_pass();
> > > > 
> > > > as well as a few style clean ups now that the code is shorter.
> > > > 
> > > > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > > > ---
> > > >    tools/testing/selftests/clone3/clone3_clear_sighand.c        |  2 +-
> > > >    tools/testing/selftests/clone3/clone3_set_tid.c              |  4 +++-
> > > >    tools/testing/selftests/ipc/msgque.c                         | 11 +++++------
> > > >    tools/testing/selftests/kselftest.h                          | 12 ++++++------
> > > >    .../selftests/membarrier/membarrier_test_multi_thread.c      |  2 +-
> > > >    .../selftests/membarrier/membarrier_test_single_thread.c     |  2 +-
> > > >    tools/testing/selftests/mm/compaction_test.c                 |  6 +++---
> > > >    tools/testing/selftests/mm/cow.c                             |  2 +-
> > > >    tools/testing/selftests/mm/gup_longterm.c                    |  2 +-
> > > >    tools/testing/selftests/mm/gup_test.c                        |  4 ++--
> > > >    tools/testing/selftests/mm/ksm_functional_tests.c            |  2 +-
> > > >    tools/testing/selftests/mm/madv_populate.c                   |  2 +-
> > > >    tools/testing/selftests/mm/mkdirty.c                         |  2 +-
> > > >    tools/testing/selftests/mm/pagemap_ioctl.c                   |  4 ++--
> > > >    tools/testing/selftests/mm/soft-dirty.c                      |  2 +-
> > > >    tools/testing/selftests/pidfd/pidfd_fdinfo_test.c            |  2 +-
> > > >    tools/testing/selftests/pidfd/pidfd_open_test.c              |  4 +++-
> > > >    tools/testing/selftests/pidfd/pidfd_poll_test.c              |  2 +-
> > > >    tools/testing/selftests/pidfd/pidfd_test.c                   |  2 +-
> > > >    tools/testing/selftests/resctrl/resctrl_tests.c              |  6 +++---
> > > >    tools/testing/selftests/sync/sync_test.c                     |  3 +--
> > > >    tools/testing/selftests/timers/adjtick.c                     |  4 ++--
> > > >    tools/testing/selftests/timers/alarmtimer-suspend.c          |  4 ++--
> > > >    tools/testing/selftests/timers/change_skew.c                 |  4 ++--
> > > >    tools/testing/selftests/timers/freq-step.c                   |  4 ++--
> > > >    tools/testing/selftests/timers/leap-a-day.c                  | 10 +++++-----
> > > >    tools/testing/selftests/timers/leapcrash.c                   |  4 ++--
> > > >    tools/testing/selftests/timers/mqueue-lat.c                  |  4 ++--
> > > >    tools/testing/selftests/timers/posix_timers.c                | 12 ++++++------
> > > >    tools/testing/selftests/timers/raw_skew.c                    |  6 +++---
> > > >    tools/testing/selftests/timers/set-2038.c                    |  4 ++--
> > > >    tools/testing/selftests/timers/set-tai.c                     |  4 ++--
> > > >    tools/testing/selftests/timers/set-timer-lat.c               |  4 ++--
> > > >    tools/testing/selftests/timers/set-tz.c                      |  4 ++--
> > > >    tools/testing/selftests/timers/skew_consistency.c            |  4 ++--
> > > >    tools/testing/selftests/timers/threadtest.c                  |  2 +-
> > > >    tools/testing/selftests/timers/valid-adjtimex.c              |  6 +++---
> > > >    tools/testing/selftests/x86/lam.c                            |  2 +-
> > > >    38 files changed, 81 insertions(+), 79 deletions(-)
> > > > 
> > > 
> > > Please generate separate patches for each test so it is easy to apply
> > > them and also reduce merge conflicts.
> > 
> > Is applying 30+ patches easier than applying just one? It is not a
> > trivial amount of work for me to break this series up into individual
> > patches but I will do so if you really want me to. I based this on the
> > kselftest tree directly so that it would apply cleanly.
> > 
> 
> I am not asking each file to be a separate patch.

What granularity would you like? One per folder in
tools/testing/selftest (i.e., clone3, ipc, membarrier, etc)?

> > How does breaking apart the changes reduce merge conflicts? The diff is
> > going to be the same and semantic conflicts can still occur due to the
> > kselftest.h changes.
> 
> selftest patches go through various repos. With this patch touching
> several tests, there will be conflicts with multiple trees.
> 
> If this patch can't be split due to dependency on kselftest.h, I will
> pull it in, but I do need you to include all the maintainers.

No, it can be split as long as the kselftest.h change is last. I just
did not see the value of that at the time but I am not out to make life
harder for maintainers so I will split it as you see fit.

> > > You are missing maintainers for clone3, mm, pidfd tests. I can take these
> > > through kselftest tree, but I need the changes split.
> > 
> > Fair enough, I should have CC'd them, although given this is a change to
> > the kselftest API, I was not sure they would care too much.
> > 
> 
> The reason for cc'ing the maintainers is to keep them in the loop about this
> change that could result in merge conflicts between kselftest tree and theirs.
> 
> Besides I would rather not have developers make calls on who should or shouldn't
> care about a change. :)

Sure, that makes sense.

Cheers,
Nathan

