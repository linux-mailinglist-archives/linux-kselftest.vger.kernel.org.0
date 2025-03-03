Return-Path: <linux-kselftest+bounces-28066-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC41A4C447
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 16:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB13C18966AC
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 15:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6A7214231;
	Mon,  3 Mar 2025 15:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="mm2Hi89V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SNuczT8P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECA02144D7;
	Mon,  3 Mar 2025 15:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741014491; cv=none; b=DPYgg2tDdyDwPKiG5gbp916XjE9NIph5ikTL2Mte1OJuvjoruKN0W84aFse1paADu+FsbtNQpEB7UW6V2WrSwA5sirHdSbH26d3uQafoigvQqaUhEglzHB/L+ThGpWPjD9IPzZgxpiL3hF4hlAjVxHPbxbss1l3zeG9bZ3bPNhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741014491; c=relaxed/simple;
	bh=uY37hLsnqfunlnVgAETJ5yHs5LSi7CEAJHOGRdcxCs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qzbG04L3kjv5PJnfl4lGe+o8ITxJ+NRzXhqrkLdWfEb0DDmVQ7EHsb+znJl5LRzRLcUQPaRkjeZnnplcq6cvNzi4oF31sMiJgiooTSp7kNCK9HiKgYpPQHwmGHogSx9K8HOG/errdU+seyiijsLHVp/4yAUTPiKn8Z4EsXf5Xeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=mm2Hi89V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SNuczT8P; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 32A6F25401AC;
	Mon,  3 Mar 2025 10:08:06 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 03 Mar 2025 10:08:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1741014486; x=
	1741100886; bh=YIJosWGKOL8Klp9iSMuyg2RpazBkO4MxPj7H5SheFlc=; b=m
	m2Hi89V2fT7r6Roi3/lc0vngNy9e37HyxmZGQTQoMt7KfpsHnRuTLtV+Uhg88OK/
	cl34golA25zuxLXn+BjNYThdoMVCHWptElad2O+iBB65pPt0SqqgaumKQVt2dMSI
	xchOIg/3EbEiIeqstj9xzxTivZ7Yoi9fMyrAIUY1MO05AnE2UJq9wCiFsAuQzdvV
	6gAqzm5O0Ph1Il7FPTSa+fqlsZkkmU2vUGBUGzyJjMrgq8bQC8nKCIpNgv/5qHsx
	MzYsobBCcKoo87G2J4R1Zu/qIGHksMx4o04mGVIMZMUfV4DVL/AxbwEo6Plf131L
	oIl031dm2WJjQHi1A83fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741014486; x=1741100886; bh=YIJosWGKOL8Klp9iSMuyg2RpazBkO4MxPj7
	H5SheFlc=; b=SNuczT8PKYv9M2K0NHaMxphWX+0rMGp24HVkZoOIY+ExmRy99CJ
	SK5cUEdQWK9Rp1wuvK7L/ON9c65WG9FjIPNQ8I8s3XFaAWWSTEk7+Do6CuEJk4Qt
	Yk+39mbyAhmjTKGI2YLr2PeCBw8J9GTJ3tZRctfGicba2VE3f6lB9LU9vERTHP7y
	q73zauLNqLJ6IhCLZSOEsH0P3DiUG98CC0HNaqV1Lo8z7IV+L0uSq8/P/WPJyh2D
	kbY/cApr++IzCPGKCSIik2RZgP19L7BwM7hD7tkTmDGVDKXUMHjiZeZIVJJa0ngs
	fniAjxlEGdQPZXlraMQQnhphxb4ym8i0qaQ==
X-ME-Sender: <xms:1cXFZ1NxRqoKHtFVWrx22zOHDXVyVLuoLStVC6ganB7d7kvC_MSlkg>
    <xme:1cXFZ3_uSISOtyAnqk94HobRkUfaBcdxKxez35NX12AuIrBYGARQrvzHwU6hbuf5O
    p4rzuw2B1yI0nQPJ2I>
X-ME-Received: <xmr:1cXFZ0T-x8-3SZ_fGj1BxD_bqI-uiAGGcP_o1i9ilNiyqByelN7zd9-qJLEG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelleeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdej
    necuhfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnh
    grihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefh
    keegteehgeehieffgfeuvdeuffefgfduffenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgs
    pghrtghpthhtohepudegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhhtoh
    hnihhosehophgvnhhvphhnrdhnvghtpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtg
    homhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgr
    sggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopeguohhnrghlugdrhhhunhhtvg
    hrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheprhihrgiirghnohhvrdhsrdgrsehgmhgrihhlrdgtohhmpdhrtghpth
    htoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthh
X-ME-Proxy: <xmx:1cXFZxvHK8rV59ErlSEq6rapSTX0EUkDxjEEIZqfUEAKsafSukAN3A>
    <xmx:1cXFZ9fMrZzuzRlNtDJImglxEFzA3-OYs0Hme0PF-1d9nyy8ytHgkw>
    <xmx:1cXFZ939I6VzwMqxSyoK-tqkzWmpWpSZ1bHN8n1Qt3E7EWPleXxO-g>
    <xmx:1cXFZ582wcZlSXRvSiMHvmo4a1y7LJMSCUO4602hbKr4x8UcIkR-TQ>
    <xmx:1sXFZ40Pw7Z-JjexMJaJZd2zpb8_9jTTBfT6lJ_AMh4kg1gsXhKzTZh1>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 10:08:04 -0500 (EST)
