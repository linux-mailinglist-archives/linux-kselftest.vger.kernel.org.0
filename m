Return-Path: <linux-kselftest+bounces-45331-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6E8C4EDF4
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 16:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4DAD64F3F51
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 15:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A0F36B04B;
	Tue, 11 Nov 2025 15:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nHjWJIRc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zgv3Vjkd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F1A36999B;
	Tue, 11 Nov 2025 15:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762876213; cv=none; b=kB1SXs/+k4f4UbmKAWPgd7KQCLX3aCWBf01dioEu/d7rNDYjVrpwDGceon+RIFYQ2eS+rdbSlNM8OpQzbg12nBHvX4t+qbXb9b1Wyk+e3ekU30d1egdamjhiYmO/a8rlqIPqQ8VnOC2G8ije0sUmMJGdthI6tb+z2i0k6YrdSoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762876213; c=relaxed/simple;
	bh=BMJlNwmMTdtSKwoaSfO/WddlNnAXuvgL81pj3zevl7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGSauOsn7qteCR0s1saArOHranzXaUnZ9FO4dSzFpKjdtOR+0OhBrlFxHYEIx3Mq1H12Nj1MaKjEfgWrnjHfXrpdxi4wbaG2vKISCvqxrPh+4S1FlsTyVXjO0b5WH/omC+k0+EoV0ChCo0LAEuw5Qr8EcJnocIS3v5HpASql7LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nHjWJIRc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zgv3Vjkd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Nov 2025 16:50:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762876209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mz8HgiX8mpfnq1sd09VX4QXfPLUFlyj8paeKNhiLDkY=;
	b=nHjWJIRcNkyB8Y2XuZWPQ3ER+uIqTSju6i4D6MBEXZIIkdweHCJgtH/R6V/Uqv7NAfJJ1j
	R/1ao7diyQYrBZxZG4+HcW/zblEcfHfDLKO/7XG10GAUw3fwNaQnSKKLIn1xibZKB8BbLM
	f3n3BUdQgRNCNTnMSJPGR04hJnr2wLQ+bPBHWeSFE45KXfxusCUZXqpFM8h4O/aowJ9H68
	YAy9Ghpl/Z2kH7xGVO4BSl4l1UMgc8Fv2ApwK08XRCJhTdrkl3UodkNOi01GCMjB4KUjkJ
	M6mGQdrFguqFK2rcnoh+xA1sN64tJi6D9u03g7Cerj5+G22Kq+ERn+/1hRX3+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762876209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mz8HgiX8mpfnq1sd09VX4QXfPLUFlyj8paeKNhiLDkY=;
	b=Zgv3VjkdnPQkvHtpJ/NoK/a7mSsFYrxEwJiQUY4FXwi3YmHJWPdyOeNfV69TBJj9cMyu/h
	7vYXxnH1FRDr8LCw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	shuah <shuah@kernel.org>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 04/10] selftests: vDSO: vdso_test_abi: Provide
 compatibility with 32-bit musl
Message-ID: <20251111162059-734e18c4-f428-411c-afe3-87fb430fb64d@linutronix.de>
References: <20251111-vdso-test-types-v1-0-03b31f88c659@linutronix.de>
 <20251111-vdso-test-types-v1-4-03b31f88c659@linutronix.de>
 <29dd9e11-9ae8-415a-acb3-b96af56550b0@app.fastmail.com>
 <20251111144805-ab2781fe-5424-492b-9cb3-55ebaaedc199@linutronix.de>
 <a78a17eb-1df2-471b-9c28-64619c71dc54@app.fastmail.com>
 <20251111153707-0926c681-0b2a-4cc0-9074-acbe8a6371c2@linutronix.de>
 <2976374e-dd64-48ce-9726-56d97e94323c@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2976374e-dd64-48ce-9726-56d97e94323c@app.fastmail.com>

On Tue, Nov 11, 2025 at 04:07:58PM +0100, Arnd Bergmann wrote:
> On Tue, Nov 11, 2025, at 15:46, Thomas Weißschuh wrote:
> > On Tue, Nov 11, 2025 at 03:19:00PM +0100, Arnd Bergmann wrote:

(...)

> >> >> If we are trying to validate the interface here, we should probably
> >> >> call both if available. If we just want to know the result and
> >> >> trust that both work correctly, I'd always use __NR_clock_getres_time64
> >> >> on 32-bit systems and __NR_clock_getres on 64-bit systems.
> >> >
> >> > As these are vDSO and not timer selftests I think we trust the syscalls.
> >> > But how do we detect a native 64-bit time system? The preprocessor builtins
> >> > won't work as a 32-bit pointer system may use 64-bit time syscalls. I am not
> >> > aware of the UAPI #define, beyond the absence of __NR_clock_getres_time64.
> >> 
> >> I would just check __BITS_PER_LONG=32 and require a linux-5.6+ kernel
> >> at runtime to ensure the 64-bit calls are available.
> >
> > That doesn't work for x32. It uses __BITS_PER_LONG but does not have
> > __NR_clock_getres_time64.
> 
> Right. In C code, we can usually check for
> 'sizeof(time_t) > sizeof(__kernel_long_t)' to catch that case,
> but that doesn't work as easily with the preprocessor.
> 
> A more complex setup using both compile-time and run-time fallbacks
> would work, e.g.
> 
> static int
> syscall_clock_getres_old(clockid_t clockid, struct timespec *res);
> #ifdef __NR_clock_getres
>        struct __kernel_old_timespec ts_old;
>        ret = syscall(__NR_clock_getres, clockid, &ts_old);
>        if (ret)
>               return ret;
>        res->tv_sec = ts_old.sec;
>        res->tv_nsec = ts_old.tv_nsec;
>        return 0;
> #else
>        return -ENOSYS;
> #endif
> }
> 
> static int
> syscall_clock_getres_time64(clockid_t clockid, struct timespec *res);
> #ifdef __NR_clock_getres_time64
>        struct __kernel_timespec ts_64;
>        ret = syscall(__NR_clock_getres_time64, clockid, &ts_64);
>        if (ret)
>               return ret;
>        res->tv_sec = ts_64.sec;
>        res->tv_nsec = ts_64.tv_nsec;
>        return 0;
> #else
>        return -ENOSYS;
> #endif
> }
> 
> static int
> syscall_clock_getres(clockid_t clockid, struct timespec *res)
> {
>        ret = syscall_clock_getres_time64(clockid, res);
>        if (ret != -ENOSYS)
>               return ret;
>        return syscall_clock_getres_old(clockid, &ts_old);
> }

This is exactly what I tried to avoid.

> but the simpler check falling back to the 'old' version
> is probably sufficient.

On musl there is no SYS_clock_getres_time64 but instead there is
SYS_clock_getres_time32. Switching to __NR gives us back the more natural
fallback logic. We are back at the nolibc 64-bit time functions.
We can add a static_assert() to gain some compile-time safety.

static int
syscall_clock_getres(__kernel_clockid_t clockid, struct __kernel_timespec *res)
{
#ifdef __NR_clock_getres_time64
	return syscall(__NR_clock_getres_time64, clockid, res);
#else
	/*
	 * __NR_clock_getres expects __kernel_old_timespec.
	 * Make sure the actual parameter is compatible.
	 */
	_Static_assert(sizeof(struct __kernel_old_timespec) == sizeof(*res));
	return syscall(__NR_clock_getres, clockid, res);
#endif
}

And stick all of those wrappers into another helper header.


Thomas

