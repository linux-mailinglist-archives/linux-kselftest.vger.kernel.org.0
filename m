Return-Path: <linux-kselftest+bounces-21146-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9CD9B6AC3
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 18:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED86E1C21913
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 17:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B544B1BD9D0;
	Wed, 30 Oct 2024 17:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="HdM2aA/x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jps8Tkd1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-a5-smtp.messagingengine.com (flow-a5-smtp.messagingengine.com [103.168.172.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0119D1BD9C1;
	Wed, 30 Oct 2024 17:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730308474; cv=none; b=vE224b1T0n4m2P02aAkTgpIElaspmLxkQbewMo+jaBUsICDSKHZbaQWEGZHDT3zP1YnHb3EbIx8wPQNIiHvuEJdmQ6lUoW7g+UnV1DuvOKVwtgY2BAKL8zcTa2JNxoqEvus/PwOmyP9GbVUcZ+kY/bMJGbEsvb4x1SGnVAF39IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730308474; c=relaxed/simple;
	bh=fR1wu/43Tn/xy2VITfwzgyphiC6mLhU60m+KhVenjRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nCwZuJdVcy5cOzHPQB36SLbO0nI12YBVY063HmtG/iEWKSyDm8xYij+n4z96bEeUZMEiUMssHs7P0sStkFAL6K6zW/W/puDrInVFPCMdaJCMlEkLMqmw3oiGjyHgZLpaNanVo14RcCdbuvzNxoqHQxCNpJzJ1GZEbnIfffiIEOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=HdM2aA/x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jps8Tkd1; arc=none smtp.client-ip=103.168.172.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailflow.phl.internal (Postfix) with ESMTP id A86AD2002B4;
	Wed, 30 Oct 2024 13:14:29 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 30 Oct 2024 13:14:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1730308469; x=
	1730312069; bh=YtJGD22t0Esf05b74Px7IXGtR0E9aUFiphweZKoOEkw=; b=H
	dM2aA/xs7By5VhGk9WShrjhxMdMoqRct9iMQ8VEaO45yg0QfCOn4Fp1iU8gi3QOI
	Tsc6WekYvLfAevSVArc2OFHYi0o2eIyVLhZqdJ3fOhxOgobKGlvUwchO4Fac1jpg
	8+F/K4h+z5XFem8APxRiBrWIcp8wo6OefGZ1LyVukaIyl8Seea7U8ai235ANkXzC
	XMPcwYxYsoTpcOmFLBaWnCUnyZVQ7aSfmFacW2oJm8XV9G/SxP+2YaB9sWnon8yF
	Z4UE+hbvMuVrL+wBQQg27gdZJ2EoyP3rc4vj4nQpkAL5DitH6dlTKBIBPvZjJq2P
	REFoYptcuQtvbFRfq6qaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730308469; x=1730312069; bh=YtJGD22t0Esf05b74Px7IXGtR0E9aUFiphw
	eZKoOEkw=; b=Jps8Tkd1eYgklX4OQwoZA9tVyAZfLzm+mO2ziZ0rKY59Y/E6/Yl
	DxdabEKmVENhQNJQuWfodga2Rr3ZzMJKy1TZMhqYWZ9EttZT3Z/OiEnJy2mIbwF8
	BQZOIQh9GKPqLUKhLWzkq8JgY0yiWkQRAP1oOjmdbribHZka0MbHaBftva4VpGcv
	nGe+AfpwkELXguEDahyVTfkpOjPLOQeYwrVIi3vS2PZhn3tUdNEZgyOQqeu2/+ht
	HN+fnY2LwR/3CJzNgThaNns2ZoRMSEpDVmjSs2mv9gVtk7g6CJWfRZ+jiJNXqNzy
	u+mDXiWd+yNz1ROGCgGZqhjtdoGTWxKyiyw==
X-ME-Sender: <xms:dWkiZ1Ui0G0mAaAaRk5Ii1CP490jacLEp3knPEocIHO4H5lQyey5DQ>
    <xme:dWkiZ1kYyWQ1FQXZHjHver46pUVlQH27WTHlvq2mir9UnRiIO7rWf_SRhwxGLXtvk
    jLtfY0SdYUlPEd0M6A>
