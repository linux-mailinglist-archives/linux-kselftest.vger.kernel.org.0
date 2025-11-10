Return-Path: <linux-kselftest+bounces-45217-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C2207C463B1
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 12:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 030834EAFEC
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 11:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA8C30DEA0;
	Mon, 10 Nov 2025 11:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DXEFd4Uj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OGD8oKbf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C2530CD8E;
	Mon, 10 Nov 2025 11:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762773857; cv=none; b=Ml18Jx3OJG+//QhG750oH4FY2rM2EYLk0FcVp3wBdqO50m4ErobJQcw/mYbco7hiTb6xnsWzT+sz1NvLAeVnok3zIHBVY4UAS0zNi+KFY4hVgUEEu96VZLd8iBScoSmzlqpS1VOrgzOH74GhaC3Y+4+UofskvbZxjDHRngQDQhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762773857; c=relaxed/simple;
	bh=t7oYPr0nA5k7sctEhM/hJB7ljC3f9ZRuI/DqK+KCKaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ntL+VskuwEBFCIr34zs3aJT5s8Shp2Ek29miaXvQ6atdXy6NxgZBi5kbrqh55n9QyRgmdhaXHLUfUESmI6kOP8eEFBH0P03INARw/cTUW+nLQ//xkfi7nnIRJHQMIDQpqbgOo7z1yQ4HbNZphWSmlpRDuZ+GlTM5mX9pc/ffLZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DXEFd4Uj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OGD8oKbf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 10 Nov 2025 12:24:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762773853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p96pAwq/VC3UfPWRsm0wtdyMQb6nexxAkpfro+m18b4=;
	b=DXEFd4UjN9Qd6hW+g2n27mHddszaRAS18B/aA/XIVGLJc2KTiyMZLtg5QqpWMb8uU/H3B9
	KxnWzKfryNbO05muzqQ3EH/Qy5Ex39fIt9aYPvZwzk7tYaYM0Ga4rAGfDqmWVm/ijDiqJe
	UreuQgu+ljTfyt03fyLMCP2q72vQK65Yg3bTwRjrhywPiUNs3bonCC/dovrLW3yrxbzRLi
	SEetB1OBIOrzMR9Pm7BKtsFVVl7zaT8kZoGkXTgYkXKJlzu5u5qpoGroxIRpsPxffobOnp
	2wiRdJptvgJPn1+5yi2wq0KxIAFgq0y5/TLYt4qlSVLaw1erJhuu6jtNQWRfXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762773853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p96pAwq/VC3UfPWRsm0wtdyMQb6nexxAkpfro+m18b4=;
	b=OGD8oKbfgNkv/Z96N3ixFCGRB4K/UzZRB9Pseb2rl8K66Ye5pHYKSiQNyZcS40WSC4Ian5
	duIbPgXrooL+qfDQ==
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
Message-ID: <20251110114550-a3f2afa8-4f86-4048-be5b-2dc4f4ef340d@linutronix.de>
References: <20251106-vdso-sparc64-generic-2-v5-0-97ff2b6542f7@linutronix.de>
 <20251106-vdso-sparc64-generic-2-v5-19-97ff2b6542f7@linutronix.de>
 <aQ6EvdukQytvqK-u@zx2c4.com>
 <20251110094555-353883a9-1950-4cc6-a774-bb0ef5db11c5@linutronix.de>
 <aRHAU7bVAIyaOrpA@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aRHAU7bVAIyaOrpA@zx2c4.com>

