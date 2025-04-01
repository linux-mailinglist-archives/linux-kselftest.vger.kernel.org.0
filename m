Return-Path: <linux-kselftest+bounces-29987-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 781B2A77CA8
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Apr 2025 15:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CCB77A2E4E
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Apr 2025 13:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DD120459B;
	Tue,  1 Apr 2025 13:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="PR1Tl/t6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kOKRpO0q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46DB20371A;
	Tue,  1 Apr 2025 13:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743515379; cv=none; b=AAbtxdV5cnTmjcmLz/iih7/rZXusUnco1frQElN4udh9YbMffeWtWKie9mbUawqYbbpRfszHILZE+FUtRx/qj55drkLFjhvbIVlrwAMLtAAFX0RsLEltYC+SxH1GWqz0dcIUmcQuuKTyEFlo92yf9YY0fGW4suMhnq8PCD9Hga8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743515379; c=relaxed/simple;
	bh=jeth/bwBzY8doEtYBJgsfD1LAAzvW37CgYN819KxCvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBakuPcwBBZV5wWqBlQpNLh+lhwlp6Ed0coXl/UmTATNo+tFLnrc0l/ntdGnIXWx/ui3G8bEaXeKcKRbaKgmqIXywmeaPEgWLO8qmaTcOiWKxtsdDIUCQBRX/qSuNks0hyhnE+D4121VMVpiHLn3MVDkdsE4L2o9LeiIWp/qdBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=PR1Tl/t6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kOKRpO0q; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 369042540230;
	Tue,  1 Apr 2025 09:49:35 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 01 Apr 2025 09:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1743515375; x=
	1743601775; bh=IDNWLnNGgo+VaA1pzStaigL03Xw+iXfe/8+bV3Foqqc=; b=P
	R1Tl/t6/ah/BbDH+eD5qFwGmTVrTWzOeEJW75feD8gMY9DX3W2M7hbS4uywyiBM8
	aWqlVACXcI2pgSo4oojXTk4nV9Q8mH8kW3K9cUFwRLTkFXhIq4D8tn9gGC5l1W5a
	uDh+KbIVbFXqCu/k3r6xewe/rFwp6mvwR7rRyCIdu3XZlOLuveHS33kd1eurjgQT
	Jzhm3uGlfC7lqYgBJNXal/C8C/gXSdesOshDbOLfXw8oMtvosIOhDqu2cPIt/rgt
	JLbV6Ffa4wyFgEV88ldrbXWmS+3i/4s+bSM/5Uy6+LppQUNEowuKkLr3lZDM9c38
	1ydaM7WY+G6QQKDkGK3Hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743515375; x=1743601775; bh=IDNWLnNGgo+VaA1pzStaigL03Xw+iXfe/8+
	bV3Foqqc=; b=kOKRpO0qLT+7631+t61z+Wr+8D17CtFfuHnpdjh09HfyxemYmbG
	dSEkZ8vHgxmQx1PQgQyqPEoCa0EGJpbSSV5fL5IBI4r1jb6ALYGO+pRssn5q4rLE
	wek3cNXA4JuSTM60Y/spxuUgQB7UgnDbe+SmUM3mY/ged1g5G402HAeSktgwlSGw
	sTzFpqRd23WW8i2A70t719e2wfGV8YxL+AzIk/GG3SHw/TdRQumo/hwNC3Mk3OKW
	kNdaQps10Zr2ALgQhMMDmOu5+Fsw91y3uAvcoYxJbNYN1lDMXDpkKSst6todeTHC
	LB4UPM5SI3bZzEdmSrXGVP83QANvaEpMlUA==
X-ME-Sender: <xms:7u7rZ-LoFvBMA0vs6fHYu_oxudWyGWLFEPi6-8uMS4wiJftyHd-J3g>
    <xme:7u7rZ2JQSsPfjdQmPKYY23A_DcFEwBoD1ReBD8ua17mwSOvYDHP2nzIsnZmNlnqxD
    yaHaDzhpBJBhDdvLCU>
X-ME-Received: <xmr:7u7rZ-udlPgakiG0OXQhgLfO5sOjCkZYtw8P3y-aIyzT1FqKXHGyQO5ZcH8K>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukedvleegucetufdoteggodetrf
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
X-ME-Proxy: <xmx:7u7rZzbLrwCcsT5I9vIn31J0oy8TjzAo_ovB6in--X9f9jSPC1ussg>
    <xmx:7u7rZ1bOd6FCYmP1T4bNqnmi57ysuAFMVv86kSaLqPr1G5JJsQFJKw>
    <xmx:7u7rZ_C6kq-zuSM8-5Sld5m-RQFuQXodfDddLNOdBoo0QuBWhMoSeQ>
    <xmx:7u7rZ7bJSn3cc8s11fkAq70yaIL98plcGTWHkFPVNGIzNM7T9C1AOQ>
    <xmx:7-7rZ5oZsvBW3JPT5lM_WhxSmj9l9vkOGcpf1VH3L5aSm8_rrQ8EgU6G>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Apr 2025 09:49:34 -0400 (EDT)
Date: Tue, 1 Apr 2025 15:49:32 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
Subject: Re: [PATCH net-next v24 07/23] ovpn: implement basic TX path (UDP)
Message-ID: <Z-vu7AWTwWE2D_df@krikkit>
References: <20250318-b4-ovpn-v24-0-3ec4ab5c4a77@openvpn.net>
 <20250318-b4-ovpn-v24-7-3ec4ab5c4a77@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250318-b4-ovpn-v24-7-3ec4ab5c4a77@openvpn.net>

2025-03-18, 02:40:42 +0100, Antonio Quartulli wrote:
> +static int ovpn_udp_output(struct ovpn_peer *peer, struct dst_cache *cache,
> +			   struct sock *sk, struct sk_buff *skb)
> +{
> +	struct ovpn_bind *bind;
> +	int ret;
> +
> +	/* set sk to null if skb is already orphaned */
> +	if (!skb->destructor)
> +		skb->sk = NULL;
> +
> +	/* always permit openvpn-created packets to be (outside) fragmented */
> +	skb->ignore_df = 1;

Have you tested this with IPv4 encap? AFAICT it doesn't have any
effect because of the call chain:

ovpn_udp4_output -> udp_tunnel_xmit_skb -> iptunnel_xmit -> skb_scrub_packet

which does

    skb->ignore_df = 0;


But since you pass df = 0 to udp_tunnel_xmit_skb, I suspect it works
as intended despite skb_scrub_packet.


[note: that was the last comment I wanted to send, I have a few more
suggestions that don't need to be addressed at this time]

> +
> +	rcu_read_lock();
> +	bind = rcu_dereference(peer->bind);
> +	if (unlikely(!bind)) {
> +		net_warn_ratelimited("%s: no bind for remote peer %u\n",
> +				     netdev_name(peer->ovpn->dev), peer->id);
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +
> +	switch (bind->remote.in4.sin_family) {
> +	case AF_INET:
> +		ret = ovpn_udp4_output(peer, bind, cache, sk, skb);
> +		break;
> +#if IS_ENABLED(CONFIG_IPV6)
> +	case AF_INET6:
> +		ret = ovpn_udp6_output(peer, bind, cache, sk, skb);
> +		break;
> +#endif
> +	default:
> +		ret = -EAFNOSUPPORT;
> +		break;
> +	}
> +
> +out:
> +	rcu_read_unlock();
> +	return ret;
> +}

-- 
Sabrina

