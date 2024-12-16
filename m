Return-Path: <linux-kselftest+bounces-23415-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2049F3219
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 14:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E10431886AD9
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 13:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF64205AC3;
	Mon, 16 Dec 2024 13:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="GkJwlyRb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wpTdVEW3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB26420551E;
	Mon, 16 Dec 2024 13:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734357557; cv=none; b=KdzsSKmUylnpsdHeNmyaDzV+9cBgi3GuSxKq/hsad+DwJUe6p9G8cLWS5v9yrgGpMPs63fhXkmLsI8T0NG7ZZi0Xy62QFSpHkfkRB9/jj4cuR4lW06848vrdCNaxaYjptIttHmZM3UD3n3xjFv+RWwdR+e+1DvfoCNQwWVFyoU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734357557; c=relaxed/simple;
	bh=8cnDpAmdmw7q0pujChBmKz1JpTyYIp7Gr+aiiHZKWSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ko6SmVRSwKaYWi5Tgfp9iu6SxgVgt45F2AN20EnYqqXx9PzdjVi48gczi9Zrx5c+VUz+BHvu0DnUexGmbBQ7xgrTmvHtr3DRV22lc3M3QbJPGaPQ3OZ28cz4yX1VnDetl6pur1r9J8/v9wsaIIcgRTYbA2pS7C+uiAHxLb1i0Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=GkJwlyRb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wpTdVEW3; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 60F511140183;
	Mon, 16 Dec 2024 08:59:12 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 16 Dec 2024 08:59:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1734357552; x=
	1734443952; bh=/v6226Ro8TC4Mj/uCUF5W/7DJNZ8K0LPbNR7dvkO4bM=; b=G
	kJwlyRbN9YNvQVCdFjvXtdA/pgbCABZpYBYUoKVeBl4RCn7UFRbi4iQx4VeEhCcy
	GLOR+DCEKQDYjMtq2cjQ1iWGzOuReTCFRNs9nMhrRZhK13MF+wGbvxweQk8KoSai
	l+sbRiZcbHpcvZp92MZrzgMz6/ZiWTJ+TGIPV5/AfL4Sd6StkNyt2IjNJrmc54oQ
	1isSNd8iCMruQimb53/gqAbDAE5YHlqwA5bzngQYfNvUhmro46lTc99rmQSG8oS1
	ILldTPChANkQvuhsrX0tmNr8/40SOYQFbYgDWuda/xJq8S3xWp4dVyw+19PXiBSo
	l3AZG5yEftgm42o7adKLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734357552; x=1734443952; bh=/v6226Ro8TC4Mj/uCUF5W/7DJNZ8K0LPbNR
	7dvkO4bM=; b=wpTdVEW3BJSeU27h+Vr201d9ZNZ6JltAPd6l0xv0WHROOALqFaz
	vellAr61+0gAKS6eDdrFYAhCZpfr+AiRGDZ3j2liOBdKRZWWhJ9FzfXzvng/r/59
	GPTQb7aCaCZfnPhIwsupkWtFa5vHzOosVVYX/Z9xOicgXM1osU+mNVIjYQEI/LJl
	JZjENc4TaMubcwhW6ZOOBxUORmzYXX8dvxYwn+y29XTgM9myIZJh6CaNvAuQHNJx
	4UHzv4ncRjO5/W2fVImUj7xNy0NtQLejpRZZytmPQfta91t8tAPaG0UEMSCxSQ57
	fHe+1I9l86jMpo6bZ99TI9wm3atCwD5bBKA==
X-ME-Sender: <xms:LzJgZ5juurNgpowQiQQ6yhQLibhpRrMNZ_m98wGK90vtpObdanO6RA>
    <xme:LzJgZ-BCCoUJuVSKcUXfTzegkm66e20BkgdrRfWkq6CsJpMC4PGmzi_rwiSGCq2rv
    QAVdlYtq8OZ6QV56ew>
X-ME-Received: <xmr:LzJgZ5ERVLvtgmjH7iO5rhB4PtwcCNA46QoGFkdm8g-sUCzyd1PFCdJ8oGGq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleefgdehkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecu
    hfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrih
    hlrdhnvghtqeenucggtffrrghtthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefhkeeg
    teehgeehieffgfeuvdeuffefgfduffenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghr
    tghpthhtohepudegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhhtohhnih
    hosehophgvnhhvphhnrdhnvghtpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomh
    dprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggv
    nhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopeguohhnrghlugdrhhhunhhtvghrse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheprhihrgiirghnohhvrdhsrdgrsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    eprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthh
X-ME-Proxy: <xmx:LzJgZ-QsI3_NDRA9Vy5erYDIYrx9-YefC95BcIRnl-eIjN0gUhWLkw>
    <xmx:LzJgZ2y5whIofRlqyx9AZVXmbWyyaGOY1oFZg1UBlTjvrKXSwEpS9g>
    <xmx:LzJgZ06X9ge0V8HO1KSTzSKF6XovdRLuhaVVzJuUHnIrHa0SN7yPOg>
    <xmx:LzJgZ7wRdIJZXUGij9gCrJJ_xa0UuLCVH81l_TbujuoNoYbANW-60w>
    <xmx:MDJgZ7ITFA9mJfEFcYsytzTsAG-3DYHBdDE83KWCcKie1pVPMcBuDxLu>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Dec 2024 08:59:10 -0500 (EST)
