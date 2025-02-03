Return-Path: <linux-kselftest+bounces-25560-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A15DFA2569B
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 11:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 336011882B2F
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 10:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A68200127;
	Mon,  3 Feb 2025 10:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="UzAOEhaJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ncrkRvQ0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9DE1FBE89;
	Mon,  3 Feb 2025 10:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738577119; cv=none; b=YmHeTJrI6sC/vK8xKfuBRh/EFI9HTZBLc47qirWrk2bJygzhVnB2aUQRXv0R7QgvzgwCPXP4cyrKlJqsfeC1+0se18//YeDT9ES0jTBWT3tzSZIBueuLZpf8QOC8vl5/Y3RJORUzFyWrDWYGqRyipeJa8iyDnjzQ4ugD7ptyd74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738577119; c=relaxed/simple;
	bh=3HHG+wimANz9PCn4LqlAg/P/yA1akIgyINNXDfylSfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=flkhaYHg795V0cRRzg8XJVzbJT87TD9JI23K3LIAz2SMByynoTKAQuNB1gKGhbMeN1j98rWreVKnvyHd+s0ySwYWVn2PDP8dFAC33FXFWeQKil2UGCSZ9Xcg/s+BkgJ+ZafAZhSGT/9m2xd9viZMDhGJ8RHqdfk2rxB9z+qazr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=UzAOEhaJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ncrkRvQ0; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 88FC111400A2;
	Mon,  3 Feb 2025 05:05:15 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 03 Feb 2025 05:05:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1738577115; x=
	1738663515; bh=wiAtp5B6f/uLxzPGB/aY07G4Vjh7/bji9bknfJtXxs0=; b=U
	zAOEhaJRcQvSEB5oNhR79kQgGXPBh7qV3p/JB/GDI6SS6puuJPg6fLYCK+Qwz20q
	nxQ17bsZIf7saqNKH7ZuNx2Up3jkFMf2VDcNqubo3ufWy4Ymd8oHB7eUj5gJFS1u
	SBlWvcOGHl9AfJ2fRowZ9E0W4SDeSLc9npC6vHUe1cL20VbrR+l/vUCHFMfzTa0V
	r92I7XL+S0CE3ZmFrIKfmuitxlVau8PnBU1BAs+wSvKKch02Xl7pJI+EDbS1K3jd
	wvZIq+twClXNy7x1w6PfX5hWEWqYmhb+dBboIuWLJ1FC5J2qPVMxNoGzRnQR1Wbb
	l5qXMTLkYSguly+/2jzCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738577115; x=1738663515; bh=wiAtp5B6f/uLxzPGB/aY07G4Vjh7/bji9bk
	nfJtXxs0=; b=ncrkRvQ0xlD/YnkmsY7G2uZPfSj2igsDvJbchnY/Mfjdr+ZWLdH
	PHm6HKn1i/9PPqfkJlsT66KIsGXjn3pTZE2OnSJzRSD2s+WMS6aC9kjzPdhnOldp
	EagQPJpj9sB/OFgCpKEvYP1RBOD6g+Wb7Kxz8lnsy9W359fOkmSrhK6jYSdPJ88V
	3+2YxAOSL+ecyf+pWc93LhdwVDKgfJ/P2cZw8TEQOPQ4v/327cR1ctxWbIxVcHyo
	XJB3isS8xZkMOXc6hsxUEf5YELQFgs01dSWZhPq76QoI5glVHeUxdUdNzaziYDJk
	bugUdbwt50+AquaR/xh+2tExXlinOJc+h6w==
X-ME-Sender: <xms:2pSgZ01glIi_t20VkD7C6hltG5WUQcRnTvZbb_9CVN0klWq5ZpeyDA>
    <xme:2pSgZ_FKpEpSKLNEePodAd8l8aGGW0KOoSfZLfGbhrNJev5cGJ6DwTtD2cKDm-1xa
    mKqanLmXChwD1cwHd0>
