Return-Path: <linux-kselftest+bounces-28237-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECC1A4EC39
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 19:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67A53162CCA
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 18:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA5624EABD;
	Tue,  4 Mar 2025 18:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="qrrWfi+W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kLjTaXfd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D0E1FC7FF;
	Tue,  4 Mar 2025 18:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741113446; cv=none; b=myQtHyFMTiG5AlRbRQxq9HJWT19P/pZbOcTnnwtL06nPoiWFQ/Kh5sU6dsM4S980eUxYGCSuviXaP3ZUc3w/ZijlVtfR6bCwdvLWD0VU+ID1e9/4rdkxDsD/d4+y8NhUK98fCkps7Ab6fBBZFkNVJeeXh2Lnq6izdE7h196pKEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741113446; c=relaxed/simple;
	bh=3oTo4HsepLNOrxVRw/IauYMjtUPldg3lclpNkHh/29g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mqi4mx86+WEk6eq5q6ZDkgME388yS4WHdbBypFcTl4+KQ7qzI//pexlK+OkBrplGj1T9qxfP8/0qNUFyKxLRVqR2p9pbOr7RRs4OoxcLPDMd2gf60ZaRZpCoY7P7RQ/QvWK8LM8ZaLa0zAGeij/spsKAOUtQiLmXvgl31nwNfa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=qrrWfi+W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kLjTaXfd; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 951AF138275A;
	Tue,  4 Mar 2025 13:37:21 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 04 Mar 2025 13:37:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1741113441; x=
	1741199841; bh=BTMdi2sO4qcCbYw3uZrxjQBXPSMDoPBpMctb92eWqz8=; b=q
	rrWfi+W8kY4+Qu0KjcLo04owoZcz8IHtvpR1fd+B8CDonDFFb/211SJiGDh/5B1z
	SSpXzu3gXQ+NSuGDHsZwHD91kSlZIwTWsIods8qes37lo13YIhAZtEBUoz6zhu8U
	T/D8JBmcqDc0gO59Kl0RkB90PuM69mJEyV3+R4iTzbhnrPTMVgMO75ljgnm3+gmJ
	4jGYCaVDqRhFQ3Ilxr9ZdwoUIlZ6uSEKnoQ4ErDUDmH/PGyvrB4zZGrxGfyqxfR2
	qqce9aeF0s9NAXYQL4LgOITuFLw244Ht7PC84IKntRBSEBrDjJXwc5Y+8BbKlF/z
	Ys/TFNP54NlrDmyCP+2EA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741113441; x=1741199841; bh=BTMdi2sO4qcCbYw3uZrxjQBXPSMDoPBpMct
	b92eWqz8=; b=kLjTaXfddhk8nLWPNWbM0tORYkhvD99Zqpo6E6arL8tPl7YX13H
	GGTSl/B59ggDbP5YH4tATYWJvoB0iBkNcZqvW6s2/BecrcyZ577j7ItqkOyGOZw5
	Kv36LVUX9EJQxXWrsAy5DFH7dOS7oD5KqIHBL0mOE8Xl8Sqh53FODK/+C3pFeTit
	Gupd36oRZrG9HvdL5or2vIVX8qX1k83SN5RXhbB2P7/704WtkGESMXXij/DD421p
	adpjO3Sj6barnVPaftHj7o1xmU/2WDOk34g/eCaOUi05vVY9QrpoGyOuTSXGst4o
	oVF3FcUyn2ycLefaJKkd1dlIEeXYcf+YTkQ==
X-ME-Sender: <xms:YUjHZzum3ZHEKm4JmCOsGL3SNbLTgqOd3ZYq4otmLqA8TOPEao13aQ>
    <xme:YUjHZ0flEu_UUsYDpB_SfqGJfdK1vdbKlsjBFMfWZTnHlvms6if-GztaRuD7nz5xs
    5YiWJsXqOTL7XBW0Ik>
