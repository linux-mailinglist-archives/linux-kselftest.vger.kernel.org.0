Return-Path: <linux-kselftest+bounces-45751-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4611FC64789
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 14:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7989D4EF5F8
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 13:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81921332EB0;
	Mon, 17 Nov 2025 13:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zewSX/fr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GM28NwN1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A67331A4B;
	Mon, 17 Nov 2025 13:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763387030; cv=none; b=nDAtDnw2xKose+1UzrGg3zik/Lg879IN8p58KNr6E8g5tVk0ZCFS4eT1ykhJNdTYXRz7J8GBnnAmP8GBYOWDIheIeowvIRvHTgfB2cRG6gMqZtQo7MiXHMIw8NlRf2VHe+wDPFf5nrAhnlMfRm62rDAfa99AXzJT2CcbvyAl8Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763387030; c=relaxed/simple;
	bh=duAx2VgQ0gYY9TJ/L2rcm8J/86SdKdBcCDHwD6qepxI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ooisiMdTTz2xVSWSvqGKGoIeC6ubayNEZmk2mMF807Iw9jCseOGNsi7a33G66KHys3ceRtQ86gzCE3cLw9zwjFVn99oEh55zmZDraTl6kfctYCjIlqAACEE18ZB6kvKS9+ZvJ7VNzXprxeHgRM0LUw28F3MW+jGU9tA/eDt+d1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zewSX/fr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GM28NwN1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763387025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=duAx2VgQ0gYY9TJ/L2rcm8J/86SdKdBcCDHwD6qepxI=;
	b=zewSX/fr0sDpdjN4IQRj9Ut5gWvKRxTTXFxbJzqo5txZRWjHhx+MXfC7E3coy3iUbi+dLX
	Pyq2kXnMrW2QNB9cBwLNhN32KVmwiD7qCgmDl/oG4d25/zY1ves9JK3aYvcgEQqBgnWAH4
	WUxRVXVr7AFaIJJ8W3ittpBONf0W0EsDv+AGLOzzR/AfNjHUNOYSK8EX9uQFfyox284e+U
	Z8EWDc8bg1XZLj6UASkbJ1UZ2HUSbUw9eSR2O+K/fWIfRLRDCKJ/u+foF2y5yrVIO3gTJJ
	CKx1p7YHlBtCx+IAMfheJ5ECyS+SLF8zh+cpqI1H+LvsFR083USI+4H50Eb0jg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763387025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=duAx2VgQ0gYY9TJ/L2rcm8J/86SdKdBcCDHwD6qepxI=;
	b=GM28NwN1RR4HRdFlS6YPhvkWiGVMLC8h8j/wO7UeoJVD+E0y/pJFq7jFjMBv6CAN0uv0L4
	FPXAaS7hMqdXDHDQ==
To: Jinjie Ruan <ruanjinjie@huawei.com>, catalin.marinas@arm.com,
 will@kernel.org, oleg@redhat.com, peterz@infradead.org, luto@kernel.org,
 shuah@kernel.org, kees@kernel.org, wad@chromium.org,
 akpm@linux-foundation.org, ldv@strace.io, macro@orcam.me.uk,
 deller@gmx.de, mark.rutland@arm.com, song@kernel.org, mbenes@suse.cz,
 ryan.roberts@arm.com, ada.coupriediaz@arm.com, anshuman.khandual@arm.com,
 broonie@kernel.org, kevin.brodsky@arm.com, pengcan@kylinos.cn,
 dvyukov@google.com, kmal@cock.li, lihongbo22@huawei.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: ruanjinjie@huawei.com
Subject: Re: [PATCH v7 04/11] entry: Add syscall_exit_to_user_mode_prepare()
 helper
In-Reply-To: <20251117133048.53182-5-ruanjinjie@huawei.com>
References: <20251117133048.53182-1-ruanjinjie@huawei.com>
 <20251117133048.53182-5-ruanjinjie@huawei.com>
Date: Mon, 17 Nov 2025 14:43:44 +0100
Message-ID: <87zf8k7p0v.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Nov 17 2025 at 21:30, Jinjie Ruan wrote:

> In the generic entry code, the part before
> syscall_exit_to_user_mode_work() calls syscall_exit_work(), which
> serves the same purpose as syscall_exit_to_user_mode_prepare()
> in arm64.
>
> In preparation for moving arm64 over to the generic entry
> code, extract syscall_exit_to_user_mode_prepare() helper from
> syscall_exit_to_user_mode_work().
>
> No functional changes.
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

