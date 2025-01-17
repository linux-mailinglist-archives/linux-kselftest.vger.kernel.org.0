Return-Path: <linux-kselftest+bounces-24743-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F29CA15587
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 18:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06F1C3A054A
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 17:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2BF1A072A;
	Fri, 17 Jan 2025 17:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="DSnm1eZo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QXgZjFZO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD3713792B;
	Fri, 17 Jan 2025 17:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737134081; cv=none; b=awZwOg8C7qOAi9bQL/Ak3mPsqxRSRJ35wSZi6HkoaGTbdAI7e02Z9vG37FZzuOqqM71HQwgQc8DofqLhYnsluaBhjApuqOuH0XzwwMV0DxuS/5dxnuUStCZvBmdQj/EdmXaTXeYzGu1m//skvO/RQwVZU2FfHHIbkxlOES+U8n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737134081; c=relaxed/simple;
	bh=F6toiSB2Gw9kyAdz02k1MpLROzvE/OM6YEh3XKz+usQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tgd+xbUykS2O8O6SzdPFDqXjw2TxaePrGQqWD33HmqIO6IhUeUVh/Ru9Ctj3DRxxyB9m1PH7peD7CgL6flqxsVTKDsSqIBhDNS5TjpTV/hdFmb4I8SCOAwrS5x6q87UZbZ4Ufx4NrnWdbQ8lEeV3hMiGbsvQ3qv4gOtApVmyvL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=DSnm1eZo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QXgZjFZO; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DFBA825401BF;
	Fri, 17 Jan 2025 12:14:37 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 17 Jan 2025 12:14:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1737134077; x=
	1737220477; bh=odGEVfcNUWpJyzlitBgCdTRE3J1CjggSDfNlqZmHiuk=; b=D
	Snm1eZolxHoNprk88FskjQqGCSklGGnNaP7Eg1rz4PHz+FcAK2zlD0c7m/UzPF50
	J1ykW4tpvaeB6f2NyTvewxhjNPJCR+F8EljsDZ63pShvC0/GmZrF9RYGcnonsvd5
	BCQiapbjrP2heoEqaEwqUC8+LiG4tqJQYJjgayR7ZgW0erM9p7AkJzeaFkd8EkC4
	c86HXZT8WQ4C5rBuaO107H3w63Lc9Tk+wl7bslFeSIaQ+t9fsMinlQFnZjPv1OSr
	TSaFtGwkJgPrxpDlUE5U3rBvyvyYjr2d4RquZrZp+LZeVHpL0xxxPCYPFa4ioARA
	PyAz+PF3Db5meJZiqfQdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737134077; x=1737220477; bh=odGEVfcNUWpJyzlitBgCdTRE3J1CjggSDfN
	lqZmHiuk=; b=QXgZjFZOYcOIAXK9PfqrzhJUzH6lKGl5gshB1ZB12x0BZCpRy/W
	aXQGZe10X5mUbv+Yv+osqWXQc12apVnzWwQ1GtdlJVz6XMBdS7H1hwjJQamFTXMx
	8+lhJSBLMhgBnu7TjBb4cb//E3kpG6KzMBkTVySUzVMGn0iEhE8xSEm7tSRVSGur
	VDimfFLxQzjmIZczkEVwQT2/nFxx/CYygf4SdPrKjojfP4vsxf8xEMjhULCxWou4
	1rj9P7X5CKss15awgo1HDTmveiLR5gZ6OjinruDm/jcy2002oG5lbtpXRBmPZSZG
	FwEa8e0Mp1bwjiwgzEXHlESu5O769iG3R0w==
X-ME-Sender: <xms:_Y-KZy6FWC0twbl7YlSvKtrpig1wGTtCyi0n3ZMf6xBkY9HrLCexAg>
    <xme:_Y-KZ74ktshNd0bH04yAwLPXtprZ7k8_DBg-gmY78aAqjWpKFSX103omi7ozUYTPF
    RHGxuIC6Xl5VqpSmDg>
X-ME-Received: <xmr:_Y-KZxexGLVf2DphH7HjKuma5SpDeW6Y2C_f_TrH4F9AvesaZfMheESzDKSf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeifedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtjeen
    ucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrg
    hilhdrnhgvtheqnecuggftrfgrthhtvghrnhepgefhffdtvedugfekffejvdeiieelhfet
    ffeffefghedvvefhjeejvdekfeelgefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsuges
    qhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepudefpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopegrnhhtohhnihhosehophgvnhhvphhnrdhnvghtpdhr
    tghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprh
    gtphhtthhopeguohhnrghlugdrhhhunhhtvghrsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhihrgiirghnohhvrd
    hsrdgrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvhes
    lhhunhhnrdgthh
X-ME-Proxy: <xmx:_Y-KZ_J8tcLHYKaRaHOZOCJ8TsMy3fJZ6-Vefrn8jygrQOxB_oSjjA>
    <xmx:_Y-KZ2Jj4zwx_9O58oJuLf-mZkm0_4exMc0_8o7I91nNAaGrRUWsZQ>
    <xmx:_Y-KZwz5WVMYqbHfFNPCJQ6Bb7PfbFOGJZhF-iBhD2-gtZaLL8cFcQ>
    <xmx:_Y-KZ6JjvcSJz56UsDwhrwZ77VieuBArtValpOQoKuVFlnP_rkEO_g>
    <xmx:_Y-KZxYCD4G4SK1rynz3w1BDEii5lVrZYbK2Eysk0CvK8CLCNH5Q6svx>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jan 2025 12:14:37 -0500 (EST)
