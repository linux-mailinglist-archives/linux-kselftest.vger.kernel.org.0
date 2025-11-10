Return-Path: <linux-kselftest+bounces-45209-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6210FC45699
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 09:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FF2D188FAC1
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 08:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBED2FC891;
	Mon, 10 Nov 2025 08:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zc0jjKjA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dKrT84Jk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955DF2EBBB2;
	Mon, 10 Nov 2025 08:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762764356; cv=none; b=NnQg8wen6ThHXqzAYSSDTwY/j0xdevej4KkMSpYsyEENk+wowthL2mSTURrb9q62OWJqSVR5wYcjtjR4+A6VXpjbFzGTx9rn6gofp3qWTvr7TIW9nsLxSZZd4C4LbTJCv8J4L6edWTqUmaSi9OD34wAoFsYKaKpg+k1PAYloO1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762764356; c=relaxed/simple;
	bh=qFxHyINETSyVLE4+guZZc0myjQ3B+ECx4XBF2wKcF+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbWN5oSE/H5o9/wXKrSeOuVsIFHjIeyYCmebmCQTihS4kCHUdx9WmzwsqRmYMhzNl7JSWN+yo8hz1gG0mjgXTVvjKDZoKvOq85MOWvZcmTYMjJeFdEFx03vihO1IokIpQhkEGRHCBTA5I3WKp1tyrNoPwjGeHQ4JTq3tj0V0AO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zc0jjKjA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dKrT84Jk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 10 Nov 2025 09:45:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762764350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bsLI0Nxueu9BHgoGhAQAGzoBni2o++loH1n4XsHhDVo=;
	b=zc0jjKjAsp0YnhtHKw7eM1+liJCO5iSx7CCFd73BS2XJvvlXwflG1NFICzbDNPrMliB1Zz
	z9oijqTWuNr9uWvpbtAZJfvjFOWQZE3AFkPNDdET/ElQz/Xv3oLQmA/M6PJ/hhmHAX6Cpy
	Iay9FeMMRFmSX+WRkJbz/WiJ+lqtk6zlCxe5YYD/aR+0JWiaTbiZdKvflk/K+zTAKAHRyh
	iNT7oqeaQjzbbX4GfH8HcmR7cfsveFd4GJFxHPGpcHUVJs+ns0T1guWntAt+nL8WuHcQAH
	YY2YP6EklQ3einkrNDniOoe3mo7Bw4HTblfZNZoJk+qiWUqrtmRZ9kBC4KKy5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762764350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bsLI0Nxueu9BHgoGhAQAGzoBni2o++loH1n4XsHhDVo=;
	b=dKrT84JkcQPBJNqu6XZmJfzmvsjkLpa1AvSOPwrcdFwP4VawI33FMJzCLV+t2ZRC2Nv2Nq
	0e6oPX/MtzX04lDw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Nick Alcock <nick.alcock@oracle.com>, 
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Shuah Khan <shuah@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
	Russell King <linux@armlinux.org.uk>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Shannon Nelson <sln@onemain.com>, linux-kernel@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v5 17/34] random: vDSO: remove ifdeffery
Message-ID: <20251110094145-462671cc-1f51-466a-b448-3dc541e764ca@linutronix.de>
References: <20251106-vdso-sparc64-generic-2-v5-0-97ff2b6542f7@linutronix.de>
 <20251106-vdso-sparc64-generic-2-v5-17-97ff2b6542f7@linutronix.de>
 <aQ6Cq_5kiIXllEoS@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQ6Cq_5kiIXllEoS@zx2c4.com>

On Sat, Nov 08, 2025 at 12:37:15AM +0100, Jason A. Donenfeld wrote:
> On Thu, Nov 06, 2025 at 11:02:10AM +0100, Thomas Weißschuh wrote:
> > -#endif
> > +	if (IS_ENABLED(CONFIG_VDSO_GETRANDOM))
> > +		smp_store_release((unsigned long *)&vdso_k_rng_data->generation, next_gen + 1);
> > +
> 
> This is possible because vdso_k_rng_data is now defined in the C source
> on all platforms and under all configurations, even if
> !CONFIG_VDSO_GETRANDOM means it's null? Whereas before, some config's
> headers didn't have this at all, so the #ifdef was necessary?

This is possible because vdso/datapage.h is now included unconditionally.
(Which was made possible by the previous cleanup patches in this series)
vdso_k_rng_data is only defined if CONFIG_VDSO_GETRANDOM=y but declared
unconditionally. If CONFIG_VDSO_GETRANDOM=n all references to the symbol
are optimized away by the compiler before the linker is invoked, so no
unresolved references are created.

> If so, can you mention this in the commit message?

Will do.


Thomas

