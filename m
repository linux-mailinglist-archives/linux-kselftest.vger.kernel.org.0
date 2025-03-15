Return-Path: <linux-kselftest+bounces-29143-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE37FA6320D
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Mar 2025 20:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21E0C3B0C61
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Mar 2025 19:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A236C19AD8B;
	Sat, 15 Mar 2025 19:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VWiCjKq3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W2gIlOn/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B1E199E8D;
	Sat, 15 Mar 2025 19:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742066612; cv=none; b=X6/NHRg6OnpxrqD4WJrrVPaw8BD8XsgqqgGgWpsIxQoleNOPoWuMNr2yUksUqB15sJeWI/290ucp0nh7UYklf5xa8/C43VtnryF4+WNPN7uEyQ8ahTSfXQZYekVDv1ifCZBUFJrzv6G4ZGp030qmeWhqrE99zxoWqqpf+/fEdqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742066612; c=relaxed/simple;
	bh=V2GjZ+Wme+82fiO8P+KF6QQrrM8s9f4K2x2lxB+XAh4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q46wqfdGo9u/wQpQ/HEewBXQNsLjKfRBn+QHCjmqdE99pyUOx3MOOrJvKv0aSEelCQCH5Z8ikFulg98SRNayggeFP4aUn25XF2kwBxRKC6Vi4OBv2W5mtYnq7v66ym040A/YYL9qhcUOzVK8N/ndIXELIXnrGAyuhBDCxnBcdUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VWiCjKq3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W2gIlOn/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742066602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ed91DmtJ8+cC57ZeKK493iuWEPzr9T903d0c/Mk88VU=;
	b=VWiCjKq3ZQ4oGq4eTFP610BP8zXYSNNgPdynEO5zj+Mp3sXVYb6ewL/vSSmBHovETU9a15
	wr5NVQXv4YkQvdUgpeL+7rkmyepeG+IcOrv1SoMFr/SZkoU5o8NeZxuRHVQj7ShqlSIO6+
	C73Dv35nqaaoBGibQk71jOip4k4OpD9dSfskYEv3yeEs9jYbv0Fq5r5GWRhomU+qv2QOvt
	pvnULCkPzZNJoMyZW1Daj0NbhfOyLC2D3FgkJIkWLmIutG7azGy4/eB8PrW3nMw0LX3niF
	0GKa0hv0aF2WF2lv7sqH5oOVFFTeOPmMfzQtq00HQOvr7BXl4/8VDJQEPgyv4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742066602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ed91DmtJ8+cC57ZeKK493iuWEPzr9T903d0c/Mk88VU=;
	b=W2gIlOn/bbcHamghmjgEj7N+41Anp9ccjkAeg/2bDVF0bNNdSaDW+KWmppnhCbHHWunahS
	FYotzAFoFlXPMFAA==
To: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, Shuah Khan <shuah@kernel.org>, Miroslav Lichvar
 <mlichvar@redhat.com>, linux-kselftest@vger.kernel.org,
 kernel-team@android.com, Lei Chen <lei.chen@smartx.com>
Subject: Re: [RFC PATCH 1/2] time/timekeeping: Fix possible inconsistencies
 in _COARSE clockids
In-Reply-To: <20250315003800.3054684-1-jstultz@google.com>
References: <CANDhNCoueki=keYNcNr4eXqgLFPh3VupDJC0hFqxm4FNKfGzYg@mail.gmail.com>
 <20250315003800.3054684-1-jstultz@google.com>
Date: Sat, 15 Mar 2025 20:23:21 +0100
Message-ID: <877c4q5c9i.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Mar 14 2025 at 17:37, John Stultz wrote:
> Now, by design, this negative adjustment should be fine, because
> the logic run from timekeeping_adjust() is done after we
> accumulate approx mult*interval_cycles into xtime_nsec.
> The accumulated (mult*interval_cycles) will be larger then the
> (mult_adj*offset) value subtracted from xtime_nsec, and both
> operations are done together under the tk_core.lock, so the net
> change to xtime_nsec should always be positive.

/should/is/

We better are confident about that :)

> However, do_adjtimex() calls into timekeeping_advance() as well,
> since we want to apply the ntp freq adjustment immediately.
> In this case, we don't return early when the offset is smaller
> then interval_cycles, so we don't end up accumulating any time
> into xtime_nsec. But we do go on to call timekeeping_adjust(),
> which modifies the mult value, and subtracts from xtime_nsec
> to correct for the new mult value.

We don't do anything. :)

> Here because we did not accumulate anything, we have a window
> where the _COARSE clockids that don't utilize the mult*offset
> value, can see an inconsistency.
>
> So to fix this, rework the timekeeping_advance() logic a bit
> so that when we are called from do_adjtimex() and the offset
> is smaller then cycle_interval, that we call
> timekeeping_forward(), to first accumulate the sub-interval
> time into xtime_nsec. Then with no unaccumulated cycles in
> offset, we can do the mult adjustment without worry of the
> subtraction having an impact.

It's a smart solution. I briefly pondered something similar, but I'm not
really fond of the fact, that it causes a clock_was_set() event for no
good reason.

clock_was_set() means that there is a time jump. But that's absolutely
not the case with do_adjtimex() changing the frequency for quick
adjustments. That does not affect continuity at all.

That event causes avoidable overhead in the kernel, but it's also
exposed to user space via timerfd TFD_TIMER_CANCEL_ON_SET.

I have no really strong opinion about that, but the route through
clock_was_set() triggers my semantical mismatch sensors :)

> NOTE: This was implemented as a potential alternative to
> Thomas' approach here:
>    https://lore.kernel.org/lkml/87cyej5rid.ffs@tglx/
>
> And similarly, it needs some additional review and testing,
> as it was developed while packing for conference travel.

We can debate that next week over your favourite beverage :)

Have a safe trip!

Thanks,

        tglx

