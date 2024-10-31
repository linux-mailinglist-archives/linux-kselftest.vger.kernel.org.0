Return-Path: <linux-kselftest+bounces-21203-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9669B79D3
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 12:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD200B2213B
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 11:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3924319AD87;
	Thu, 31 Oct 2024 11:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="J4wFSb9v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YSWouGBP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A548919AD7B;
	Thu, 31 Oct 2024 11:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730374686; cv=none; b=gWjAUunUa+XjsTQVxpOvnxWgyJ38T+/9VNJ4ASiFoosPOHPWbMJAG9678akrxNKWN+X2QjJUXXLFj/3HLAuMNBVSds25r/o0uhuxiaScrhdoHFMBOABSW6rWhMAHEvNE+CS/orY0J0s5+tzfM+XQRn+Zh6sNSrfmjLOVL5ucNHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730374686; c=relaxed/simple;
	bh=+2ezm7ikVucZRjDp6jFTKSXMVY5RmXRwW8UnOs7DnYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q3k2hfWKOvsQ2x4a3licqZ9r5bdZhNDqbLpQG4cX57IgdVJNU85dTJe6iNZoT5yoPhrCEQ61ViGfKy3wQ3zBJSbB85xk/II+olpMKX28NYpB8buRPOYwqmIX60AjJMGk8uMXQYaBZ3d33SQcKxhOrGh9Iims4C92ucTbPAl4MNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=J4wFSb9v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YSWouGBP; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailflow.stl.internal (Postfix) with ESMTP id 3CA761D40124;
	Thu, 31 Oct 2024 07:38:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 31 Oct 2024 07:38:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1730374682; x=
	1730378282; bh=TNLMgpoB1+iWpOPaw3Q130oc/9fY2QyTB1Nrw4iWw7Y=; b=J
	4wFSb9vij9wJagIGTAwjZ5II3rw9gI6oaKM1uOYXkJH3Whx+p+ti4Q+FDycKchZE
	t7/ewJNUuKAVZzTSapqYVvf3navn71aevh4ST+adKu3NMFOZVmasi6OswSo3hUCM
	WQIhqmfomZyIrkW/6OXd3Mp+8Pc9KTo5kL9JEOlJijAYyrqZLjx1fau8dpfOGUVW
	Jn10d9N2sSM7PetFgPWTlTGmGA9c/UUsKhn1Fz29H66bl2Fdjevuy7EtCA2wGg+z
	fUTNOTOU35IhukGvsyS3CvN7xmtflPtS8rWaC5UUzUJrCmVs7/5zaAl3Rvx2AQzh
	BY2VkyzFJlWcRge3AfXbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730374682; x=1730378282; bh=TNLMgpoB1+iWpOPaw3Q130oc/9fY2QyTB1N
	rw4iWw7Y=; b=YSWouGBPqA0WW4YbxjcBVOvN/O7QhOQyIaSnyzYcbfv40yJiAhx
	ZwAP5UNbpG5v2hXkcf7YPfm4kIYmV1DQto5cpEORvPX0W4PKfGgPfX0DGw0jqjxM
	tX1FI2fPVa+FbHuQPOyQQxIKCwvBfPlgzNdm1+ugh3J/wxeAdX4L+G5u29sjNs53
	Sw1bxY4KDU/Ta0KSdwGTmwddt/R9pAjUuFdRftcCdD9AmNhNhUqGnq/eg60fXDR3
	UbBk4g1kerTN5J2fsjstrcD0zBypgW67ydPdtfp+2fLR2J1tN6+G/wOKn6Mz1/LS
	XW0FwfwzGSJv/Xft3PLTZI8QF6IrAxmq9Vg==
X-ME-Sender: <xms:GWwjZxCdZFecVJaTxPc3O3PBYhLf9t7b1PQgq6CgXa7aXqzJV5_Wsw>
    <xme:GWwjZ_hbqY1eodqqtqbuycw47ue9Qm7s43ei4VSdJYA-sDYaE73SMsu9tX4MrTctP
    n_cFECfYp_laERoMvE>
X-ME-Received: <xmr:GWwjZ8lQvUmyRa4rtdv4pFmRrV2HO3-efH1Av4OSCZeEQGTMm3wCcWTi2K2T>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekhedgvdekucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:GWwjZ7xnX4g9sGsfueA5YeryZ9AxtW_J0s9a4UxLJXWN4d1RWHUy8g>
    <xmx:GWwjZ2TXZa15e2xv1xbdb19xxAg92nqqEolOSYugi4rd5Aq8UOGzFg>
    <xmx:GWwjZ-Yp9xw0dSeY8OM_ImII2S79R8iSiZmRedoixJI_S9gVeRjJiw>
    <xmx:GWwjZ3QMh-taBfW19_Q6-MGcfA8W-4AR44nOrliUksbJu-UjPbMRnA>
    <xmx:GWwjZ5H9dWbKWOg8maVDdJbw6vE9WWxXtkTXFedm_K_SzO6KUoeGaZZq>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Oct 2024 07:38:01 -0400 (EDT)
Date: Thu, 31 Oct 2024 12:37:59 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v11 11/23] ovpn: store tunnel and transport
 statistics
Message-ID: <ZyNsFyx3fUtVxSSy@hog>
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-11-de4698c73a25@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241029-b4-ovpn-v11-11-de4698c73a25@openvpn.net>

2024-10-29, 11:47:24 +0100, Antonio Quartulli wrote:
> @@ -136,6 +139,10 @@ void ovpn_decrypt_post(void *data, int ret)
>  		goto drop;
>  	}
>  
> +	/* increment RX stats */
> +	ovpn_peer_stats_increment_rx(&peer->vpn_stats, skb->len);
> +	ovpn_peer_stats_increment_rx(&peer->link_stats, orig_len);

[I don't know much about the userspace implementation, so maybe this
is a silly question]

What's the value of keeping track of 2 separate stats if they are
incremented exactly at the same time? Packet count will be the same,
and the difference in bytes will be just measuring the encap overhead.

Should one of them be "packets/individual messages that get received
over the UDP/TCP link" and the other "packets that get passed up to
the stack"?


> @@ -197,6 +206,8 @@ void ovpn_encrypt_post(void *data, int ret)
>  		goto err;
>  
>  	skb_mark_not_on_list(skb);
> +	ovpn_peer_stats_increment_tx(&peer->link_stats, skb->len);
> +	ovpn_peer_stats_increment_tx(&peer->vpn_stats, orig_len);
>  
>  	switch (peer->sock->sock->sk->sk_protocol) {
>  	case IPPROTO_UDP:

And on TX maybe something like "packets that the stack wants to send
through the tunnel" and "packets that actually make it onto the
UDP/TCP socket after encap/encrypt"?

-- 
Sabrina