Date: Fri, 17 Jan 2025 18:14:35 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
Subject: Re: [PATCH net-next v18 12/25] ovpn: implement TCP transport
Message-ID: <Z4qP-x4F-lQiQTRy@hog>
References: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
 <20250113-b4-ovpn-v18-12-1f00db9c2bd6@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250113-b4-ovpn-v18-12-1f00db9c2bd6@openvpn.net>

2025-01-13, 10:31:31 +0100, Antonio Quartulli wrote:
> +static int ovpn_tcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
> +			    int flags, int *addr_len)
> +{
> +	int err = 0, off, copied = 0, ret;
> +	struct ovpn_socket *sock;
> +	struct ovpn_peer *peer;
> +	struct sk_buff *skb;
> +
> +	rcu_read_lock();
> +	sock = rcu_dereference_sk_user_data(sk);
> +	if (!sock || !sock->peer) {
> +		rcu_read_unlock();
> +		return -EBADF;
> +	}
> +	/* we take a reference to the peer linked to this TCP socket, because
> +	 * in turn the peer holds a reference to the socket itself.

Not anymore since v12? [*]

I think it's ok here because we're only using peer and sk (not
anything from ovpn_socket), but it is relevant in _sendmsg, which has
the same peer_hold pattern without this comment.

[*]
v11:
 - https://lore.kernel.org/netdev/20241029-b4-ovpn-v11-8-de4698c73a25@openvpn.net/
   ovpn_peer_release -> ovpn_socket_put

v12:
 - https://lore.kernel.org/netdev/20241202-b4-ovpn-v12-9-239ff733bf97@openvpn.net/
   ovpn_peer_release doesn't do ovpn_socket_put

 - https://lore.kernel.org/netdev/20241202-b4-ovpn-v12-7-239ff733bf97@openvpn.net/
   ovpn_socket_put is done directly at ovpn_peer_remove time, before the final peer_put

> +	 * By doing so we also ensure that the peer stays alive along with
> +	 * the socket while executing this function
> +	 */
> +	ovpn_peer_hold(sock->peer);
> +	peer = sock->peer;
> +	rcu_read_unlock();
> +
> +	skb = __skb_recv_datagram(sk, &peer->tcp.user_queue, flags, &off, &err);
> +	if (!skb) {
> +		if (err == -EAGAIN && sk->sk_shutdown & RCV_SHUTDOWN) {
> +			ret = 0;
> +			goto out;
> +		}
> +		ret = err;
> +		goto out;
> +	}
> +
> +	copied = len;
> +	if (copied > skb->len)
> +		copied = skb->len;
> +	else if (copied < skb->len)
> +		msg->msg_flags |= MSG_TRUNC;
> +
> +	err = skb_copy_datagram_msg(skb, 0, msg, copied);
> +	if (unlikely(err)) {
> +		kfree_skb(skb);
> +		ret = err;
> +		goto out;
> +	}
> +
> +	if (flags & MSG_TRUNC)
> +		copied = skb->len;
> +	kfree_skb(skb);
> +	ret = copied;
> +out:
> +	ovpn_peer_put(peer);
> +	return ret;
> +}

[...]
> +static int ovpn_tcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
> +{
> +	struct ovpn_socket *sock;
> +	int ret, linear = PAGE_SIZE;
> +	struct ovpn_peer *peer;
> +	struct sk_buff *skb;
> +
> +	rcu_read_lock();
> +	sock = rcu_dereference_sk_user_data(sk);
> +	if (unlikely(!sock || !sock->peer || !ovpn_peer_hold(sock->peer))) {
> +		rcu_read_unlock();
> +		return -EIO;
> +	}
> +	peer = sock->peer;
> +	rcu_read_unlock();
> +
> +	lock_sock(peer->sock->sock->sk);

Isn't that just sk?

> +
> +	if (msg->msg_flags & ~MSG_DONTWAIT) {
> +		ret = -EOPNOTSUPP;
> +		goto peer_free;
> +	}
> +
> +	if (peer->tcp.out_msg.skb) {
> +		ret = -EAGAIN;
> +		goto peer_free;
> +	}
> +
> +	if (size < linear)
> +		linear = size;
> +
> +	skb = sock_alloc_send_pskb(sk, linear, size - linear,
> +				   msg->msg_flags & MSG_DONTWAIT, &ret, 0);
> +	if (!skb) {
> +		net_err_ratelimited("%s: skb alloc failed: %d\n",
> +				    netdev_name(sock->peer->ovpn->dev), ret);

Since we only have a ref on peer (but not on sock), I'd use
peer->... directly instead of sock->peer.

> +		goto peer_free;
> +	}
> +
> +	skb_put(skb, linear);
> +	skb->len = size;
> +	skb->data_len = size - linear;
> +
> +	ret = skb_copy_datagram_from_iter(skb, 0, &msg->msg_iter, size);
> +	if (ret) {
> +		kfree_skb(skb);
> +		net_err_ratelimited("%s: skb copy from iter failed: %d\n",
> +				    netdev_name(sock->peer->ovpn->dev), ret);

s/sock->//

> +		goto peer_free;
> +	}
> +
> +	ovpn_tcp_send_sock_skb(sock->peer, skb);

s/sock->//

> +	ret = size;
> +peer_free:
> +	release_sock(peer->sock->sock->sk);
> +	ovpn_peer_put(peer);
> +	return ret;
> +}

-- 
Sabrina