Date: Mon, 16 Dec 2024 14:59:08 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>,
	dsahern@kernel.org
Subject: Re: [PATCH net-next v15 11/22] ovpn: implement TCP transport
Message-ID: <Z2AyLOMazyOCDopc@hog>
References: <20241211-b4-ovpn-v15-0-314e2cad0618@openvpn.net>
 <20241211-b4-ovpn-v15-11-314e2cad0618@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241211-b4-ovpn-v15-11-314e2cad0618@openvpn.net>

2024-12-11, 22:15:15 +0100, Antonio Quartulli wrote:
> @@ -42,6 +56,31 @@ struct ovpn_peer {
>  		struct in6_addr ipv6;
>  	} vpn_addrs;
>  	struct ovpn_socket *sock;
> +
> +	/* state of the TCP reading. Needed to keep track of how much of a
> +	 * single packet has already been read from the stream and how much is
> +	 * missing
> +	 */

nit: not so accurate since the switch to strp, can probably be dropped
since @tcp has a kdoc entry

> +	struct {
> +		struct strparser strp;
> +		struct work_struct tx_work;
> +		struct sk_buff_head user_queue;
> +		struct sk_buff_head out_queue;
> +		bool tx_in_progress;
> +
> +		struct {
> +			struct sk_buff *skb;
> +			int offset;
> +			int len;
> +		} out_msg;
> +
> +		struct {
> +			void (*sk_data_ready)(struct sock *sk);
> +			void (*sk_write_space)(struct sock *sk);
> +			struct proto *prot;
> +			const struct proto_ops *ops;
> +		} sk_cb;
> +	} tcp;

[...]
> +static void ovpn_tcp_send_sock_skb(struct ovpn_peer *peer, struct sk_buff *skb)
> +{
> +	if (peer->tcp.out_msg.skb)
> +		ovpn_tcp_send_sock(peer);
> +
> +	if (peer->tcp.out_msg.skb) {
> +		dev_core_stats_rx_dropped_inc(peer->ovpn->dev);

tx_dropped?

> +		kfree_skb(skb);
> +		return;
> +	}
> +
> +	peer->tcp.out_msg.skb = skb;
> +	peer->tcp.out_msg.len = skb->len;
> +	peer->tcp.out_msg.offset = 0;
> +	ovpn_tcp_send_sock(peer);
> +}
> +
> +void ovpn_tcp_send_skb(struct ovpn_peer *peer, struct sk_buff *skb)
> +{
> +	u16 len = skb->len;
> +
> +	*(__be16 *)__skb_push(skb, sizeof(u16)) = htons(len);
> +
> +	bh_lock_sock(peer->sock->sock->sk);
> +	if (sock_owned_by_user(peer->sock->sock->sk)) {
> +		if (skb_queue_len(&peer->tcp.out_queue) >=
> +		    READ_ONCE(net_hotdata.max_backlog)) {
> +			dev_core_stats_rx_dropped_inc(peer->ovpn->dev);

tx_dropped?

> +			kfree_skb(skb);
> +			goto unlock;
> +		}
> +		__skb_queue_tail(&peer->tcp.out_queue, skb);
> +	} else {
> +		ovpn_tcp_send_sock_skb(peer, skb);
> +	}
> +unlock:
> +	bh_unlock_sock(peer->sock->sock->sk);
> +}

[...]
> +static void ovpn_tcp_close(struct sock *sk, long timeout)
> +{
> +	struct ovpn_socket *sock;
> +
> +	rcu_read_lock();

[can't sleep until unlock]

> +	sock = rcu_dereference_sk_user_data(sk);
> +
> +	strp_stop(&sock->peer->tcp.strp);
> +
> +	tcp_close(sk, timeout);


    void tcp_close(struct sock *sk, long timeout)
    {
    	lock_sock(sk);

but this can sleep.

Is there anything that prevents delaying tcp_close until after
ovpn_peer_del and rcu_read_unlock?

> +	ovpn_peer_del(sock->peer, OVPN_DEL_PEER_REASON_TRANSPORT_ERROR);
> +	rcu_read_unlock();
> +}

[...]
> +void __init ovpn_tcp_init(void)
> +{
> +	ovpn_tcp_build_protos(&ovpn_tcp_prot, &ovpn_tcp_ops, &tcp_prot,
> +			      &inet_stream_ops);
> +
> +#if IS_ENABLED(CONFIG_IPV6)
> +	ovpn_tcp_build_protos(&ovpn_tcp6_prot, &ovpn_tcp6_ops, &tcpv6_prot,
> +			      &inet6_stream_ops);

I don't think that works for CONFIG_OVPN=y and CONFIG_IPV6=m. You can
either go back to the ugly thing espintcp and tls do, or use the
traditional Kconfig hack:

	depends on IPV6 || !IPV6

(you can find it sprinkled in various places of drivers/net/Kconfig
and net/)

-- 
Sabrina