X-ME-Received: <xmr:YUjHZ2zB3asC5om_GtKOiv-aDyVnGHZkXwHI8FkDOk_9F4SXGa5Sa4N1bpXU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddvjeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    jeenucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshihsh
    hnrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepuefhhfffgfffhfefueeiudegtdef
    hfekgeetheegheeifffguedvuefffefgudffnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhn
    sggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnth
    honhhiohesohhpvghnvhhpnhdrnhgvthdprhgtphhtthhopehnvghtuggvvhesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrd
    gtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehp
    rggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepughonhgrlhgurdhhuhhnth
    gvrhesghhmrghilhdrtghomhdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehrhigriigrnhhovhdrshdrrgesghhmrghilhdrtghomhdprhgtph
    htthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghh
X-ME-Proxy: <xmx:YUjHZyPPpaWNsh9MEPuhpnqZEhCyyjasqHuXrzXz6Igl8_A-ocjqGQ>
    <xmx:YUjHZz9oOgpyLK7podKYOie9e7NE_aSptL30V2vfQexlaD3aL_pwmA>
    <xmx:YUjHZyWZgRFkmNaqUpjBlaDW3b9vHPLTv2CciBXfMWlqUUECEn6Igw>
    <xmx:YUjHZ0cEf5pm_Wc2vALrdXwNPxh64zcW8YjE6jce_VNt_BBaCyqHGg>
    <xmx:YUjHZ5c4FjKOB-cWWzDdrTbwmBhaY6G0GWj_luoi4Xq4z8NDUh6v7Sto>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 13:37:20 -0500 (EST)
Date: Tue, 4 Mar 2025 19:37:18 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
Subject: Re: [PATCH v21 18/24] ovpn: add support for peer floating
Message-ID: <Z8dIXjwZ3QmiEcd-@hog>
References: <20250304-b4-ovpn-tmp-v21-0-d3cbb74bb581@openvpn.net>
 <20250304-b4-ovpn-tmp-v21-18-d3cbb74bb581@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250304-b4-ovpn-tmp-v21-18-d3cbb74bb581@openvpn.net>

2025-03-04, 01:33:48 +0100, Antonio Quartulli wrote:
> A peer connected via UDP may change its IP address without reconnecting
> (float).

Should that trigger a reset of the peer->dst_cache? And same when
userspace updates the remote address? Otherwise it seems we could be
stuck with a cached dst that cannot reach the peer.


