Return-Path: <linux-kselftest+bounces-7121-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A331897B98
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 00:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35F21282E5A
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 22:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21DA156979;
	Wed,  3 Apr 2024 22:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iEzK0h73";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F+/te/Q4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17797156966;
	Wed,  3 Apr 2024 22:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712183064; cv=none; b=eRaScGEeOZb4e/ECK8H3xRAzE7jEMpGL4RDeddqINBnXiTrMs8HgV0j5Vz/h8SIuTn2W60g/cmTcQXvU0J+Awm4HCa88FZJrl1U7VcBCxeP4uOy11MJqUJM3lFWuh4zeFGK2Rm/x72OsaKt43ORrZRdXqr0vDgDGyUiBmvZKfJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712183064; c=relaxed/simple;
	bh=TEp7+Qiyo82s+1tiadbpVHFDh224LahtR7+iS2DB1/4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aZ/JzQYfLJmnFfVD+ktTZoHsnQLsIjYXEcK3KUpcw2gvrODLgaclLP5K+lTeUuLRh0qmUj0W5mIWiIpduPFFYdQkVBszjyjKcQD+QCBvb5CKq0ugs/RORvlsPIntpsoghmzVNYVvjtue+xGyhCgLCF/ep60uNMmuKmrESaxi2RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iEzK0h73; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F+/te/Q4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712183060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c3YFPvNQqpuZ+J4wj70XcY9sGKlu8GfBq1D4XGyQln4=;
	b=iEzK0h73bJZnELeHznNtxplvE+IZX5vy9DG5U104MYJjcdtkjpByoyiqR1I2myvBSrgG3g
	TOT3WPqydtip+Ib+cTgo373q5zZiBH1nOFcm9P6PQRd6R/CdriImzB9FBPBdTX0KgPQUf8
	RCfA9v67fZPqU20NVULL7ioeoKqV7f9MK0zrwJKpTD0NIcPezUmsDxanW/NWWiuW0WZJNU
	Hq7LxfA3LcdX2t0D4EWDyOQVtbidlsyvpVrNk8K23w+/VCeHH9yjC+YMkiqY2ckL4B94UW
	EI+eKyzrNcF49QyvojPUcAMkDwu8bY+6ZhDd8LFZ1+PXAjMjiqhJ+0+Ka0PuqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712183060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c3YFPvNQqpuZ+J4wj70XcY9sGKlu8GfBq1D4XGyQln4=;
	b=F+/te/Q4J9hwYmJ2XOE5oHMCodz5CX1FL7lExc7xTFaQmhwzYWPIjNGTS2B9ivLXz2lvd9
	/K68co45wZidz1BA==
To: John Stultz <jstultz@google.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Marco Elver <elver@google.com>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, "Eric W.
 Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
 kasan-dev@googlegroups.com, Edward Liaw <edliaw@google.com>, Carlos Llamas
 <cmllamas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6 1/2] posix-timers: Prefer delivery of signals to the
 current thread
In-Reply-To: <CANDhNCreA6nJp4ZUhgcxNB5Zye1aySDoU99+_GDS57HAF4jZ_Q@mail.gmail.com>
References: <87sf02bgez.ffs@tglx> <87r0fmbe65.ffs@tglx>
 <CANDhNCoGRnXLYRzQWpy2ZzsuAXeraqT4R13tHXmiUtGzZRD3gA@mail.gmail.com>
 <87o7aqb6uw.ffs@tglx>
 <CANDhNCreA6nJp4ZUhgcxNB5Zye1aySDoU99+_GDS57HAF4jZ_Q@mail.gmail.com>
Date: Thu, 04 Apr 2024 00:24:19 +0200
Message-ID: <87frw2axv0.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 03 2024 at 12:35, John Stultz wrote:
> On Wed, Apr 3, 2024 at 12:10=E2=80=AFPM Thomas Gleixner <tglx@linutronix.=
de> wrote:
>>
>> On Wed, Apr 03 2024 at 11:16, John Stultz wrote:
>> > On Wed, Apr 3, 2024 at 9:32=E2=80=AFAM Thomas Gleixner <tglx@linutroni=
xde> wrote:
>> > Thanks for this, Thomas!
>> >
>> > Just FYI: testing with 6.1, the test no longer hangs, but I don't see
>> > the SKIP behavior. It just fails:
>> > not ok 6 check signal distribution
>> > # Totals: pass:5 fail:1 xfail:0 xpass:0 skip:0 error:0
>> >
>> > I've not had time yet to dig into what's going on, but let me know if
>> > you need any further details.
>>
>> That's weird. I ran it on my laptop with 6.1.y ...
>>
>> What kind of machine is that?
>
> I was running it in a VM.
>
> Interestingly with 64cpus it sometimes will do the skip behavior, but
> with 4 cpus it seems to always fail.

Duh, yes. The problem is that any thread might grab the signal as it is
process wide.

What was I thinking? Not much obviously.

The distribution mechanism is only targeting the wakeup at signal
queuing time and therefore avoids the wakeup of idle tasks. But it does
not guarantee that the signal is evenly distributed to the threads on
actual signal delivery.

Even with the change to stop the worker threads when they got a signal
it's not guaranteed that the last worker will actually get one within
the timeout simply because the main thread can win the race to collect
the signal every time. I just managed to make the patched test fail in
one out of 100 runs.

IOW, we cannot test this reliably at all with the current approach.

I'll think about it tomorrow again with brain awake.

Thanks,

        tglx


