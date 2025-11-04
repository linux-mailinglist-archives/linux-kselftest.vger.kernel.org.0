Return-Path: <linux-kselftest+bounces-44721-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E662BC31E6F
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 16:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B281F424CF6
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 15:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CAF2FB619;
	Tue,  4 Nov 2025 15:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rjbrvle2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FojQgXp5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B3C2D29C7;
	Tue,  4 Nov 2025 15:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762271023; cv=none; b=Y/Y4lewkevxOhzv6+HMjbwDEslplqnURklodDzYu4r/5F0GDkkxsu+HSU/KDfd38hgYZMn+jlshTlU+5624LsDpA5E9YGEP04kXRbfGu3CYoM83/Z7lHk7eF6S5rVhmWwkgZsFMVMA4D7M7PVGMP0Vg6DNv3C31rFIDV0d8l/qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762271023; c=relaxed/simple;
	bh=KLrPQSaIQNrnjth1rrMVwNhWXm2E0ayWA44G954ZxC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+C224NIQ742598UMpcbVsNy+FS3HumGTiN5yvlwZAKRx5YtiRGTu4bETgoA9aWiX6iebd7DeY5wRRQHDLzqpfNO9qdnYt1flNqQPI1jisJ1tVHXqvUpM0JLt6fPvbj2pbW+wm6qZ3SyZJyNsZ/sMbsIBZpNX6G6uLOFO7kud1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rjbrvle2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FojQgXp5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 4 Nov 2025 16:43:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762271019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6/0fonC1CcSFJ/vzCGw398TxXXxzhqjx7ZhCqclZhJI=;
	b=rjbrvle2cRAQ2r1/E6AUyn/63AoNirT+MeY3CSkMLQkjVu4MZ9i9gsM5VaY1sb3+Qse+3E
	k5Tsj3k0sX10MaW1Vt77Ml/iwrO90sXCi7ohIUnxBp8RCfq2diJY/ZCpc3gLIELLZkZ1gT
	L/BTyFm2ieNoLfdbPm3joETfalKC7jCYGiBCKDuN65AUEULDiusUD1wLGQDHRp47rNGPSE
	CNiRZhbWp4pKi5KAc4rKlwVrMeyIJALch4gPPlEKog+++hdtB+pAyXWGyDy2/FQb1lBsmj
	YmFrBOIEWYHsmogSRF3LDckjk1IVIHNKXQ3GxfoNtiFlAXBk/A7zx0VxilqApg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762271019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6/0fonC1CcSFJ/vzCGw398TxXXxzhqjx7ZhCqclZhJI=;
	b=FojQgXp5lZ7JuVC/TErfcQFIVgMu5YQg1OclEVtlB2s1//ebKD9BRtli3pju35zYRju4WW
	6T9NeyF0VG7+qZCA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Mark Brown <broonie@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Nick Alcock <nick.alcock@oracle.com>, 
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Shuah Khan <shuah@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, Russell King <linux@armlinux.org.uk>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>, Shannon Nelson <sln@onemain.com>, linux-kernel@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-s390@vger.kernel.org, Aishwarya.TCV@arm.com
Subject: Re: [PATCH v4 23/35] vdso/datastore: Map pages through struct page
Message-ID: <20251104162009-8cffa62d-e95b-466b-9a27-c51b0f5257cd@linutronix.de>
References: <20251014-vdso-sparc64-generic-2-v4-0-e0607bf49dea@linutronix.de>
 <20251014-vdso-sparc64-generic-2-v4-23-e0607bf49dea@linutronix.de>
 <aQjJNmwniQwwjeBR@finisterre.sirena.org.uk>
 <CGME20251104084442eucas1p2af1bd88393f4d6a532df1cd41f32a287@eucas1p2.samsung.com>
 <e7f05748-a11c-47eb-b1fa-cdc9dc6d05e0@samsung.com>
 <aQn8G9r2OWv_yEQp@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQn8G9r2OWv_yEQp@finisterre.sirena.org.uk>

On Tue, Nov 04, 2025 at 01:14:03PM +0000, Mark Brown wrote:
> On Tue, Nov 04, 2025 at 09:44:38AM +0100, Marek Szyprowski wrote:
> > On 03.11.2025 16:24, Mark Brown wrote:
> 
> > > We do have some other serious breakage affecting arm64 in -next which
> > > are making it hard to get a clear picture of which platforms are
> > > affected, at least the FVP and O6 are unaffected by those other issues
> > > (due to using MTE on platforms that don't have it, those platforms do
> > > have MTE).
> 
> > I got almost the same result while bisecting on ARM 32bit Exynos-based 
> > boards, so the issue with this patchset is not fully ARM64 specific. For 
> > some reasons it also doesn't affect all systems though. It is even 
> > worse, because it affected only a subset of boards, but different for 
> > each tested commit. The observed failure looks exactly the same:
> 
> I've now got the results for this specific commit, it looks like every
> single arm64 system is failing.  I didn't test any other architectures.

Which one do you mean exactly with "this specific commit"?

6a011a228293 ("vdso/datastore: Map pages through struct page")
10d91dac2ea5 ("vdso/datastore: Allocate data pages dynamically")

> > Then I've tested it on ARM64bit (RaspberrryPi3b+ board) and got the 
> > following panic on 6a011a228293 ("vdso/datastore: Map pages through 
> > struct page") commit:
> 
> I'm seeing the same thing on at least some of the systems - this is with
> arm64 defconfig (I suspect that's what Marek is doing too).  For
> example:

I can now reproduce this issue, too. Even on QEMU. But it goes away,
as soon as the second commit is applied. The two commits should be merged.
That could also explain the weird bisection results, landing on either one
of the commits. However I can't reproduce the "silent freeze" issue on commit
10d91dac2ea5 ("vdso/datastore: Allocate data pages dynamically") on my
Raspberry Pi 3b+.

Any chance I could get remote access to one of your test machines?
I don't have access to the exact machines and that should reduce the chance
of chasing down dead ends.


Thomas

