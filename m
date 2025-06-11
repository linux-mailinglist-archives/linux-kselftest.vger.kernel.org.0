Return-Path: <linux-kselftest+bounces-34754-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D319AD5E22
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 20:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C14C016C68A
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 18:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7EB2248B8;
	Wed, 11 Jun 2025 18:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C4IJI/H6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D27E1E8329
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Jun 2025 18:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749666607; cv=none; b=LyerDWVN9rbmvFT/a3hHnNGDWAYotPxB/6zk4yhPbPgfhfAl2DfQL/mqB4q0ktlgNswToTFCtghDtKKpBauymQr8lNieR+hWz4oNcVKFDU0eHLt8E6RCowKFjmr0xH2ltTbNaAsBetXcwCbTzMN4/jjw95M6U7QgPpgdtDfMNHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749666607; c=relaxed/simple;
	bh=JiBEW9GnpC6nphMw1Nmi6/whGvQxkUqmaI4odvdQYMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PwoJDlWVn71YEESzy3iFMwXhaYP9pwq0Gkg7/f8q4bXVNKcpuZa12Jb6+skSMuv35izj5psKVWo5ciMdwJBJj80lILfwrG1GjF1I/JUrmzMjy+kD4C8x6ocRZxqT4yPyKymkL8cSZLNhyeb0S6PmQm4YKRBBIV/Mv/sMWWr2xUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C4IJI/H6; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-450cf214200so718905e9.1
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Jun 2025 11:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749666604; x=1750271404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kZUFhp39dTZAMXovncJ1VhLVfSRWQwMXUrqA+mPJGfc=;
        b=C4IJI/H6X0BPuMTp+YEnc+ZzqqQw2cQtwAPjVGxI7uAhgSUTBRsTlgODWAbeSDPPkM
         PD8RI6xwxWn57OpalpNwedk/5DGfh/mQ5cIzGJ3QpU/NBS/VPavEZEUbGJ4s7/0MFYF6
         tzE3AfQB5tTOnBQ5R6BMEJk8ZSxTRg+XRKm1FRiqCQ5aEJdURHAMbnmP4G4rNIVzV3BF
         3+CMt75HUTW8KzZr6JTMbpxNb6/SPEsj2xR5Ey44RVjjxzWf4cQLAam6LmtvTkpBlmIy
         J2NF0GnHCCs0/KJjlzD3mY98b1z7vR7kSMMmizt1IqhIw6umMv3cCMxPGYnDb3E8GSY1
         bfaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749666604; x=1750271404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZUFhp39dTZAMXovncJ1VhLVfSRWQwMXUrqA+mPJGfc=;
        b=tHlV8SS4BiBjdjNW1ZqL8m1g7AyFEhrjfT7A+u3Ugn3Jm3OThmALNAglEngUmjURng
         AJWYMqi7/6BBxXhyNsG3IBf8P8bAyiPMUOXkis/F/Mu0mgIaAOLYRodZV0OIzeN3vYSt
         YeWKy+mzByEvmvD4b05HReEWkL6lgpThrm3H5hV8KymTVw45VDJW8eGaqC9c+GDy99df
         O9eWj8TyK70gHK4Iq/xSK+6BsF26DIbDUK8qhOF9aw9ELct7pUhp/DOgoZegJQy4vH5i
         f+aIki6Cdv+K5fW1ttGrQaO3/lCh4h51/C6TEZDj+NKfpSBwZ5M+j8Y8AQps4LwVS3RN
         2new==
X-Forwarded-Encrypted: i=1; AJvYcCXdp0tIBcrYz5iBZuv8S3nH3uIGprZst3IvFbP9zJQ8N4BLgYtA/EejN94vaAxw2ruC94l+/gcl03iUfU5mb4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGU1OFcwtXbaTr1FPQzU5KjeqmL384/fT96fmumycwly0EJqFp
	+LMEBZZs9OwLSgOqK5E//8Pjs4XSTuG/Zd0MYXAXHVoDCsTnOIAsrfp/4zF+KCOy3hsr6XAgPex
	yI9ta
X-Gm-Gg: ASbGncusUKaeC75MGL/vIKPviHc0hCZIQzeZa8HULNHJEr3qpuXzWrjgBDPpyLFMI3h
	CTq2LrcrrPUyshCf6OuMMq4iSl0x5WcYPk3ByUc+rbr7B/Rx5ADU9d/m6tXwqoPA9SuPQ8vuFn1
	17BJw1binFsSYbFyIdKt81p+O52L7lj1T/lzoMD9Vgg9KAn0wfLXukkDe/c2gK4UyC0JNHB0Ejp
	6F8xdmS5Dn+Jag5UsMu2K5/pjq1HtzogfpztAxs4dK4g+hSimUMyy/HMRXcXXWGvkeGDMwOuG+m
	auZtYdfuGDgQPaCVAMfUKi7+uVTd6qAszpNAvWF1awtJC0MUG+KXAvDWUpubI3UgE8c=