X-ME-Received: <xmr:2pSgZ87G1G7cT2zDNzdiqhm3m5qpzu2HJN07VMO5txhvSbuW5fTlh6V3K_7Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdej
    necuhfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnh
    grihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeevjeehuefguedtudffgfegjeefleek
    udehgedvjefhgfduhedtveeuvdejffefjeenucffohhmrghinhepshhkpggtsgdrshhkne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgusehq
    uhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmh
    htphhouhhtpdhrtghpthhtoheprghnthhonhhiohesohhpvghnvhhpnhdrnhgvthdprhgt
    phhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    gvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtg
    hpthhtohepughonhgrlhgurdhhuhhnthgvrhesghhmrghilhdrtghomhdprhgtphhtthho
    pehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrhigriigrnhhovhdrsh
    drrgesghhmrghilhdrtghomhdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehl
    uhhnnhdrtghh
X-ME-Proxy: <xmx:25SgZ90lAYpnraoO-U43dqA_YW3SVrFVU-PPjfH-wNB_AigTnbCV0w>
    <xmx:25SgZ3FxgZTHd2tGKoC2Zph6RnOahxiBZBc38QffFWG0Qt3S1XJwTg>
    <xmx:25SgZ29vG5oDfbk15UwNmKc-20A8WkyWtPLq8i1joQZ83UriDeQl0g>
    <xmx:25SgZ8m9vbJCl6bIumXSjPXVCksJz9XwMV0I1jGHF0Hk6xnOut7p7w>
    <xmx:25SgZ3HLmOXm8FWCqahYy5yRdgB3J8iUMs2QGqDZt6g3S6ayMBcprMiM>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 05:05:14 -0500 (EST)
Date: Mon, 3 Feb 2025 11:05:13 +0100
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
Message-ID: <Z6CU2emFGy1L3MDT@hog>
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
> +static void ovpn_tcp_rcv(struct strparser *strp, struct sk_buff *skb)
> +{
[...]
> +	/* we need the first byte of data to be accessible
> +	 * to extract the opcode and the key ID later on
> +	 */
> +	if (!pskb_may_pull(skb, 1)) {

make sure we have 1B...

> +		net_warn_ratelimited("%s: packet too small to fetch opcode for peer %u\n",
> +				     netdev_name(peer->ovpn->dev), peer->id);
> +		goto err;
> +	}
> +
> +	/* DATA_V2 packets are handled in kernel, the rest goes to user space */
> +	opcode = ovpn_opcode_from_skb(skb, 0);

but this reads a u32 (4B) from skb->data

[...]
> +void ovpn_tcp_socket_detach(struct ovpn_socket *ovpn_sock)
> +{
> +	struct ovpn_peer *peer = ovpn_sock->peer;
> +	struct socket *sock = ovpn_sock->sock;
> +
> +	strp_stop(&peer->tcp.strp);
> +
> +	skb_queue_purge(&peer->tcp.user_queue);
>
> +	/* restore CBs that were saved in ovpn_sock_set_tcp_cb() */
> +	sock->sk->sk_data_ready = peer->tcp.sk_cb.sk_data_ready;
> +	sock->sk->sk_write_space = peer->tcp.sk_cb.sk_write_space;
> +	sock->sk->sk_prot = peer->tcp.sk_cb.prot;
> +	sock->sk->sk_socket->ops = peer->tcp.sk_cb.ops;
> +
> +	/* drop reference to peer */

nit: not really :)

> +	rcu_assign_sk_user_data(sock->sk, NULL);
> +
> +	/* before canceling any ongoing work we must ensure that CBs
> +	 * have been reset to prevent workers from being re-armed
> +	 */
> +	barrier();
> +
> +	cancel_work_sync(&peer->tcp.tx_work);
> +	strp_done(&peer->tcp.strp);
> +	skb_queue_purge(&peer->tcp.out_queue);

Also kfree_skb(peer->tcp.out_msg.skb)?

> +	ovpn_peer_put(peer);
> +}


[...]
> +static int ovpn_tcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
> +{
[...]
> +	ret = skb_copy_datagram_from_iter(skb, 0, &msg->msg_iter, size);
> +	if (ret) {
> +		kfree_skb(skb);
> +		net_err_ratelimited("%s: skb copy from iter failed: %d\n",
> +				    netdev_name(sock->peer->ovpn->dev), ret);
> +		goto peer_free;
> +	}
> +
> +	ovpn_tcp_send_sock_skb(sock->peer, skb);

This isn't propagating MSG_DONTWAIT down to ovpn_tcp_send_sock?

-- 
Sabrina

