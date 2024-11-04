Return-Path: <linux-kselftest+bounces-21380-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F5D9BB358
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 12:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10FDB1C2239C
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 11:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3A81BC07E;
	Mon,  4 Nov 2024 11:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="zvb5TYGP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WjWFaF3h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-b1-smtp.messagingengine.com (flow-b1-smtp.messagingengine.com [202.12.124.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C20A1AF0A6;
	Mon,  4 Nov 2024 11:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730719611; cv=none; b=tR/azD6pMFRoyXANkdfINl5L3MmGEFyGxc/9gGoDAqkdlnG6WXKKGUwyOAsYdbh9uZVltj8mVR3ulXuBhUlVUvx45Mt0ls61iO5+gXR5JeTBnBWJ+1p6m8UOv2OhJcoKZs90aLh7lNkKW9a4py6pY6/0BuWHAlgJbYJNO9xfWtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730719611; c=relaxed/simple;
	bh=kAYEPRitsOzAY6hbeb25oEHVLMhVT9X/0ELkJOdJuLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iRadixvyHVI6BvmQVeG88WG+ui2OAuuQ9pJZvL8rFQ5cOpUXvGsmk93BxI+BAaxgODz7PilGkoP6ykv9PjzS+bF9fCtnc4EFhwn9hT0k4huilEeSWlqAi+MCYHrAtMtpwY28dyLpK87hmUXxOxJ+KYQuSLJwa9EkBdhB5GXvOlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=zvb5TYGP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WjWFaF3h; arc=none smtp.client-ip=202.12.124.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailflow.stl.internal (Postfix) with ESMTP id DE0471D401C1;
	Mon,  4 Nov 2024 06:26:48 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 04 Nov 2024 06:26:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1730719608; x=
	1730723208; bh=Vyghno5J9c7YrXB31VGHCX520h4RHsgzGudOGYt30G8=; b=z
	vb5TYGPMLV7KHhDY/fNiPfYjDm234CydkuuYe+gzy9kAN3DyzRqamRcM+CyGDBQh
	cMLM05BQ6ZVNpegl+664Ll3oKyTHlT5mvEnia3M7nGCY6TyjxcR9dLizxgScTxYR
	zUklS4CjbfwOfifqMHhMNRixQT5QgTK1Ay3GtladkaLH7WauRk21+txvN8Yk4VSA
	4Y5RyPzRqxi3289LEYb26buDRU5HFDW/eU2snhTfa2nCMlO8G6PhXmWp/gBWoz6S
	HU3ZHF8JOwLkmm2xazFIo2AaSPOVB/n2IBxSsYqOQkMAv/irvJOSt3OzWZQ3uszm
	eq/Rw/1KizkKaz9DUB1ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730719608; x=1730723208; bh=Vyghno5J9c7YrXB31VGHCX520h4RHsgzGud
	OGYt30G8=; b=WjWFaF3h55/o8OHp34oaaJVjdmttdYt7/wuWi1eA4zeBcBiFbjG
	1EYkJVBb1Qt3Ysox0T+qN+k0mg/GoQ9Jrx8kKHvJp8p1hqnHs2yG8aKp10FWZKzI
	+TsqGhylWaROH2zdC800tTIVXJnqvz2Wu02BGT5zM9pN8VrGp+KoLesSCkjMHLFr
	9AYBbmIN2vWirEypT8lS10IdUqWGvKRuJeCNez6Ojc14yXHqu4u35IhJe0sS29MM
	DxAHUbBdSzACXenzSZDg1va10+OL6lAWA2PMVvv8nrk6xP92seHywLmtD0fsz0us
	87oH7T6IoRaoa6yUzHgzgZ0cik7kynYQ0fA==
X-ME-Sender: <xms:eK8oZ6TGrv3g1sLJ5lGlXNJA69Y5AgLgzg9W3K4-CeLAYB5SqODpfA>
    <xme:eK8oZ_wHCKmFhlOg5rp7uROdtMDIPtqqKwl2OroysEw_yOA73PCBgV0lK1keCygha
    VSKeIhrDcSU_ENVCMc>
X-ME-Received: <xmr:eK8oZ30mSAsGtHcvqKengwmWFANAyYGxkJGtdtoVWo-LRUmYmoF4OHb2WzVt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeliedgvdejucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:eK8oZ2AdbMYuI8BHolH1pD55qvHE9OZFHExO-_uu_BYlgW8KSYzP4A>
    <xmx:eK8oZziGMC929EjOnaeC630j8U9QTLgU5Vpnu8_cd21gOXEXPlG3EA>
    <xmx:eK8oZyoSxny7nP6a8Ah6xxateTxdGpb7DgMOmvcHUNWcs0W8h1irSA>
    <xmx:eK8oZ2gJ_bG84sLYvdPLicpD7IVPlayDPV_u20O9C17siB0a7tIobw>
    <xmx:eK8oZ0Wo8fVjCfBj5M0j3_irYxf91wQjIF3P5wKrN2MJ0L5PoREuhfau>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Nov 2024 06:26:48 -0500 (EST)
Date: Mon, 4 Nov 2024 12:26:46 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v11 14/23] ovpn: implement peer lookup logic
Message-ID: <ZyivdrpZhx4WpMbn@hog>
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-14-de4698c73a25@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241029-b4-ovpn-v11-14-de4698c73a25@openvpn.net>

2024-10-29, 11:47:27 +0100, Antonio Quartulli wrote:
>  struct ovpn_peer *ovpn_peer_get_by_transp_addr(struct ovpn_struct *ovpn,
>  					       struct sk_buff *skb)
>  {
> -	struct ovpn_peer *peer = NULL;
> +	struct ovpn_peer *tmp, *peer = NULL;
>  	struct sockaddr_storage ss = { 0 };
> +	struct hlist_nulls_head *nhead;
> +	struct hlist_nulls_node *ntmp;
> +	size_t sa_len;
>  
>  	if (unlikely(!ovpn_peer_skb_to_sockaddr(skb, &ss)))
>  		return NULL;
>  
>  	if (ovpn->mode == OVPN_MODE_P2P)
> -		peer = ovpn_peer_get_by_transp_addr_p2p(ovpn, &ss);
> +		return ovpn_peer_get_by_transp_addr_p2p(ovpn, &ss);
> +
> +	switch (ss.ss_family) {
> +	case AF_INET:
> +		sa_len = sizeof(struct sockaddr_in);
> +		break;
> +	case AF_INET6:
> +		sa_len = sizeof(struct sockaddr_in6);
> +		break;
> +	default:
> +		return NULL;
> +	}

You could get rid of that switch by having ovpn_peer_skb_to_sockaddr
also set sa_len (or return 0/the size).

> +
> +	nhead = ovpn_get_hash_head(ovpn->peers->by_transp_addr, &ss, sa_len);
> +
> +	rcu_read_lock();
> +	hlist_nulls_for_each_entry_rcu(tmp, ntmp, nhead,
> +				       hash_entry_transp_addr) {

I think that's missing the retry in case we ended up in the wrong
bucket due to a peer rehash?

> +		if (!ovpn_peer_transp_match(tmp, &ss))
> +			continue;
> +
> +		if (!ovpn_peer_hold(tmp))
> +			continue;
> +
> +		peer = tmp;
> +		break;
> +	}
> +	rcu_read_unlock();
>  
>  	return peer;
>  }

-- 
Sabrina

