Return-Path: <linux-kselftest+bounces-35942-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F97AEA95C
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 00:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A4F57A986F
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 22:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0842C2609F5;
	Thu, 26 Jun 2025 22:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NiewYSwo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4ddefJky"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B14D20C024;
	Thu, 26 Jun 2025 22:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750975778; cv=none; b=TQLApb6CE9HhslibmhcwWZVn1Xuwq/l/RWMMfHqJnkAeVu1YLJPPROEUnk4KBJyfkCh+JF62huxixZW1VTJlcTcRArWfG6mYG/TZdatI6unfZmsgjfmxvQSpw0jjrk3+1pKsfcb+zNbIggHMcu1tzBpPaoO4JjIeNrR3Ro6SAgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750975778; c=relaxed/simple;
	bh=8Q31b4CQqHIUk2xjlK7k9PkKJ1PtpfFMkYpN7OJEdeA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pw0Dwxc4PVzW7Me/x4XFzuSa53SU5D3/BcXb6CznfMmrPkdXmgHDDW+VGB63dfUjGAh4mIOUcS6JQITTrcykaAicfTul1IfCSeofh8Y7vie+QHyuWa3zRWfDkE7cXryiTDr6YdKMvO5+avu/WSciTx1O09wbqz+ZlwD1IjyL+rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NiewYSwo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4ddefJky; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750975775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Q31b4CQqHIUk2xjlK7k9PkKJ1PtpfFMkYpN7OJEdeA=;
	b=NiewYSwoLOob1iZUNkc/JOWdcuZFLefaYCYQOM3451d5UENZt6BVmzGGjMgfePurJjMvn6
	8fl/pUs5eLANUdu6CxfU1JJxR5XJ6Ajh7bk9Mu4yGS0BgFjOPAszJrazKz9bO6qKrEWKCy
	DGl8qEM3Tg84wedTLpjtv8NA4limrdiuKgjBsjWwYpG7t83cgTqETkDLrw8QnehuSF/9oY
	g45XrUa7jBeC8Jd4oJ1yYD24oJkt2jcohpy8OovKvvAW6rq014LD+Of+JjVEaipv1UGkXw
	uw9eN080bFV7ml2RSTlVD5QwVo1CPC+PFaNr1KAC7yEiQ7dhUPReSVdMbZSa+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750975775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Q31b4CQqHIUk2xjlK7k9PkKJ1PtpfFMkYpN7OJEdeA=;
	b=4ddefJkyx2z8wEfTxbjHthYNTFQenY44EtkhGqvFmxNLHTrLuJNu2RXTdD2vrkYeIm4LJM
	abB26UE5U1C1bKCA==
To: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>, Ingo Molnar
 <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Shuah Khan <shuah@kernel.org>, Arnd
 Bergmann <arnd@arndb.de>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Waiman Long <longman@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-api@vger.kernel.org, kernel-dev@igalia.com, =?utf-8?Q?Andr=C3=A9?=
 Almeida <andrealmeid@igalia.com>
Subject: Re: [PATCH v5 1/7] selftests/futex: Add ASSERT_ macros
In-Reply-To: <87ecv6p364.ffs@tglx>
References: <20250626-tonyk-robust_futex-v5-0-179194dbde8f@igalia.com>
 <20250626-tonyk-robust_futex-v5-1-179194dbde8f@igalia.com>
 <87ecv6p364.ffs@tglx>
Date: Fri, 27 Jun 2025 00:09:34 +0200
Message-ID: <87bjqap335.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27 2025 at 00:07, Thomas Gleixner wrote:

> On Thu, Jun 26 2025 at 14:11, Andr=C3=A9 Almeida wrote:
>
>> Create ASSERT_{EQ, NE, TRUE, FALSE} macros to make test creation easier.
>
> What's so futex special about this that it can't use the same muck in
>
> tools/testing/selftests/kselftest_harness.h
>
> or at least share the implementation in some way?

BPF has it's own set as well. Sigh...

