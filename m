Return-Path: <linux-kselftest+bounces-45321-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37623C4EA24
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 15:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B3DB421EDC
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 14:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4A72DECBA;
	Tue, 11 Nov 2025 14:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4OG8LA68";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pyfFHjlF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9202D8764;
	Tue, 11 Nov 2025 14:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762872415; cv=none; b=b2bmBQnlFyrh632Lyhv6EDqLUJ7G06QTp7DGNnNVGxE+X9TdaXfe+z1nV+xA6G0nZ8Rigx1edfKlpLLLwOGYFK6bRQ9q3i96uDSuGhmVDwtCnN0rgCoMqo8CNDZfU7ODlkQ6RqMiY/XNsLwBet9QgtISnFTOsb4iP3R6uQ1tSLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762872415; c=relaxed/simple;
	bh=O4E/iAZKRmvEPxGaSV4Bn0dPxV2PQ+bmBY7iNdtoIF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P6KlhkEKYVtOqvZg6R2+hU6BwvKeAtD74KHPJiQkZ/KKjWZQufl+9NQ0KjqSbQdMxLK369lkbDrcjXeCwDrR7KQMKBQ2MLDBP44rO0XuEEuMdMKjvdu28Nc5sX8quRII8PgWTD+Vt90XcLxEfjkQR3fBUf7vcCpEX4VXfTUuRqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4OG8LA68; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pyfFHjlF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Nov 2025 15:46:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762872412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ink/2zFhF4AgFZbPd5svCQScsNMJvH6J0jtfx8HNJGE=;
	b=4OG8LA68GOK50k/Nqc9N+5L+YJpjceWl49FmNwliI10is+R37NShi38KXIRkejh1zt9c/y
	P85X4ewAS67oWB+ie6wXmx2VsuPseilesjJV8p4CMNr56nHDK+4OBWQvL0DE7Awg/DeQfx
	GxmMLLXKCAa1ELpYFZaWUmddXKFg7gZahq/Qly5fStADUKEjju0MjXk5R0mDxnkj0f4aQG
	zuDRuW8ZmIS0NdbjYZhnn+zEDJfcD7jBHzOas2A1BYGTNH83XALWnvsxi2P9IxA88DZjoo
	EiCd6oRBoTwlDxiFoVSYGEdsLCffsUNnfe1662HlGGSbRbhd49zKXFQg9OFAnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762872412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ink/2zFhF4AgFZbPd5svCQScsNMJvH6J0jtfx8HNJGE=;
	b=pyfFHjlF9adiqmQ/63LSqMO4Sd1oACx66oKOehD32GvlrZedV/QZ/svPdLOGRMWGn8i27h
	yrmp4qa9NDJ7lfAQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	shuah <shuah@kernel.org>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 04/10] selftests: vDSO: vdso_test_abi: Provide
 compatibility with 32-bit musl
Message-ID: <20251111153707-0926c681-0b2a-4cc0-9074-acbe8a6371c2@linutronix.de>
References: <20251111-vdso-test-types-v1-0-03b31f88c659@linutronix.de>
 <20251111-vdso-test-types-v1-4-03b31f88c659@linutronix.de>
 <29dd9e11-9ae8-415a-acb3-b96af56550b0@app.fastmail.com>
 <20251111144805-ab2781fe-5424-492b-9cb3-55ebaaedc199@linutronix.de>
 <a78a17eb-1df2-471b-9c28-64619c71dc54@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a78a17eb-1df2-471b-9c28-64619c71dc54@app.fastmail.com>

On Tue, Nov 11, 2025 at 03:19:00PM +0100, Arnd Bergmann wrote:
> On Tue, Nov 11, 2025, at 14:55, Thomas Weißschuh wrote:
> > On Tue, Nov 11, 2025 at 01:59:02PM +0100, Arnd Bergmann wrote:
> >> On Tue, Nov 11, 2025, at 11:49, Thomas Weißschuh wrote:
> >> > 
> >> > +#ifdef SYS_clock_getres
> >> >  	ret = syscall(SYS_clock_getres, clk_id, &sys_ts);
> >> > +#else
> >> > +	ret = syscall(SYS_clock_getres_time32, clk_id, &sys_ts);
> >> > +#endif
> >> > 
> >> 
> >> I think this #ifdef check is not reliable enough and may hide
> >> bugs. As with the other syscalls, the best way to call these
> >> is to either use __NR_clock_getres_time64 on __kernel_timespec, or
> >> to use __NR_clock_getres on __kernel_old_timespec.
> >
> > Could you give an example for such a bug?
> 
> If CONFIG_COMPAT_32BIT_TIME is disabled, 32-bit targets
> only provide clock_getres_time64, so using SYS_clock_getres
> may -ENOSYS.

Ok. That I am aware of. I expected something more subtle.

> Since SYS_clock_getres itself is provided by the libc implementation,
> I wouldn't trust that this actually means the same as __NR_clock_getres,
> and it might be set to __NR_clock_getres_time64.

Should that case not work anyways, as libc would also need to convert the
parameters transparently? But I'll switch it over to __NR instead.

> >> If we are trying to validate the interface here, we should probably
> >> call both if available. If we just want to know the result and
> >> trust that both work correctly, I'd always use __NR_clock_getres_time64
> >> on 32-bit systems and __NR_clock_getres on 64-bit systems.
> >
> > As these are vDSO and not timer selftests I think we trust the syscalls.
> > But how do we detect a native 64-bit time system? The preprocessor builtins
> > won't work as a 32-bit pointer system may use 64-bit time syscalls. I am not
> > aware of the UAPI #define, beyond the absence of __NR_clock_getres_time64.
> 
> I would just check __BITS_PER_LONG=32 and require a linux-5.6+ kernel
> at runtime to ensure the 64-bit calls are available.

That doesn't work for x32. It uses __BITS_PER_LONG but does not have
__NR_clock_getres_time64.


Thomas