> +void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
> +{
> +	struct hlist_nulls_head *nhead;
> +	struct sockaddr_storage ss;
> +	const u8 *local_ip = NULL;
> +	struct sockaddr_in6 *sa6;
> +	struct sockaddr_in *sa;
> +	struct ovpn_bind *bind;
> +	size_t salen = 0;
> +
> +	spin_lock_bh(&peer->lock);
> +	bind = rcu_dereference_protected(peer->bind,
> +					 lockdep_is_held(&peer->lock));
> +	if (unlikely(!bind))
> +		goto unlock;
> +
> +	switch (skb->protocol) {
> +	case htons(ETH_P_IP):
> +		/* float check */
> +		if (unlikely(!ovpn_bind_skb_src_match(bind, skb))) {
> +			if (bind->remote.in4.sin_family == AF_INET)
> +				local_ip = (u8 *)&bind->local;

If I'm reading this correctly, we always reuse the existing local
address when we have to re-create the bind, even if it doesn't match
the skb? The "local endpoint update" chunk below is doing that, but
only if we're keeping the same remote? It'll get updated the next time
we receive a packet and call ovpn_peer_endpoints_update.

That might irritate the RPF check on the other side, if we still use
our "old" source to talk to the new dest?

> +			sa = (struct sockaddr_in *)&ss;
> +			sa->sin_family = AF_INET;
> +			sa->sin_addr.s_addr = ip_hdr(skb)->saddr;
> +			sa->sin_port = udp_hdr(skb)->source;
> +			salen = sizeof(*sa);
> +			break;
> +		}
> +
> +		/* local endpoint update */
> +		if (unlikely(bind->local.ipv4.s_addr != ip_hdr(skb)->daddr)) {
> +			net_dbg_ratelimited("%s: learning local IPv4 for peer %d (%pI4 -> %pI4)\n",
> +					    netdev_name(peer->ovpn->dev),
> +					    peer->id, &bind->local.ipv4.s_addr,
> +					    &ip_hdr(skb)->daddr);
> +			bind->local.ipv4.s_addr = ip_hdr(skb)->daddr;
> +		}
> +		break;

[...]
> +	if (peer->ovpn->mode == OVPN_MODE_MP) {
> +		spin_lock_bh(&peer->ovpn->lock);
> +		spin_lock_bh(&peer->lock);
> +		bind = rcu_dereference_protected(peer->bind,
> +						 lockdep_is_held(&peer->lock));
> +		if (unlikely(!bind)) {
> +			spin_unlock_bh(&peer->lock);
> +			spin_unlock_bh(&peer->ovpn->lock);
> +			return;
> +		}
> +
> +		/* his function may be invoked concurrently, therefore another

typo:
                   ^ This


[...]
> -/* variable name __tbl2 needs to be different from __tbl1
> - * in the macro below to avoid confusing clang
> - */
> -#define ovpn_get_hash_slot(_tbl, _key, _key_len) ({	\
> -	typeof(_tbl) *__tbl2 = &(_tbl);			\
> -	jhash(_key, _key_len, 0) % HASH_SIZE(*__tbl2);	\
> -})
> -
> -#define ovpn_get_hash_head(_tbl, _key, _key_len) ({		\
> -	typeof(_tbl) *__tbl1 = &(_tbl);				\
> -	&(*__tbl1)[ovpn_get_hash_slot(*__tbl1, _key, _key_len)];\
> -})
> -
>  /**
>   * ovpn_peer_get_by_vpn_addr4 - retrieve peer by its VPN IPv4 address
>   * @ovpn: the openvpn instance to search
> @@ -522,51 +694,6 @@ static void ovpn_peer_remove(struct ovpn_peer *peer,
>  	llist_add(&peer->release_entry, release_list);
>  }
>  
> -/**
> - * ovpn_peer_update_local_endpoint - update local endpoint for peer
> - * @peer: peer to update the endpoint for
> - * @skb: incoming packet to retrieve the destination address (local) from
> - */
> -void ovpn_peer_update_local_endpoint(struct ovpn_peer *peer,
> -				     struct sk_buff *skb)
> -{
> -	struct ovpn_bind *bind;
> -
> -	rcu_read_lock();
> -	bind = rcu_dereference(peer->bind);
> -	if (unlikely(!bind))
> -		goto unlock;
> -
> -	spin_lock_bh(&peer->lock);
> -	switch (skb->protocol) {
> -	case htons(ETH_P_IP):
> -		if (unlikely(bind->local.ipv4.s_addr != ip_hdr(skb)->daddr)) {
> -			net_dbg_ratelimited("%s: learning local IPv4 for peer %d (%pI4 -> %pI4)\n",
> -					    netdev_name(peer->ovpn->dev),
> -					    peer->id, &bind->local.ipv4.s_addr,
> -					    &ip_hdr(skb)->daddr);
> -			bind->local.ipv4.s_addr = ip_hdr(skb)->daddr;
> -		}
> -		break;
> -	case htons(ETH_P_IPV6):
> -		if (unlikely(!ipv6_addr_equal(&bind->local.ipv6,
> -					      &ipv6_hdr(skb)->daddr))) {
> -			net_dbg_ratelimited("%s: learning local IPv6 for peer %d (%pI6c -> %pI6c\n",
> -					    netdev_name(peer->ovpn->dev),
> -					    peer->id, &bind->local.ipv6,
> -					    &ipv6_hdr(skb)->daddr);
> -			bind->local.ipv6 = ipv6_hdr(skb)->daddr;
> -		}
> -		break;
> -	default:
> -		break;
> -	}
> -	spin_unlock_bh(&peer->lock);
> -
> -unlock:
> -	rcu_read_unlock();
> -}

I guess you could squash this and the previous patch into one to
reduce the churn (and get a little bit closer to the 15-patch limit :))

-- 
Sabrina

