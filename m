Return-Path: <linux-kselftest+bounces-21223-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE4A9B7E50
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 16:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF2C51C20A44
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 15:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEDF1A00D2;
	Thu, 31 Oct 2024 15:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="TGlZly+v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EvYgsp6+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-a8-smtp.messagingengine.com (flow-a8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C1E14901B;
	Thu, 31 Oct 2024 15:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730388356; cv=none; b=PWBCRfQ2EQNKiDbX+sYmgwBlWtkpXUb3Gv8a7zExMCLJQgjDS+jeWhCq7GV+feA/2eLHTapHeBYKb8pWOKKcyOyEbnVvTnwJmzUPnEVcYxvFD/flP1pwZiub4YsIp0WVNAC7LSQ7hBCGz+cGPU0O0Kfao4gBNpeWBa+mc/JLZjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730388356; c=relaxed/simple;
	bh=zLgXAY+IyfURML/rOrbDqAFSsQ+qWA8xLdSWIymvDug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RADn8bvUBycuTH5iGOHcV5cG1nixJK1u17K5mxtCOD2avyn0Nf2Kx2APX8WSmHWpHUzzmuPb0uLbtbVUA0s5AuT+PS0/2484x27SrGAEkVktrKF5W/PnYtiBmCaTUl9Gcr0n0Wkli8TVjFjnvKAlsCamsRaxSAfTRnSNZQb6JIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=TGlZly+v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EvYgsp6+; arc=none smtp.client-ip=103.168.172.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailflow.phl.internal (Postfix) with ESMTP id 61F63200A0A;
	Thu, 31 Oct 2024 11:25:50 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 31 Oct 2024 11:25:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1730388350; x=
	1730391950; bh=4jAwy/FJmIagUUK1GwikobWyx2JBEH7eHzXn79DRuCw=; b=T
	GlZly+vH/Ku/xu3tiu7PFbH+dydnmqU+ldrxdE3bVoVYS8RuYb6rjibL19lr38CJ
	jCwmUyxEydRwnc9+aMS3FY7iTn53kO/rflZXhWVgyjfXWF/Yg1lXwYsG6OT7tgrm
	yhYPd5WfslV/UrJA2Uh795dP781rk1d6b823Ey5CS5nilJM195QZM5DMKLo/2RXF
	ihPzjTvqv4l/5tCNTtveAe2lGYXl7SRl7kXmEkrXuJDoT278o/1XrIHY9w9rSXCq
	6HQNdk9J9TUgoyuWrP57Sr+lbHdDJuTT6qHqMtQSxr4xeqsCKY/Fp5Uc94tSI7Z1
	cyPfoq1nx+R/nsMwtd3oA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730388350; x=1730391950; bh=4jAwy/FJmIagUUK1GwikobWyx2JBEH7eHzX
	n79DRuCw=; b=EvYgsp6+up1yXJB3PIE8Jj9sIGBkHDdV1I7EzuW0GGA6p4OfFoC
	sM/x6RSDuefeTOX3h9RUOEoJr6t32aWCLNod5IxHpkaYC6uLfi0E5Jihz9168qL4
	2slqeTIw7v43iRT8UflrNStZc+BvvMuY9wtR5quRYIerIZE7xlNHRnGDYJJXQJKd
	Z9h4xkkHkvzGtEc+HuPid6ubP+J74KvR3rZBOMpDurzGx7JI+3WfwErsBhKRDF5E
	YuTKA2ixfEbbZyeiZOuuMW6Qn+fblk1kPt2Nf8wFe2hWPyi9ZcbN8lYvbCW5ttT9
	9W3sgCWJKDGiluGeP3eg8n/xNHGkOgCcJKw==
X-ME-Sender: <xms:faEjZ3nduXheRs29qRKuNvxNLTBTbSe-enJ-SwC1KsKw8aggKPm1nw>
    <xme:faEjZ60eoMXqdpMoh7DODg5DTWrTCAdwa_3TM9CkmG_AefbGEIQQ0IWh8aIFdPyBJ
    zt8C36JMp43MWtfvzw>
