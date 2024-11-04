Return-Path: <linux-kselftest+bounces-21379-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8209BB34C
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 12:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E7D51C22386
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 11:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088BD1C729E;
	Mon,  4 Nov 2024 11:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="GQnt38nN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OWpoKna5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-b1-smtp.messagingengine.com (flow-b1-smtp.messagingengine.com [202.12.124.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAD01C7274;
	Mon,  4 Nov 2024 11:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730719478; cv=none; b=cEnlvvYoRgwQcLwjc6OwWHAle34IUl3568jHeSq3orT1eNg2dg8O/++/olPB8NDTowI6Wyjk1mS5hvRQ+FxNHCeSS1/ih9FsU2Uyr9S8/X9N5vI4galLvyJJvDoEr1wsDZB/frIPTJiS2S55lf84GXkLFiPVxQbsTeTTlcZYrj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730719478; c=relaxed/simple;
	bh=c5cmqJKCzRXjZX4BQY0MmxVSVWNlpksK1VTyTpz8Ykc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nfhCr2iOleE4Z8V8C6DOI0WeWfCyVvSJw+62BbShmR7gkh4kYMPZ8WE1sh2ogHYYUeI6VX4eCm+QB7u5H0gg472DVFTBzp++1SS8ApeaE+pDB+0EghRWre3l62o3MtfPgwiXovrrWhh2H7lwUf4MugBu+TJKTb4xqfdTroQkai0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=GQnt38nN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OWpoKna5; arc=none smtp.client-ip=202.12.124.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailflow.stl.internal (Postfix) with ESMTP id 206A31D4012F;
	Mon,  4 Nov 2024 06:24:33 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 04 Nov 2024 06:24:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1730719472; x=
	1730723072; bh=8527qvyn8s3tp1A8G7J33ch0STQt6X1YJ2YVR8+xU8w=; b=G
	Qnt38nNLXqeO2oqED4K0WtxE/ehtzAHZdlgScMIi4r3XOpmw/BjBJsGeemTASOwY
	gpWnilwuIrZ5zmArKsbPYQd32JJsV+JEwrkbWbBL1zyMcdfVdk2DGNzvGuc/IfNc
	T94UHvkO0oIPZzlgIrJrU37cJmon+vtNSCEpd7/ex2pe0iRF2CTWx7iePwz0Rj7a
	yBqbQNe1WOIqma9UuiuoUlEzQ9pWMibL+bPVQuwPcKv7o0dEmKHyMyLgZBY49nwr
	fKXYyux9Lf0CLODNSNHgln+Grc81VpnMmsF1e+X09VA2Oxsg6XeK8Ec4/XHy8oMu
	F57atArOD4sOvvogFeFUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730719472; x=1730723072; bh=8527qvyn8s3tp1A8G7J33ch0STQt6X1YJ2Y
	VR8+xU8w=; b=OWpoKna5qAwlb4hVnZxoiK9XSLI8ZkjRU13yEO8xhK1RIEu0ncW
	Z1wdbjaSQcVhcYtVDZNNyW+mzPEfPFVHzAKEnsBbWxB9LO++26w3SJxOYWEr9mCP
	Y3w96YKCzPJJpxyGVe9Xxab5l2CmYmxRVfS3A+t/VuBcV2RPe8AAp1t6LRi/Uqr6
	6wZftX1EB64HGqmFTT39YKrDCU/ZmBxp2ouYpMtZNkJi8de5J8FlUynd5FdYeiQw
	adVZaAvZ5YytTx8KsNPn4vEZz+e0zFkF16X0UBXpa0lL1da3uqxMlMiP7pMhLdzF
	uRb97YZFeNic+pHCeEAqVGy3jm5Z3WOtUbQ==
X-ME-Sender: <xms:8K4oZw9QxeIfWrZw-viCPU9CvBSuuqws9-7E1uwpVZUVhZ5XZV-Enw>
    <xme:8K4oZ4usuuuWD839-IMNe8K1WyP01m8jk07S4x0nHoOMPCII0T02S4zOj18rXVwvD
    CB5oMVwZw9sfnTtVVE>
