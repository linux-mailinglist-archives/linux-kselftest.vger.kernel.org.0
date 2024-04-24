Return-Path: <linux-kselftest+bounces-8780-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C91D8B0D88
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 17:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52E4228611E
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 15:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCCF15EFBE;
	Wed, 24 Apr 2024 15:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9fLJL0q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438BE15E5D3;
	Wed, 24 Apr 2024 15:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713971117; cv=none; b=HEfaUK0FkInrjOWTjjCv3C0YJ/E6AG5CwkSyV4Ik6Lx2vR1hQGLpu6cB3iX/bH57wfFjVPUJXwFuE9vITY43KPMa7Yn8H3+Fsw4+fu3JzcMIN+qAVc/WsJEe7IjIYcwRapgLYYREbfga+opO+SYNtYv7AIFNXnGBF+5e9LL8B8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713971117; c=relaxed/simple;
	bh=sUz0nJFCexGFraISbSEhtrGW1B4ZozQR3B90me4c+ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TxCqtDG2plehoVVQ0bp+mweJ6ruTLoMzl/+OI367WG67N43gu5r4XZ+T1d1r9AKV1eR6SMeclKjJUWMuJh+p+MkqpyNTFXYl/upW3n4GP/k6vBLqa+n3ngddcd4N/en5ofqqc03dRbZjdeZZqVk4efm2D4YIA8E5G4LuIapnSN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9fLJL0q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7032EC113CD;
	Wed, 24 Apr 2024 15:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713971115;
	bh=sUz0nJFCexGFraISbSEhtrGW1B4ZozQR3B90me4c+ho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z9fLJL0qJtVYdXZ3k0K6Iq0nCNQJNyEo5IedHPT897zsSfNwevWP+aYq5/7B2FJ3+
	 pcBwzbtGC1EiPpgcOi8O17bOAiZqUyrKj4zZtbTSH5A1Pf0n8rcb2gcxXVwDxCczcq
	 y50KYoiYvWj5gL2x1xnQ9novEmYH50Lwtw93dkiselqtvus7w0/riii3u+tyoH25yJ
	 /rhTBauKn19vOePrQgqJiR3lDVVONOjrj6+4jI5/lsWE/WT+NcDUA7m6n70boF5eIa
	 S+EpDSYIHdH4MtltYQ68PIjIws/0mmWe0g11SpDWc2scA4ZoI/m1GM+KtJF/La+Yzj
	 1kqekEAgp/NQA==
Date: Wed, 24 Apr 2024 08:05:13 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: shuah@kernel.org, tglx@linutronix.de, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: Make ksft_exit functions return void instead
 of int
Message-ID: <20240424150513.GA304587@dev-arch.thelio-3990X>
References: <20240417-ksft-exit-int-to-void-v1-1-eff48fdbab39@kernel.org>
 <bb5fd480-bd43-42c9-b326-2ee7addcda33@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb5fd480-bd43-42c9-b326-2ee7addcda33@linuxfoundation.org>

