Return-Path: <linux-kselftest+bounces-46243-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2162EC7A543
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 15:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 241EE34940D
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 14:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C093528DF2D;
	Fri, 21 Nov 2025 14:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g9EWvCFn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0A0289376;
	Fri, 21 Nov 2025 14:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763736588; cv=none; b=icmHQEEs8aA4bVfilSp04kS8eEb9mZUKqFOkPkMV3clM1S/XUsAOM0j3VO+qVJgz0V4qVdP+ExHXziXV4xbuaVT0Qo/tmC7RiVpuHX/KvE0hw7VxlOy2SQRf4LT7ddH9PAZfubhDVVylcN6wv+Eg/FcgRrENqMvTyCW9HUvpm7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763736588; c=relaxed/simple;
	bh=LAgQOAX/iRSrNlimKQztYAf12tQgMawoWwuoKF7Pwx4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ru8BfEOAqOn5oNTYkrqvXS00lMGzCPxooXj2CRWvsjZL/B5UYLZbb7916BRkAIksKLJ4d8hmAvgM/4swpwdOBRt18+qDUCv0eUK9E1upk8oCk4gDlWj+0zWduRG0kWNghSYKERU67rSjYc1EbOpPSXuJB2QsbtN7sDnHWOTqDJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g9EWvCFn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC0A8C4CEF1;
	Fri, 21 Nov 2025 14:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763736588;
	bh=LAgQOAX/iRSrNlimKQztYAf12tQgMawoWwuoKF7Pwx4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=g9EWvCFngau2InASUxL979A8jZUZj5tWKpazJpXU8LQDpQhkd0mx7rCXZWijQfwqd
	 WpSKs5twG9AKLDZ4nvLjsFHu6Kf4Eit3jFoMzBO0uxkTfXaCLnN1dakfE38W+83H+e
	 Bkk7/MSqnXaAxzz8WRou+bQ8WQk0W9WcSHT4IiCRpnB/p8JUUsKv5sKuLEr7RGD2Im
	 AJVAlCH9XXFMBMX15Ds3L/Wkn8QgvQLfyTSeR5vbDYf9/GACS3Va07FyddDCihf0GV
	 ELLMDdkrIx1IEMXN383yZG9Pt+MbU+euV7iNnBzfczs7RMR1dwQB91pcZ/q0Nv6bJX
	 FuQh4n4yBmxFQ==
Content-Type: multipart/mixed; boundary="===============7562567454715943652=="
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fef61c630bb79a9d6778560b913039bebc760aaf3e02fae0a55d13dd6af8af85@mail.kernel.org>
In-Reply-To: <20251121142352.297588-3-jiayuan.chen@linux.dev>
References: <20251121142352.297588-3-jiayuan.chen@linux.dev>
Subject: Re: [PATCH bpf-next v3 2/3] bpf, sockmap: Fix FIONREAD for sockmap
From: bot+bpf-ci@kernel.org
To: jiayuan.chen@linux.dev,bpf@vger.kernel.org
Cc: jiayuan.chen@linux.dev,john.fastabend@gmail.com,jakub@cloudflare.com,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,ncardwell@google.com,kuniyu@google.com,dsahern@kernel.org,andrii@kernel.org,eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,mhal@rbox.co,sgarzare@redhat.com,cong.wang@bytedance.com,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 21 Nov 2025 14:49:46 +0000 (UTC)

--===============7562567454715943652==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
> index 49847888c..87772846f 100644
> --- a/include/linux/skmsg.h
> +++ b/include/linux/skmsg.h

[ ... ]

> +static inline ssize_t sk_psock_get_msg_size(struct sk_psock *psock)
> +{
> +	return psock->ingress_size;
> +}

[ ... ]

> +static inline ssize_t sk_psock_msg_inq(struct sock *sk)
> +{
> +	struct sk_psock *psock;
> +	ssize_t inq = 0;
> +
> +	psock = sk_psock_get(sk);
> +	if (likely(psock)) {
> +		inq = sk_psock_get_msg_size(psock);
> +		sk_psock_put(sk, psock);
> +	}
> +	return inq;
> +}

Does this create a data race on ingress_size? The field is read here
without holding ingress_lock, but all modifications happen under that
lock in sk_psock_queue_msg(), sk_psock_dequeue_msg(), and
sk_msg_recvmsg().

When ioctl(FIONREAD) executes concurrently with recv(), one thread
reads ingress_size locklessly in sk_psock_msg_inq() while another
thread modifies it under lock in sk_msg_recvmsg(). On 32-bit systems
with 32-bit ssize_t, this could produce torn reads.

Would READ_ONCE/WRITE_ONCE be needed for the lockless access?

> +/* for udp */
> +static inline ssize_t sk_msg_first_length(struct sock *sk)
> +{
> +	struct sk_psock *psock;
> +	struct sk_msg *msg;
> +	ssize_t inq = 0;
> +
> +	psock = sk_psock_get(sk);
> +	if (likely(psock)) {
> +		msg = sk_psock_peek_msg(psock);
> +		if (msg)
> +			inq = msg->sg.size;
> +		sk_psock_put(sk, psock);
> +	}
> +	return inq;
> +}

Can msg be freed between sk_psock_peek_msg() and reading msg->sg.size?
The peek function releases ingress_lock before returning the pointer.
If another thread in sk_msg_recvmsg() fully consumes the message after
the peek but before the size read, won't sk_psock_dequeue_msg() free
the message, leading to a use-after-free when we read msg->sg.size?

The call chain would be:
  Thread A: udp_bpf_ioctl()->sk_msg_first_length()->sk_psock_peek_msg()
            returns msg, releases lock, then reads msg->sg.size
  Thread B: udp_bpf_recvmsg()->sk_msg_recvmsg() consumes msg fully,
            calls sk_psock_dequeue_msg() which frees msg


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19573628679

--===============7562567454715943652==--

