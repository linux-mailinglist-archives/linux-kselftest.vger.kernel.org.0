Return-Path: <linux-kselftest+bounces-30344-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F6FA7F8D7
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 11:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 212DA189C538
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 09:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B337522257F;
	Tue,  8 Apr 2025 09:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FLTcbOre";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RAAYx+1g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30828206F31;
	Tue,  8 Apr 2025 09:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744102854; cv=none; b=FmLuMw9FV2VTnPdcWBX/6/lNIXKmTmXSSp4JWc+EzFUXTAq95m1G7QlAniLwxQ+LG0aSc+5PI1VTqbGfC/W34UL+bNzgX63Z3s++UAqnW7Kno2zjrdD2js+WT37Drwif1r49NB8ZLpQwloteptj0iZ9x8twvqWC4vH7mwIGmob0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744102854; c=relaxed/simple;
	bh=Z/pcvKfgNqZVt5kg+UI9M+1DEbsC3c9S7vBAF3ADiIM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=USbycY9t66Jl03CvVVEuJQ1VDVxQpa7ZmgvIP0oDgoQ/XEqRENU3jDS9iYLczn6SfHe85eGgVBhgEU7CmFCIHPoTHupnJpUmiotkDbB8et5Pb//dD1zwVmzo1mKXec3sleSYwWYc8+GLPnKQ84QSHDx7sc6xO7ZWqd9SA+tD0C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FLTcbOre; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RAAYx+1g; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744102851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z/pcvKfgNqZVt5kg+UI9M+1DEbsC3c9S7vBAF3ADiIM=;
	b=FLTcbOrekMjaZiOAywyNvzZAWxshyzHJMfAuKxuvSgOQQxrTv3pGJSv5wXNlH7AznJ/Bxj
	BzB7j6vBE/VsSyPfgr48tMz+VU6RbZO9E3TmpGeaNGVHthaZ82XU1S2vJV8cvLO3CcZ7r0
	VYxpaACs/+forcgxrjUfhDmNO24pH+LaBdMftEOtzuftXWGq2pFE4LAc7lbrDea5EYTSL1
	N4NPQqkvEt/Nl198DNKzORZloyygiBTntm+vnV3Be+saXmLjYOzJJVv1O+RkcZOe0eZUyq
	pEGWEi4cuvLsM+Qo82AN8kCDk/jDI0FgMZLtvq2npvtUfSC8JNYKsIwtA7ugcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744102851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z/pcvKfgNqZVt5kg+UI9M+1DEbsC3c9S7vBAF3ADiIM=;
	b=RAAYx+1g87X/fuPtv+7fUKIjVyB4ca7ZsoUSkjyxj1pLcsu3OBj+BqWcPw91uI7t2JiPLK
	J4AZewqWuWcEPiBg==
To: Edward Liaw <edliaw@google.com>, linux-kselftest@vger.kernel.org, Ingo
 Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Darren
 Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 =?utf-8?Q?Andr=C3=A9?=
 Almeida <andrealmeid@igalia.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, Edward Liaw
 <edliaw@google.com>
Subject: Re: [PATCH] selftests/futex: futex_waitv wouldblock test should fail
In-Reply-To: <20250404221225.1596324-1-edliaw@google.com>
References: <20250404221225.1596324-1-edliaw@google.com>
Date: Tue, 08 Apr 2025 11:00:50 +0200
Message-ID: <87ldsbuiwt.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Apr 04 2025 at 22:12, Edward Liaw wrote:

> Testcase should fail if -EWOULDBLOCK is not returned when expected value
> differs from actual value from the waiter.
>
> Fixes: 9d57f7c79748920636f8293d2f01192d702fe390 ("selftests: futex: Test sys_futex_waitv() wouldblock")
> Signed-off-by: Edward Liaw <edliaw@google.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

