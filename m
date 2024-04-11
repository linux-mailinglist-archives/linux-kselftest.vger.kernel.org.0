Return-Path: <linux-kselftest+bounces-7708-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEB38A1717
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 16:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2311CB22531
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 14:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB1414EC61;
	Thu, 11 Apr 2024 14:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4kjBAKBi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YYbHCtpq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AB514F9DE;
	Thu, 11 Apr 2024 14:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712845068; cv=none; b=RXRf4yRPksz//2agF+igmFo2zk9GNHmBLEgx3VgbeIyKU/vpsS6rgXFnzhqgjYsWB/QM0cTvLpotCq+7PbiEo8PDnV5ku1yP7l2a8vIJYSjhRt5V5fc5c9wjbxSO/byJinlBaazHXCnjWm0quyRfiw40tnQUIF3j+6pjqjZbHro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712845068; c=relaxed/simple;
	bh=5x0MJ3oCoUFbEb4ZlnmuvTMNgcR/kZw65+jhCj9cLhM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mBPPj+V7ZkY8PA+6qySVIL4c5m8jKcyYjz7ON9ZHwWMAuJK7ZEHmc+oAvna8RtYdgjWID9e0AaGLFv99cZZPStNJB2ez5EwOTL/Z2Fe8wNlAC3hfLQ+V2LmE/pQRZuqTCwqceSbNYCrUgMKbafcsDKt8VAaqmHMx2zJ/I/gdMUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4kjBAKBi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YYbHCtpq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712845064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MuXafFQRttff2dvLyAB+pKNoH9ktNnb1Y8CD+U2h2iw=;
	b=4kjBAKBiMhS93Omd+VB6jNMZSvXVrGz1kFAWONWeGzGTKO5eL7Gdl+KiPuK7RGKvdUg2IY
	WG0QwXptatQ1UrCGETre4IlEb7zLIKlRHI8oYc7s3ACVAXV2QrmY+KVIEC7DsdRdNpPnuf
	exnkzDLQiU8wOKWXSena8KavR2cxIpBkQ/r54FAmrWtt6KDn6K2Ny8vvGzYvlMTL48Pk9Z
	B5UCuPojjhHjyDyc1EJzhoa7ovOEMaCOzfScvsj8UMM/b3w2p+gCwerH+ZcucRCVbXFJSX
	K5IUjobSD+323YETmKHV9rrBRM+O35ydu6xN+g7fUKn5kD3bxrVFk1PKBXCy4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712845064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MuXafFQRttff2dvLyAB+pKNoH9ktNnb1Y8CD+U2h2iw=;
	b=YYbHCtpqVdErGD/xWX7jCfyMJ7RKGG5XMnFy87uCVQbX8RlmIzJNMA5yAu3RiqBkuQnuGD
	NtDUNUM+6hyyESAQ==
To: Mark Brown <broonie@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Cc: John Stultz <jstultz@google.com>, Marco Elver <elver@google.com>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, "Eric W.
 Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
 kasan-dev@googlegroups.com, Edward Liaw <edliaw@google.com>, Carlos Llamas
 <cmllamas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] selftests/timers/posix_timers: reimplement
 check_timer_distribution()
In-Reply-To: <f0523b3a-ea08-4615-b0fb-5b504a2d39df@sirena.org.uk>
References: <87sf02bgez.ffs@tglx> <87r0fmbe65.ffs@tglx>
 <CANDhNCoGRnXLYRzQWpy2ZzsuAXeraqT4R13tHXmiUtGzZRD3gA@mail.gmail.com>
 <87o7aqb6uw.ffs@tglx>
 <CANDhNCreA6nJp4ZUhgcxNB5Zye1aySDoU99+_GDS57HAF4jZ_Q@mail.gmail.com>
 <87frw2axv0.ffs@tglx> <20240404145408.GD7153@redhat.com>
 <87le5t9f14.ffs@tglx> <20240406150950.GA3060@redhat.com>
 <f0523b3a-ea08-4615-b0fb-5b504a2d39df@sirena.org.uk>
Date: Thu, 11 Apr 2024 16:17:43 +0200
Message-ID: <87il0o0yrc.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Apr 11 2024 at 13:44, Mark Brown wrote:
> On Sat, Apr 06, 2024 at 05:09:51PM +0200, Oleg Nesterov wrote:
>> Thomas says:
>> 
>> 	The signal distribution test has a tendency to hang for a long
>> 	time as the signal delivery is not really evenly distributed. In
>> 	fact it might never be distributed across all threads ever in
>> 	the way it is written.
>> 
>> To me even the
>> 
>> 	This primarily tests that the kernel does not favour any one.
>
> Further to my previous mail it's also broken the arm64 selftest builds,
> they use kselftest.h with nolibc in order to test low level
> functionality mainly used by libc implementations and nolibc doesn't
> implement uname():
>
> In file included from za-fork.c:12:
> ../../kselftest.h:433:17: error: variable has incomplete type 'struct utsname'
>         struct utsname info;
>                        ^
> ../../kselftest.h:433:9: note: forward declaration of 'struct utsname'
>         struct utsname info;
>                ^
> ../../kselftest.h:435:6: error: call to undeclared function 'uname'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>         if (uname(&info) || sscanf(info.release, "%u.%u.", &major, &minor) != 2)
>             ^
> ../../kselftest.h:435:22: error: call to undeclared function 'sscanf'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>         if (uname(&info) || sscanf(info.release, "%u.%u.", &major, &minor) != 2)

Grrr. Let me stare at this.


