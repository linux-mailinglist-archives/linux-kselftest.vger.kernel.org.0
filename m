Return-Path: <linux-kselftest+bounces-45635-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A758FC5C735
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 11:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7EB2E3433CE
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 10:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25FD30BBA4;
	Fri, 14 Nov 2025 10:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jP5DX/dL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VZ6G/f/Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434CE309DDD;
	Fri, 14 Nov 2025 10:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763114537; cv=none; b=ax9UTCZ0fk+PcV3m2L3/qnEOwKO/I0vTJxUF1WfdjZRwn59zZhpETzwP5DIbiklE+eu85+mEfJrYujxADwAsrNMYk2bI/6luwwTcb3jBvbYYBljAeO1E+izq//iNDvvDMyi8XKuT2xzoY1bzDYnuBpn/vNiCOZRyd12ATqiVpCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763114537; c=relaxed/simple;
	bh=uFJ3tCmzxjr24kfSjW7hvnvRdjUGJJy00lidAz7ScYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Apec3mV4YJbzKabzlENe5bh61MFCliQQwSbOXvRQbW7Wh+wCV0e4D8dfQxrhEpE4QmrAg4JUeor9GZqvcNB8eP0urm7u00kmafCjeojL+C9GpSHyLJYn7twN8ahzZeo8vlErl5g4Rq17uQm4ldjzUjxHIVFumK/czHdv38Picvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jP5DX/dL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VZ6G/f/Q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Nov 2025 11:02:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763114534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J3NJ2hVdl34EenSSC0yUQp8+itPhhA9bQ3nZQG7Vlng=;
	b=jP5DX/dL3nC4ehyZkrnu/yL6RfDH7ZPjVMQdh9UpQZq9sXXqu959qLsc6eT8txpLMzEVLG
	RArDJFjMXlM0j+1xwp1Ye92hFiyjBgaSW0XwN0mI4SgHuSHUCNs1+ZUORk9OepG1t5Doio
	h2mnfjCJmKi3UkO4vBwDTOrY4rPNvQOtBzxNSXv8c43qa6CpkbnywSMRU97pj0EPshfIkI
	tdPf9u2cPJSFbgIQGzfJc8QzFOAZjb/gojTCK3W1+le2Ja6hgAPFmMkDmTGQorcMB33gsf
	7lKNoAsXGjyjtjtX7JdVCIwtHStEvo3Y/ZpNh0Cm+KZi0zqq5aEmpZITcZPytA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763114534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J3NJ2hVdl34EenSSC0yUQp8+itPhhA9bQ3nZQG7Vlng=;
	b=VZ6G/f/QY2oHxbCIpcYSMZToVRxwB69mmUbpw4srl1GfhinOWqiwhy1g9HLUKTVJzcczpT
	Bmzb3GYuQyTpDXBA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	shuah <shuah@kernel.org>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 03/14] selftests: vDSO: Introduce vdso_syscalls.h
Message-ID: <20251114102555-293562eb-f1f9-47e1-bc2d-59f26a7283fa@linutronix.de>
References: <20251113-vdso-test-types-v2-0-0427eff70d08@linutronix.de>
 <20251113-vdso-test-types-v2-3-0427eff70d08@linutronix.de>
 <5826549e-88a8-429c-ad42-46aeada9d21b@app.fastmail.com>
 <20251114093245-04b5eb56-d3ed-486b-90ff-7c7ad5cfc7e7@linutronix.de>
 <22ec7315-49b2-4fde-bd2f-f24f2cfcec37@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <22ec7315-49b2-4fde-bd2f-f24f2cfcec37@app.fastmail.com>

On Fri, Nov 14, 2025 at 10:16:01AM +0100, Arnd Bergmann wrote:
> On Fri, Nov 14, 2025, at 09:48, Thomas Weißschuh wrote:
> > On Fri, Nov 14, 2025 at 09:13:02AM +0100, Arnd Bergmann wrote:
> >> On Thu, Nov 13, 2025, at 16:30, Thomas Weißschuh wrote:
> >> 
> >> __NR_clock_getres and vdso_clock_getres() both always return a
> >> __kernel_old_timespec, so I now think it's best to return that from
> >> sys_clock_getres() without the __NR_clock_getres_time64 alternative
> >> here and not worry about whether that is a 32-bit or 64-bit type,
> >>
> >> I should have thought this through better in my comments to the
> >> previous version.
> >> 
> >> In kernels without CONFIG_COMPAT_32BIT_TIME, we currently leave
> >> out the clock_getres/clock_gettime/gettimeofday/time syscalls,
> >> but still provide the vdso interfaces. For consistency we should
> >> probably leave out both syscall and vdso in that configuration,
> >> and then we also don't need to compare the vdso_getres result
> >> against sys_getres_time64.
> >
> > That sounds good. But today no vDSO provides clock_getres_time64,
> > so removing clock_getres from the vDSO will affect users.
> 
> In what way? When we introduced the clock_gettime64()
> vdso call, we debated also adding time64(), gettimeofday_time64()
> and clock_getres_time64() but decided against that based on
> the argument that the libc can implement all of these efficiently
> with just clock_gettime64().

clock_getres_time64() can't be implemented with vdso_clock_gettime64().
It could use vdso_clock_getres() as the resolution should never
overflow the type. But nobody seems to do this either.

> If you think that clock_getres_time64() is important, I don't
> mind changing that, especially now that we have a shared vdso
> for all architectures. The arguments here is a bit different,
> since an efficient clock_getres() function in libc requires
> caching the values in userspace, while an efficient gettimeofday()
> is much simpler, by calling vdso_clock_gettime_time64()

I don't think it is important. For my SPARC vDSO series I even
dropped the regular clock_getres() after your request. But because it
doesn't exist we need to handle the presence of vdso_clock_getres() and
the simultaneous absence of sys_clock_getres() in the test.

> > So we will end up with some sort of inconsistency in any case.
> > While I agree that it would be nice if the type mangling was unnecessary,
> > I prefer to correctly test what we have today. If we decide to simplify
> > the vDSO itself then we have working tests.
> 
> Sorry, I'm not following. Do you mean we need the mangling since we
> support the vdso for configurations without the direct syscalls, or
> do you mean something else?

Exactly.

> I don't think we can actually build a full userspace (other than nolibc)
> that works with CONFIG_COMPAT_32BIT_TIME=n, so I'm not particularly
> worried about testing the vdso for that case.

musl 1.2 started to always use 64-bit times. Looking at both the musl and glibc
code, they always try the 64-bit variant first.
I think they should work fine.

Personally I'd like to have tests for the functionality that exists.
Even if there are currently no users.

> You already skip testing vdso_time() if sys_time() is unavailable, and I
> think we can do it the exact same way for all five vdso calls.

That was an oversight.

> > sys_clock_gettime() should probably be called sys_clock_gettime64(),
> > as that is what it actually is.
> 
> That also seems wrong, as there is no clock_gettime64 on 64-bit
> architectures, only clock_gettime.

I referred to the type that it returns, which is always 64-bit.
Another name, without the sys_ prefix, would be better.

> > FYI: gettimeoday() seems to be available even in kernels without
> > CONFIG_COMPAT_32BIT_TIME.
> 
> I see, that does sound like a mistake. It's relatively harmless,
> but I think it would be safe to change this along with changing
> the vdso to only expose the time32 interfaces when COMPAT_32BIT_TIME
> is enabled.

IMO that would need to be another series with its own discussion.


Thomas

