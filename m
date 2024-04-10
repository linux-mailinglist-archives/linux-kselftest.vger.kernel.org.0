Return-Path: <linux-kselftest+bounces-7612-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6748A0367
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 00:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD1ADB21829
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 22:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C69E1FA5;
	Wed, 10 Apr 2024 22:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0qpQ9mYn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NM1JXoXk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BB5946C;
	Wed, 10 Apr 2024 22:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712788316; cv=none; b=IB89o79z0gwXybHUHGbPUbg/jhiOA/x8qyhM5/PD1mzW0rCnWb+zQtxAng9zDUwHHVYIeecx4pYVc0PY1VDYosdCmMiTzgThgvGxrZXuBGQSgDsoOqLr/w0wMPFVZdiZdcXSqbYK+JApPjKZnHXMw7RXydA0P54/lgPFuuR7NKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712788316; c=relaxed/simple;
	bh=CQAkRLHzbHNeQ4XNjYisH376qoK2YXzgcIKtK0/F6IM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TvbD+JtzWpw/O4ina1SwlPRZoyCaMQKnk9PxUTEHtAu7uudvgN/2UDHbEnn7Lr8RBPUaQ6rdv/f6N3y8CVM+c2y6rqbOODYcD0WF3TpLwBIPo94USbjiGer2aPaatm9I42b/PUdM2zn4S2W4SdfkicYWtapfW2JbHizdyDGfZ1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0qpQ9mYn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NM1JXoXk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712788312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JiCIrEt1XaB7glCHGKWy0bvbFt+bdOBFG+aYBovTWNY=;
	b=0qpQ9mYn7/RK66bvyakaRZyX1QXI0C/xFXLbq8msszSeAifJTQaQOCbfa3NjPnLWZfyNFd
	237z2m55CSNrMTwuWgDiAoaPxSLbSuK1XWXr4lbOnmUBHjRAlyiRdwRexEnz/Brg5hGq2b
	8yBpn17CQMaH8ri+S+eRv1tfA1PrqnShxhR1GydRM/+tLT7sKXcsLueFD7paIHJu+l/UMF
	znRNLcHqeV7M1tGxy8B+qS8M2bDwVgMAy9gIhfmd1WwdOjjHtDdqdWnjWurcc52mh8CCvs
	XcnUOxMCyct9/XClFNeBX4XtUew1tmSSuZvrrET9flpnK/SlWJ7GAifbI7JIPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712788312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JiCIrEt1XaB7glCHGKWy0bvbFt+bdOBFG+aYBovTWNY=;
	b=NM1JXoXkoAEEAMysStVpj+bPDuS1AZPO5wUVMixGO3fXwkelntDZb+ytkoxKNZrWdCDGJf
	GrWRfzuZDdyu2QBw==
To: John Stultz <jstultz@google.com>, Oleg Nesterov <oleg@redhat.com>
Cc: Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kasan-dev@googlegroups.com, Edward Liaw
 <edliaw@google.com>, Carlos Llamas <cmllamas@google.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] selftests/timers/posix_timers: reimplement
 check_timer_distribution()
In-Reply-To: <CANDhNCrverCP+nB53XnMKFH4sTvxmtchiLWyGbNW6du=8xOSNg@mail.gmail.com>
References: <20240404145408.GD7153@redhat.com> <87le5t9f14.ffs@tglx>
 <20240406150950.GA3060@redhat.com> <20240406151057.GB3060@redhat.com>
 <CACT4Y+Ych4+pdpcTk=yWYUOJcceL5RYoE_B9djX_pwrgOcGmFA@mail.gmail.com>
 <20240408102639.GA25058@redhat.com> <20240408184957.GD25058@redhat.com>
 <87il0r7b4k.ffs@tglx> <20240409111051.GB29396@redhat.com>
 <877ch67nhb.ffs@tglx> <20240409133802.GD29396@redhat.com>
 <CANDhNCrverCP+nB53XnMKFH4sTvxmtchiLWyGbNW6du=8xOSNg@mail.gmail.com>
Date: Thu, 11 Apr 2024 00:31:52 +0200
Message-ID: <871q7c3l47.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10 2024 at 15:21, John Stultz wrote:
> On Tue, Apr 9, 2024 at 6:39=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wr=
ote:
> This is working great here (on both 6.6 and the older 6.1)! Thanks so
> much for fixing this!
> One nit below, but otherwise:
>   Tested-by: John Stultz <jstultz@google.com>
>
>> +err:
>> +       ksft_print_msg(errmsg);
>
> This bit is causing the following warning:
> posix_timers.c:250:2: warning: format not a string literal and no
> format arguments [-Wformat-security]
>   250 |  ksft_print_msg(errmsg);
>       |  ^~~~~~~~~~~~~~
>
> A simple fix is just to switch it to:
>   ksft_print_msg("%s", errmsg);

Can you please send a delta patch against tip timers/urgent?

