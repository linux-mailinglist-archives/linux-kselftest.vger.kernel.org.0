Return-Path: <linux-kselftest+bounces-7220-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D71898DBB
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 20:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31C161C28A7F
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 18:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFC712FF9E;
	Thu,  4 Apr 2024 18:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IKN17SMS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fxB5JykP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A5912FB10;
	Thu,  4 Apr 2024 18:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712254123; cv=none; b=N9/KeZdj7uqib6zRMy5IusS2JhfxV02zoxT1nmzTvZx9PiXlG6CXICqqohMbUu6gi6pbBcRASxQi/7zH2qXEgfQzm8qyfL0EbvvbhP9wK9vLO+gnR6316Kob2pALlNkYg+RsrPrzswhRqIIaqVbSJ3y9SmyxwzzahvvOo2sjPLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712254123; c=relaxed/simple;
	bh=tkMiv2B4K7kFjJ2XUNPtFrHanpcstv972bKvZlxjA74=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NUZOO0s0a7LZ2Mioqd6vZ/OPXlktyBDhqolYOkmt1AvG9nBZg/dbpl7gZcf8dPdIBMyLjCLdAx+hwlGFP42npHQRCqMT59kszPqi0IxeC3R4J/mXcKjdBUhwjibU68Rs4+BMfbigOm4afaeeTnnGo95ASqzrIiQ6vl98FV7V9UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IKN17SMS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fxB5JykP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712254120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tkMiv2B4K7kFjJ2XUNPtFrHanpcstv972bKvZlxjA74=;
	b=IKN17SMSQlnLIgXy4XcmNogo7m7DTD8DLnPDMszy0CRD0ssfFAiY135HjEzNX4QxK/F+ev
	DtGEcwVnnhew1Ad6CP4+0sQUcn4Sd9rRRXpNfBUdQyDr9ciMaJHKlvTSo5/CzXSF2xZ6lD
	uknxZ0tehvxsGlY6T2ZG0PguAq7jam/rNkYupA736F1b7rlsoPft0dDZTo/zGkHUwDqvd/
	5KH+oqO+tmELIPdT7zPyCLPBeieHIApdKQ6nFcrcFpZsevfYSs/0JvYAmxlrByZ9uPMF4m
	tVVuFNHGVDf7hysRNtqeZRVl6ALFieEm1+i0Vc74mHa3fL1JrJoId1+wqF68HQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712254120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tkMiv2B4K7kFjJ2XUNPtFrHanpcstv972bKvZlxjA74=;
	b=fxB5JykPkIfiapBWgjbkLF+Pafh4KbXqiRhWbLtcBha2jxzZnCQgrNFoU5ffThGqYA1C0Z
	Z/e8nH329LHE3sAw==
To: Oleg Nesterov <oleg@redhat.com>
Cc: John Stultz <jstultz@google.com>, Marco Elver <elver@google.com>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, "Eric W.
 Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
 kasan-dev@googlegroups.com, Edward Liaw <edliaw@google.com>, Carlos Llamas
 <cmllamas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6 1/2] posix-timers: Prefer delivery of signals to the
 current thread
In-Reply-To: <20240404145408.GD7153@redhat.com>
References: <87sf02bgez.ffs@tglx> <87r0fmbe65.ffs@tglx>
 <CANDhNCoGRnXLYRzQWpy2ZzsuAXeraqT4R13tHXmiUtGzZRD3gA@mail.gmail.com>
 <87o7aqb6uw.ffs@tglx>
 <CANDhNCreA6nJp4ZUhgcxNB5Zye1aySDoU99+_GDS57HAF4jZ_Q@mail.gmail.com>
 <87frw2axv0.ffs@tglx> <20240404145408.GD7153@redhat.com>
Date: Thu, 04 Apr 2024 20:08:39 +0200
Message-ID: <87le5t9f14.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Apr 04 2024 at 16:54, Oleg Nesterov wrote:

> On 04/04, Thomas Gleixner wrote:
>>
>> IOW, we cannot test this reliably at all with the current approach.
>
> Agreed!
>
> So how about a REALLY SIMPLE test-case below?
>
> Lacks error checking, should be updated to match tools/testing/selftests.
>
> Without commit bcb7ee79029dca assert(sig_cnt > SIG_CNT) fails, the very
> 1st tick wakes the leader up.
>
> With that commit it doesn't fail.

Clever!

