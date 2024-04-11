Return-Path: <linux-kselftest+bounces-7720-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3288A1F27
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 21:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20CBEB230A7
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 18:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0536205E15;
	Thu, 11 Apr 2024 18:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="De7ESMTs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76950DF5C;
	Thu, 11 Apr 2024 18:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712861230; cv=none; b=d8MXoL0ZWGBsZwGpdXcrZU/KoRCBnRjiUyuuVO1dY0CC3SW8inP2+NZH7JmXJ1BVKfWkj7p2VNSZOczmAktIUVhEcmOjOdofKWyNozRFI/zLucxolY6H4cSi1U/1R0VPfHYfZmu9V4vBbACd2ZkjhUdGs3uvZyTg6+wBrLZ67g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712861230; c=relaxed/simple;
	bh=MCeR7HtXL7nbj9uUbgxs72avaXllwlL5Zu3wM03KPLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=crhKlZoeB8YLa/70tVKsOSYt5ZUAtQ0fRx+LJlzd97/KVLoZRJBgdnJsiGgwz9yVvJtyPRlLqmuZgNpqVe3Ki1SimA11n/Z2a5WblHhpZClXrEsjZ3MKsMyCzTo7r6ghdfGAffRlFhMsLCT8GP9TJfCUh0BpJmCdIJpU2n0v/Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=De7ESMTs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DACAC072AA;
	Thu, 11 Apr 2024 18:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712861230;
	bh=MCeR7HtXL7nbj9uUbgxs72avaXllwlL5Zu3wM03KPLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=De7ESMTs/7MYP2JnavGZGYEyz6N/7fYQmuLWAZ+K1zgQNOGKxGyN/uGL7eS+4QeYl
	 SfZa3knyteFFXBQ39dEaunMhzCgxjza3gMgMvCXqnuLyGk13Q+hg4PNKZmAiL6Ywnv
	 XrYKvb3Ifw++Y6/Kvr7KIMro4g0fW7MzhI19oE0FZzeZX8fzqgxg46rtE5wmRjd8Fb
	 v8K+vBi0zTZq8hplA+tCBOjuM4q/Dop8Rv3q8SSFbgZ0wIlWy8PnasGM0fDVCbba8R
	 nNfjlaUP90z5VZELIByN671DugpZNvnWyRQ8IsBkndZIrMHpcKtesXLW2uQW3bzfFI
	 bX3PGc+eSZMAg==
Date: Thu, 11 Apr 2024 11:47:07 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Edward Liaw <edliaw@google.com>,
	Carlos Llamas <cmllamas@google.com>, kernel-team@android.com,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/3] selftests: timers: Fix uninitialized variable
 warning in ksft_min_kernel_version
Message-ID: <20240411184707.GA153244@dev-arch.thelio-3990X>
References: <20240410232637.4135564-1-jstultz@google.com>
 <20240410232637.4135564-2-jstultz@google.com>
 <20240411153945.GA2507795@dev-arch.thelio-3990X>
 <CANDhNCoaMX7B5_SLuo-oaYD6VGdqT7vqPw2fe8ONz7AFqO22qg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANDhNCoaMX7B5_SLuo-oaYD6VGdqT7vqPw2fe8ONz7AFqO22qg@mail.gmail.com>

On Thu, Apr 11, 2024 at 11:11:59AM -0700, John Stultz wrote:
> On Thu, Apr 11, 2024 at 8:39 AM Nathan Chancellor <nathan@kernel.org> wrote:
> > On Wed, Apr 10, 2024 at 04:26:29PM -0700, John Stultz wrote:
> > > Building with clang, I see the following warning:
> > >
> > > In file included from posix_timers.c:17:
> > > ./../kselftest.h:398:6: warning: variable 'major' is used uninitialized whenever '||' condition is true [-Wsometimes-uninitialized]
> > >         if (uname(&info) || sscanf(info.release, "%u.%u.", &major, &minor) != 2)
> > >             ^~~~~~~~~~~~
> > > ./../kselftest.h:401:9: note: uninitialized use occurs here
> > >         return major > min_major || (major == min_major && minor >= min_minor);
> > >                ^~~~~
> > >
> > > This is a bit of a red-herring as if the uname() call did fail,
> > > we would hit ksft_exit_fail_msg() which should exit.
> >
> > Correct, although we have not really conveyed that to the compiler,
> > right? exit() is noreturn, which means all functions that call exit()
> > unconditionally are also noreturn, such as ksft_exit_fail_msg(). LLVM
> > will figure this out once it performs inlining and such but that happens
> > after clang's static analysis phase that this warning occurs in. I think
> > a better solution would be to add __noreturn to the functions in
> > tools/testing/selftests/kselftest.h that call exit(), so that the
> > compiler is aware of this through all pipeline phases, maybe something
> > like this? It resolves the wawrning for me.
> 
> No objection from me if this is the better approach.
> 
> Would you send that patch out?

Done: https://lore.kernel.org/20240411-mark-kselftest-exit-funcs-noreturn-v1-1-b027c948f586@kernel.org/

If you have to respin this series for some reason, feel free to include
that change so that they go together, up to you though.

Cheers,
nathan

