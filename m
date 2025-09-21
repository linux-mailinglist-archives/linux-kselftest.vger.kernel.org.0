Return-Path: <linux-kselftest+bounces-42014-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC10B8D70D
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 09:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25E4A1668BE
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 07:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549E82D130A;
	Sun, 21 Sep 2025 07:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kKdha3PW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rc1bcWmg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D072746B5;
	Sun, 21 Sep 2025 07:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758441572; cv=none; b=eLAsfvKSQ3O9NK9PzblM98ZkeqfRtY6JOyMltgAGOoLXxiegRHQCMZ0vtMSFTVdYlxuJLb06D7YhV4B8w8l8tF7+2Isd+rSmVwNKD8VYDAS3u0WIuo0Lsd+eBEiUKOBNCzhAQBG6yqhXF+J2ixsAwrfjTLt9HsiDI+acIXEYjbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758441572; c=relaxed/simple;
	bh=PtSTT4p20a/LZGlJuc4NQQnsML1a972kpDpubnns6Rs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CBG6wo7JF6JGZ6FUQMsO7R7XRz4wbkH/7KFxmQdrS7JlRusJZdNJKHFnVcjERgLvMBv/divjRTLGC0DFRc4hoL+gxGAu9oj7v8BBITSBU70B6zp+4qs4H/WJuFLqe9ZNEPthptMFJx3SYCADT/bMO0KcAur/kkpgYiqnhTxVv5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kKdha3PW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rc1bcWmg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758441568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qgzTW+fNXfoELpXTfDFx6F6ILchBQgnAN8zjC0dBrjE=;
	b=kKdha3PWFHhtuCZgx3r/mUJwryEbl6EfdCZVvSaoFERn9DTsjePgVn4RJokc7eaDZH6CJz
	CZCgljVLHt1KGKMkuySbd9npSyxnu7ea5rd28cYyxEK17nc5pt9kML5QklTyM2aIKslngz
	KjSTJipr/DUNiF1H5fiFvX0qoq0iMFKQxPE5W8Cqx2rdwT1YnJrV2RtBnkcbiCuNEOPLX0
	tE/3JO61vA6f/gdkjHe/5MjDzpvEAnTRWskZuZ7bxiEKNwMO24B0wFP2EK33hNycVljIJl
	y079jKqO/XDkBUmHyJ9EFGgRnueQZhiVtBfbKItZD4DC9x9cKwkJGz16cMDKEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758441568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qgzTW+fNXfoELpXTfDFx6F6ILchBQgnAN8zjC0dBrjE=;
	b=rc1bcWmgmyAGk9xtXsuLiImVzQSaTXW/J1c/XX5bozwpOk6GDSbwaKWFG3qjojWFXcVyHL
	OPS5Gj39MBvQ1zBQ==
To: Wake Liu <wakel@google.com>, John Stultz <jstultz@google.com>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, wakel@google.com
Subject: Re: [PATCH] selftests/timers: Skip some posix_timers tests on
 kernels < 6.13
In-Reply-To: <20250807085042.1690931-1-wakel@google.com>
References: <20250807085042.1690931-1-wakel@google.com>
Date: Sun, 21 Sep 2025 09:59:27 +0200
Message-ID: <87o6r46xsw.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Aug 07 2025 at 16:50, Wake Liu wrote:
> Several tests in the posix_timers selftest fail on kernels older
> than 6.13. These tests check for timer behavior related to SIG_IGN,
> which was refactored in the 6.13 kernel cycle, notably by
> commit caf77435dd8a ("signal: Handle ignored signals in
> do_sigaction(action != SIG_IGN)").
>
> To ensure the selftests pass on older, stable kernels, gate the
> affected tests with a ksft_min_kernel_version(6, 13) check.

What's the point of emitting 9 times the same skip message?

There is no value at all and this can nicely be solved in main() by
checking the kernel version once, registering either 10 or 19 tests and
not invoking the tests which depend on 6.13+ in the first place, No?

Thanks,

        tglx