X-ME-Received: <xmr:dWkiZxas6yzxhMv05RmYjnA6isRr501X2mfY2n7MapBsclvyec5NyHZztCMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekfedgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtjeen
    ucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrg
    hilhdrnhgvtheqnecuggftrfgrthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfek
    geetheegheeifffguedvuefffefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggp
    rhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnthhonh
    hiohesohhpvghnvhhpnhdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhg
    lhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepughonhgrlhgurdhh
    uhhnthgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehshhhurghhsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehrhigriigrnhhovhdrshdrrgesghhmrghilhdrtghomhdp
    rhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehnvghtuggvvh
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:dWkiZ4V1H9rrcDU-HRgMt_XXzOeg8I87vRIOXBMyxRxs4qfZ6GrI0A>
    <xmx:dWkiZ_lL2gvYv2Rn5fB534z2-70dBtfJKuInDP7XOLuVU3WPi0os0Q>
    <xmx:dWkiZ1erpqS4WCqi4AiraK3oZS5i9vXU5TFloH7Tyew8Eb3e2sp1Zg>
    <xmx:dWkiZ5GvuLGoWdoNf4qsrVowttTzTsxhG7dithLtwfFs3doqyRV8UA>
    <xmx:dWkiZx7G1bDNw4X0LojsHZMB11VBNhxF58igXorRc9dGAHcEmJAUsVw0>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Oct 2024 13:14:28 -0400 (EDT)
Date: Wed, 30 Oct 2024 18:14:25 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v11 08/23] ovpn: implement basic TX path (UDP)
Message-ID: <ZyJpcbHJI5MqZHVB@hog>
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-8-de4698c73a25@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241029-b4-ovpn-v11-8-de4698c73a25@openvpn.net>

2024-10-29, 11:47:21 +0100, Antonio Quartulli wrote:
> +static void ovpn_send(struct ovpn_struct *ovpn, struct sk_buff *skb,
> +		      struct ovpn_peer *peer)
> +{
> +	struct sk_buff *curr, *next;
> +
> +	if (likely(!peer))
> +		/* retrieve peer serving the destination IP of this packet */
> +		peer = ovpn_peer_get_by_dst(ovpn, skb);
> +	if (unlikely(!peer)) {
> +		net_dbg_ratelimited("%s: no peer to send data to\n",
> +				    ovpn->dev->name);
> +		dev_core_stats_tx_dropped_inc(ovpn->dev);
> +		goto drop;
> +	}
> +
> +	/* this might be a GSO-segmented skb list: process each skb
> +	 * independently
> +	 */
> +	skb_list_walk_safe(skb, curr, next)

nit (if you end up reposting): there should probably be some braces
around the (multi-line) loop body.

> +		if (unlikely(!ovpn_encrypt_one(peer, curr))) {
> +			dev_core_stats_tx_dropped_inc(ovpn->dev);
> +			kfree_skb(curr);
> +		}

> +void ovpn_udp_send_skb(struct ovpn_struct *ovpn, struct ovpn_peer *peer,
> +		       struct sk_buff *skb)
> +{
[...]
> +	/* crypto layer -> transport (UDP) */
> +	pkt_len = skb->len;
> +	ret = ovpn_udp_output(ovpn, bind, &peer->dst_cache, sock->sk, skb);
> +
> +out_unlock:
> +	rcu_read_unlock();
> +out:
> +	if (unlikely(ret < 0)) {
> +		dev_core_stats_tx_dropped_inc(ovpn->dev);
> +		kfree_skb(skb);
> +		return;
> +	}
> +
> +	dev_sw_netstats_tx_add(ovpn->dev, 1, pkt_len);

If I'm following things correctly, that's already been counted:

ovpn_udp_output -> ovpn_udp4_output -> udp_tunnel_xmit_skb
                                    -> iptunnel_xmit
                                    -> iptunnel_xmit_stats

which does (on success) the same thing as dev_sw_netstats_tx_add. On
failure it increments a different tx_dropped counter than what
dev_core_stats_tx_dropped_inc, but they should get summed in the end.

> +}

-- 
Sabrina

