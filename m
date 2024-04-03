Return-Path: <linux-kselftest+bounces-7101-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37965897441
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 17:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 669721C21012
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 15:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E3314A4C0;
	Wed,  3 Apr 2024 15:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sD3iALlA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LXSNI6mg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463331E871;
	Wed,  3 Apr 2024 15:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712159015; cv=none; b=hpIkZO1366I2QrP5uiQ2UdmqsI9dqLOVC1BJ0NRBAtelmBBUf4CXOeYdrdb4YMNsSryJlydaP5AIYiLmVvIfJI4YpZ9eKPhyuEXnsJrri7/9/oobRXlaENqlEpaf7kxuvyZPESddM+ezKBfMwntjpjP8cgf/pTDyVtM0R4hxlIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712159015; c=relaxed/simple;
	bh=T6ATMPb0L6jQmUdZukRjg/J3crE9UrcQ5hjw5772x5A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gEc+SA8FqPc+J8HwN+gqaHAZzRa6Rhm59WlkBfYaYVfSMCpPUwx13fbBqIO99tIMb9imsc/ffCAxb8LAfYGI0ygf1XYuKnNgJ5hBzUdWlyc82HOUIYtedJqUnrXxgbOJvImDe0EmAhoS9zel66fc3aCNzuce9Xnx5ES3seRDYgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sD3iALlA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LXSNI6mg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712159012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0ZWNUC2Pb10IDRHFLsN4mAj14Fjk7lK2G1G9BFqCQx4=;
	b=sD3iALlAHq87Li0ITqAVHVUJn4FRxdTyg8m1gPG+LOzVvMQz2dTbiiH38ktFhrjm1TRzS4
	Zo+ksm8rKsS8tcOEoKso1w455YUOP82JbFovRjNLSayXTnjD1YL/1XdzqJNBpJZuXz+26e
	/fSp8RhscDgr1RFB+MoIhbAVpqAKe4tfYUEV5nybg6BjFMW/V6Dg4kPcmDBky7LCbtYjU9
	YMKMqzCB3NWF7c0OxRkDvYgijekaaTECxorL0Up4ZEqsF+BuHk9G1orAgUsp2Dbr0iwwMw
	t8fUCE1k92TiF8WGrWIEUUy3G5+GHhisJ2pg5r5ddK9ZwIuaYY15yvSrlXLIsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712159012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0ZWNUC2Pb10IDRHFLsN4mAj14Fjk7lK2G1G9BFqCQx4=;
	b=LXSNI6mgfuJiVQShFc3oviDQpxtZXNLCZwsb+8sl4TKoEpTx9Ns389HsCAS6SYVbkSpjcQ
	G5ifs6gtp6y5PiAQ==
To: Oleg Nesterov <oleg@redhat.com>
Cc: John Stultz <jstultz@google.com>, Marco Elver <elver@google.com>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, "Eric W.
 Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
 kasan-dev@googlegroups.com, Edward Liaw <edliaw@google.com>, Carlos Llamas
 <cmllamas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6 1/2] posix-timers: Prefer delivery of signals to the
 current thread
In-Reply-To: <20240403150343.GC31764@redhat.com>
References: <20230316123028.2890338-1-elver@google.com>
 <CANDhNCqBGnAr_MSBhQxWo+-8YnPPggxoVL32zVrDB+NcoKXVPQ@mail.gmail.com>
 <87frw3dd7d.ffs@tglx>
 <CANDhNCqbJHTNcnBj=twHQqtLjXiGNeGJ8tsbPrhGFq4Qz53c5w@mail.gmail.com>
 <874jcid3f6.ffs@tglx> <20240403150343.GC31764@redhat.com>
Date: Wed, 03 Apr 2024 17:43:32 +0200
Message-ID: <87sf02bgez.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Apr 03 2024 at 17:03, Oleg Nesterov wrote:
> On 04/03, Thomas Gleixner wrote:
>> The test if fragile as hell as there is absolutely no guarantee that the
>> signal target distribution is as expected. The expectation is based on a
>> statistical assumption which does not really hold.
>
> Agreed. I too never liked this test-case.
>
> I forgot everything about this patch and test-case, I can't really read
> your patch right now (sorry), so I am sure I missed something, but
>
>>  static void *distribution_thread(void *arg)
>>  {
>> -	while (__atomic_load_n(&remain, __ATOMIC_RELAXED));
>> -	return NULL;
>> +	while (__atomic_load_n(&remain, __ATOMIC_RELAXED) && !done) {
>> +		if (got_signal)
>> +			usleep(10);
>> +	}
>> +
>> +	return (void *)got_signal;
>>  }
>
> Why distribution_thread() can't simply exit if got_signal != 0 ?
>
> See https://lore.kernel.org/all/20230128195641.GA14906@redhat.com/

Indeed. It's too obvious :)

