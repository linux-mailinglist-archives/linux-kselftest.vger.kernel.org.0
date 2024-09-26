Return-Path: <linux-kselftest+bounces-18406-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0257987832
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 19:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83FCE2856FB
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 17:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7562913B5B4;
	Thu, 26 Sep 2024 17:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ahvJ6ELI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4Y3JgBns"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E332D4A32;
	Thu, 26 Sep 2024 17:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727370921; cv=none; b=plYULRX+c+HKD0fjTE4uTiz7TAURsUW9Fsz4K6D3U04TLLy/dK9Iqr3vYUAX8UnDutnx7fdyPXaIi5AHD9y/n0s8a37rKmn8U1c26pUAt8XAC2hgimQ/VMfOKaGj7c+SDU7OlqKfxx25wJL29ibXF32JTf4otk/yVydf+vMTxcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727370921; c=relaxed/simple;
	bh=KTd/7DeF4THfRHYleD7QLnvHZc/zNNrR8yFGwvG2RY8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DtPH5acS7GkM8sQ0KeNKY5VVD0k6uT7g5S3MKUnWpclcrpBM9J7BjCzyMlnaYNop28ZU+QiLGuAvE7AYJ5T9FnbUHKzbdHb7cxGzuSgZxC7OUP59Q3hb60slIqfNhEaQRC6RjVAVJB/o5xQJyerXFBJvBrq391lNtlW+psz/Xwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ahvJ6ELI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4Y3JgBns; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727370917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KTd/7DeF4THfRHYleD7QLnvHZc/zNNrR8yFGwvG2RY8=;
	b=ahvJ6ELIl6HZ1GowgArOlJZ3graTTJCM1TMd6gTRZF0JnjiHa1+laun3yE+6gMxj72TGi9
	aQttl0E63C8ueINWyKuwaVVaCjk8Ubo8NKCbg0mOCoUD/SXOQs0U1lsK0PMxkCDzQmaVKM
	WiUtUhZpq/w5O9ahOGGRZNBjwV5Vqej43dmZ0vukDQcltWnFdxHTkahXUbsXWai6y3tHCh
	cGwb0nSfYPT9ynsJbU6XRe6QMU+SRNIQtXN1WIUQfAc9OpmaJF3GVyxpREqHbY10xw35LB
	8GPgTxbos9G4xu6IUViqz6R+q8hxOqqmxN2/xzwyh8qPtkdfH/AOAmRNTaz9mg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727370917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KTd/7DeF4THfRHYleD7QLnvHZc/zNNrR8yFGwvG2RY8=;
	b=4Y3JgBnscp978klURKEZ5GjD46AyW3kzcHErxdzmgeqKd91C6iDovYAJY38DGXlo6vRYij
	7IwYtx/0orZHPIAg==
To: Shuah Khan <skhan@linuxfoundation.org>, jstultz@google.com,
 sboyd@kernel.org, shuah@kernel.org
Cc: Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/2] timers test fix and duplicate defines cleanup
In-Reply-To: <cover.1727191485.git.skhan@linuxfoundation.org>
References: <cover.1727191485.git.skhan@linuxfoundation.org>
Date: Thu, 26 Sep 2024 19:15:17 +0200
Message-ID: <877cay2v6i.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Sep 24 2024 at 09:56, Shuah Khan wrote:

> The first patch in this two patch fixes warn_unused_result compile
> time warning in posix_timers test.
>
> The second patch removes local NSEC_PER_SEC and USEC_PER_SEC defines.
> NSEC_PER_SEC and USEC_PER_SEC are defines in several timers tests.
> These defines are inconsistent with variations of ULL, LL, etc. without
> any explanation why it is necessary.
>
> These defines can be picked up from include/vdso/time64.h header
> file. In the interest of making it easier to maintain, remove the
> local defines. Include include/vdso/time64.h instead. This change
> will also make the defines consistent.

Acked-by: Thomas Gleixner <tglx@linutronix.de>