Date: Mon, 3 Mar 2025 16:08:03 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>,
	David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH net-next v20 12/25] ovpn: implement TCP transport
Message-ID: <Z8XF06vDCNreOL4E@hog>
References: <20250227-b4-ovpn-v20-0-93f363310834@openvpn.net>
 <20250227-b4-ovpn-v20-12-93f363310834@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250227-b4-ovpn-v20-12-93f363310834@openvpn.net>

2025-02-27, 02:21:37 +0100, Antonio Quartulli wrote:
> @@ -94,11 +96,23 @@ void ovpn_socket_release(struct ovpn_peer *peer)
>  	 * detached before it can be picked by a concurrent reader.
>  	 */
>  	lock_sock(sock->sock->sk);
> -	ovpn_socket_put(peer, sock);
> +	released = ovpn_socket_put(peer, sock);
>  	release_sock(sock->sock->sk);
>  
>  	/* align all readers with sk_user_data being NULL */
>  	synchronize_rcu();
> +
> +	/* following cleanup should happen with lock released */
> +	if (released) {
> +		if (sock->sock->sk->sk_protocol == IPPROTO_UDP) {
> +			netdev_put(sock->ovpn->dev, &sock->dev_tracker);
> +		} else if (sock->sock->sk->sk_protocol == IPPROTO_TCP) {
> +			/* wait for TCP jobs to terminate */
> +			ovpn_tcp_socket_wait_finish(sock);
> +			ovpn_peer_put(sock->peer);
> +		}
> +		kfree_rcu(sock, rcu);

kfree_rcu after synchronize_rcu is a bit unexpected. Do we still need
to wait before we free sock, now that we have synchronize_rcu before?

> +	}
>  }
>  



> +static int ovpn_tcp_parse(struct strparser *strp, struct sk_buff *skb)
> +{
> +	struct strp_msg *rxm = strp_msg(skb);
> +	__be16 blen;
> +	u16 len;
> +	int err;
> +
> +	/* when packets are written to the TCP stream, they are prepended with
> +	 * two bytes indicating the actual packet size.
> +	 * Here we read those two bytes and move the skb data pointer to the
> +	 * beginning of the packet

There's no update to skb->data being done in ovpn_tcp_parse AFAICT.

[...]
> +static void ovpn_tcp_rcv(struct strparser *strp, struct sk_buff *skb)
> +{
> +	struct ovpn_peer *peer = container_of(strp, struct ovpn_peer, tcp.strp);
> +	struct strp_msg *msg = strp_msg(skb);
> +	size_t pkt_len = msg->full_len - 2;
> +	size_t off = msg->offset + 2;
> +	u8 opcode;
> +
> +	/* ensure skb->data points to the beginning of the openvpn packet */
> +	if (!pskb_pull(skb, off)) {

Is that the one you mean in the previous comment?

> +		net_warn_ratelimited("%s: packet too small for peer %u\n",
> +				     netdev_name(peer->ovpn->dev), peer->id);
> +		goto err;
> +	}
[some checks]
> +	/* DATA_V2 packets are handled in kernel, the rest goes to user space */
> +	opcode = ovpn_opcode_from_skb(skb, 0);
> +	if (unlikely(opcode != OVPN_DATA_V2)) {
> +		if (opcode == OVPN_DATA_V1) {
> +			net_warn_ratelimited("%s: DATA_V1 detected on the TCP stream\n",
> +					     netdev_name(peer->ovpn->dev));
> +			goto err;

In TCP encap, receiving OVPN_DATA_V1 packets is going to kill the peer:

> +err:
> +	dev_core_stats_rx_dropped_inc(peer->ovpn->dev);
> +	kfree_skb(skb);
> +	ovpn_peer_del(peer, OVPN_DEL_PEER_REASON_TRANSPORT_ERROR);
> +}
> +

but that's not the case with the UDP encap (ovpn_udp_encap_recv simply
drops those packets). Should the TCP/UDP behavior be consistent?




> +void ovpn_tcp_send_skb(struct ovpn_peer *peer, struct socket *sock,
> +		       struct sk_buff *skb)
> +{
> +	u16 len = skb->len;
> +
> +	*(__be16 *)__skb_push(skb, sizeof(u16)) = htons(len);
> +
> +	spin_lock_nested(&sock->sk->sk_lock.slock, OVPN_TCP_DEPTH_NESTING);

With this, lockdep is still going to complain in the unlikely case
that ovpn-TCP traffic is carried over another ovpn-TCP socket, right?
(probably fine to leave it like that)


[...]
> +static int ovpn_tcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
> +{
> +	struct ovpn_socket *sock;
> +	int ret, linear = PAGE_SIZE;
> +	struct ovpn_peer *peer;
> +	struct sk_buff *skb;
> +
> +	lock_sock(sk);
> +	rcu_read_lock();
> +	sock = rcu_dereference_sk_user_data(sk);
> +	if (unlikely(!sock || !sock->peer || !ovpn_peer_hold(sock->peer))) {
> +		rcu_read_unlock();
> +		release_sock(sk);
> +		return -EIO;
> +	}
> +	rcu_read_unlock();
> +	peer = sock->peer;

This used to be done under RCU in previous versions of the series. Why
is it after rcu_read_unlock now? (likely safe since we're under
lock_sock so detach can't happen)

> +
> +	if (msg->msg_flags & ~MSG_DONTWAIT) {
> +		ret = -EOPNOTSUPP;
> +		goto peer_free;
> +	}


-- 
Sabrina

