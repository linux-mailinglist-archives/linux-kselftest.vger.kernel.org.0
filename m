Return-Path: <linux-kselftest+bounces-31061-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFD6A91C6D
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 14:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1081E5A5844
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 12:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8178D241663;
	Thu, 17 Apr 2025 12:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O25nyECe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3SGlk+Dw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0A5182B4;
	Thu, 17 Apr 2025 12:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744893423; cv=none; b=t8eKC5sVKiqxGjam1oUxzd9NaaG5sJkqDXCvW7CYK6aKXrmBfxhdfpv1sys6Lrj3e8lTnqUQVasZWCZpbKGa1S9UsHMyl119CmdqpsZA9b6O75CakNDVPoMXomT4mhVRhf+5nrudWEpC1/443wTOsXnXmCYI1lXfa6PUtWN2+VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744893423; c=relaxed/simple;
	bh=4U7pAtsP86XpxhRzRp+QzvCo/nlFYwDOE1lcXezX5P0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qZUa59z8yZFJYf+nE6cZTWcXbT3Y32bzVYIa6bCGpNrd/N5kMkLs3U08ienjBISm9ManlOz+Z5RTXRQGP/UxG74f67OmA6Tz/t1gw32MvBx5kdQ8MtgRLTiJBPgM/3C2oYM+z1k7OoEksnNX/zuzXZe5Zx9jm16+USFWnIv8is8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O25nyECe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3SGlk+Dw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744893419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aCKQRidTo69sAO5WoLA8RVR5lHcaFFP9FBycq+t7MAc=;
	b=O25nyECeB5OSXyoPyyyc+PyE+CmMFc3L0AfOckhWXRoCZLrTPvQhIeUTs3k6ITI6xXmuAr
	rXQHcFM8u9VCnqeVRo+n4NJF0b4EzKEVetyeEJ1gUdn1PKC22+gHEeDk4mbyhwtbv3/jKj
	G68kohMBJXBjqR/4wBUeOKbjhI2e99Emo+LlRNjis6I0a5F75Vlo2+lD7ZLBpzrx1TweoF
	iQYO5XcGWo4LTGcyeC6Acc65qKQWJOqzfXa0WWSxuOvgp7pZBou1ddTAv/+//mIM0G4ifb
	ILPpD3a0DOzu8qs+J6WAnNlnkwdWu6H0JjuQxn9S9Zzowib4N1x2RTls3slQKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744893419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aCKQRidTo69sAO5WoLA8RVR5lHcaFFP9FBycq+t7MAc=;
	b=3SGlk+DwzX8LcKmyd9APUaWXZ0w+HTSg7wM9iV5H8yKwk+T5Emjjor7AJDetXSyMFJosoy
	jC3YhosNyhGqf6DQ==
To: John Stultz <jstultz@google.com>
Cc: Miroslav Lichvar <mlichvar@redhat.com>, LKML
 <linux-kernel@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, kernel-team@android.com, Lei Chen
 <lei.chen@smartx.com>
Subject: Re: [PATCH] timekeeping: Prevent coarse clocks going backwards
In-Reply-To: <CANDhNCpAVo7FsmGhTVRMkazUT18dZG42M82O3QPQE8XobsWOaw@mail.gmail.com>
References: <20250320200306.1712599-1-jstultz@google.com>
 <Z-KURRE_Gr72Xv_n@localhost> <874izezv3c.ffs@tglx>
 <Z-Vx8kV4M3khPknC@localhost> <Z-qsg6iDGlcIJulJ@localhost>
 <87o6xgwftc.ffs@tglx> <Z-vL3cVZuQ8XQXhG@localhost> <87iknnwxa4.ffs@tglx>
 <Z-5HlSUEh1xgCi4f@localhost> <877c41wkis.ffs@tglx> <87h632wals.ffs@tglx>
 <CANDhNCpAVo7FsmGhTVRMkazUT18dZG42M82O3QPQE8XobsWOaw@mail.gmail.com>
Date: Thu, 17 Apr 2025 14:36:59 +0200
Message-ID: <874iynrml0.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Apr 16 2025 at 22:29, John Stultz wrote:
> Looking over the patch, it seems ok to me, but in a test run with it,
> I've seen an error with CLOCK_REALTIME_COARSE during the
> clocksource-switch test  (as well as some seemingly unrelated test
> errors, which I need to investigate) so I'm looking at the zeroing
> done in timekeeping_forward_now and will try to look more into this
> tomorrow.

Odd. I ran all the test nonsense here and did not run into any issues.

