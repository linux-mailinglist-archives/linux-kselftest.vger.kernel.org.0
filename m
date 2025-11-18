Return-Path: <linux-kselftest+bounces-45867-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 177ACC69ECE
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 15:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id B39A32B10B
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 14:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0FA3587BE;
	Tue, 18 Nov 2025 14:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lfL49kdU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uwqsdovN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA3554654;
	Tue, 18 Nov 2025 14:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763475738; cv=none; b=L9vLIhl312U+R/B+fqkNK2mtVasaOXzPMPjK1lr6JdwjR9bEYqtUUOkqHPAdhN2OmZzpeLCcG6GAQnOm6wrhetDPsDi4laQJWxejGxWrrQNvwbHbLXw+gIHc4J9DcWxtcAa7ojum655ypsAQQ3ZEuqf1qD5fM4Hejf60ulYxKRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763475738; c=relaxed/simple;
	bh=jtHF94XSwbsL6wHPBiXplOUGzG6pOILNKa+2e3ieMTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bHP5B4qtDdyhk4Zrmq1TS4WH8tIkGkD+Efmix2k/DW6+uDm0m4WXXZey5e2RMtSs4+OecUedLwo2aLyXPLld/0eaGeCK6Q10A6wyQyNkf5XzGftFMX4s2Q7wuJZMrvPNsP/bsxFMASqbM7+X1l2Cfx1tymOwm3lUcNCoQoVc5oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lfL49kdU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uwqsdovN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Nov 2025 15:22:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763475735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m/SQQx3QGkIVTOBUkQBKoaWYKbbiWJQlY9jPVQ9Tue4=;
	b=lfL49kdUhYAALYpZ/Ae2iA2zjopK+tBZiIY5FRY8P2neXsGetWR8ImW4Cmf5s9C8sBhYtp
	z9Lv2qW6cdrQNtyDcOWFS8ur3gZmvOLy1pFdRe32Tcf1kejLuof3MQvVf1fTXriAft5xqA
	7UB16z7uSofkFORdMVQBONWcOZVl565HwmlMfyf/+juHMZrxZ/ohuWqJfjb1apZV9y/2/R
	raLdooHg11C5m6tAEm8RcpF7oR6c9Q9IQF/0JnV5oD7N3QbCViVT1Y1JWJNok86CWZB787
	qGPMua314wDJ2BuZe6eyCwciXaRHBcnrF2dsLSNWE4FV6Mmts6xE4Mhonb7Vhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763475735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m/SQQx3QGkIVTOBUkQBKoaWYKbbiWJQlY9jPVQ9Tue4=;
	b=uwqsdovNdgT1CbSRVBMUyeims5/XIzat5sHWw/HmzaFM6EN7Rze/YOE6jQozFgrR/jVJxv
	Q1aWh1vpR3k3KeCw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	shuah <shuah@kernel.org>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 03/14] selftests: vDSO: Introduce vdso_syscalls.h
Message-ID: <20251118145635-16c14d65-cc62-4c0f-bb2c-2cf7eb30b63c@linutronix.de>
References: <20251113-vdso-test-types-v2-0-0427eff70d08@linutronix.de>
 <20251113-vdso-test-types-v2-3-0427eff70d08@linutronix.de>
 <5826549e-88a8-429c-ad42-46aeada9d21b@app.fastmail.com>
 <20251114093245-04b5eb56-d3ed-486b-90ff-7c7ad5cfc7e7@linutronix.de>
 <22ec7315-49b2-4fde-bd2f-f24f2cfcec37@app.fastmail.com>
 <20251114102555-293562eb-f1f9-47e1-bc2d-59f26a7283fa@linutronix.de>
 <db53e96f-d0c4-4702-aee5-1c38c69074cd@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <db53e96f-d0c4-4702-aee5-1c38c69074cd@app.fastmail.com>

