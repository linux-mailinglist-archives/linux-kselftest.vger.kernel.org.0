Return-Path: <linux-kselftest+bounces-29635-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 606F6A6DA4D
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 13:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9AAE7A35E1
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 12:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B8425EF9B;
	Mon, 24 Mar 2025 12:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aeJpHzaf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4CC25EF90;
	Mon, 24 Mar 2025 12:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742820681; cv=none; b=KgCFkt1BKhVjPViLtihS8caT/6sEenpMwQs3o7ZhWajAUb2PjiFpFLOwzy7USQLPNO5cEv4ZJZQlQJW1njdsHKFUKo5meOuBq5mCzSQSpZocqkfpuhm7TJVHiSbu7t7cWRBoVJkaC5JkU1fStJbgyB19SM98YPxS5DBwLkSuypM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742820681; c=relaxed/simple;
	bh=SskKo6BEXqjWismZvLLpJ50BS/HyqQjryM3kuO4JNZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oMnuKPxoB7eevc/hC7iWnY/EgXEh2BxZTSFKb5TJAgLlmnz12s2Om3p18PJzmjvXrxMTCb05enlhtb0UjfrxnXTgnX2PA9SsrqqbBL44/Ai8N6wMGTffgvu8Jd+RzV9n/YIUYL4vXnjA+mH9+etZKGnat0GTBUhxgT5DU69hE+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aeJpHzaf; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=I8xvSTrF+CLj7ibckfWAmAEUfTSv6VxXJGkoERVw5mQ=; b=aeJpHzafuJzRiuIf+GMnlKs3z1
	3/ZEeienyTdidSujp1qb47Li5I4tSrols2bHwGRikoJ1yWBa2Tpf/3u2VPhG8nqWN0TGXeewvsfTJ
	deLuRo+pkgztXbwcTgdgyLrvF1SGtDjkSFSjyvf2k5FH3jn7uAy3V2y0pts/SW6iZxcPHgAYdd8EW
	SkD6Bee0IcPvmI0yzjl3mlNWPQOc/KdFaYD7KY0l+fIuat++A0T41vU9/bJpS4rZsqPebfANwDREP
	4ZVWNN7nTp5hCyLWrOGMUU838Dl3y3UOIWG0s8L3XjnptAs/4VvvV3fhJaTsF1mBMOJezgnPIRlny
	IbNHE+Xg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1twhGn-00000000g68-1nyj;
	Mon, 24 Mar 2025 12:51:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id AFEC93004AF; Mon, 24 Mar 2025 13:51:08 +0100 (CET)
Date: Mon, 24 Mar 2025 13:51:08 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Malaya Kumar Rout <malayarout91@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/x86/lam: fix memory leak and resource leak in
 lam.c
Message-ID: <20250324125108.GH14944@noisy.programming.kicks-ass.net>
References: <malayarout91@gmail.com>
 <20250324124810.883767-1-malayarout91@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324124810.883767-1-malayarout91@gmail.com>

On Mon, Mar 24, 2025 at 06:17:50PM +0530, Malaya Kumar Rout wrote:
> Static Analyis for bench_htab_mem.c with cppcheck:error
> tools/testing/selftests/x86/lam.c:585:3:
> error: Resource leak: file_fd [resourceLeak]
> tools/testing/selftests/x86/lam.c:593:3:
> error: Resource leak: file_fd [resourceLeak]
> tools/testing/selftests/x86/lam.c:600:3:
> error: Memory leak: fi [memleak]
> tools/testing/selftests/x86/lam.c:1066:2:
> error: Resource leak: fd [resourceLeak]
> 
> fix the issue by closing the file descriptors and 
> releasing the allocated memory.
> 

But but but, doesn't the program just exit on any of those 'errors'
anyway?

That is, iirc this is a single shot program.

