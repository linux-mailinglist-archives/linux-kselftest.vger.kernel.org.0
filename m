Return-Path: <linux-kselftest+bounces-35944-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E293AAEAA22
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 00:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AB4D4A4B99
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 22:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A149421ABDB;
	Thu, 26 Jun 2025 22:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WuiuV7xz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WeSirK8m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9751917FB;
	Thu, 26 Jun 2025 22:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750978612; cv=none; b=l2cmK7Rmdrxosgp6o2SrOjWzYdhxgH/B3Je3QKzem3QSrIf2pq8YAYcmJ0OJaB4maFayNpr2nlbWx1N0yPQgeEFHd9XMWcr9zOIA8QGhW9f8UyP9cIIkAmAlmSy3tcX58lM8rJi1KxnscO9vnlRIncfWuZ6OumK2D62gbSWyE9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750978612; c=relaxed/simple;
	bh=rY9MgvPQZ1cSs/gQeTWTYk5o89/XmmWpdB/pAB/WmNE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AH/6W1PLlf3G6WV3M8Lu8XHS3qmhjZ/r7qagGNqlTHnXsBX2lDRaXgGXY7mEm+A0leqoWsHwbjOI7zjCHBUWMPRzm7xOCCPG4P2Cs9wa9UlDsKdIwO2rXeCFbRNOujfpx0VGBMB5BJWJCvw1vVkHJxpsZ3LyBXdkyRpKvjoihDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WuiuV7xz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WeSirK8m; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750978608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y4An1iWghZea7Hv/U4xil7KqA0XVAzlvEupnwSQQsnU=;
	b=WuiuV7xz1jwjEHGPpC9LfaD2dh5uYdIugcoWWxCI9Q1ZFtjDsh/5weLVjGv+ZSuEyUiOWJ
	9L25OUVOiJy3e7PxHWbqYpH9pB/WtjBKkBR4RWX+aB1uEXEKnMB2/gJPfYKpB375QHOq8y
	I+QmftPkTqs4aItgl9EGsNmPP61gk/cOYM95Tg9BW3hjCNWPNVQ/YwAo59+z1G/Tzj86Bt
	qh8ngRYjlB5iYJJKjnNMMzqlLcgYjzml8GR7XGHKT4LOYt1RzcsNnQqZxCcbpRwAtDysMe
	Mpvdr5T0pWWoNBbvbpCN7czbTmLUWSvUV65Ns0FZcyrz+BvsXH0vuZ6sybLbIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750978608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y4An1iWghZea7Hv/U4xil7KqA0XVAzlvEupnwSQQsnU=;
	b=WeSirK8m2R0UAfMHlUR3iaXBaYwP9cvWn0yQGxTwvD0WQhNrzFwQC/3lZGeJK1qBQ1aCmf
	PYKScdEunGGxu0CA==
To: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>, Ingo Molnar
 <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Shuah Khan <shuah@kernel.org>, Arnd
 Bergmann <arnd@arndb.de>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Waiman Long <longman@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-api@vger.kernel.org, kernel-dev@igalia.com, =?utf-8?Q?Andr=C3=A9?=
 Almeida
 <andrealmeid@igalia.com>
Subject: Re: [PATCH v5 3/7] futex: Use explicit sizes for
 compat_exit_robust_list
In-Reply-To: <20250626-tonyk-robust_futex-v5-3-179194dbde8f@igalia.com>
References: <20250626-tonyk-robust_futex-v5-0-179194dbde8f@igalia.com>
 <20250626-tonyk-robust_futex-v5-3-179194dbde8f@igalia.com>
Date: Fri, 27 Jun 2025 00:56:47 +0200
Message-ID: <875xgip0wg.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26 2025 at 14:11, Andr=C3=A9 Almeida wrote:

$subject lacks a () function notation ....

> There are two functions for handling robust lists during the task

during a tasks exit

> exit: exit_robust_list() and compat_exit_robust_list(). The first one
> handles either 64bit or 32bit lists, depending if it's a 64bit or 32bit
> kernel. The compat_exit_robust_list() only exists in 64bit kernels that

s/The//

> supports 32bit syscalls, and handles 32bit lists.

32-bit 64-bit all over the place

> For the new syscall set_robust_list2(), 64bit kernels need to be able to
> handle 32bit lists despite having or not support for 32bit syscalls, so
> make compat_exit_robust_list() exist regardless of compat_ config.

What new syscall and what are the requirements here? You really want to
add some rationale and background here.

> Also, use explicitly sizing, otherwise in a 32bit kernel both
> exit_robust_list() and compat_exit_robust_list() would be the exactly
> same function, with none of them dealing with 64bit robust lists.

Explicit sizing of what? The changelog should give information which
allows me to verify the implementation and not some blurb which makes me
to oracle the meaning of the changelog out of the actual implementation.

What is the actual gist of this patch? The subject says:

     Use explicit sizes for compat_exit_robust_list

Now you say 'Also,' which means aside of the above actual statement to
make compat_exit_robust_list() unconditional this is now a side effect
or what?

The subject line is misleading because the real purpose of this patch is
to make compat_exit_robust_list() unconditionally available independent
of bitness.

Now the obvious question is why this patch isn't split into two pieces:

    1) The patch matching the above subject line and does the
       struct/argument rename

    2) A subsequent patch which makes the function unconditionally
       available

That's not done because obfuscating changes makes everyones life easier,
right?

> +++ b/include/linux/compat.h
> @@ -385,16 +385,6 @@ struct compat_ifconf {
>  	compat_caddr_t  ifcbuf;
>  };
>=20=20
> -struct compat_robust_list {
> -	compat_uptr_t			next;
> -};
> -
> -struct compat_robust_list_head {
> -	struct compat_robust_list	list;
> -	compat_long_t			futex_offset;
> -	compat_uptr_t			list_op_pending;
> -};
> -
>  #ifdef CONFIG_COMPAT_OLD_SIGACTION
>  struct compat_old_sigaction {
>  	compat_uptr_t			sa_handler;
> @@ -672,7 +662,7 @@ asmlinkage long compat_sys_waitid(int, compat_pid_t,
>  		struct compat_siginfo __user *, int,
>  		struct compat_rusage __user *);
>  asmlinkage long
> -compat_sys_set_robust_list(struct compat_robust_list_head __user *head,
> +compat_sys_set_robust_list(struct robust_list_head32 __user *head,
>  			   compat_size_t len);

How does this even survive a full kernel build without a forward
declaration of struct robust_list_head32?

Not everything which includes compat.h includes futex.h first. There is
a reason why the structs were define here. Sure you can move them, but
not without a forward declaration.

Thanks,

        tglx