On Fri, Nov 14, 2025 at 11:40:31AM +0100, Arnd Bergmann wrote:
> On Fri, Nov 14, 2025, at 11:02, Thomas Weißschuh wrote:
> > On Fri, Nov 14, 2025 at 10:16:01AM +0100, Arnd Bergmann wrote:
> >> On Fri, Nov 14, 2025, at 09:48, Thomas Weißschuh wrote:
> >> If you think that clock_getres_time64() is important, I don't
> >> mind changing that, especially now that we have a shared vdso
> >> for all architectures. The arguments here is a bit different,
> >> since an efficient clock_getres() function in libc requires
> >> caching the values in userspace, while an efficient gettimeofday()
> >> is much simpler, by calling vdso_clock_gettime_time64()
> >
> > I don't think it is important. For my SPARC vDSO series I even
> > dropped the regular clock_getres() after your request. But because it
> > doesn't exist we need to handle the presence of vdso_clock_getres() and
> > the simultaneous absence of sys_clock_getres() in the test.
> 
> But that is the other way round, right? On sparc32 we have
> (optionally) sys_clock_getres() but never vdso_clock_getres().

Here SPARC was just an example to show that I don't really care about
clock_getres() in the vDSO in general.
But if it was present before for an architecture and we now drop it without a
replacement, userspace developers might complain. Manually caching the value
in userspace sounds ugly and brittle, as it could even change at some point.
Introducing a time64 replacement on the other hand wouldn't make much
difference as the values never would exceed the 32-bit range anyways.

So I would keep vdso_clock_getres() where it exists today even with
CONFIG_COMPAT_32BIT_TIME=n.

> >> I don't think we can actually build a full userspace (other than nolibc)
> >> that works with CONFIG_COMPAT_32BIT_TIME=n, so I'm not particularly
> >> worried about testing the vdso for that case.
> >
> > musl 1.2 started to always use 64-bit times. Looking at both the musl and glibc
> > code, they always try the 64-bit variant first.
> > I think they should work fine.
> 
> No, musl only uses the time64 syscalls when it actually passes
> a 64-bit time value, but e.g. still uses __NR_futex instead of
> __NR_futex_time64 when waiting for a futex without a timeout, and it uses 
> __NR_clock_settime instead of __NR_clock_settime_time64 when setting a
> time within the 32-bit time_t range (1902..2037).

Yes indeed. Sorry, I only looked at the time-reading functions.

> > Personally I'd like to have tests for the functionality that exists.
> > Even if there are currently no users.
> >
> >> You already skip testing vdso_time() if sys_time() is unavailable, and I
> >> think we can do it the exact same way for all five vdso calls.
> >
> > That was an oversight.
> 
> Ok. So you'd want to check all the time32 and time64 vdso calls
> against the __kernel_timespec values returned from
> sys_clock_get{res_time64,time64} and their 64-bit equivalents?

Yes. As these are the only ones which are guaranteed to be available.

> I think in this case we have to actually address the inconsistency
> in the rounding between the interfaces, which I don't think is
> well documented and possibly differs across implementations.

Borrowing words from Jon Corbet:
It probably is meticulously undocumented.

> As far as I can tell, gettimeofday() always returns the
> CLOCK_REALTIME value rounded down to full microseconds and
> truncated to signed 'long' seconds, while time() returns the
> CLOCK_REALTIME_COARSE value rounded down to full seconds.
> This can be a second earlier than a previous CLOCK_REALTIME
> value.

Ack. Having tests for this should be useful in general.

> I see that glibc's time() function uses CLOCK_REALTIME_COARSE
> to be consistent with the Linux sys_time() and vdso_time(),
> while musl's time() uses CLOCK_REALTIME for consistency with
> gettimeofday() and sensible user expectations.
> 
> >> > sys_clock_gettime() should probably be called sys_clock_gettime64(),
> >> > as that is what it actually is.
> >> 
> >> That also seems wrong, as there is no clock_gettime64 on 64-bit
> >> architectures, only clock_gettime.
> >
> > I referred to the type that it returns, which is always 64-bit.
> > Another name, without the sys_ prefix, would be better.
> 
> Right, but then I would make it return 'struct timespec', not
> 'struct __kernel_timespec', because it's no longer the kernel
> interface.

'struct timespec' might be only 32-bit, breaking the tests after y2038.
While that shouldn't happen in actual y2038 it would be nice if we can
validate the future behavior today without reconfiguring libc.
Given that this is also no longer a libc interface, can't we just use
the UAPI type?

What is the general expectation for userspace using 32-bit interfaces
after y2038 from the kernel's perspective?

(...)


Thomas