X-ME-Received: <xmr:faEjZ9rVmEVIsXBIXJZEASCkTfo3lk4V6eGUDp9zuMGjq2VdYjalsJgq1qMq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekiedgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtjeen
    ucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrg
    hilhdrnhgvtheqnecuggftrfgrthhtvghrnhepveejheeugfeutddufffggeejfeelkedu
    heegvdejhffgudehtdevuedvjefffeejnecuffhomhgrihhnpehskhgptggsrdhskhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsugesqhhu
    vggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopegrnhhtohhnihhosehophgvnhhvphhnrdhnvghtpdhrtghp
    thhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrg
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtgho
    mhdprhgtphhtthhopeguohhnrghlugdrhhhunhhtvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhihrgiirghn
    ohhvrdhsrdgrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughrvgifsehluhhnnh
    drtghhpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:faEjZ_lVEGhl6zpl_-2MBSuLbnJn8gXMa_dviN6yTX8KL_kuIj-ZnQ>
    <xmx:faEjZ10VAmjzVzBTb2gapDFt7pCBOipSlzvU8sjoF4IdZtWom1dmjA>
    <xmx:faEjZ-tCtwAp7w3i1vzpRkf0_N6PyWgvVbPejyQYxwJJGcE4jn00zQ>
    <xmx:faEjZ5UxaOG0Dex5KC9ECQcly9qBt4wepT_t4JMMb3BqOXxyeVadCw>
    <xmx:fqEjZ-Lo8LtUGI-PP07l-hr6hLstsMR0NEZXJ-se2k25hhpoAJBNpTSJ>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Oct 2024 11:25:49 -0400 (EDT)
Date: Thu, 31 Oct 2024 16:25:47 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v11 12/23] ovpn: implement TCP transport
Message-ID: <ZyOhe3yKTiqCF2TH@hog>
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-12-de4698c73a25@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241029-b4-ovpn-v11-12-de4698c73a25@openvpn.net>

