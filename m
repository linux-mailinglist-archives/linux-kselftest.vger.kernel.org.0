Return-Path: <linux-kselftest+bounces-7201-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98866898ABA
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 17:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 379061F22223
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 15:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C9A28689;
	Thu,  4 Apr 2024 15:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yyw/gEou";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8WI+dxa9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470EC1D551;
	Thu,  4 Apr 2024 15:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712243421; cv=none; b=bBsKWlEUwmIK53UP3iRVdcqgs0mN+DhJbKvXLgK620Be8EBFGiAE1Gi65buQYEGCir9IABiWslagwhEWZjjoSv7KBQ0+gVILsm2uZj0uP1r40TU4nqVxluUxbCBLbU2YOwjj25CIzLFX6NQXWRs98yh6hiOR0z1yYduxbCfvZMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712243421; c=relaxed/simple;
	bh=h1CjU1JG+GY3d4PN/CqDUdYCCccyfwlv8y9jCvqQC4U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iWrn91AkYKZecNZNIFZ76QZQmuOOOlefqWDOkHYwRMZ9S6iWsaZE73oQSmXkLakGUC0KcYymnIq7QW5dYfCI8f37K/LRBtMAse9S3rdGr4KRzsi5nc8hKBCBf/nHMHKwhKZmN9Jrtd+D7ig5w5QPyC5Ca8QJmUIyKUmh1Ocy/yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yyw/gEou; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8WI+dxa9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712243418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z5plkxd242OMtGKpte6blfseLcSdvpYvQ4c9jL8q5L8=;
	b=yyw/gEouiS/IirwoaGCvhqLow9UcQMFHq2e2pVbOE1DGGUy1t1tm/etM2iXo2XmnZb1Dml
	pJubPntaxb88vo1I8T9Whvgsv+mmfQ1NvDhqf2W7wJIpmCFWfiLegNHyU2IXJREivBdGdA
	nXSLCzBxYxR/ikOOS5Q8DQS5/cf1ux4RnhR2/Is0DDa+JJOTqmpBl6UG6JQqXVJOnrHpce
	CVH8QhCE9ANEJflWjzyEM/uZNMFmf/r77j9auRcS9jHbrTohpaYhxg5RzLM28euKgRYdm8
	2GjfgSsR1ilUa74dy/ug+pvus4mvBJ8fIWiK38/hj3muIILFdAIKPdb5CA+t4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712243418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z5plkxd242OMtGKpte6blfseLcSdvpYvQ4c9jL8q5L8=;
	b=8WI+dxa9jLUQ9K5BxoE/j18iAq0nizDN1BJ1lU0wqbv13V88erwi+Q8LGUQdIdkQmOJxYB
	jXZJKD5+9zDDPdDw==
To: Oleg Nesterov <oleg@redhat.com>, Dmitry Vyukov <dvyukov@google.com>
Cc: John Stultz <jstultz@google.com>, Marco Elver <elver@google.com>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, "Eric W.
 Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kasan-dev@googlegroups.com, Edward Liaw
 <edliaw@google.com>, Carlos Llamas <cmllamas@google.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6 1/2] posix-timers: Prefer delivery of signals to the
 current thread
In-Reply-To: <20240404134357.GA7153@redhat.com>
References: <20230316123028.2890338-1-elver@google.com>
 <CANDhNCqBGnAr_MSBhQxWo+-8YnPPggxoVL32zVrDB+NcoKXVPQ@mail.gmail.com>
 <87frw3dd7d.ffs@tglx>
 <CANDhNCqbJHTNcnBj=twHQqtLjXiGNeGJ8tsbPrhGFq4Qz53c5w@mail.gmail.com>
 <874jcid3f6.ffs@tglx> <20240403150343.GC31764@redhat.com>
 <87sf02bgez.ffs@tglx>
 <CACT4Y+a-kdkAjmACJuDzrhmUPmv9uMpYOg6LLVviMQn=+9JRgA@mail.gmail.com>
 <20240404134357.GA7153@redhat.com>
Date: Thu, 04 Apr 2024 17:10:18 +0200
Message-ID: <87v84x9nad.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Apr 04 2024 at 15:43, Oleg Nesterov wrote:
> On 04/04, Dmitry Vyukov wrote:
>> they all should get a signal eventually.
>
> Well, yes and no.
>
> No, in a sense that the motivation was not to ensure that all threads
> get a signal, the motivation was to ensure that cpu_timer_fire() paths
> will use the current task as the default target for signal_wake_up/etc.
> This is just optimization.
>
> But yes, all should get a signal eventually. And this will happen with
> or without the commit bcb7ee79029dca ("posix-timers: Prefer delivery of
> signals to the current thread"). Any thread can dequeue a shared signal,
> say, on return from interrupt.
>
> Just without that commit this "eventually" means A_LOT_OF_TIME
> statistically.

bcb7ee79029dca only directs the wakeup to current, but the signal is
still queued in the process wide shared pending list. So the thread
which sees sigpending() first will grab and deliver it to itself.

> But yes, I agree, if thread exits once it get a signal, then A_LOT_OF_TIME
> will be significantly decreased. But again, this is just statistical issue,
> I do not see how can we test the commit bcb7ee79029dca reliably.

We can't.

What we can actually test is the avoidance of waking up the main thread
by doing the following in the main thread:

     start_threads();
     barrier_wait();
     nanosleep(2 seconds);
     done = 1;
     stop_threads();

and in the first thread which is started:

first_thread()
     barrier_wait();
     start_timer();
     loop()
     
On a pre 6.3 kernel nanosleep() will return early because the main
thread is woken up and will eventually win the race to deliver the
signal.

On a 6.3 and later kernel nanosleep() will not return early because the
main thread is not woken up as the wake up is directed at current,
i.e. a worker thread, which is running anyway and will consume the
signal.

> OTOH. If the threads do not exit after they get signal, then _in theory_
> nothing can guarantee that this test-case will ever complete even with
> that commit. It is possible that one of the threads will "never" have a
> chance to run cpu_timer_fire().

Even with the exit I managed to make one out of 100 runs run into the
timeout because the main thread always won the race.

> In short, I leave this to you and Thomas. I have no idea how to write a
> "good" test for that commit.
>
> Well... perhaps the main thread should just sleep in pause(), and
> distribution_handler() should check that gettid() != getpid() ?
> Something like this maybe... We need to ensure that the main thread
> enters pause before timer_settime().

I'm testing a modification which implements something like the above and
the success condition is that the main thread does not return early from
nanosleep() and has no signal accounted. It survived 2000 iterations by
now.

Let me polish it up.

Thanks,

        tglx


