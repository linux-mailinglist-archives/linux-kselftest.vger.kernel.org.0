Return-Path: <linux-kselftest+bounces-45210-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA9CC4582C
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 10:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1ABA3B5FA7
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 09:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0CA2FE045;
	Mon, 10 Nov 2025 09:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="THzC1+oh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+Nqx/ogP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73EE2FDC22;
	Mon, 10 Nov 2025 09:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762765462; cv=none; b=kZi9NBOupBlPf+vJqK/yY91af2kiDUK+ZOjncdmRcUNtJaBNz3AncwBW3SYaxp1XLuAsVWO1nZoE5XwGqpevSkQJ/2Uovqgwb2+d3du+1TndNneDChtQC37EaB1OCH1atUnz2JK6kSljZOqAF5u1bn2GhT42fvuhNMzOS6PivCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762765462; c=relaxed/simple;
	bh=3ydwZExzPTVL5H7Bph6AACoiEJH6uJ/+bxisIogOO3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsXUHOUB8IsIFDRLnWsIbLHhs12NfFoQqC4bjGeulFdyrga0EKK7Pz9QLFbWRBcuGSWWnPE1KMo/l8Rp2i6c43dWVjnN7u66iS8IZQEkuUgYJCTLjRtko6OeVPW+m50gCeiAzgie0/wUfehbnE0a8lA53IOoGPSrGQYzJvXosLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=THzC1+oh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+Nqx/ogP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 10 Nov 2025 10:04:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762765458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t7Guwo0wpxf95Dj+W5UROJyXFGtl7LdcWRhhh/Qf98U=;
	b=THzC1+ohs7W95eY6RMSRaFJ23VdVBGm5I563I8YASdM00wmofpB9awW1xssuqstq1G4GN9
	sOp/H73rX5A8lDzddsuk8aEuXZEoY8VatUS8uqdA4P1QwSycvK5U5xYCvCQW9Q155hvtp3
	7ckU266rRRDn0XAp4JFw8QggWtZsAdOzRHV27wCZCUOuJXVoY4kNpRUGWB5Gkn9W3A+Nid
	ZNdYJVGJc5HIjFvYZ80gZ8VPKbKpROUhWLEJnGJX/MlPmmtBKOsGsmRMNFy48oFYgIc0zU
	W+Yiule8nXEF4YfdxOus7DWnvJkK4zQXI2Nc/NhrrTfeic27du8bXWM6BV1vSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762765458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t7Guwo0wpxf95Dj+W5UROJyXFGtl7LdcWRhhh/Qf98U=;
	b=+Nqx/ogPinQ4vfSfKxwtwM9MURpLI4OvfJJe18bf22Qbmt21zd133O7NoOhjUAYH62UQVr
	zbqasc8HiwXrEsDA==
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
Subject: Re: [PATCH v5 19/34] random: vDSO: only access vDSO datapage after
 random_init()
Message-ID: <20251110094555-353883a9-1950-4cc6-a774-bb0ef5db11c5@linutronix.de>
References: <20251106-vdso-sparc64-generic-2-v5-0-97ff2b6542f7@linutronix.de>
 <20251106-vdso-sparc64-generic-2-v5-19-97ff2b6542f7@linutronix.de>
 <aQ6EvdukQytvqK-u@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQ6EvdukQytvqK-u@zx2c4.com>

On Sat, Nov 08, 2025 at 12:46:05AM +0100, Jason A. Donenfeld wrote:
> I'm not a huge fan of this change:
> 
> On Thu, Nov 06, 2025 at 11:02:12AM +0100, Thomas Weißschuh wrote:
> > +static DEFINE_STATIC_KEY_FALSE(random_vdso_is_ready);
> >  
> >  /* Control how we warn userspace. */
> >  static struct ratelimit_state urandom_warning =
> > @@ -252,6 +253,9 @@ static void random_vdso_update_generation(unsigned long next_gen)
> >  	if (!IS_ENABLED(CONFIG_VDSO_GETRANDOM))
> >  		return;
> >  
> > +	if (!static_branch_likely(&random_vdso_is_ready))
> > +		return;
> > +
> >  	/* base_crng.generation's invalid value is ULONG_MAX, while
> >  	 * vdso_k_rng_data->generation's invalid value is 0, so add one to the
> >  	 * former to arrive at the latter. Use smp_store_release so that this
> > @@ -274,6 +278,9 @@ static void random_vdso_set_ready(void)
> >  	if (!IS_ENABLED(CONFIG_VDSO_GETRANDOM))
> >  		return;
> >  
> > +	if (!static_branch_likely(&random_vdso_is_ready))
> > +		return;
> > +
> >  	WRITE_ONCE(vdso_k_rng_data->is_ready, true);
> >  }
> >  
> > @@ -925,6 +932,9 @@ void __init random_init(void)
> >  	_mix_pool_bytes(&entropy, sizeof(entropy));
> >  	add_latent_entropy();
> >  
> > +	if (IS_ENABLED(CONFIG_VDSO_GETRANDOM))
> > +		static_branch_enable(&random_vdso_is_ready);
> > +
> >  	/*
> >  	 * If we were initialized by the cpu or bootloader before jump labels
> >  	 * or workqueues are initialized, then we should enable the static
> > @@ -934,8 +944,10 @@ void __init random_init(void)
> >  		crng_set_ready(NULL);
> >  
> >  	/* Reseed if already seeded by earlier phases. */
> > -	if (crng_ready())
> > +	if (crng_ready()) {
> >  		crng_reseed(NULL);
> > +		random_vdso_set_ready();
> > +	}
> 
> The fact that the vdso datapage is set up by the time random_init() is
> called seems incredibly contingent on init details. Why not, instead,
> make this a necessary part of the structure of vdso setup code, which
> can actually know about what happens when?

The whole early init is "carefully" ordered in any case. I would have been
happy to allocate the data pages before the random initialization, but the
allocator is not yet usable by then.
We could also make the ordering more visible by having the vDSO datastore call
into a dedicated function to allow the random core to touch the data pages:
random_vdso_enable_datapages().

> For example, one clean way of
> doing that would be to make vdso_k_rng_data always valid by having it
> initially point to __initdata memory, and then when it's time to
> initialize the real datapage, memcpy() the __initdata memory to the new
> specially allocated memory. Then we don't need the complex state
> tracking that this commit and the prior one introduce.

Wouldn't that require synchronization between the update path and the memcpy()
path? Also if the pointer is going to change at some point we'll probably need
to use READ_ONCE()/WRITE_ONCE(). In general I would be happy about a cleaner
solution for this but didn't find a great one.


Thomas