2024-10-29, 11:47:25 +0100, Antonio Quartulli wrote:
> +static void ovpn_socket_release_work(struct work_struct *work)
> +{
> +	struct ovpn_socket *sock = container_of(work, struct ovpn_socket, work);
> +
> +	ovpn_socket_detach(sock->sock);
> +	kfree_rcu(sock, rcu);
> +}
> +
> +static void ovpn_socket_schedule_release(struct ovpn_socket *sock)
> +{
> +	INIT_WORK(&sock->work, ovpn_socket_release_work);
> +	schedule_work(&sock->work);

How does module unloading know that it has to wait for this work to
complete? Will ovpn_cleanup get stuck until some refcount gets
released by this work?


[...]
> +static void ovpn_tcp_rcv(struct strparser *strp, struct sk_buff *skb)
> +{
> +	struct ovpn_peer *peer = container_of(strp, struct ovpn_peer, tcp.strp);
> +	struct strp_msg *msg = strp_msg(skb);
> +	size_t pkt_len = msg->full_len - 2;
> +	size_t off = msg->offset + 2;
> +
> +	/* ensure skb->data points to the beginning of the openvpn packet */
> +	if (!pskb_pull(skb, off)) {
> +		net_warn_ratelimited("%s: packet too small\n",
> +				     peer->ovpn->dev->name);
> +		goto err;
> +	}
> +
> +	/* strparser does not trim the skb for us, therefore we do it now */
> +	if (pskb_trim(skb, pkt_len) != 0) {
> +		net_warn_ratelimited("%s: trimming skb failed\n",
> +				     peer->ovpn->dev->name);
> +		goto err;
> +	}
> +
> +	/* we need the first byte of data to be accessible
> +	 * to extract the opcode and the key ID later on
> +	 */
> +	if (!pskb_may_pull(skb, 1)) {
> +		net_warn_ratelimited("%s: packet too small to fetch opcode\n",
> +				     peer->ovpn->dev->name);
> +		goto err;
> +	}
> +
> +	/* DATA_V2 packets are handled in kernel, the rest goes to user space */
> +	if (likely(ovpn_opcode_from_skb(skb, 0) == OVPN_DATA_V2)) {
> +		/* hold reference to peer as required by ovpn_recv().
> +		 *
> +		 * NOTE: in this context we should already be holding a
> +		 * reference to this peer, therefore ovpn_peer_hold() is
> +		 * not expected to fail
> +		 */
> +		if (WARN_ON(!ovpn_peer_hold(peer)))
> +			goto err;
> +
> +		ovpn_recv(peer, skb);
> +	} else {
> +		/* The packet size header must be there when sending the packet
> +		 * to userspace, therefore we put it back
> +		 */
> +		skb_push(skb, 2);
> +		ovpn_tcp_to_userspace(peer, strp->sk, skb);
> +	}
> +
> +	return;
> +err:
> +	netdev_err(peer->ovpn->dev,
> +		   "cannot process incoming TCP data for peer %u\n", peer->id);

This should also be ratelimited, and maybe just combined with the
net_warn_ratelimited just before each goto.

> +	dev_core_stats_rx_dropped_inc(peer->ovpn->dev);
> +	kfree_skb(skb);
> +	ovpn_peer_del(peer, OVPN_DEL_PEER_REASON_TRANSPORT_ERROR);
> +}

[...]
> +void ovpn_tcp_socket_detach(struct socket *sock)
> +{
[...]
> +	/* restore CBs that were saved in ovpn_sock_set_tcp_cb() */
> +	sock->sk->sk_data_ready = peer->tcp.sk_cb.sk_data_ready;
> +	sock->sk->sk_write_space = peer->tcp.sk_cb.sk_write_space;
> +	sock->sk->sk_prot = peer->tcp.sk_cb.prot;
> +	sock->sk->sk_socket->ops = peer->tcp.sk_cb.ops;
> +	rcu_assign_sk_user_data(sock->sk, NULL);
> +
> +	rcu_read_unlock();
> +
> +	/* cancel any ongoing work. Done after removing the CBs so that these
> +	 * workers cannot be re-armed
> +	 */

I'm not sure whether a barrier is needed to prevent compiler/CPU
reordering here.

> +	cancel_work_sync(&peer->tcp.tx_work);
> +	strp_done(&peer->tcp.strp);
> +}
> +
> +static void ovpn_tcp_send_sock(struct ovpn_peer *peer)
> +{
> +	struct sk_buff *skb = peer->tcp.out_msg.skb;
> +
> +	if (!skb)
> +		return;
> +
> +	if (peer->tcp.tx_in_progress)
> +		return;
> +
> +	peer->tcp.tx_in_progress = true;

Sorry, I never answered your question about my concerns in a previous
review here.

We can reach ovpn_tcp_send_sock in two different contexts:
 - lock_sock (either from ovpn_tcp_sendmsg or ovpn_tcp_tx_work)
 - bh_lock_sock (from ovpn_tcp_send_skb, ie "data path")

These are not fully mutually exclusive. lock_sock grabs bh_lock_sock
(a spinlock) for a brief period to mark the (sleeping/mutex) lock as
taken, and then releases it.

So when bh_lock_sock is held, it's not possible to grab lock_sock. But
when lock_sock is taken, it's still possible to grab bh_lock_sock.


The buggy scenario would be:

  (data path encrypt)                       (sendmsg)
  ovpn_tcp_send_skb                         lock_sock
                                              bh_lock_sock + owned=1 + bh_unlock_sock
  bh_lock_sock
  ovpn_tcp_send_sock_skb                      ovpn_tcp_send_sock_skb
    !peer->tcp.out_msg.skb                      !peer->tcp.out_msg.skb
    peer->tcp.out_msg.skb = ...                 peer->tcp.out_msg.skb = ...
    ovpn_tcp_send_sock                          ovpn_tcp_send_sock
      !peer->tcp.tx_in_progress                   !peer->tcp.tx_in_progress
      peer->tcp.tx_in_progress = true             peer->tcp.tx_in_progress = true
      // proceed                                  // proceed


That's 2 similar races, one on out_msg.skb and one on tx_in_progress.
It's a bit unlikely (but not impossible) that we'll have 2 cpus trying
to call skb_send_sock_locked at the same time, but if they just
overwrite each other's skb/len it's already pretty bad. The end of
ovpn_tcp_send_sock might also reset peer->tcp.out_msg.* just as
ovpn_tcp_send_skb -> ovpn_tcp_send_sock_skb starts setting it up
(peer->tcp.out_msg.skb gets cleared, ovpn_tcp_send_sock_skb proceeds
and sets skb+len, then maybe len gets reset to 0 by
ovpn_tcp_send_sock).


To avoid this problem, esp_output_tcp_finish (net/ipv4/esp4.c) does:

	bh_lock_sock(sk);
	if (sock_owned_by_user(sk))
		err = espintcp_queue_out(sk, skb);
	else
		err = espintcp_push_skb(sk, skb);
	bh_unlock_sock(sk);


(espintcp_push_skb is roughly equivalent to ovpn_tcp_send_sock_skb)


> +	do {
> +		int ret = skb_send_sock_locked(peer->sock->sock->sk, skb,
> +					       peer->tcp.out_msg.offset,
> +					       peer->tcp.out_msg.len);
> +		if (unlikely(ret < 0)) {
> +			if (ret == -EAGAIN)
> +				goto out;
> +
> +			net_warn_ratelimited("%s: TCP error to peer %u: %d\n",
> +					     peer->ovpn->dev->name, peer->id,
> +					     ret);
> +
> +			/* in case of TCP error we can't recover the VPN
> +			 * stream therefore we abort the connection
> +			 */
> +			ovpn_peer_del(peer,
> +				      OVPN_DEL_PEER_REASON_TRANSPORT_ERROR);
> +			break;
> +		}
> +
> +		peer->tcp.out_msg.len -= ret;
> +		peer->tcp.out_msg.offset += ret;
> +	} while (peer->tcp.out_msg.len > 0);
> +
> +	if (!peer->tcp.out_msg.len)
> +		dev_sw_netstats_tx_add(peer->ovpn->dev, 1, skb->len);
> +
> +	kfree_skb(peer->tcp.out_msg.skb);
> +	peer->tcp.out_msg.skb = NULL;
> +	peer->tcp.out_msg.len = 0;
> +	peer->tcp.out_msg.offset = 0;
> +
> +out:
> +	peer->tcp.tx_in_progress = false;
> +}
> +
> +static void ovpn_tcp_tx_work(struct work_struct *work)
> +{
> +	struct ovpn_peer *peer;
> +
> +	peer = container_of(work, struct ovpn_peer, tcp.tx_work);
> +
> +	lock_sock(peer->sock->sock->sk);
> +	ovpn_tcp_send_sock(peer);
> +	release_sock(peer->sock->sock->sk);
> +}
> +
> +void ovpn_tcp_send_sock_skb(struct ovpn_peer *peer, struct sk_buff *skb)
> +{
> +	if (peer->tcp.out_msg.skb)
> +		return;

That's leaking the skb? (and not counting the drop)

> +
> +	peer->tcp.out_msg.skb = skb;
> +	peer->tcp.out_msg.len = skb->len;
> +	peer->tcp.out_msg.offset = 0;
> +
> +	ovpn_tcp_send_sock(peer);
> +}
> +
> +static int ovpn_tcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
> +{
[...]
> +	ret = skb_copy_datagram_from_iter(skb, 0, &msg->msg_iter, size);
> +	if (ret) {
> +		kfree_skb(skb);
> +		net_err_ratelimited("%s: skb copy from iter failed: %d\n",
> +				    sock->peer->ovpn->dev->name, ret);
> +		goto unlock;
> +	}
> +
> +	ovpn_tcp_send_sock_skb(sock->peer, skb);

If we didn't send the packet (because one was already queued/in
progress), we should either stash it, or tell userspace that it wasn't
sent and it should retry later.

> +	ret = size;
> +unlock:
> +	release_sock(sk);
> +peer_free:
> +	ovpn_peer_put(peer);
> +	return ret;
> +}

-- 
Sabrina

