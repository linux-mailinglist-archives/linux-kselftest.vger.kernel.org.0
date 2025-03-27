Return-Path: <linux-kselftest+bounces-29871-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 974E0A73A7C
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Mar 2025 18:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EC907A3E25
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Mar 2025 17:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6DD35977;
	Thu, 27 Mar 2025 17:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nxD4MqK2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wAe4owd+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5184CDDD3;
	Thu, 27 Mar 2025 17:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743096753; cv=none; b=KILB/b6WTaOHhK9REXT/Eo044NwJAr/FIxwRppPwL5mhebtxuZKo+/upCtshS69Jod+eI3Jdr4iv0slo/5Zxkna2ze3Yh2LwcygqLtWTnkT3jmlE+npXCnl56Uf7GHcKXIcEgA69wonaDsf2T8oB6hV6vNXQ9zEQ4fNrdklMCUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743096753; c=relaxed/simple;
	bh=bruqDQ91bY1u8bLhPN8dGiaW/bKoNawVJ7r8njBA4og=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LMDgj1eJa7XjCsFR+5LeO11WQ4rBp0+xTiV9JwtVeUzdhSK0sW1SKf+7YLqxixZwDXZFL/UxNpAsh4CFh7QXIGrB+F3kyFap4pMHDH+vsZR9vEcRm0Mkjzy+INSNbTtNKIvJo2Mzdfgs4ZtDgvmtc9g90Q5RQ3kafUH4pH+6lsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nxD4MqK2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wAe4owd+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743096750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aCF9YAPPTg0G/VZvO7ssO5AXFYNHvZkHK2oCBQEtTkM=;
	b=nxD4MqK2VDREo0N1JVC753CtIZgVemErx9ye5ZEyWDo1uV3/Tk9tgAs+nYO4Bx6xzlJJtQ
	15hCVyBPCibfJmNzFzn8NKgp1qn8gYnBN7zNcDbfQbU2TTPacjyA2JUHa4QOBDd6ytivoq
	Dzl8lvu806v/VVv55c/BKgizp7I9XjtGfEhUhUlwflnP1KCmn1GhR5gvzcX0tRgwQkaNsO
	u9A0xpYODd3MzlQWZYm5NgCL1DAIn5ukhx1UanJE3gxZ6oJ/Qv6h6DFbfRO97dXVUAMlxO
	CCU/G0uMkGwWAvAX9HjCdK/5mwIpq2TfPV7Fj4Rp9Oj8b3C0p74OqJNlCCbYCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743096750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aCF9YAPPTg0G/VZvO7ssO5AXFYNHvZkHK2oCBQEtTkM=;
	b=wAe4owd+VWF/06neZgD1upVu7sJIWSdeh3kry8gAqWupOkT7Uu8qaDVw/Ttj2CfeNte2Qa
	x1NWhxoCUVpHQyBw==
To: Miroslav Lichvar <mlichvar@redhat.com>
Cc: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 kernel-team@android.com, Lei Chen <lei.chen@smartx.com>
Subject: Re: [PATCH v2 1/2] time/timekeeping: Fix possible inconsistencies
 in _COARSE clockids
In-Reply-To: <Z-Vx8kV4M3khPknC@localhost>
References: <20250320200306.1712599-1-jstultz@google.com>
 <Z-KURRE_Gr72Xv_n@localhost> <874izezv3c.ffs@tglx>
 <Z-Vx8kV4M3khPknC@localhost>
Date: Thu, 27 Mar 2025 18:32:27 +0100
Message-ID: <87bjtmxtuc.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Mar 27 2025 at 16:42, Miroslav Lichvar wrote:
> On Thu, Mar 27, 2025 at 10:22:31AM +0100, Thomas Gleixner wrote:
>> The original implementation respected this base period, but John's
>> approach of forwarding, which cures the coarse time getter issue,
>> violates it. As a consequence the previous error accumulation is not
>> longer based on the base period because the period has been reset to the
>> random point in time when adjtimex() was invoked, which makes the error
>> accumulation a random number.
>
> I see, so that value of the NTP error is already wrong at that point
> where it's reset to 0.
>
> To clearly see the difference with the new code, I made an attempt
> to update the old linux-tktest simulation that was used back when the
> multiplier adjustment was reworked, but there are too many missing
> things now and I gave up.

Can you point me to that code?

It would be probably useful to create a test mechanism which allows to
exercise all of this in a simulated way so we actually don't have to
wonder every time we change a bit what the consequences are.

Thanks,

        tglx

