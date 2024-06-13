Return-Path: <linux-kselftest+bounces-11829-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F5790632A
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 06:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1CBCB21120
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 04:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6304113247D;
	Thu, 13 Jun 2024 04:51:51 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CCA446CF;
	Thu, 13 Jun 2024 04:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718254311; cv=none; b=g98g1uwB6lETUIpYA2RK4Qtx8bSl6lH/Fn5BOVQEMOczZW/qcpGxnw8EveYImbRLyHZz7h8C+WOZlMmDljRUeQqJ4jvSR+VadOtbAdFzXcHVwRx36PxOGN1oksohxrSTVUMgHyhlbCa+rAvSFOVibVuGLuS7NMSGbhjGnp1wRh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718254311; c=relaxed/simple;
	bh=XMWE/qKJYHRLlJwTts9vGKC7pShgpwVODiKw4rZJ7eo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QY5TVwP7Mp2X79kmxm9wbivuhn9wNqXXJ9AcY3o65B0EaIo1TXa7u8ruTgIPpuPFq0W2BfApcHp2Lx/ckxt8nz2EOnqPFLxMHO+yy3RXi7WIIa17yXr49UR8GkI/sa6hbYqAUagEg78oF1+T4E6lOqlOLoV0dw8DVxx4P3vgmUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 417511042;
	Wed, 12 Jun 2024 21:52:12 -0700 (PDT)
Received: from [10.162.43.11] (e116581.arm.com [10.162.43.11])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F9953F5A1;
	Wed, 12 Jun 2024 21:51:42 -0700 (PDT)
Message-ID: <920f2e27-39ee-4c53-9c90-63d67e7d7586@arm.com>
Date: Thu, 13 Jun 2024 10:21:39 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] selftests: Add a test mangling with uc_sigmask
To: Mark Brown <broonie@kernel.org>
Cc: shuah@kernel.org, oleg@redhat.com, stsp2@yandex.ru, mingo@kernel.org,
 tglx@linutronix.de, mark.rutland@arm.com, ryan.roberts@arm.com,
 suzuki.poulose@arm.com, Anshuman.Khandual@arm.com,
 DeepakKumar.Mishra@arm.com, AneeshKumar.KizhakeVeetil@arm.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240611075650.814397-1-dev.jain@arm.com>
 <20240611075650.814397-3-dev.jain@arm.com>
 <Zmg0GoGnJFbPysfK@finisterre.sirena.org.uk>
 <ec1973ee-909d-41a2-8b32-256302d190b4@arm.com>
 <ZmmfkbuCl61rEPs-@finisterre.sirena.org.uk>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <ZmmfkbuCl61rEPs-@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/12/24 18:46, Mark Brown wrote:
