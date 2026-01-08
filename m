Return-Path: <linux-kselftest+bounces-48530-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9816D048C2
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 17:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33B2934E14B1
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 15:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4B1346FCA;
	Thu,  8 Jan 2026 15:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STXWlS2E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4D8343D90;
	Thu,  8 Jan 2026 15:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767886206; cv=none; b=oYj0j48dv5EPdG2T1eXmkqwS9MiTzp8yuGYaXwrFlm5fNH92HrKBTxU1PasE3kaYxZJ/bBN+AeVRstqoe79wt35VImw5+/kf7s39RUAcAu9pYJG3NTBrqeAjUlFa4LAxTCICJysbjKi0d9lfBDmbqN+AxpSBQNhINe0Ei/z+gcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767886206; c=relaxed/simple;
	bh=O5nTqfKGed4/ouIvuXWoveXxb7DulUnX59ws2pakbe8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=q87CYdSQzclsclK2I2mBh9BzL3jqILJ4k2ARbSzYPf9DlNHA/GTS3V6NCvi611/0fLntQfqrb/uUFypcAWO3tHvDLe4g38TZMwIpTZoktT0SWgMrVMqxFsD1ukVfPgvWPrvSkR56+bjcn3xBrfmBMC9xUwRdWU0k4acRoERFgZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STXWlS2E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144F2C116C6;
	Thu,  8 Jan 2026 15:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767886205;
	bh=O5nTqfKGed4/ouIvuXWoveXxb7DulUnX59ws2pakbe8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=STXWlS2EA/1fun9Zp78AAlIfZxHVkCS6HlUCJuDmnCIq1174bQIx/3D8HB4GzBoaS
	 LmUUNu+Oefzf+aQlC28T+bimIQ3JnYQX/hHUdXRHI5eOkAfVpuEIWGyWxtAWLjW0ez
	 ptkCGcyAXAll9cZ+mLCwMt6suCYukZlG/fHlO+hIcrxDvZRPtSW/MPoHuH/sR0nPu5
	 e4UYuFOLmMEGMZlA9729C0TTM5YtO10GVt4C4pu3SzZqli5GnpCzRNFPO1YIyuP/ya
	 +S6dWMy9WMARnWjyGdQGPEcjIlyCY6yV1VX1ljNPKunftMUmzciAXsXnYrB8TSEQiS
	 /IFLZAQm/KrzA==
Content-Type: multipart/mixed; boundary="===============8409071063143057427=="
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <00f31a205b2c447d9b8c1bbb15acb3b137f49a24c7f96e65ffce41ca541c2a90@mail.kernel.org>
In-Reply-To: <20260108150102.12563-3-jiayuan.chen@linux.dev>
References: <20260108150102.12563-3-jiayuan.chen@linux.dev>
Subject: Re: [PATCH bpf-next v6 2/3] bpf, sockmap: Fix FIONREAD for sockmap
From: bot+bpf-ci@kernel.org
To: jiayuan.chen@linux.dev,bpf@vger.kernel.org
Cc: jiayuan.chen@linux.dev,john.fastabend@gmail.com,jakub@cloudflare.com,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,ncardwell@google.com,kuniyu@google.com,dsahern@kernel.org,andrii@kernel.org,eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,mhal@rbox.co,cong.wang@bytedance.com,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  8 Jan 2026 15:30:05 +0000 (UTC)

--===============8409071063143057427==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c

[ ... ]

> +static int tcp_bpf_ioctl(struct sock *sk, int cmd, int *karg)
> +{
> +	bool slow;
> +
> +	/* we only care about FIONREAD */
> +	if (cmd != SIOCINQ)
> +		return tcp_ioctl(sk, cmd, karg);
> +
> +	/* works similar as tcp_ioctl */
> +	if (sk->sk_state == TCP_LISTEN)
> +		return -EINVAL;
> +
> +	slow = lock_sock_fast(sk);
> +	*karg = sk_psock_msg_inq(sk);
> +	unlock_sock_fast(sk, slow);
> +
> +	return 0;
> +}

Can FIONREAD underreport available data here? The tcp_bpf_recvmsg()
function can read from both the BPF ingress_msg queue and the native TCP
receive queue:

    if (!skb_queue_empty(&sk->sk_receive_queue) &&
        sk_psock_queue_empty(psock)) {
        sk_psock_put(sk, psock);
        return tcp_recvmsg(sk, msg, len, flags, addr_len);
    }

But tcp_bpf_ioctl() only returns the BPF queue size via sk_psock_msg_inq(),
ignoring any data in sk_receive_queue. For TCP_BPF_BASE sockets (sockmap
without verdict program), incoming data stays in the native receive queue.
If such a socket has data in sk_receive_queue but an empty ingress_msg,
FIONREAD would return 0 even though tcp_bpf_recvmsg() would successfully
read data.

Should this return the sum of both queues, similar to how the original
tcp_ioctl() uses tcp_inq()?

> diff --git a/net/ipv4/udp_bpf.c b/net/ipv4/udp_bpf.c

[ ... ]

> +static int udp_bpf_ioctl(struct sock *sk, int cmd, int *karg)
> +{
> +	if (cmd != SIOCINQ)
> +		return udp_ioctl(sk, cmd, karg);
> +
> +	/* works similar as udp_ioctl. */
> +	*karg = sk_msg_first_len(sk);
> +	return 0;
> +}

Similar question for UDP: udp_bpf_recvmsg() checks psock_has_data() and
falls through to native udp recvmsg when the BPF queue is empty:

    if (!psock_has_data(psock)) {
        ret = sk_udp_recvmsg(sk, msg, len, flags, addr_len);
        goto out;
    }

If the BPF ingress_msg queue is empty but the native UDP receive queue has
a datagram, sk_msg_first_len() returns 0 while udp_bpf_recvmsg() would
successfully receive data. Should udp_bpf_ioctl() fall through to
udp_ioctl() when sk_msg_first_len() returns 0?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20821477139

--===============8409071063143057427==--

