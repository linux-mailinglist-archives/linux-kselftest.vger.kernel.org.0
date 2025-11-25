Return-Path: <linux-kselftest+bounces-46431-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F54C84F62
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 13:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA2434E2AE6
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 12:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAC031B102;
	Tue, 25 Nov 2025 12:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pnX4Co3o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A059E2DE6E3;
	Tue, 25 Nov 2025 12:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764073585; cv=none; b=WUYY/4hMpoDzYj67blI+epXvf4u1nu2m2s8STFT0eEf1NCLJ6VeFgf7GIWbCwv4V3BZA/sivlEujWZM2NWuF/ObQXeQyTE4tLreAJI/EDVX05OzKmNWPASMVUSFWQ6leLDlRkUYXy1EAB3EAEN5xPdstx0io2yjrVC5s4vUihyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764073585; c=relaxed/simple;
	bh=V6Lltgy2RzvdJgkiIvSobsAxNSZXD8KBgxPEi9Gwigs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=q8b3Q+OHWSCL66m47O8wKx/3wUOMb8LYxXA01f4IjxPJ8h2K8zpY6Wnl/K0+LXSFTV6x0Gwb2BQnGGbhWyCVGfH1+v5oCm9eFdUJzLoQcVuKnZNfJNdBqyHb71aRSM4SWlAN9H21+g1BV5TArOj1+r9pCzZ8RvdaeT+IEMIFVa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pnX4Co3o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 708CBC4CEF1;
	Tue, 25 Nov 2025 12:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764073585;
	bh=V6Lltgy2RzvdJgkiIvSobsAxNSZXD8KBgxPEi9Gwigs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=pnX4Co3oJ4s18lRZjGBqDJAWf5QIXOS+AGHrHjIAjmbD1DU2O2LwXyFVtzxqD3rsZ
	 UA2H47Z0SR9zBH2H7MhgeYwzDWXoIVpMDwlvejJp7ndBtQuXMYeqOsEBv/nJllA+IT
	 oZ4NQiOHTLpfo6Cvic/kWAsk2Vcw37iuTNKNnM6TZ0aTBaU3EPQGsSiDGvGGUxPuoL
	 6BHqXiJ/yZukU7Pgrm54HVBBrdhOTJogjb2mOJ3J8yJj2z5/zwZTagNonPwSWAM+by
	 QqYJGELDnzTmmwpWjEzf9N0T9uDN3ZufRHeeHE85mpcyEjkI8ci6F276gSDr9Vg5xm
	 Vy3FSAc2xqP4A==
Content-Type: multipart/mixed; boundary="===============6162177496242865021=="
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <45f34557fff9207019b48f62fc92678c76255f213a5904f82f02bad9a4883ef2@mail.kernel.org>
In-Reply-To: <20251125115709.249440-3-jiayuan.chen@linux.dev>
References: <20251125115709.249440-3-jiayuan.chen@linux.dev>
Subject: Re: [PATCH bpf-next v4 2/3] bpf, sockmap: Fix FIONREAD for sockmap
From: bot+bpf-ci@kernel.org
To: jiayuan.chen@linux.dev,bpf@vger.kernel.org
Cc: jiayuan.chen@linux.dev,john.fastabend@gmail.com,jakub@cloudflare.com,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,ncardwell@google.com,kuniyu@google.com,dsahern@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,mhal@rbox.co,sgarzare@redhat.com,cong.wang@bytedance.com,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 25 Nov 2025 12:26:24 +0000 (UTC)

--===============6162177496242865021==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
> index 0323a2b6c..2fccae0df 100644
> --- a/include/linux/skmsg.h
> +++ b/include/linux/skmsg.h
> @@ -97,6 +97,7 @@ struct sk_psock {
>  	struct sk_buff_head		ingress_skb;
>  	struct list_head		ingress_msg;
>  	spinlock_t			ingress_lock;
> +	ssize_t				ingress_size;
>  	unsigned long			state;
>  	struct list_head		link;
>  	spinlock_t			link_lock;

[ ... ]

> @@ -321,6 +322,16 @@ static inline void sock_drop(struct sock *sk, struct sk_buff *skb)
>  	kfree_skb(skb);
>  }
>
> +static inline ssize_t sk_psock_get_msg_size(struct sk_psock *psock)
> +{
> +	return READ_ONCE(psock->ingress_size);
> +}
> +
> +static inline void sk_psock_inc_msg_size(struct sk_psock *psock, ssize_t diff)
> +{
> +	WRITE_ONCE(psock->ingress_size, READ_ONCE(psock->ingress_size) + diff);
> +}
> +

