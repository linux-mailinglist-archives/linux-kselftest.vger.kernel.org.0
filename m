Return-Path: <linux-kselftest+bounces-39287-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3A8B2BAD5
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 09:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4322C5285D8
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 07:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8407F27B353;
	Tue, 19 Aug 2025 07:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c/6nEF8z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6I0mRjty"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D9820F08E;
	Tue, 19 Aug 2025 07:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755588755; cv=none; b=NL52UMawc6Wp+8rK9tnqUB3NXo+F5iwLk3hWGJ6flcms+3Pvwh+nBwXJTerTSdFZnccVK2MeZapplrxwvaMuWQqzgxQRGM0w69ysLk62a4q2b0rzSntxAgCAt+oPnvropYQsWvgTLflowgQ5qS2H9RVB+aQh8mVrrK0RXtXrK+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755588755; c=relaxed/simple;
	bh=2wLuAo381KhJtQkRClMN8LIhb7JAua7arGcFv6fvF5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BbGBmQSlw6KPowY7JwdO86CcxOpE6Gg5HvpTrFIj7e1axQ7r7IIKzxIWTnSiYfwgciWRX1/yBM8ZZbmbBvDLUUrxypNIUoUDY+uSjTg7/D7LjZptQViCiSVgPl7YKBoH11VLyVqjgl5u//yu6A3MOzZ3m2qM3Wj99Ednjmo6uQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c/6nEF8z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6I0mRjty; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 19 Aug 2025 09:32:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755588751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6ghg175AsfGLoXkygcsu9yHvH4+ZO7WfnjSNzxFio3g=;
	b=c/6nEF8z8gz4O37DYDw1UBFgXIoXkNfInJlOTVTaDuRMROLdBw0inxnLyebJNDoRTmFR19
	qoAGPC0UCyb5s1/j2Uo2wM/0bEs+iQvEP1XyrtFOq/6R87DfiKDFeys6W4Chz7GETQAqd1
	kPWsNudNlDkJJN1qY9Kror9zGRLyPOUHjxJ4w0sSCkJEqpGZz+qQdI9ZCVF1ArpTOZzT18
	crGT4lhA4rD73hXLMahc7ke5pFSzTMunxlm3laR7sli7669vPW8PQAe9/8vuFSHHYqOBLb
	Ixe3oWJji4yCXkG967rHon2eDlhhziDNTK5nXpHchJ8Ac7NRP5Tmb8/uT99+GA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755588751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6ghg175AsfGLoXkygcsu9yHvH4+ZO7WfnjSNzxFio3g=;
	b=6I0mRjtyAJNSzny5lUR1ktAlSQeaxUcJf8Ljxxox0g08EOYi03ypYl43nIqMyxgs1oGgyR
	B6iauQpyGPvdmpAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Waiman Long <longman@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Colin Ian King <colin.i.king@gmail.com>
Subject: Re: [PATCH] selftests/futex: Fix some futex_numa_mpol subtests
Message-ID: <20250819073230.9YxJoQY3@linutronix.de>
References: <20250810222742.290485-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250810222742.290485-1-longman@redhat.com>

On 2025-08-10 18:27:42 [-0400], Waiman Long wrote:
> The "Memory out of range" subtest of futex_numa_mpol assumes that memory
> access outside of the mmap'ed area is invalid. That may not be the case
> depending on the actual memory layout of the test application. When
> that subtest was run on an x86-64 system with latest upstream kernel,
> the test passed as an error was returned from futex_wake(). On another
> powerpc system, the same subtest failed because futex_wake() returned 0.
> 
>   Bail out! futex2_wake(64, 0x86) should fail, but didn't
> 
> Looking further into the passed subtest on x86-64, it was found that an
> -EINVAL was returned instead of -EFAULT. The -EINVAL error was returned
> because the node value test with FLAGS_NUMA set failed with a node value
> of 0x7f7f. IOW, the futex memory was accessible and futex_wake() failed
> because the supposed node number wasn't valid. If that memory location
> happens to have a very small value (e.g. 0), the test will pass and no
> error will be returned.
> 
> Since this subtest is non-deterministic, it is dropped unless we
> explicitly set a guard page beyond the mmap region.
> 
> The other problematic test is the "Memory too small" test. The
> futex_wake() function returns the -EINVAL error code because the given
> futex address isn't 8-byte aligned, not because only 4 of the 8 bytes
> are valid and the other 4 bytes are not. So proper name of this subtest
> is changed to "Mis-aligned futex" to reflect the reality.
> 
> Fixes: 3163369407ba ("selftests/futex: Add futex_numa_mpol")
> Signed-off-by: Waiman Long <longman@redhat.com>

This makes sense.
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian

