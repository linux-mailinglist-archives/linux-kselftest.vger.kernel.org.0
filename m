Return-Path: <linux-kselftest+bounces-6989-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7AF8957CE
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 17:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1C83B29063
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 14:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AAE129E78;
	Tue,  2 Apr 2024 14:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qtcSN0Ml";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1uVgVveT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715CE17BD8;
	Tue,  2 Apr 2024 14:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712069865; cv=none; b=fOTOoKgzc5kULlzDc7xE1MPgblE4p9DVFzDotGLK1Vvm8XFsvDlbjceY60ZDDKpB74hhCT7bu9TFuSVwYO9vHv88VPj1ewYsJWP0ZaOYAKjn20iscbqJ+a3MXuj1uDMhT5hNbtm/1FI1cdBWZ79vWPrv/1/+YBFDtHpEFoTWwGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712069865; c=relaxed/simple;
	bh=5fZg5QWgvKLZtjYce+k9weQ/XmQqOIU56cLlpWouz1U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=azHpFG/ufl8ADeZxwzQEIpUw6pIw+JwKmltlX/evFcPxKA6UYrL+D38ENGc76tkySIXeezPWeFRv6jNm8VhyF5YEwHE6llk6DO9EH493qsRs44bOXIStaV0SWJtqL6Wet6tbJdyOXWVsh3gca7vOVSQZMMKaDfUTfoFGGFSKjog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qtcSN0Ml; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1uVgVveT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712069862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NIf2A5XgT+mSuLeFeNcerJGYHIuW/buAb+x1UGGwSvc=;
	b=qtcSN0Ml+uulz1MBPI5yX3dxO+D+BxS0GQB9loNAx+1qy8o8f6+08TJdS1yPqvCCZRS5ZL
	Vh8IA+n+yInbBJYszYKIVGNzObdD8SnGPs2FvsvfWlsxdiLXOv4Ulevvhbpyqk83xkIR7F
	b98/XBV2uVbowtiNEhZ/yDBbUIADwwQD0hoKEOI3UFzp3PVNZU2PTrab11N5zWR6atqf+f
	2RDgeaAvI9zBaZc1BYZFxprWY2jeQoDC3VVYGgUrtc5IH0Fu5WaRxLYtw4yxYpgJRBxvbh
	VjYhALIE1hnqdY51w+5f2NN3RUmP2JxlnaLswQD0HAdidlPqum0MxRI+UKNicA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712069862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NIf2A5XgT+mSuLeFeNcerJGYHIuW/buAb+x1UGGwSvc=;
	b=1uVgVveT8jsAq2IsPas3JyTp+ZuLAZAUuFrNVw2wPOpr24nhGjd8RuBTFQ6NW+lJIHkHNI
	EwMq2PfkSoKDYPDA==
To: John Stultz <jstultz@google.com>, Marco Elver <elver@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Oleg Nesterov <oleg@redhat.com>, "Eric W. Biederman"
 <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
 kasan-dev@googlegroups.com, Edward Liaw <edliaw@google.com>, Carlos Llamas
 <cmllamas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6 1/2] posix-timers: Prefer delivery of signals to the
 current thread
In-Reply-To: <CANDhNCqBGnAr_MSBhQxWo+-8YnPPggxoVL32zVrDB+NcoKXVPQ@mail.gmail.com>
References: <20230316123028.2890338-1-elver@google.com>
 <CANDhNCqBGnAr_MSBhQxWo+-8YnPPggxoVL32zVrDB+NcoKXVPQ@mail.gmail.com>
Date: Tue, 02 Apr 2024 16:57:42 +0200
Message-ID: <87frw3dd7d.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Apr 01 2024 at 13:17, John Stultz wrote:
> Apologies for drudging up this old thread.
> I wanted to ask if anyone had objections to including this in the -stable trees?
>
> After this and the follow-on patch e797203fb3ba
> ("selftests/timers/posix_timers: Test delivery of signals across
> threads") landed, folks testing older kernels with the latest
> selftests started to see the new test checking for this behavior to
> stall.  Thomas did submit an adjustment to the test here to avoid the
> stall: https://lore.kernel.org/lkml/20230606142031.071059989@linutronix.de/,
> but it didn't seem to land, however that would just result in the test
> failing instead of hanging.

Thanks for reminding me about this series. I completely forgot about it.

> This change does seem to cherry-pick cleanly back to at least
> stable/linux-5.10.y cleanly, so it looks simple to pull this change
> back. But I wanted to make sure there wasn't anything subtle I was
> missing before sending patches.

This test in particular exercises new functionality/behaviour, which
really has no business to be backported into stable just to make the
relevant test usable on older kernels.

Why would testing with latest tests against an older kernel be valid per
se?

Thanks,

        tglx