On Mon, Nov 10, 2025 at 11:37:07AM +0100, Jason A. Donenfeld wrote:
> On Mon, Nov 10, 2025 at 10:04:17AM +0100, Thomas Weißschuh wrote:
> > On Sat, Nov 08, 2025 at 12:46:05AM +0100, Jason A. Donenfeld wrote:
> > > I'm not a huge fan of this change:
> > > 
> > > On Thu, Nov 06, 2025 at 11:02:12AM +0100, Thomas Weißschuh wrote:
> > > > +static DEFINE_STATIC_KEY_FALSE(random_vdso_is_ready);
> > > >  
> > > >  /* Control how we warn userspace. */
> > > >  static struct ratelimit_state urandom_warning =
> > > > @@ -252,6 +253,9 @@ static void random_vdso_update_generation(unsigned long next_gen)
> > > >  	if (!IS_ENABLED(CONFIG_VDSO_GETRANDOM))
> > > >  		return;
> > > >  
> > > > +	if (!static_branch_likely(&random_vdso_is_ready))
> > > > +		return;
> > > > +
> > > >  	/* base_crng.generation's invalid value is ULONG_MAX, while
> > > >  	 * vdso_k_rng_data->generation's invalid value is 0, so add one to the
> > > >  	 * former to arrive at the latter. Use smp_store_release so that this
> > > > @@ -274,6 +278,9 @@ static void random_vdso_set_ready(void)
> > > >  	if (!IS_ENABLED(CONFIG_VDSO_GETRANDOM))
> > > >  		return;
> > > >  
> > > > +	if (!static_branch_likely(&random_vdso_is_ready))
> > > > +		return;
> > > > +
> > > >  	WRITE_ONCE(vdso_k_rng_data->is_ready, true);
> > > >  }
> > > >  
> > > > @@ -925,6 +932,9 @@ void __init random_init(void)
> > > >  	_mix_pool_bytes(&entropy, sizeof(entropy));
> > > >  	add_latent_entropy();
> > > >  
> > > > +	if (IS_ENABLED(CONFIG_VDSO_GETRANDOM))
> > > > +		static_branch_enable(&random_vdso_is_ready);
> > > > +
> > > >  	/*
> > > >  	 * If we were initialized by the cpu or bootloader before jump labels
> > > >  	 * or workqueues are initialized, then we should enable the static
> > > > @@ -934,8 +944,10 @@ void __init random_init(void)
> > > >  		crng_set_ready(NULL);
> > > >  
> > > >  	/* Reseed if already seeded by earlier phases. */
> > > > -	if (crng_ready())
> > > > +	if (crng_ready()) {
> > > >  		crng_reseed(NULL);
> > > > +		random_vdso_set_ready();
> > > > +	}
> > > 
> > > The fact that the vdso datapage is set up by the time random_init() is
> > > called seems incredibly contingent on init details. Why not, instead,
> > > make this a necessary part of the structure of vdso setup code, which
> > > can actually know about what happens when?
> > 
> > The whole early init is "carefully" ordered in any case. I would have been
> > happy to allocate the data pages before the random initialization, but the
> > allocator is not yet usable by then.
> > We could also make the ordering more visible by having the vDSO datastore call
> > into a dedicated function to allow the random core to touch the data pages:
> > random_vdso_enable_datapages().
> > 
> > > For example, one clean way of
> > > doing that would be to make vdso_k_rng_data always valid by having it
> > > initially point to __initdata memory, and then when it's time to
> > > initialize the real datapage, memcpy() the __initdata memory to the new
> > > specially allocated memory. Then we don't need the complex state
> > > tracking that this commit and the prior one introduce.
> > 
> > Wouldn't that require synchronization between the update path and the memcpy()
> > path? Also if the pointer is going to change at some point we'll probably need
> > to use READ_ONCE()/WRITE_ONCE(). In general I would be happy about a cleaner
> > solution for this but didn't find a great one.
> 
> This is still before userspace has started, and interrupts are disabled,
> so I don't think so?

Interrupts being disabled is a good point. But we are still leaking
implementation details from the random code into the vdso datastore.

> Also, you only care about being after
> mm_core_init(), right? So move your thing before sched_init() and then
> you'll really have nothing to worry about.

The callchains random_init_early() -> crng_reseed()/_credit_init_bits() could
still touch the datapage before it is allocated.
Adding conditionals to prevent those is essentially what my patch does.

> But I think globally I agree with Andy/Arnd -- this is kind of ugly and
> not worth it. Disable vDSO for these old CPUs with cache aliasing
> issues.

(I obviously still need to properly respond to Andy and Arnd)

The dynamic allocation does more.
1) It is a preparation for mlockall() for the datapages [0].
2) On the SPARC T4 Niagara this was tested on, the MMU would send an exception,
if userspace accessed the mapped kernel .data page. Even compensating for dcache
aliasing did not prevent this, so that is not the reason. It is not clear why
it happens. At some point I gave up investigating as point 1) would still hold
true.

[0] https://lore.kernel.org/lkml/20250901-vdso-mlockall-v2-0-68f5a6f03345@linutronix.de/
    (This revision used 'struct page' with .data memory, but that doesn't
    actually work everywhere)


Thomas

