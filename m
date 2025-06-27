Return-Path: <linux-kselftest+bounces-35966-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B863BAEB78F
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 14:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58EFB1C432A8
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 12:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C952D29A9;
	Fri, 27 Jun 2025 12:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rguzkvZm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+bKauc6Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C44917A2F0;
	Fri, 27 Jun 2025 12:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751026971; cv=none; b=DGadXM+/rvAycYtlqfxmMO+PDPtbvx2RAaScV6zYypOXs1E3/jtRykSZnF9NJWIdutKtoCouingonaWHW+gkFkrkbktaRx1m+xAEfsUyN2z371UFMs9tVMuYhGqZCHw5oS405Rxa+Mf82brZNmn6qR8bNXzoKPtAm/bo7lIfTVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751026971; c=relaxed/simple;
	bh=ZH1O5sFB7vO18/fSp54SFUkm5kp1MbIbNtVFxFDzZsU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o6Kpw7SN1mzR4BZdAJot5WJsfFDr7/yavwCuJVAGdkvpFdDFQdE+4gZwxWV5P0DT4UNtVw/MI/z/8dJHpGvuNtb9zemQLaXjxT+YtK2qXVYy3bFIvd8q8NUSViY0GED9CvkUU2hv5j4pyBu953kaNlMGlSRX8wEBZKTRNuYeTKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rguzkvZm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+bKauc6Q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751026967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EtbN+fhOj6879PFfkihHug11BT+rDU03fP9A04+d78s=;
	b=rguzkvZmWmn+qkAnhyFPWBYKZtbx8NdPU6iB1Pkz+SQR9mobvyF3zUpmEEYfRleHfyT9AP
	lzaTVHd5SQZuSQLVF2v2ehXjmlOch5uez+AjRcxtJVvGMhCnnogdjd+SKd6F7QpgplkGsq
	gEcgM941/B9oqB08xWA46yDo54jHcm5UF3KAfM217+kCz8YoS7FsUQ7pQ4LMQ0Yl+HyTON
	h34lL0M2OgTYh0kLTQcoSJOzSNwAUzKTHIwwEJga6b+Hj1m9bYpmA2WN9NlIw/PrmVHuQI
	qUfCsXzVj3Mhy6xw1WAwVNg5O26sX4pxsoUraxKNVt73sffKwKxDrnB8Cwv4rg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751026967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EtbN+fhOj6879PFfkihHug11BT+rDU03fP9A04+d78s=;
	b=+bKauc6Qa39uLsKZRIKGIGFNi4mBNq3lp25x9xe1M4j06WeBEdZpjVTH1kS4G86M6bexhB
	RxJSfAQ83AhpKaCA==
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
Subject: Re: [PATCH v5 5/7] futex: Remove the limit of elements for
 sys_set_robust_list2 lists
In-Reply-To: <20250626-tonyk-robust_futex-v5-5-179194dbde8f@igalia.com>
References: <20250626-tonyk-robust_futex-v5-0-179194dbde8f@igalia.com>
 <20250626-tonyk-robust_futex-v5-5-179194dbde8f@igalia.com>
Date: Fri, 27 Jun 2025 14:22:46 +0200
Message-ID: <87wm8xnzl5.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26 2025 at 14:11, Andr=C3=A9 Almeida wrote:
> Remove the limit of ROBUST_LIST_LIMIT elements that a robust list can
> have, for the ones created with the new interface. This is done by

With which new interface?

> overwritten the list as it's proceeded in a way that we avoid circular

overwriting each processed list entry to point at ...., which eliminates
a potential circular list.


> lists.
>
> For the old interface, we keep the limited behavior to avoid changing

s/we//

> the API.

Which API would be violated?

Overwriting the dying tasks robust list entries is not violating any
ABI. The task's memory is on the way to be destroyed.

> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
>  kernel/futex/core.c | 37 +++++++++++++++++++++++++++++--------
>  1 file changed, 29 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/futex/core.c b/kernel/futex/core.c
> index 1049f8ef3ce3c611b3be0ca12df34a98f710121d..942b66facdea16cd7be2235d9=
5c2bbbae8d7cc63 100644
> --- a/kernel/futex/core.c
> +++ b/kernel/futex/core.c
> @@ -1152,7 +1152,8 @@ static inline int fetch_robust_entry(struct robust_=
list __user **entry,
>   * We silently return on any sign of list-walking problem.
>   */
>  static void exit_robust_list64(struct task_struct *curr,
> -			       struct robust_list_head __user *head)
> +			       struct robust_list_head __user *head,
> +			       bool destroyable)
>  {
>  	struct robust_list __user *entry, *next_entry, *pending;
>  	unsigned int limit =3D ROBUST_LIST_LIMIT, pi, pip;
> @@ -1196,13 +1197,17 @@ static void exit_robust_list64(struct task_struct=
 *curr,
>  		}
>  		if (rc)
>  			return;
> -		entry =3D next_entry;
> -		pi =3D next_pi;
> +
>  		/*
>  		 * Avoid excessively long or circular lists:
>  		 */
> -		if (!--limit)
> +		if (!destroyable && !--limit)
>  			break;
> +		else
> +			put_user(&head->list, &entry->next);

Unchecked put_user() with zero explanation what it actually does.

> +
> +		entry =3D next_entry;
> +		pi =3D next_pi;
>=20=20
>  		cond_resched();
>  	}
> @@ -1214,7 +1219,8 @@ static void exit_robust_list64(struct task_struct *=
curr,
>  }
>  #else
>  static void exit_robust_list64(struct task_struct *curr,
> -			       struct robust_list_head __user *head)
> +			       struct robust_list_head __user *head,
> +			       bool destroyable)
>  {
>  	pr_warn("32bit kernel should not allow ROBUST_LIST_64BIT");
>  }
> @@ -1252,7 +1258,8 @@ fetch_robust_entry32(u32 *uentry, struct robust_lis=
t __user **entry,
>   * We silently return on any sign of list-walking problem.
>   */
>  static void exit_robust_list32(struct task_struct *curr,
> -			       struct robust_list_head32 __user *head)
> +			       struct robust_list_head32 __user *head,
> +			       bool destroyable)
>  {
>  	struct robust_list __user *entry, *next_entry, *pending;
>  	unsigned int limit =3D ROBUST_LIST_LIMIT, pi, pip;

So this get's a destroyable argument as well, but no implementation?

> @@ -1474,10 +1481,19 @@ static void exit_pi_state_list(struct task_struct=
 *curr)
>  static inline void exit_pi_state_list(struct task_struct *curr) { }
>  #endif
>=20=20
> +/*
> + * futex_cleanup - After the task exists, process the robust lists
> + *
> + * Walk through the linked list, parsing robust lists and freeing the
> + * allocated lists. Lists created with the set_robust_list2 don't have a=
 limit
> + * for sizing and can be destroyed while we walk on it to avoid circular=
 list.
> + */
>  static void futex_cleanup(struct task_struct *tsk)
>  {
>  	struct robust_list2_entry *curr, *n;
>  	struct list_head *list2 =3D &tsk->robust_list2;
> +	bool destroyable =3D true;
> +	int i =3D 0;
>=20=20
>  	/*
>  	 * Walk through the linked list, parsing robust lists and freeing the
> @@ -1485,15 +1501,20 @@ static void futex_cleanup(struct task_struct *tsk)
>  	 */
>  	if (unlikely(!list_empty(list2))) {
>  		list_for_each_entry_safe(curr, n, list2, list) {
> +			destroyable =3D true;
> +			if (tsk->robust_list_index =3D=3D i)
> +				destroyable =3D false;

Oh well.....

