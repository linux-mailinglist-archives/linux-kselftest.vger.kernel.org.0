Return-Path: <linux-kselftest+bounces-45152-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F0DC42084
	for <lists+linux-kselftest@lfdr.de>; Sat, 08 Nov 2025 00:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BE2804E21FE
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 23:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8050C3081D7;
	Fri,  7 Nov 2025 23:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="YTujExV9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45687279917;
	Fri,  7 Nov 2025 23:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762559180; cv=none; b=Wxzwf1K+MHsR+dXP0lTENUcfCpclyYDMzw/THAYAhO6lqEtsiKIBZqES56srqrrhiusXxi9pG6cYMgeJaMiE89P5b+/idniVcdjSMeBD5swveq4v6E1fyrpGGp4egLadraRNRdp95/SA+TVztbBfZI4fCbimCX7as5uVVZwnRWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762559180; c=relaxed/simple;
	bh=K8HkLqrSqm3BPpuDnYJ0RdqRU6xjN20fn56q9ZX81cM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hHXDtOAtYgB7ESw4eGaA15zLzHyybwa7myTX8bVeo2Keuemn5v3S9dHFxr1q+8d2tPuArUv8CqiAreWO/R3p7RE7w61BPCgcnAhUPeV2aojdhHfbcA1IMSSVUpmKy3Ra5Ej6aPJyi0xMICwF2miwffwbRB51TUMKTH8WXiHuueg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=YTujExV9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29549C116C6;
	Fri,  7 Nov 2025 23:46:16 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="YTujExV9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1762559174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rOGbjEMvho9DWS0i3tlr01jp4bYqQwHxD0wdftLlPDk=;
	b=YTujExV99iq+x3/5TiVgxM3SNv/SNCs01cmQ8GL0Jpi/3NRgFfDths0Wd+AhJn/Zi+xdjz
	KJuL84DTYadQtc42UEd5WjaYhLFn9gbieg9iZN1PsrsuVKUou2TnnU4tSyt61zSLX6REJ4
	VbFmzErGcGRRuGr4NEC9WQjYO1r7QcQ=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a1e888cd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Nov 2025 23:46:13 +0000 (UTC)
Date: Sat, 8 Nov 2025 00:46:05 +0100
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
Message-ID: <aQ6EvdukQytvqK-u@zx2c4.com>
References: <20251106-vdso-sparc64-generic-2-v5-0-97ff2b6542f7@linutronix.de>
 <20251106-vdso-sparc64-generic-2-v5-19-97ff2b6542f7@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251106-vdso-sparc64-generic-2-v5-19-97ff2b6542f7@linutronix.de>

Hi Thomas,

I'm not a huge fan of this change:

On Thu, Nov 06, 2025 at 11:02:12AM +0100, Thomas Weißschuh wrote:
> +static DEFINE_STATIC_KEY_FALSE(random_vdso_is_ready);
>  
>  /* Control how we warn userspace. */
>  static struct ratelimit_state urandom_warning =
> @@ -252,6 +253,9 @@ static void random_vdso_update_generation(unsigned long next_gen)
>  	if (!IS_ENABLED(CONFIG_VDSO_GETRANDOM))
>  		return;
>  
> +	if (!static_branch_likely(&random_vdso_is_ready))
> +		return;
> +
>  	/* base_crng.generation's invalid value is ULONG_MAX, while
>  	 * vdso_k_rng_data->generation's invalid value is 0, so add one to the
>  	 * former to arrive at the latter. Use smp_store_release so that this
> @@ -274,6 +278,9 @@ static void random_vdso_set_ready(void)
>  	if (!IS_ENABLED(CONFIG_VDSO_GETRANDOM))
>  		return;
>  
> +	if (!static_branch_likely(&random_vdso_is_ready))
> +		return;
> +
>  	WRITE_ONCE(vdso_k_rng_data->is_ready, true);
>  }
>  
> @@ -925,6 +932,9 @@ void __init random_init(void)
>  	_mix_pool_bytes(&entropy, sizeof(entropy));
>  	add_latent_entropy();
>  
> +	if (IS_ENABLED(CONFIG_VDSO_GETRANDOM))
> +		static_branch_enable(&random_vdso_is_ready);
> +
>  	/*
>  	 * If we were initialized by the cpu or bootloader before jump labels
>  	 * or workqueues are initialized, then we should enable the static
> @@ -934,8 +944,10 @@ void __init random_init(void)
>  		crng_set_ready(NULL);
>  
>  	/* Reseed if already seeded by earlier phases. */
> -	if (crng_ready())
> +	if (crng_ready()) {
>  		crng_reseed(NULL);
> +		random_vdso_set_ready();
> +	}

The fact that the vdso datapage is set up by the time random_init() is
called seems incredibly contingent on init details. Why not, instead,
make this a necessary part of the structure of vdso setup code, which
can actually know about what happens when? For example, one clean way of
doing that would be to make vdso_k_rng_data always valid by having it
initially point to __initdata memory, and then when it's time to
initialize the real datapage, memcpy() the __initdata memory to the new
specially allocated memory. Then we don't need the complex state
tracking that this commit and the prior one introduce.

Jason