> On Wed, Jun 12, 2024 at 10:14:01AM +0530, Dev Jain wrote:
>> On 6/11/24 16:55, Mark Brown wrote:
>>> On Tue, Jun 11, 2024 at 01:26:50PM +0530, Dev Jain wrote:
>>>> + * A signal is said to be delivered, when the program takes action on the
>>>> + * signal: such action may involve termination of the process, ignoring the
>>>> + * signal, terminating with core dump, stopping the process, or continuing the
>>>> + * process if it was currently stopped. A signal is said to be blocked when the
>>>> + * program refuses to take any of the above actions; note that, this is not the
>>>> + * same as ignoring the signal. At a later time, the program may unblock the
>>>> + * signal and then it will have to take one of the five actions
>>>> + * described above.
>>> I'm not sure that's what my understanding of a blocked signal is, I
>>> would interpret "blocked" as a signal being masked (this usage can be
>>> seen in for example sigaction(2)).  I'd also interpret delivery of the
>>> signal as happening when the signal handler is invoked rather than
>>> something that the handler has control over (the comment later on says
>>> that so I think it's just an issue here).  Perhaps I'm confused about
>>> terminology though, this is just usage I've picked up and ICBW.
>> Isn't "signal being masked" equivalent to what I wrote...
>> man signal(7): Under "Signal mask and pending signals":-
>> "A signal may be blocked, which means that it will not be delivered
>> until it is later unblocked."
>> Under "Signal dispositions":-
>> "Each signal has a current disposition, which determines how the
>> process behaves when it is delivered the signal."
> The point is that the delivery and blocking are done prior to the
> process getting involved in the handling of the signal, the delivery
> happens when the signal handler is invoked.  The program requests
> delivery or blocking but it doesn't actually do the delivery or blocking
> itself.


I guess we agree on the same thing; so, how about I rephrase the delivery
and blocking code comments this way:
"A process can request blocking of a signal by masking it into its set of
blocked signals; such a signal, when sent to the process by the kernel, will
get blocked by the process and it may later unblock it and take an action.
At that point, the signal will be "delivered".
A signal sent by the kernel to the process, is said to be delivered to the
process when the process takes an action upon receipt of the signal: such
action may include termination, or jumping to a signal handler."

>
>> "The comment later on says that", which comment and what does it say,
>> sorry didn't get you.
> That signals are blocked before the process sees them.
>
>>>> + * For standard signals (also see real-time signals in the man page), multiple
>>>> + * blocked instances of the same signal are not queued; such a signal will
>>>> + * be delivered just once.
>>> See also SA_NODEFER.
>> Yes, thanks for the note, but do  need to include it in the
>> comments? This is a specific setting...
> TBH I'm not sure what you mean there by real time signals, I can't see
> a reference to real time in the copies of signal(2), signal(7) or
> sigaction(2) on my system.  I suspect SA_NODEFER is the actual thing
> here.


Real-time signals get a mention on signal(7), under the heading
"Real-time signals":
"Multiple instances of real-time signals can be queued.  By
contrast, if multiple instances of a standard signal are
delivered while that signal is currently blocked, then only
one instance is queued."

I guess SA_NODEFER has no relation with queuing; it is used to not
block the signal for which the handler was installed.

>
>>>> +	/* SEGV has been blocked in sa_mask, but ucontext is invariant */
>>>> +	ret = sigismember(&(((ucontext_t *)uc)->uc_sigmask), SIGSEGV);
>>>> +	ksft_test_result(ret == 0, "SEGV not blocked in ucontext\n");
>>> We're not manipulating the masks outside of main() so it's a bit unclear
>>> what the mention of ucontext being invariant is all about here?
>> This is the point I raised in the cover letter and in this program:  the mask
>> stores the set of blocked signals. What should happen when I block signals
>> using sigaction()? According to the man pages, one could easily come to
>> an erroneous conclusion that these signals will also be present as blocked
>> in ucontext. I am making a point that, SEGV and USR1 have been blocked,
>> but they have not been added into ucontext, i.e ucontext is invariant w.r.t
>> to before and in the handler.
> I still don't follow what the above means.  When you say "invariant" you
> don't specify with respect to what, and it's not clear to me why the
> saved context in ucontext would have changed without the handler writing
> to it.  For clarity I think this needs to say what the ucontext is
> expected to be the same as/different to.


The ucontext at this stage is supposed to be empty, I guess I'll replace
the word "invariant" then.
"it's not clear to me why the saved context in ucontext would have changed
without the handler writing to it" - by invariant I meant, the set of blocked
signals before invocation of handler is exactly the set of signals blocked in
ucontext, which, in this case, is the empty set. I'll just write that ucontext
is empty.

>
> The general flow with signals is that the context at the time the signal
> is delivered is saved to the context structure, then the signal handler
> context is set up and the signal handler invoked.  There are a number of
> ways in which the signal handler context may differ from the context
> that was interrupted, additional signals being masked is one of those.
> On return from the signal handler the context is then restored from
> memory and we restart from that context, potentially including
> modifications made during handling.  This means that the state in the
> signal handler may be different to the state in the context that was
> preempted by it.
>
>>>> +	act.sa_sigaction = &handler_verify_ucontext;
>>>> +	if (sigaction(SIGUSR1, &act, NULL))
>>>> +		ksft_exit_fail_perror("Cannot install handler");
>>>> +
>>>> +	if (raise(SIGUSR1))
>>>> +		ksft_exit_fail_perror("raise");
>>>> +
>>>> +	ksft_print_msg("USR2 still blocked on return from handler\n");
>>> But we just raised SIGUSR1 rather than SIGUSR2?  If nothing else this
>>> bit is a little unclear.
>> Before raise(SIGUSR1), we register a handler for it: handler_verify_ucontext.
>> So, we jump there, we verify that USR2 is present in ucontext (since we mangled
>> with ucontext before), then we raise(SIGUSR2): the program must not terminate
>> since USR2 is blocked in &current->blocked. This is described by ksft_print_msg().
> Like I say I think this needs a comment, it's not obvious from the
> immediate code what the USR1 handler is doing and we're not doing
> anything in this context to verify anything about USR2 so it looks like
> a missed search/replace.

Okay, I'll add a comment.


