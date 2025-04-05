Return-Path: <linux-kselftest+bounces-30158-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C120AA7C8BF
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Apr 2025 12:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46F637A8F01
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Apr 2025 10:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3BD1DEFF4;
	Sat,  5 Apr 2025 10:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D9x15F/T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680B4182BC;
	Sat,  5 Apr 2025 10:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743848742; cv=none; b=sg56/QEMH1kxEwgNYoZJBzF3JCD1kepd+l/JxEZ2/FNIM4UDmBb8gnxXx6u+4n7Nm6vtuqhmazrSHHqCfaaLp/YQdYrUDYEccKr6CurEpfLGRHnwsR4SoTdYQXozl6y1EPeCvUlgX8jaLpvOJ2l4P9HQUW9HpZnQ+gzugjTt2xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743848742; c=relaxed/simple;
	bh=vE5HlGqFMPRiEApGfruZPXTVG1TFF/lORB022UJd2+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mSjobpu6ulbzo/y/7cOFTX6RdMR9QHPexfEl0xls9HKe3lnbwJm/b9MXk2gyDpFpvvGXIK55isoGSXrVVx0tp71iYgcMcGq5jHnd9J5ssBAsqJPW3tjy8J2Z+ffbSFadGtBd0g+/3r+1rXKP3XLdtMQgcSxHVkuELFAmL9kQSfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D9x15F/T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F18C4CEE4;
	Sat,  5 Apr 2025 10:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743848741;
	bh=vE5HlGqFMPRiEApGfruZPXTVG1TFF/lORB022UJd2+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D9x15F/TYNWiEI75UcJrX8YPtugDm+WaUhtn6Lb0l0B9RjaeEzQa8gSaTqN9JOLPw
	 N9U9Q8OLIV5X9gX4sY7uzAYJCqW7r+muYhi1Vs9VdHxlnWEKXEKpsOxYSR1R1Uc55V
	 S2IdIaNAnTVyE8Ef2zAU0NCEK5fGUZ4aKB2jYZoI=
Date: Sat, 5 Apr 2025 11:24:13 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
	clang-built-linux <llvm@lists.linux.dev>,
	Nathan Chancellor <nathan@kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 6.13 00/23] 6.13.10-rc1 review
Message-ID: <2025040527-harmonics-bath-946e@gregkh>
References: <20250403151622.273788569@linuxfoundation.org>
 <CA+G9fYvPdt8CETb7cDmraiZPpG3YX83en8SKO4ac+-83TQY_pQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYvPdt8CETb7cDmraiZPpG3YX83en8SKO4ac+-83TQY_pQ@mail.gmail.com>

On Sat, Apr 05, 2025 at 11:50:59AM +0530, Naresh Kamboju wrote:
> On Thu, 3 Apr 2025 at 20:56, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 6.13.10 release.
> > There are 23 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sat, 05 Apr 2025 15:16:11 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.13.10-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.13.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> 
> Regressions on arm, arm64 and x86_64.
> 
> 1)
> The selftests rseq failed across the boards and virtual environments.
> These test failures were also noticed on Linux mainline and next.
> 
> We will bisect these lists of regressions and get back to you.

Thanks, this I'll care about, but:

> * kselftest-rseq
>   - rseq_basic_percpu_ops_mm_cid_test
>   - rseq_basic_percpu_ops_test
>   - rseq_basic_test
>   - rseq_param_test
>   - rseq_param_test_benchmark
>   - rseq_param_test_compare_twice
>   - rseq_param_test_mm_cid
>   - rseq_param_test_mm_cid_benchmark
>   - rseq_param_test_mm_cid_compare_twice
> 
> 2)
>  The clang-nightly build issues reported on mainline and next.
> 
> * S390, powerpc, build
>   - clang-nightly-defconfig
>   - clang-nightly-lkftconfig-hardening
>   - clang-nightly-lkftconfig-lto-full
>   - clang-nightly-lkftconfig-lto-thing
> 
>  clang-nightly: ERROR: modpost: "wcslen" [fs/smb/client/cifs.ko] undefined!
>   - https://lore.kernel.org/all/CA+G9fYuQHeGicnEx1d=XBC0p1LCsndi5q0p86V7pCZ02d8Fv_w@mail.gmail.com/
> 
> 3)
>  The clang-nightly boot regressions with no console output have been
>  reported on mainline and next.

These 2 I don't, as that's a mainline issue first.

thanks,

greg k-h

