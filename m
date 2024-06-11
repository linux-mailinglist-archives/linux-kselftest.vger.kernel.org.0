Return-Path: <linux-kselftest+bounces-11666-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AC9903707
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 10:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED46C1C23215
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 08:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B3017555C;
	Tue, 11 Jun 2024 08:50:31 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1FA174EEB;
	Tue, 11 Jun 2024 08:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718095831; cv=none; b=hftt5o8OoXxG0wRv+b4a2GsF8RMjDSgffuOyscDRNOrUGtLBm30S80K26QiLZjxKcIFTcOCs5+tuRWvRFCmxpMfJlmcmteY0noWb82bpOg05qAMzhGe/VdV2tLS3IyS89CPmOUmsHeS0+yZWNbmevkns0tPIVXlSjYFrhW1osz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718095831; c=relaxed/simple;
	bh=Tz0c5VcTfHJlV2uX+Q+nERoAMIrZpPDtHjcTjqCCVNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQRRWfFz6L6s0kLyXKc9BmOMdc47vbR+qybGa8fJTsQbdvLRzy7RxSXmVwswpODEt94iXHqHqRFdD2IOd+00usbny3R70LO5Gflv8ldR2vzTLN5QMj63v563YOSiO3dlfi8CdqENGjh0e5ir2xN/b8/j24WvDh7M6brRmsT2CLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1sGxBT-0000Ne-00; Tue, 11 Jun 2024 10:48:51 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 023C9C0120; Tue, 11 Jun 2024 10:41:16 +0200 (CEST)
Date: Tue, 11 Jun 2024 10:41:16 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Celeste Liu <coelacanthushex@gmail.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
	Anup Patel <anup@brainfault.org>, Guo Ren <guoren@kernel.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
	Sven Joachim <svenjoac@gmx.de>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Tony Lindgren <tony@atomide.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Arnd Bergmann <arnd@arndb.de>, Mykola Lysenko <mykolal@fb.com>,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
	linux-tegra@vger.kernel.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org, linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lennart Poettering <lennart@poettering.net>,
	Icenowy Zheng <uwu@icenowy.me>
Subject: Re: [PATCH 3/6] mips: defconfig: drop RT_GROUP_SCHED=y from
 generic/db1xxx/eyeq5
Message-ID: <ZmgNrOr1nalSTeja@alpha.franken.de>
References: <20240530111947.549474-8-CoelacanthusHex@gmail.com>
 <20240530111947.549474-11-CoelacanthusHex@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530111947.549474-11-CoelacanthusHex@gmail.com>

On Thu, May 30, 2024 at 07:19:51PM +0800, Celeste Liu wrote:
> For cgroup v1, if turned on, and there's any cgroup in the "cpu" hierarchy it
> needs an RT budget assigned, otherwise the processes in it will not be able to
> get RT at all. The problem with RT group scheduling is that it requires the
> budget assigned but there's no way we could assign a default budget, since the
> values to assign are both upper and lower time limits, are absolute, and need to
> be sum up to < 1 for each individal cgroup. That means we cannot really come up
> with values that would work by default in the general case.[1]
> 
> For cgroup v2, it's almost unusable as well. If it turned on, the cpu controller
> can only be enabled when all RT processes are in the root cgroup. But it will
> lose the benefits of cgroup v2 if all RT process were placed in the same cgroup.
> 
> Red Hat, Gentoo, Arch Linux and Debian all disable it. systemd also doesn't
> support it.[2]
> 
> [1]: https://bugzilla.redhat.com/show_bug.cgi?id=1229700
> [2]: https://github.com/systemd/systemd/issues/13781#issuecomment-549164383
> 
> Signed-off-by: Celeste Liu <CoelacanthusHex@gmail.com>
> ---
>  arch/mips/configs/db1xxx_defconfig  | 1 -
>  arch/mips/configs/eyeq5_defconfig   | 1 -
>  arch/mips/configs/generic_defconfig | 1 -
>  3 files changed, 3 deletions(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