X-Google-Smtp-Source: AGHT+IEOnrEhGtLnO/aBJWRPFeQDku4c9EmVz/spaw65LaaOkpsBO4KbA6/7mK4y3l0ElS0ayRNSyw==
X-Received: by 2002:a05:600c:6612:b0:453:8a6:d8de with SMTP id 5b1f17b1804b1-4532b8c5819mr8416435e9.1.1749666604214;
        Wed, 11 Jun 2025 11:30:04 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a5323b6612sm15852258f8f.41.2025.06.11.11.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 11:30:03 -0700 (PDT)
Date: Wed, 11 Jun 2025 21:29:59 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Nathan Chancellor <nathan@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
	clang-built-linux <llvm@lists.linux.dev>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	lkft-triage@lists.linaro.org,
	Anders Roxell <anders.roxell@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, Sasha Levin <sashal@kernel.org>
Subject: Re: selftests/filesystem: clang warning null passed to a callee that
 requires a non-null argument [-Wnonnull]
Message-ID: <aEnLJ0CkfrHieKrG@stanley.mountain>
References: <CA+G9fYt-CMBGCFxV5ziP98upkeK2LBxkZRo7-0XN1G+zLtWK4A@mail.gmail.com>
 <aEmzK5B4pbF5MZ6Y@stanley.mountain>
 <20250611175052.GA2307190@ax162>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611175052.GA2307190@ax162>

On Wed, Jun 11, 2025 at 10:50:52AM -0700, Nathan Chancellor wrote:
> On Wed, Jun 11, 2025 at 07:47:39PM +0300, Dan Carpenter wrote:
> > This seems like a Clang bug, right?  The test for _Nullable is reversed
> > or something?
> 
> My copy of unistd.h has
> 
>   /* Execute program relative to a directory file descriptor.  */
>   extern int execveat (int __fd, const char *__path, char *const __argv[],
>                        char *const __envp[], int __flags)
>       __THROW __nonnull ((2, 3));
> 
> so I think the warning is valid in this case. I will note that
> tools/testing/selftests/exec/recursion-depth.c uses execve() with a NULL
> argv and disables -Wnonnull so maybe that should happen for this test
> case too? Or should that NULL be changed into a ""?
> 

Oh, huh.  The man page for execveat() says _Nullable but the headerfile
says the opposite.

regards,
dan carpenter

> > On Thu, Jun 05, 2025 at 05:41:01PM +0530, Naresh Kamboju wrote:
> > > Regressions found on arm, arm64 and x86_64 building warnings with clang-20
> > > and clang-nightly started from Linux next-20250603
> > > 
> > > Regressions found on arm, arm64 and x86_64
> > >  - selftests/filesystem
> > > 
> > > Regression Analysis:
> > >  - New regression? Yes
> > >  - Reproducible? Yes
> > > 
> > > First seen on the next-20250603
> > > Good: next-20250530
> > > Bad:  next-20250603
> > > 
> > > Test regression: arm arm64 x86_64 clang warning null passed to a
> > > callee that requires a non-null argument [-Wnonnull]
> > > 
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > > 
> > > ## Build warnings
> > > make[4]: Entering directory '/builds/linux/tools/testing/selftests/filesystems'
> > >   CC       devpts_pts
> > >   CC       file_stressor
> > >   CC       anon_inode_test
> > > anon_inode_test.c:45:37: warning: null passed to a callee that
> > > requires a non-null argument [-Wnonnull]
> > >    45 |         ASSERT_LT(execveat(fd_context, "", NULL, NULL,
> > > AT_EMPTY_PATH), 0);
> > >       |                                            ^~~~
> > > 
> > > ## Source
> > > * Kernel version: 6.15.0-next-20250605
> > > * Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
> > > * Git sha: a0bea9e39035edc56a994630e6048c8a191a99d8
> > > * Toolchain: Debian clang version 21.0.0
> > > (++20250529012636+c474f8f2404d-1~exp1~20250529132821.1479)
> > > 
> > > ## Build
> > > * Test log: https://qa-reports.linaro.org/api/testruns/28651387/log_file/
> > > * Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2xzM4wMl8SvuLKE3mw3csiuv3Jz/
> > > * Kernel config:
> > > https://storage.tuxsuite.com/public/linaro/lkft/builds/2xzM4wMl8SvuLKE3mw3csiuv3Jz/config
> > > 
> > > --
> > > Linaro LKFT
> > > https://lkft.linaro.org

