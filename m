Return-Path: <linux-kselftest+bounces-45214-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D46AEC45F66
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 11:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 778FF1881C7B
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 10:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DB0301474;
	Mon, 10 Nov 2025 10:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="WTAHFhLQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281D6268C40;
	Mon, 10 Nov 2025 10:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762771038; cv=none; b=F68jjMSfiV9bek5OkvHvnic76gtqRNiVlvgq90nNeWUpxAgsxLHGY21e2a46jG7hjxPZBOgu3H1RA24gXp23Cjk9kKoy3DRl+9KuiBVmOcfm0FVfEaYs4jHVZsvn/mn66QT56hjPwhqmI4dG9wmPdVFVJv7UZ5D+QBTo5gOWHB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762771038; c=relaxed/simple;
	bh=5mJ5SG0Gwip7t2njbKaSVt8yyYamxwQDSTZJ66MYxYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PpHQ3ZVTYc0Xuroqr4pUy6LyWTz1LTxzNAJBk+/mv9uNMpk8y8z2tvffO1ke8TrgY59aP6mjB1oDQ1EoOV9bSmmxtlDdizAVLEfi/undNfJJWXBvFAf0/VynblYuDyY91BJNMl9tQxj6fgve13vLgNUf0opaZf7anWMFeJl2Fmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=WTAHFhLQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E76C4CEF5;
	Mon, 10 Nov 2025 10:37:14 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="WTAHFhLQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1762771032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1WrguxH4pokigxxkQ8JIMem650725yeeLwdoGz6ziPQ=;
	b=WTAHFhLQBM9L4uVZANImYYYEpEwrJCJmpUsPeVS7opyWT3kewXLiJpB+S7cWvpyOqmRlk0
	jOvTCsms0UYDa7uYKl2FQdhRurOUoi+bCEX1pnKZador3BykkqFb6xAp1lo4cuCgYvgUtd
	mk8NOd2uY8oXx8TZ6HnEj3LlqXVn94g=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 190dbf96 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 10 Nov 2025 10:37:11 +0000 (UTC)
Date: Mon, 10 Nov 2025 11:37:07 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Nick Alcock <nick.alcock@oracle.com>,
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Shuah Khan <shuah@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
	Russell King <linux@armlinux.org.uk>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Shannon Nelson <sln@onemain.com>, linux-kernel@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH v5 19/34] random: vDSO: only access vDSO datapage after
 random_init()
Message-ID: <aRHAU7bVAIyaOrpA@zx2c4.com>
References: <20251106-vdso-sparc64-generic-2-v5-0-97ff2b6542f7@linutronix.de>
 <20251106-vdso-sparc64-generic-2-v5-19-97ff2b6542f7@linutronix.de>
 <aQ6EvdukQytvqK-u@zx2c4.com>
 <20251110094555-353883a9-1950-4cc6-a774-bb0ef5db11c5@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251110094555-353883a9-1950-4cc6-a774-bb0ef5db11c5@linutronix.de>

On Mon, Nov 10, 2025 at 10:04:17AM +0100, Thomas Weißschuh wrote:
> On Sat, Nov 08, 2025 at 12:46:05AM +0100, Jason A. Donenfeld wrote:
> > I'm not a huge fan of this change:
> > 
> > On Thu, Nov 06, 2025 at 11:02:12AM +0100, Thomas Weißschuh wrote:
> > > +static DEFINE_STATIC_KEY_FALSE(random_vdso_is_ready);
> > >  
> > >  /* Control how we warn userspace. */
> > >  static struct ratelimit_state urandom_warning =
> > > @@ -252,6 +253,9 @@ static void random_vdso_update_generation(unsigned long next_gen)
> > >  	if (!IS_ENABLED(CONFIG_VDSO_GETRANDOM))
> > >  		return;
> > >  
> > > +	if (!static_branch_likely(&random_vdso_is_ready))
> > > +		return;
> > > +
> > >  	/* base_crng.generation's invalid value is ULONG_MAX, while
> > >  	 * vdso_k_rng_data->generation's invalid value is 0, so add one to the
> > >  	 * former to arrive at the latter. Use smp_store_release so that this
> > > @@ -274,6 +278,9 @@ static void random_vdso_set_ready(void)
> > >  	if (!IS_ENABLED(CONFIG_VDSO_GETRANDOM))
> > >  		return;
> > >  
> > > +	if (!static_branch_likely(&random_vdso_is_ready))
> > > +		return;
> > > +
> > >  	WRITE_ONCE(vdso_k_rng_data->is_ready, true);
> > >  }
> > >  
> > > @@ -925,6 +932,9 @@ void __init random_init(void)
> > >  	_mix_pool_bytes(&entropy, sizeof(entropy));
> > >  	add_latent_entropy();
> > >  
> > > +	if (IS_ENABLED(CONFIG_VDSO_GETRANDOM))
> > > +		static_branch_enable(&random_vdso_is_ready);
> > > +
> > >  	/*
> > >  	 * If we were initialized by the cpu or bootloader before jump labels
> > >  	 * or workqueues are initialized, then we should enable the static
> > > @@ -934,8 +944,10 @@ void __init random_init(void)
> > >  		crng_set_ready(NULL);
> > >  
> > >  	/* Reseed if already seeded by earlier phases. */
> > > -	if (crng_ready())
> > > +	if (crng_ready()) {
> > >  		crng_reseed(NULL);
> > > +		random_vdso_set_ready();
> > > +	}
> > 
> > The fact that the vdso datapage is set up by the time random_init() is
> > called seems incredibly contingent on init details. Why not, instead,
> > make this a necessary part of the structure of vdso setup code, which
> > can actually know about what happens when?
> 
> The whole early init is "carefully" ordered in any case. I would have been
> happy to allocate the data pages before the random initialization, but the
> allocator is not yet usable by then.
> We could also make the ordering more visible by having the vDSO datastore call
> into a dedicated function to allow the random core to touch the data pages:
> random_vdso_enable_datapages().
> 
> > For example, one clean way of
> > doing that would be to make vdso_k_rng_data always valid by having it
> > initially point to __initdata memory, and then when it's time to
> > initialize the real datapage, memcpy() the __initdata memory to the new
> > specially allocated memory. Then we don't need the complex state
> > tracking that this commit and the prior one introduce.
> 
> Wouldn't that require synchronization between the update path and the memcpy()
> path? Also if the pointer is going to change at some point we'll probably need
> to use READ_ONCE()/WRITE_ONCE(). In general I would be happy about a cleaner
> solution for this but didn't find a great one.

This is still before userspace has started, and interrupts are disabled,
so I don't think so? Also, you only care about being after
mm_core_init(), right? So move your thing before sched_init() and then
you'll really have nothing to worry about.

But I think globally I agree with Andy/Arnd -- this is kind of ugly and
not worth it. Disable vDSO for these old CPUs with cache aliasing
issues.

Jason

