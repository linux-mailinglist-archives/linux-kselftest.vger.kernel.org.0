Return-Path: <linux-kselftest+bounces-34751-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 245CDAD5D76
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 19:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D75761E1835
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 17:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE4826B2C5;
	Wed, 11 Jun 2025 17:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWU3Xda+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD8C1CF7AF;
	Wed, 11 Jun 2025 17:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749664259; cv=none; b=oI1i5R+yjAchf1ZeUeamX0FuxMXKQuMDDRuZKSXXDElQWd82hmGBFKHAhjp47+XWO0epQGUMrTlZfHtZMI5ge+S0qphv/nvTFBGpHHiGHDULCIRh7KMGyOnTcOUMxjc7STCWN06O1/V1rSkacExtV4mWfuCvHd86KX0JYNVYKkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749664259; c=relaxed/simple;
	bh=KDBiD63Sl3N9MizVVWXllFsrA9RrPUV5pY0jwlUgWqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LdszyqUr+s7sSaRN7WwqzqAxxzVbqZXp+yIcK74ZrKP9LsYNo8GMAtinrb2X18a0E/RTCGtfK0fsDha6BF+lH4MLsQzfenmQCDdz33oKV9mYOQg3Wo0aBXQimrcJZSLnwRUdRK6INS28xG1IRKfVGSdxL+Pp4zSuRnWZFfYUomo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWU3Xda+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDAB0C4CEEA;
	Wed, 11 Jun 2025 17:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749664257;
	bh=KDBiD63Sl3N9MizVVWXllFsrA9RrPUV5pY0jwlUgWqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KWU3Xda+q3cgL75t1mHyr4jThD6TxtcnaTWgt3VhDTPuqSJpfCbAuaMKGM1UsXBsI
	 I0A+Kf/mwGQ9aZ/uuudKA1/GMich4QljGT5cmIL98A4izONvPJcby1rWal44MmiBB3
	 3BHQzFb0YhrVQVYVsMnd0C37V1R6yKUbHd/RGDhvxIuaRpdnr0T6yW4s0Iva3kmeED
	 HO4VDxAdxVT322N8miL/EpQUfRaVVcD6SBqKiMhaX+kD632aC7YdPYZZpeJpMAoMCh
	 q/gUG8j0STtwTlGkDzqS6UMEDRmQ33wAt6vggPN1UztGKQYrQb1JDIugJ0bgKN+/rB
	 LP7nsN6fGcH5w==
Date: Wed, 11 Jun 2025 10:50:52 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
	clang-built-linux <llvm@lists.linux.dev>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	lkft-triage@lists.linaro.org,
	Anders Roxell <anders.roxell@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, Sasha Levin <sashal@kernel.org>
Subject: Re: selftests/filesystem: clang warning null passed to a callee that
 requires a non-null argument [-Wnonnull]
Message-ID: <20250611175052.GA2307190@ax162>
References: <CA+G9fYt-CMBGCFxV5ziP98upkeK2LBxkZRo7-0XN1G+zLtWK4A@mail.gmail.com>
 <aEmzK5B4pbF5MZ6Y@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEmzK5B4pbF5MZ6Y@stanley.mountain>

On Wed, Jun 11, 2025 at 07:47:39PM +0300, Dan Carpenter wrote:
> This seems like a Clang bug, right?  The test for _Nullable is reversed
> or something?

My copy of unistd.h has

  /* Execute program relative to a directory file descriptor.  */
  extern int execveat (int __fd, const char *__path, char *const __argv[],
                       char *const __envp[], int __flags)
      __THROW __nonnull ((2, 3));

so I think the warning is valid in this case. I will note that
tools/testing/selftests/exec/recursion-depth.c uses execve() with a NULL
argv and disables -Wnonnull so maybe that should happen for this test
case too? Or should that NULL be changed into a ""?

> On Thu, Jun 05, 2025 at 05:41:01PM +0530, Naresh Kamboju wrote:
> > Regressions found on arm, arm64 and x86_64 building warnings with clang-20
> > and clang-nightly started from Linux next-20250603
> > 
> > Regressions found on arm, arm64 and x86_64
> >  - selftests/filesystem
> > 
> > Regression Analysis:
> >  - New regression? Yes
> >  - Reproducible? Yes
> > 
> > First seen on the next-20250603
> > Good: next-20250530
> > Bad:  next-20250603
> > 
> > Test regression: arm arm64 x86_64 clang warning null passed to a
> > callee that requires a non-null argument [-Wnonnull]
> > 
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > 
> > ## Build warnings
> > make[4]: Entering directory '/builds/linux/tools/testing/selftests/filesystems'
> >   CC       devpts_pts
> >   CC       file_stressor
> >   CC       anon_inode_test
> > anon_inode_test.c:45:37: warning: null passed to a callee that
> > requires a non-null argument [-Wnonnull]
> >    45 |         ASSERT_LT(execveat(fd_context, "", NULL, NULL,
> > AT_EMPTY_PATH), 0);
> >       |                                            ^~~~
> > 
> > ## Source
> > * Kernel version: 6.15.0-next-20250605
> > * Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
> > * Git sha: a0bea9e39035edc56a994630e6048c8a191a99d8
> > * Toolchain: Debian clang version 21.0.0
> > (++20250529012636+c474f8f2404d-1~exp1~20250529132821.1479)
> > 
> > ## Build
> > * Test log: https://qa-reports.linaro.org/api/testruns/28651387/log_file/
> > * Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2xzM4wMl8SvuLKE3mw3csiuv3Jz/
> > * Kernel config:
> > https://storage.tuxsuite.com/public/linaro/lkft/builds/2xzM4wMl8SvuLKE3mw3csiuv3Jz/config
> > 
> > --
> > Linaro LKFT
> > https://lkft.linaro.org