X-ME-Received: <xmr:8K4oZ2CxBKcmSiNqJ3uy1ctxiIF-9eGgyagOnu8HofSRHB3AaBmsHwdRvTsB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeliedgvdeiucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:8K4oZwcyv12ZUrw5AQEuVotstrbcoBRh5dinYkwP332k3sYivDkhWw>
    <xmx:8K4oZ1NbEh5AX0TwKNES7D1ZXrc1kzNttcHf0WVzbNIx9Zm_q0T2JQ>
    <xmx:8K4oZ6kQSPeKGnjEYu_EF7croKhsMZjR6AmKzg7RFRNggHk3_WJ1tw>
    <xmx:8K4oZ3t_EGXC35cZanZ1CZJ6DyeYNpCppGSz4a8xnYuDN6nOIU58zg>
    <xmx:8K4oZ-ixwghvVoOBz4gHjKoCwgOgjhRMoSXGuugeMAS286kSSVzo1J9I>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Nov 2024 06:24:31 -0500 (EST)
Date: Mon, 4 Nov 2024 12:24:29 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v11 17/23] ovpn: add support for peer floating
Message-ID: <Zyiu7d5X7GcTK3Hq@hog>
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-17-de4698c73a25@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241029-b4-ovpn-v11-17-de4698c73a25@openvpn.net>

2024-10-29, 11:47:30 +0100, Antonio Quartulli wrote:
> +static int ovpn_peer_reset_sockaddr(struct ovpn_peer *peer,
> +				    const struct sockaddr_storage *ss,
> +				    const u8 *local_ip)
> +	__must_hold(&peer->lock)
> +{
> +	struct ovpn_bind *bind;
> +	size_t ip_len;
> +
> +	/* create new ovpn_bind object */
> +	bind = ovpn_bind_from_sockaddr(ss);
> +	if (IS_ERR(bind))
> +		return PTR_ERR(bind);
> +
> +	if (local_ip) {
> +		if (ss->ss_family == AF_INET) {
> +			ip_len = sizeof(struct in_addr);
> +		} else if (ss->ss_family == AF_INET6) {
> +			ip_len = sizeof(struct in6_addr);
> +		} else {
> +			netdev_dbg(peer->ovpn->dev, "%s: invalid family for remote endpoint\n",
> +				   __func__);

ratelimited since that can be triggered from packet processing?


[...]
> +void ovpn_peer_float(struct ovpn_peer *peer, struct sk_buff *skb)
> +{
[...]
> +
> +	switch (family) {
> +	case AF_INET:
> +		sa = (struct sockaddr_in *)&ss;
> +		sa->sin_family = AF_INET;
> +		sa->sin_addr.s_addr = ip_hdr(skb)->saddr;
> +		sa->sin_port = udp_hdr(skb)->source;
> +		salen = sizeof(*sa);
> +		break;
> +	case AF_INET6:
> +		sa6 = (struct sockaddr_in6 *)&ss;
> +		sa6->sin6_family = AF_INET6;
> +		sa6->sin6_addr = ipv6_hdr(skb)->saddr;
> +		sa6->sin6_port = udp_hdr(skb)->source;
> +		sa6->sin6_scope_id = ipv6_iface_scope_id(&ipv6_hdr(skb)->saddr,
> +							 skb->skb_iif);
> +		salen = sizeof(*sa6);
> +		break;
> +	default:
> +		goto unlock;
> +	}
> +
> +	netdev_dbg(peer->ovpn->dev, "%s: peer %d floated to %pIScp", __func__,

                                              %u for peer->id?

and ratelimited too, probably.

(also in ovpn_peer_update_local_endpoint in the previous patch)

> +		   peer->id, &ss);
> +	ovpn_peer_reset_sockaddr(peer, (struct sockaddr_storage *)&ss,
> +				 local_ip);

skip the rehash if this fails? peer->bind will still be the old one so
moving it to the new hash chain won't help (the lookup will fail).

-- 
Sabrina

