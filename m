Return-Path: <linux-kselftest+bounces-46106-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D448C74478
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 14:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E25DC348182
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 13:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73D6342169;
	Thu, 20 Nov 2025 13:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mQVhdPj2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2AGYMZpb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52331340A4C;
	Thu, 20 Nov 2025 13:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763645283; cv=none; b=U62F1cWgZ2BmS/AJnsdZNtNR1yd0GWIeRX948j0L3uojKGSnHLSRsmPi8B96Z5yZjrovT53o38SkGX3qH2q7Y4Up1G/6bvrZC7eOT5l4lTq/nB4UDm3X8Recky3IMuVsikR/kqQ1Tt0JtV1ChImLdezHxDHHvNGkIbcKZQW2v6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763645283; c=relaxed/simple;
	bh=mzI9cTEZSZD8xt5H1pTN636SEe9Vnqf6ts26qsNTIaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rnp/Df3uG7LBYWI9VdZt7/2+DPhTBPGqCjm+FPf1PtGzRrKTYapyInJNMCmg0YK7/5ekAQa/B+TQAomG74VunIY0SFuQoE4Sa0ql/riCE32SPVvINinbKHOqtIoGLBtWQuhp3s4zZ3RT7Q+95IvEfpzLzQZflWyn6RUmJ0xbdbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mQVhdPj2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2AGYMZpb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 20 Nov 2025 14:27:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763645274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V6lfM5WgDc8QM4spSulqDmKqkqyKsdr50H2QMibx3QE=;
	b=mQVhdPj27TFJmkvmryUpmEjJa5IzP9z5O33Sn5TdCY8IbascWg5Zm/EBLTAl9L9v9ZrOM6
	g9qvH6X2QUp5CFvwYlYdh/+6BmWxDmV+B413TQ1YeXncwrusT/oYoR09/+Xv7PvVEHV5+V
	PTpPb2wYwb630udf5QJk0TAwkhLCdozyeU8CV6HTj4bhrLoIgFH2LaTrHzUkQCJkFSzErJ
	l+5lPkuoLUmW8jdHFuS5OecSDn1yoHu4Hf5buesOmOvwGE7ED4OivdvDXuaAwpy3UUCf+E
	BGrZ/YvfKYhhML+P+Y2s2Uz6UD7tfHsU52Yyj0DCvLaDqtUnZot/XxWkfqQITQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763645274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V6lfM5WgDc8QM4spSulqDmKqkqyKsdr50H2QMibx3QE=;
	b=2AGYMZpbi6QZcZ1jia+9ZisH+ai4lh8UV4LWs8rev4bPGDZgNhh2TnqpvkIfyPG6grZN/E
	nTGz0AVCoxlQeFAw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	shuah <shuah@kernel.org>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 03/14] selftests: vDSO: Introduce vdso_syscalls.h
Message-ID: <20251120142528-86237d98-17b3-480a-a2f4-3d88e5969e9e@linutronix.de>
References: <20251113-vdso-test-types-v2-0-0427eff70d08@linutronix.de>
 <20251113-vdso-test-types-v2-3-0427eff70d08@linutronix.de>
 <5826549e-88a8-429c-ad42-46aeada9d21b@app.fastmail.com>
 <20251114093245-04b5eb56-d3ed-486b-90ff-7c7ad5cfc7e7@linutronix.de>
 <22ec7315-49b2-4fde-bd2f-f24f2cfcec37@app.fastmail.com>
 <20251114102555-293562eb-f1f9-47e1-bc2d-59f26a7283fa@linutronix.de>
 <db53e96f-d0c4-4702-aee5-1c38c69074cd@app.fastmail.com>
 <20251118145635-16c14d65-cc62-4c0f-bb2c-2cf7eb30b63c@linutronix.de>
 <6fbb952c-0119-4be7-8f65-9198330013e7@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6fbb952c-0119-4be7-8f65-9198330013e7@app.fastmail.com>

On Tue, Nov 18, 2025 at 10:40:03PM +0100, Arnd Bergmann wrote:
> On Tue, Nov 18, 2025, at 15:22, Thomas Weißschuh wrote:
> > On Fri, Nov 14, 2025 at 11:40:31AM +0100, Arnd Bergmann wrote:
> >> On Fri, Nov 14, 2025, at 11:02, Thomas Weißschuh wrote:
> >> > On Fri, Nov 14, 2025 at 10:16:01AM +0100, Arnd Bergmann wrote:
> >> >
> >> > I don't think it is important. For my SPARC vDSO series I even
> >> > dropped the regular clock_getres() after your request. But because it
> >> > doesn't exist we need to handle the presence of vdso_clock_getres() and
> >> > the simultaneous absence of sys_clock_getres() in the test.
> >> 
> >> But that is the other way round, right? On sparc32 we have
> >> (optionally) sys_clock_getres() but never vdso_clock_getres().
> >
> > Here SPARC was just an example to show that I don't really care about
> > clock_getres() in the vDSO in general.
> > But if it was present before for an architecture and we now drop it without a
> > replacement, userspace developers might complain. Manually caching the value
> > in userspace sounds ugly and brittle, as it could even change at some point.
> > Introducing a time64 replacement on the other hand wouldn't make much
> > difference as the values never would exceed the 32-bit range anyways.
> >
> > So I would keep vdso_clock_getres() where it exists today even with
> > CONFIG_COMPAT_32BIT_TIME=n.
> 
> It is rather inconsistent with all the other interfaces though:
> when we originally did the time64 conversion, there were a number
> of interfaces that didn't really need a replacement, but we
> deliberately made new interfaces wherever possible. For architectures
> without time32 support, and for validating the time64 support,
> it should be possible to build both kernel and userspace without
> even defining the __kernel_old_time{_t,spec,val} types.

Fair enough. I'll add this to my TODO list.

> >> Right, but then I would make it return 'struct timespec', not
> >> 'struct __kernel_timespec', because it's no longer the kernel
> >> interface.

(...)


Thomas

