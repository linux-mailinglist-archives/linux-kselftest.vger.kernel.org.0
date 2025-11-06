Return-Path: <linux-kselftest+bounces-44966-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D6BC3B411
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 14:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9CED18C6230
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 13:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1219433030F;
	Thu,  6 Nov 2025 13:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XS5vcpYs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h2lJfuFW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A5732E12D;
	Thu,  6 Nov 2025 13:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762435979; cv=none; b=OBpLS96RpvkqjOhXWvc/oZvf0IjlYcwUhbL8oygPinimxLsgdUS8EEwqROHRs/szz2pwWbmIg+wpsD67rXqEXpoDOWKLs+rc0e2q1GY1MoZehYXpKLqLBamuzIPY/CrlQQdIu7dSWFMLhHn2C8+n7Lm9c6L9x5gQ7yCkGtbOhbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762435979; c=relaxed/simple;
	bh=a374VVWaxC27mGZUUgLz3RDFKVy2utZLTDieDEyO4XQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/vSqeolgpjqmIwxx6YboyIWzSacktmS0q0agQLeHd1Vjgbkh87IDweIZClzMR2r0erMzy2HAQz0AS9Z9G+FP8TvkiPBO3xuSX5iGLpjos6B2cgUZwhtk3tL7bg7TrLwrRQ3x61tIfXAxjaZX6AZ64aVEJfhASlfsGdGSqjz7IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XS5vcpYs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h2lJfuFW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 6 Nov 2025 14:32:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762435976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/sYkiyBWZv/gdDO2SH4rhBeTgqDXK9+UcXf3Mn8ccUU=;
	b=XS5vcpYsyAxNvRXOzuV5hRb/nQgFMLuPJMVo17+GbZKgOVszq7TxXwgPILyevsEeD41fRn
	qOecx6vaBm+bot7gT0OvheUUOzSI/pCShMR7tGzNjWpRHVrPUfjroThu/dYpXsZWlxaEeV
	xJ5xEAUZvXg5zU2IycYwgMGtSJLdOOxj/L6FphMysTTnqID+uvpkGIepHgdU3dYJMYHK0D
	NqmpgjE3ZZBGM791NCYCLB4PlFTInSDtb+xizEDEsMjUL1/vQ2L3uOAXQyBpRCYcmc1FsI
	2+nm2NpDf8vOD6oEAqJpBSUip2moNPpLvHwoBacGawqj3f0ZCv3Emz/VsYjdKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762435976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/sYkiyBWZv/gdDO2SH4rhBeTgqDXK9+UcXf3Mn8ccUU=;
	b=h2lJfuFW33gCMREswtFH2osl5Sj9f2XsBF94AxG8++SjialvXzh6EqV+QL44v58SNQ52NN
	ToDU5p9Dbx2lwbCA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Nick Alcock <nick.alcock@oracle.com>, John Stultz <jstultz@google.com>, 
	Stephen Boyd <sboyd@kernel.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Shuah Khan <shuah@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
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
	linux-mips@vger.kernel.org, linux-s390@vger.kernel.org, Aishwarya.TCV@arm.com, 
	Ryan.Roberts@arm.com
Subject: Re: [PATCH v4 23/35] vdso/datastore: Map pages through struct page
Message-ID: <20251106142956-d6251eba-c696-4a2f-a3e3-af461530d932@linutronix.de>
References: <20251014-vdso-sparc64-generic-2-v4-0-e0607bf49dea@linutronix.de>
 <20251014-vdso-sparc64-generic-2-v4-23-e0607bf49dea@linutronix.de>
 <aQjJNmwniQwwjeBR@finisterre.sirena.org.uk>
 <CGME20251104084442eucas1p2af1bd88393f4d6a532df1cd41f32a287@eucas1p2.samsung.com>
 <e7f05748-a11c-47eb-b1fa-cdc9dc6d05e0@samsung.com>
 <aQyig5TNkw2YJm19@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQyig5TNkw2YJm19@finisterre.sirena.org.uk>

Hi Mark,

On Thu, Nov 06, 2025 at 01:28:35PM +0000, Mark Brown wrote:
> On Tue, Nov 04, 2025 at 09:44:38AM +0100, Marek Szyprowski wrote:
> > On 03.11.2025 16:24, Mark Brown wrote:
> > > On Tue, Oct 14, 2025 at 08:49:09AM +0200, Thomas Weißschuh wrote:
> 
> Copying in Ryan Roberts who's much more likely to have some idea about
> memory management stuff for arm64 than I am (I have been poking at this
> a bit but not got anywhere notable).  Not deleting context for his
> benefit.

It turned out not even to be an mm problem.
Instead the data pages were not zeroed out on allocation.

> Given that this issue is very disruptive to userspace it's causing us to
> miss huge amounts of test coverage for -next, would it be possible to
> drop these patches until we resolve the issue?

This issue and the observed panics should be fixed in v5 of the series:
https://lore.kernel.org/lkml/20251106-vdso-sparc64-generic-2-v5-0-97ff2b6542f7@linutronix.de/

I'll ping tglx directly.

(...)


Thomas

