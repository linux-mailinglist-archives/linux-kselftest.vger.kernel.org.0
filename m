Return-Path: <linux-kselftest+bounces-11738-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF86904A25
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 06:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 628191C23A37
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 04:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D238022092;
	Wed, 12 Jun 2024 04:44:12 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF97E2C6A3;
	Wed, 12 Jun 2024 04:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718167452; cv=none; b=NfYrBUResj50NOzLNXC6EuP4tcxvRx2hVUKQe0e35heqZJ8Xv5vUSpKgdWQBvmSVznGC2UMXDX0s5WwGxs/1TzGqmSAenXFmVgD2k5asplJJZToIeHl+M/WNu7z9KBHibKP/bMNSh1D+S0vzI4CiloVtp0brKp4MKnHps7Zdi1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718167452; c=relaxed/simple;
	bh=88bOPtJH+39QSELyA0j6OxhwfRT9w6E56fXRX/NhS24=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UmShhoc5z6Ew5562v4cDG/rgEn/VwrD93qZZYqQb+SPDzbZoFmyO+ZCaL440cF9mUXAZhbO430idLAp7O+/8Fo9kgpdYxRyht2fD2EE6OC4tDe9pXRr7wb2sfvX+0S+mPShKCWOx3vC1OjMQtoacUBhwf4CfPoiS8f4UVwpyYQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D470152B;
	Tue, 11 Jun 2024 21:44:33 -0700 (PDT)
Received: from [10.162.42.15] (e116581.arm.com [10.162.42.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 793E03F64C;
	Tue, 11 Jun 2024 21:44:04 -0700 (PDT)
Message-ID: <ec1973ee-909d-41a2-8b32-256302d190b4@arm.com>
Date: Wed, 12 Jun 2024 10:14:01 +0530
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
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <Zmg0GoGnJFbPysfK@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/11/24 16:55, Mark Brown wrote:
> On Tue, Jun 11, 2024 at 01:26:50PM +0530, Dev Jain wrote:
>
>> + * A signal is said to be delivered, when the program takes action on the
>> + * signal: such action may involve termination of the process, ignoring the
>> + * signal, terminating with core dump, stopping the process, or continuing the
>> + * process if it was currently stopped. A signal is said to be blocked when the
>> + * program refuses to take any of the above actions; note that, this is not the
>> + * same as ignoring the signal. At a later time, the program may unblock the
>> + * signal and then it will have to take one of the five actions
>> + * described above.
> I'm not sure that's what my understanding of a blocked signal is, I
> would interpret "blocked" as a signal being masked (this usage can be
> seen in for example sigaction(2)).  I'd also interpret delivery of the
> signal as happening when the signal handler is invoked rather than
> something that the handler has control over (the comment later on says
> that so I think it's just an issue here).  Perhaps I'm confused about
> terminology though, this is just usage I've picked up and ICBW.

Isn't "signal being masked" equivalent to what I wrote...
man signal(7): Under "Signal mask and pending signals":-
"A signal may be blocked, which means that it will not be delivered
until it is later unblocked."
Under "Signal dispositions":-
"Each signal has a current disposition, which determines how the
process behaves when it is delivered the signal."

The above must imply that, the delivery of a signal implies a signal
disposition coming into picture; so in case of blocked signal, the
following should happen:
Set disposition (default, ignore, or jump to handler) -> block SIG_x using,
say, sigprocmask() -> raise(SIG_x) -> nothing happens, do normal work ->
unblock SIG_x by sigprocmask() -> immediately act on disposition, since the
signal will be delivered.
When I wrote "such action may involve termination of the process..." I should
have also included "or jump to a signal handler".

"The comment later on says that", which comment and what does it say,
sorry didn't get you.

>
>> + * For standard signals (also see real-time signals in the man page), multiple
>> + * blocked instances of the same signal are not queued; such a signal will
>> + * be delivered just once.
> See also SA_NODEFER.

Yes, thanks for the note, but do  need to include it in the
comments? This is a specific setting...

>
>> +	/* SEGV has been blocked in sa_mask, but ucontext is invariant */
>> +	ret = sigismember(&(((ucontext_t *)uc)->uc_sigmask), SIGSEGV);
>> +	ksft_test_result(ret == 0, "SEGV not blocked in ucontext\n");
>> +
>> +	/* USR1 has been blocked, but ucontext is invariant */
>> +	ret = sigismember(&(((ucontext_t *)uc)->uc_sigmask), SIGUSR1);
>> +	ksft_test_result(ret == 0, "USR1 not blocked in ucontext\n");
> We're not manipulating the masks outside of main() so it's a bit unclear
> what the mention of ucontext being invariant is all about here?

This is the point I raised in the cover letter and in this program:  the mask
stores the set of blocked signals. What should happen when I block signals
using sigaction()? According to the man pages, one could easily come to
an erroneous conclusion that these signals will also be present as blocked
in ucontext. I am making a point that, SEGV and USR1 have been blocked,
but they have not been added into ucontext, i.e ucontext is invariant w.r.t
to before and in the handler.

>
>> +	/* Mangled ucontext implies USR2 is blocked for current thread */
>> +	if (raise(SIGUSR2))
>> +		ksft_exit_fail_perror("raise");
>> +
>> +	ksft_print_msg("USR2 bypassed successfully\n");
>> +
>> +	act.sa_sigaction = &handler_verify_ucontext;
>> +	if (sigaction(SIGUSR1, &act, NULL))
>> +		ksft_exit_fail_perror("Cannot install handler");
>> +
>> +	if (raise(SIGUSR1))
>> +		ksft_exit_fail_perror("raise");
>> +
>> +	ksft_print_msg("USR2 still blocked on return from handler\n");
> But we just raised SIGUSR1 rather than SIGUSR2?  If nothing else this
> bit is a little unclear.

Before raise(SIGUSR1), we register a handler for it: handler_verify_ucontext.
So, we jump there, we verify that USR2 is present in ucontext (since we mangled
with ucontext before), then we raise(SIGUSR2): the program must not terminate
since USR2 is blocked in &current->blocked. This is described by ksft_print_msg().


