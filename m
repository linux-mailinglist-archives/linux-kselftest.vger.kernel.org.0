Return-Path: <linux-kselftest+bounces-45630-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB47C5C13E
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 09:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E87303571E1
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 08:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E892D2490;
	Fri, 14 Nov 2025 08:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="moZSt6cb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HZCvRtv5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDE012DDA1;
	Fri, 14 Nov 2025 08:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763110126; cv=none; b=XQNk+Qr7YWCqWdPeko18jsHo9x9s1Uj/BuOxoNa+P8dI7T+a+Y4Bi9U0XLz0U3AF59hGGfeY6k2mFJO4L6uAAJbl+xXhmdDx/zuPDwGxUF+qj1KJWqiv7GMr21tNZqNWGy0QuqbibboVeB03/PYkqEFnJaKiXhk3iy+mMih5kJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763110126; c=relaxed/simple;
	bh=6HErgCfuG2oyLJ0OvIoODXolD4dOgJQq3eu64x5KF/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/61gtWmdSwCfDEjV7fs6OncjUAqA8gOkEKm0/na0ouN9jy0nWstYtKWM/1jbO4fMkYGh/5REtSjuIGKKgaC0V+QId+Pxc6YXHtzOiq30W3JKRGy6rPJ6ht0diuDgwZ/3QEWR/52nvOghoXGY3ayBBNMac4OpBOfj/Zgf7pJ68I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=moZSt6cb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HZCvRtv5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Nov 2025 09:48:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763110123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iE5dad2AVvf/htepJvItEceJfaapNCXABuvrlaiH5WM=;
	b=moZSt6cbysNj8SCy3cVIZaGxZGes7O+OzBF08afkrGbrLsAC9E1R4KpPWx/Zsmr0GZtPt9
	Qf70pTlXtxunO6qzMsccTiEeoWR7np4br3MEHjm6jb5OnmxubYp+aqvgF6DxXXLSRn3e3t
	4ipgzwpVzrQbcbl59USLLUD1DYkLrPBvmnIzwPKFj9bbcGkE4/YFp5CFuFFT8iIHfBJEna
	h7frKw0qQ/fX+jAhrkEy7pvTVwbveVllmpHTmxNp8JuymhLWhlbWM0kgstFVC3lJx6i0Yo
	VPs4KLHUFhdfU8x7PGzEfI6rkHjggvPisI7VV2VUsPrt1uz8fEOB4JFywru8bA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763110123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iE5dad2AVvf/htepJvItEceJfaapNCXABuvrlaiH5WM=;
	b=HZCvRtv5joa0JOD9NA+UmJI8SA9GxT52rs9REbWYrDqHVGVgQfshLNcm2OF60yB5izaPJL
	uobryg8SmmTeg6Ag==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	shuah <shuah@kernel.org>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 03/14] selftests: vDSO: Introduce vdso_syscalls.h
Message-ID: <20251114093245-04b5eb56-d3ed-486b-90ff-7c7ad5cfc7e7@linutronix.de>
References: <20251113-vdso-test-types-v2-0-0427eff70d08@linutronix.de>
 <20251113-vdso-test-types-v2-3-0427eff70d08@linutronix.de>
 <5826549e-88a8-429c-ad42-46aeada9d21b@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5826549e-88a8-429c-ad42-46aeada9d21b@app.fastmail.com>

On Fri, Nov 14, 2025 at 09:13:02AM +0100, Arnd Bergmann wrote:
> On Thu, Nov 13, 2025, at 16:30, Thomas Weißschuh wrote:
> > The vDSO selftests use raw system call wrapper to validate the
> > correctness of the vDSO implementation. The exactly available system
> > calls differ between architectures and kernel configurations.
> > Raw system calls should not use libc types as these are not necessarily
> > compatible.
> >
> > Introduce a helper header which uses the correct types and fallbacks.
> 
> After I looked at how these are used in patch 8, I think it's
> much easier to just always use the same types as the kernel interfaces
> here and skip the type mangling entirely:

Please see below.

> > +static inline
> > +int sys_clock_getres(__kernel_clockid_t clock, struct 
> > __kernel_timespec *ts)
> > +{
> > +#ifdef __NR_clock_getres_time64
> > +	return syscall(__NR_clock_getres_time64, clock, ts);
> > +#else
> > +	ASSERT_TIMESPEC_COMPATIBLE(typeof(*ts), struct __kernel_old_timespec);
> > +	return syscall(__NR_clock_getres, clock, ts);
> > +#endif
> > +}
> 
> __NR_clock_getres and vdso_clock_getres() both always return a
> __kernel_old_timespec, so I now think it's best to return that from
> sys_clock_getres() without the __NR_clock_getres_time64 alternative
> here and not worry about whether that is a 32-bit or 64-bit type,
>
> I should have thought this through better in my comments to the
> previous version.
> 
> In kernels without CONFIG_COMPAT_32BIT_TIME, we currently leave
> out the clock_getres/clock_gettime/gettimeofday/time syscalls,
> but still provide the vdso interfaces. For consistency we should
> probably leave out both syscall and vdso in that configuration,
> and then we also don't need to compare the vdso_getres result
> against sys_getres_time64.

That sounds good. But today no vDSO provides clock_getres_time64,
so removing clock_getres from the vDSO will affect users.
So we will end up with some sort of inconsistency in any case.
While I agree that it would be nice if the type mangling was unnecessary,
I prefer to correctly test what we have today. If we decide to simplify
the vDSO itself then we have working tests.

sys_clock_gettime() should probably be called sys_clock_gettime64(),
as that is what it actually is.

FYI: gettimeoday() seems to be available even in kernels without
CONFIG_COMPAT_32BIT_TIME.

Thomas

