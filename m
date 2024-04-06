Return-Path: <linux-kselftest+bounces-7353-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 214CB89AD75
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Apr 2024 00:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AF9128224A
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Apr 2024 22:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1636535B9;
	Sat,  6 Apr 2024 22:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SaGi5AFV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NmCuyLvg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340245338C;
	Sat,  6 Apr 2024 22:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712440866; cv=none; b=JCxKIFrIQ9BzWy5vImSdMLkkbC15bVX91Nq2BuCkjJrs6YM9bdvevTBaYBb1BZznqNRpH1W8XIBJKX9qiopa4JCjEa58DJ0m4RuNzvQelHHkprLq/tT4shEfrYrQ+DFZH2hdEKHbEazyL91HYsRpxTwn9FmPNJ54wIkDs36u3AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712440866; c=relaxed/simple;
	bh=+0GdKhMpv6asSyI+rL6kNveWke/LDPkqLFj+yFi47gk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S552ZZrTt1rkhbxlXwt0xfT4UmBwCUiaYcZCDcmNLvPMu7+8GApyNXsZMOIDQ6u1ufLGAAOPWtZfBMTe2gdG8IWP0hmdPysq/S6PG9jcCbiud3d2BaKNHcOBseuJFAJnqTRFTpo8IpMNhgiQ8oWzP0wzocJnQZMOQIrwhCMmoRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SaGi5AFV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NmCuyLvg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712440856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WALSA6ekTbORB+oMNmPW1aBENZ+fWec6I1EASj2qsLE=;
	b=SaGi5AFV2boXgpVRakH5IORUzYXtObRGfaMgx2KmAP6P5s7GryxgaQnckL25v9iSSXdsq2
	YoWuzU7oG89gYV0ABMcxFJ7ynLQYHt1SGrJ9km52hCRzpGU9/0AikZMDt6gSQxj2P9KaQt
	SRuqrcWrkQO34LRzetwl4WvddVlsF3C1W0LrKxMpSy0HWgmYL41A80k6rvJ5VlsdSMdKgP
	ynxMc6o8P7RsQ4mvnSoJMcSpV4JTMU/ZQuZ9SG+qJViK6i+BqRiOyBaYM+0fpKTFm9oqtG
	W4rQ29G9WLd5EsGMVcdGL3kzYP4pMuLjal6310Mg3AzI333Z9xHZS7Fo9DPOXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712440856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WALSA6ekTbORB+oMNmPW1aBENZ+fWec6I1EASj2qsLE=;
	b=NmCuyLvgsvxONZVAwDs9CB6ED/U47OOCFL3UkiSvrsW3ITRxVJTotdpnN6Nc2D0BOFBFNx
	aIdh1EbxUsUJKYDA==
To: Oleg Nesterov <oleg@redhat.com>
Cc: John Stultz <jstultz@google.com>, Marco Elver <elver@google.com>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, "Eric W.
 Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
 kasan-dev@googlegroups.com, Edward Liaw <edliaw@google.com>, Carlos Llamas
 <cmllamas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] selftests/timers/posix_timers: reimplement
 check_timer_distribution()
In-Reply-To: <20240406151057.GB3060@redhat.com>
References: <87sf02bgez.ffs@tglx> <87r0fmbe65.ffs@tglx>
 <CANDhNCoGRnXLYRzQWpy2ZzsuAXeraqT4R13tHXmiUtGzZRD3gA@mail.gmail.com>
 <87o7aqb6uw.ffs@tglx>
 <CANDhNCreA6nJp4ZUhgcxNB5Zye1aySDoU99+_GDS57HAF4jZ_Q@mail.gmail.com>
 <87frw2axv0.ffs@tglx> <20240404145408.GD7153@redhat.com>
 <87le5t9f14.ffs@tglx> <20240406150950.GA3060@redhat.com>
 <20240406151057.GB3060@redhat.com>
Date: Sun, 07 Apr 2024 00:00:55 +0200
Message-ID: <878r1q882w.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Apr 06 2024 at 17:10, Oleg Nesterov wrote:
> Yes, this changes the "semantics" of check_timer_distribution(), perhaps it
> should be renamed.

Definitely.

> But I do not see a better approach, and in fact I think that
>
> 	Test that all running threads _eventually_ receive CLOCK_PROCESS_CPUTIME_ID
>
> is the wrong goal.
>
> Do you agree?

No argument from my side. All we can test is that the leader is not
woken up.

Thanks,

        tglx