Can sk_psock_inc_msg_size race with itself?  The function implements a
read-modify-write operation that isn't atomic.  Looking at the call sites:

- sk_psock_queue_msg() holds ingress_lock when calling this
- sk_psock_dequeue_msg() holds ingress_lock when calling this
- __sk_psock_purge_ingress_msg() holds ingress_lock when calling this
- __sk_msg_recvmsg() does NOT hold ingress_lock when calling this

The __sk_msg_recvmsg() path runs under the socket lock via
tcp_bpf_recvmsg()->lock_sock(), but sk_psock_queue_msg() can be called
from softirq context (network RX -> BPF verdict ->
sk_psock_verdict_apply() -> sk_psock_skb_ingress_self() ->
sk_psock_queue_msg()) without the socket lock.

This means concurrent updates from different lock contexts can race:

Thread A (softirq, ingress_lock): reads size=1000
Thread B (process, socket lock): reads size=1000, subtracts 50, writes 950
Thread A: adds 100 to stale 1000, writes 1100

Result: size=1100 but should be 1050 (lost the -50 update)

The ingress_size counter would drift from the actual queue size, breaking
the FIONREAD accuracy that this patch aims to provide.

>  static inline bool sk_psock_queue_msg(struct sk_psock *psock,
>  				      struct sk_msg *msg)
>  {
> @@ -329,6 +340,7 @@ static inline bool sk_psock_queue_msg(struct sk_psock *psock,
>  	spin_lock_bh(&psock->ingress_lock);
>  	if (sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED)) {
>  		list_add_tail(&msg->list, &psock->ingress_msg);
> +		sk_psock_inc_msg_size(psock, msg->sg.size);
>  		ret = true;
>  	} else {
>  		sk_msg_free(psock->sk, msg);

[ ... ]

> @@ -345,18 +357,25 @@ static inline struct sk_msg *sk_psock_dequeue_msg(struct sk_psock *psock)
>
>  	spin_lock_bh(&psock->ingress_lock);
>  	msg = list_first_entry_or_null(&psock->ingress_msg, struct sk_msg, list);
> -	if (msg)
> +	if (msg) {
>  		list_del(&msg->list);
> +		sk_psock_inc_msg_size(psock, -msg->sg.size);
> +	}
>  	spin_unlock_bh(&psock->ingress_lock);
>  	return msg;
>  }

[ ... ]

> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index d73e03f77..c959d52a6 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -455,6 +455,7 @@ int __sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg
>  					atomic_sub(copy, &sk->sk_rmem_alloc);
>  				}
>  				msg_rx->sg.size -= copy;
> +				sk_psock_inc_msg_size(psock, -copy);

This call to sk_psock_inc_msg_size() happens without holding ingress_lock,
just the socket lock.  Can this race with sk_psock_queue_msg() which holds
ingress_lock but not the socket lock?

>
>  				if (!sge->length) {
>  					sk_msg_iter_var_next(i);
> @@ -819,9 +820,11 @@ static void __sk_psock_purge_ingress_msg(struct sk_psock *psock)
>  		list_del(&msg->list);
>  		if (!msg->skb)
>  			atomic_sub(msg->sg.size, &psock->sk->sk_rmem_alloc);
> +		sk_psock_inc_msg_size(psock, -((ssize_t)msg->sg.size));
>  		sk_msg_free(psock->sk, msg);
>  		kfree(msg);
>  	}
> +	WARN_ON_ONCE(psock->ingress_size);
>  }

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19669112811

--===============6162177496242865021==--