On Wed, Apr 24, 2024 at 07:44:31AM -0600, Shuah Khan wrote:
> On 4/17/24 09:37, Nathan Chancellor wrote:
> > Commit f7d5bcd35d42 ("selftests: kselftest: Mark functions that
> > unconditionally call exit() as __noreturn") marked functions that call
> > exit() as __noreturn but it did not change the return type of these
> > functions from 'void' to 'int' like it should have (since a noreturn
> > function by definition cannot return an integer because it does not
> > return...) because there are many tests that return the result of the
> > ksft_exit function, even though it has never been used due to calling
> > exit().
> > 
> > Prior to adding __noreturn, the compiler would not know that the functions
> > that call exit() will not return, so code like
> > 
> >    void ksft_exit_fail(void)
> >    {
> >      exit(1);
> >    }
> > 
> >    void ksft_exit_pass(void)
> >    {
> >      exit(0);
> >    }
> > 
> >    int main(void)
> >    {
> >      int ret;
> > 
> >      ret = foo();
> >      if (ret)
> >        ksft_exit_fail();
> >      ksft_exit_pass();
> >    }
> > 
> > would cause the compiler to complain that main() does not return an
> > integer, even though when ksft_exit_pass() is called, exit() will cause
> > the program to terminate. So ksft_exit_...() returns int to make the
> > compiler happy.
> > 
> >    int ksft_exit_fail(void)
> >    {
> >      exit(1);
> >    }
> > 
> >    int ksft_exit_pass(void)
> >    {
> >      exit(0);
> >    }
> > 
> >    int main(void)
> >    {
> >      int ret;
> > 
> >      ret = foo();
> >      if (ret)
> >        return ksft_exit_fail();
> >      return ksft_exit_pass();
> >    }
> > 
> > While this results in no warnings, it is weird semantically and it has
> > issues as noted in the aforementioned __noreturn change. Now that
> > __noreturn has been added to these functions, it is much cleaner to
> > change the functions to 'void' and eliminate the return statements, as
> > it has been made clear to the compiler that these functions terminate
> > the program. Drop the return before all instances of ksft_exit_...() in
> > a mechanical way. Only two manually changes were made to transform
> > 
> >    return !ret ? ksft_exit_pass() : ksft_exit_fail();
> > 
> > into the more idiomatic
> > 
> >    if (ret)
> >      ksft_exit_fail();
> >    ksft_exit_pass();
> > 
> > as well as a few style clean ups now that the code is shorter.
> > 
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > ---
> >   tools/testing/selftests/clone3/clone3_clear_sighand.c        |  2 +-
> >   tools/testing/selftests/clone3/clone3_set_tid.c              |  4 +++-
> >   tools/testing/selftests/ipc/msgque.c                         | 11 +++++------
> >   tools/testing/selftests/kselftest.h                          | 12 ++++++------
> >   .../selftests/membarrier/membarrier_test_multi_thread.c      |  2 +-
> >   .../selftests/membarrier/membarrier_test_single_thread.c     |  2 +-
> >   tools/testing/selftests/mm/compaction_test.c                 |  6 +++---
> >   tools/testing/selftests/mm/cow.c                             |  2 +-
> >   tools/testing/selftests/mm/gup_longterm.c                    |  2 +-
> >   tools/testing/selftests/mm/gup_test.c                        |  4 ++--
> >   tools/testing/selftests/mm/ksm_functional_tests.c            |  2 +-
> >   tools/testing/selftests/mm/madv_populate.c                   |  2 +-
> >   tools/testing/selftests/mm/mkdirty.c                         |  2 +-
> >   tools/testing/selftests/mm/pagemap_ioctl.c                   |  4 ++--
> >   tools/testing/selftests/mm/soft-dirty.c                      |  2 +-
> >   tools/testing/selftests/pidfd/pidfd_fdinfo_test.c            |  2 +-
> >   tools/testing/selftests/pidfd/pidfd_open_test.c              |  4 +++-
> >   tools/testing/selftests/pidfd/pidfd_poll_test.c              |  2 +-
> >   tools/testing/selftests/pidfd/pidfd_test.c                   |  2 +-
> >   tools/testing/selftests/resctrl/resctrl_tests.c              |  6 +++---
> >   tools/testing/selftests/sync/sync_test.c                     |  3 +--
> >   tools/testing/selftests/timers/adjtick.c                     |  4 ++--
> >   tools/testing/selftests/timers/alarmtimer-suspend.c          |  4 ++--
> >   tools/testing/selftests/timers/change_skew.c                 |  4 ++--
> >   tools/testing/selftests/timers/freq-step.c                   |  4 ++--
> >   tools/testing/selftests/timers/leap-a-day.c                  | 10 +++++-----
> >   tools/testing/selftests/timers/leapcrash.c                   |  4 ++--
> >   tools/testing/selftests/timers/mqueue-lat.c                  |  4 ++--
> >   tools/testing/selftests/timers/posix_timers.c                | 12 ++++++------
> >   tools/testing/selftests/timers/raw_skew.c                    |  6 +++---
> >   tools/testing/selftests/timers/set-2038.c                    |  4 ++--
> >   tools/testing/selftests/timers/set-tai.c                     |  4 ++--
> >   tools/testing/selftests/timers/set-timer-lat.c               |  4 ++--
> >   tools/testing/selftests/timers/set-tz.c                      |  4 ++--
> >   tools/testing/selftests/timers/skew_consistency.c            |  4 ++--
> >   tools/testing/selftests/timers/threadtest.c                  |  2 +-
> >   tools/testing/selftests/timers/valid-adjtimex.c              |  6 +++---
> >   tools/testing/selftests/x86/lam.c                            |  2 +-
> >   38 files changed, 81 insertions(+), 79 deletions(-)
> > 
> 
> Please generate separate patches for each test so it is easy to apply
> them and also reduce merge conflicts.

Is applying 30+ patches easier than applying just one? It is not a
trivial amount of work for me to break this series up into individual
patches but I will do so if you really want me to. I based this on the
kselftest tree directly so that it would apply cleanly.

How does breaking apart the changes reduce merge conflicts? The diff is
going to be the same and semantic conflicts can still occur due to the
kselftest.h changes.

> You are missing maintainers for clone3, mm, pidfd tests. I can take these
> through kselftest tree, but I need the changes split.

Fair enough, I should have CC'd them, although given this is a change to
the kselftest API, I was not sure they would care too much.

Cheers,
Nathan

