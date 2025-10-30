Return-Path: <linux-kselftest+bounces-44378-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6674C1E380
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 04:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFB603AE353
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 03:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8422C0293;
	Thu, 30 Oct 2025 03:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TtATJpib"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A6421ABAC;
	Thu, 30 Oct 2025 03:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761795536; cv=none; b=VRK7wwrKaAz462xBiiezh/e264oszUeUO6JtLb90STprqNCf4ilS4KR2hpwftaiPEQEScw88nzrMyveFKAENyNCyIzxkb5R/LESUQSbBWvUEaALq8nuPT1QoG28B4mLVPrMluv9m1IIE4fA3/SXr0oQU1RfqipIehYqcHXsRRmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761795536; c=relaxed/simple;
	bh=yRzypom4pzbe6gsbRhjk2rPEpXETf4phZwOxcFZU3IQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=YAs3s/xxmATyTLy7mdsMJ+n7bKX49Y7KIUl8MrNvdm8BHPtmWr1KcfiKxGSM4+oRE/+lgMd5lVBEzBk1IpNIabeLI7GJeG1QAg5BSVf3xq8xQ7q/1agAcrjGfTe5Iom2vVrKg2/7gFCHfnmui8WCCxif3xf7tnjiY43QJOETx6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TtATJpib; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D7AC4CEF1;
	Thu, 30 Oct 2025 03:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761795536;
	bh=yRzypom4pzbe6gsbRhjk2rPEpXETf4phZwOxcFZU3IQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=TtATJpibSYniStxQ6oAGf+jR1gJj1TsxoioIGhMJG4WCqH8jB+O0G3FggGJdQHp7Y
	 KzHgVq5/dLhlGGAgyQhNZmZx4QGAr3cPZvl0WCJzTTGHqUB6jY5MCHCO84/XaKWcRM
	 pXgkDNpmVXAh5Rgfq5vdZaf1xAt707GroCYapJ1DV+2xk3TpE5ri+nbIA66rid+8B6
	 qea3CLzKNPOKM/kyyEpguHcVwwUAdPeqKw9nd7n2+yxasCVWTo4WXh0RYqRHAeQhL/
	 bNqhA5QdfC1avYcHLTmL1MwJE39csDMpOLYZywjEa/1JJS4qt8UYE8br2fw6lVAxAV
	 yhl+y5apQ6/Aw==
Content-Type: multipart/mixed; boundary="===============3203120713277759930=="
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <18b6f2c755710330b0c7399d17606a46c977f1ba3de4f37319aa1783638b1d2f@mail.kernel.org>
In-Reply-To: <20251030030010.95352-2-dongml2@chinatelecom.cn>
References: <20251030030010.95352-2-dongml2@chinatelecom.cn>
Subject: Re: [PATCH bpf 1/2] bpf: use rqspinlock for lru map
From: bot+bpf-ci@kernel.org
To: menglong8.dong@gmail.com,martin.lau@linux.dev,leon.hwang@linux.dev
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,jiang.biao@linux.dev,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 30 Oct 2025 03:38:54 +0000 (UTC)

--===============3203120713277759930==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


```
commit 8ae9fd98fe53c45a1a89adf6d254c2db90d26544
Author: Menglong Dong <menglong8.dong@gmail.com>

bpf: use rqspinlock for lru map

This patch converts raw_spinlock_t to rqspinlock_t in BPF LRU maps to
prevent NMI context deadlocks. The new lock API can fail gracefully
instead of deadlocking, returning an error code.

Link: https://lore.kernel.org/bpf/CAEf4BzbTJCUx0D=zjx6+5m5iiGhwLzaP94hnw36ZMDHAf4-U_w@mail.gmail.com/

> diff --git a/kernel/bpf/bpf_lru_list.c b/kernel/bpf/bpf_lru_list.c
> index e7a2fc605..38fddcb1e 100644
> --- a/kernel/bpf/bpf_lru_list.c
> +++ b/kernel/bpf/bpf_lru_list.c

[ ... ]

> @@ -466,23 +470,26 @@ static struct bpf_lru_node *bpf_common_lru_pop_free(struct bpf_lru *lru,
>  	do {
>  		steal_loc_l = per_cpu_ptr(clru->local_list, steal);
>
> -		raw_spin_lock_irqsave(&steal_loc_l->lock, flags);
> +		if (raw_res_spin_lock_irqsave(&steal_loc_l->lock, flags))
> +			goto out_next;
>
>  		node = __local_list_pop_free(steal_loc_l);
>  		if (!node)
>  			node = __local_list_pop_pending(lru, steal_loc_l);
>
> -		raw_spin_unlock_irqrestore(&steal_loc_l->lock, flags);
> +		raw_res_spin_unlock_irqrestore(&steal_loc_l->lock, flags);
>
> +out_next:
>  		steal = cpumask_next_wrap(steal, cpu_possible_mask);
>  	} while (!node && steal != first_steal);
>
>  	loc_l->next_steal = steal;
>
>  	if (node) {
> -		raw_spin_lock_irqsave(&loc_l->lock, flags);
> +		if (raw_res_spin_lock_irqsave(&loc_l->lock, flags))
> +			return NULL;
                        ^^^^^^^^^^^

Can this leak the node? At this point in bpf_common_lru_pop_free(),
a node was successfully stolen from another CPU's list. The
__local_list_pop_free() or __local_list_pop_pending() call removed
the node from steal_loc_l, and steal_loc_l was unlocked. The node
now exists but is not in any list.

When raw_res_spin_lock_irqsave() fails here, the function returns
NULL, but the stolen node is never added to the local pending list
and never returned to any list. The node becomes orphaned.

In NMI context (which this patch is designed to handle), lock
failures are expected to be common. Each failure would leak one
pre-allocated node from the BPF LRU pool, eventually exhausting
the available nodes.

>  		__local_list_add_pending(lru, loc_l, cpu, node, hash);
> -		raw_spin_unlock_irqrestore(&loc_l->lock, flags);
> +		raw_res_spin_unlock_irqrestore(&loc_l->lock, flags);
>  	}
>
>  	return node;

[ ... ]


```

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

In-Reply-To-Subject: `bpf: use rqspinlock for lru map`
CI run summary: https://github.com/kernel-patches/bpf/actions/runs/18928591681

--===============3203120713277759930==--

