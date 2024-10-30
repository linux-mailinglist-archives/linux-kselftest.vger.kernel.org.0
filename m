Return-Path: <linux-kselftest+bounces-21144-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EEF9B6953
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 17:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6C4D1F223AC
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 16:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD05A2144CB;
	Wed, 30 Oct 2024 16:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="OjbaD3If";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IJQStmZb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-a4-smtp.messagingengine.com (flow-a4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F17B2144BD;
	Wed, 30 Oct 2024 16:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730306237; cv=none; b=HKtwZiyk7yKw/WNVxrSVFkFNMMjwUq+zUdG5x8y3K86kVAAgf0iqSPfbwJqFx7ZUVZz/D6ZKiIfpLOTQ+e2S62bZvA2J0ovnBiFEdlNhyekgtWDIWlorVCMejNfb3VOKnAvWMaxcnCpUnlNDTORzbU7XMq/B1P4dRomdl/SoaK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730306237; c=relaxed/simple;
	bh=RA8564CILpYMfKHe/rxav+joREUWQdjfvWmXA5PdQ6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V65r1WNKCwq/F13ee/hlkcKpJhKlOsW6InVN5lORBx7lCuJfEZzoZMlk33+7Bj3T6/FsWxpC55C9J17tsdFUyTnxh4vqtywU9eihN7nxOqCOWYDiv0vJQENpmpF21nYRDwIgdzoK5WfSRKLfceKmNdhIOWTRVWd7jKZRbJkiJws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=OjbaD3If; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IJQStmZb; arc=none smtp.client-ip=103.168.172.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailflow.phl.internal (Postfix) with ESMTP id 6655A200611;
	Wed, 30 Oct 2024 12:37:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 30 Oct 2024 12:37:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1730306232; x=
	1730309832; bh=jqj8WIPklrVMybUSdAmqzyKauJQM71dsz46etmGUYyw=; b=O
	jbaD3IfOd8+WFG7evNAYwuGoHha5H0dEdthQWO4uvh8X806k+Ob1ObTyObloT+lu
	4G21aiDFcFBQAJitOBoHCcOydT6fl7vPQHcPlgvggW7/5XFqGGelxYgzFjdIe7Bv
	WjbYZFaLw5Ho0/QMcOQwPr1IPij94vraF14cNnzXtwbm/pKGije5dg4ZAlFM8BZL
	h+fXPVSZOaoncJiwVzNCCeDDVTdW9EHArqMSZ7DT63HQFLXTE054dYZfRWhIDqRS
	C74clnlkTQOQDeSmV6piLH8jgYLkTAockONbVWggwziiE4Hj2aPZJ+Vi7DSpUTkd
	S8xW1BV933CsFbPb6ebdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730306232; x=1730309832; bh=jqj8WIPklrVMybUSdAmqzyKauJQM71dsz46
	etmGUYyw=; b=IJQStmZbXCBpgB22Vmu8MQkghSjYA2ErPnadjjatE1fZDopcq8e
	Bo/vHMWquL0huuV15Kz/oMfewtzraitK3XO/8qKOt9gX63kvb/sKGoWxZjZ1zjTE
	nW79WUxc14ic7F/05lpNzd7azu2L2BGp8kImYh8PM87/lg4KtpTvLhfcM4nAzQV+
	tb7QzWVoJRXI54CVGMef2TeQfz8MBDds3aBE8sb53ozFW+rk5RuP8oAZSnYCkxfB
	pyau+KyZrWxzeWEtWj6T2IxkNMALv1kny3DuxJd/rPH97tkCbqjAMc5EleVegn46
	1Z2GLBpRTS0lDCl9r/Mn2cpFT2oflEP+u3A==
X-ME-Sender: <xms:t2AiZ9IXWHTtLsSEOiUVfldzThM4lJU7tmfnmw8pmZt-WMC5XFJZUw>
    <xme:t2AiZ5LsdgihaNnwPIKEjHxF3q8-nB-PEjlJrVjEsoiP8xXrALL_MH6WSewjdSDSk
    KqKLridOqWCMMujza8>
X-ME-Received: <xmr:t2AiZ1s-Jh1ydDkzDTOnQjOZ-HUYay4BTb82xwlzTEzvZplyYkhmF0y5UxvT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekfedgledtucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:t2AiZ-a6FXBUmzj4vB-Q-0QLXh_LlD9tdayaPvTVhQqipwaPx6rCCQ>
    <xmx:t2AiZ0b8djvpui_Lm7hktwf88zUNijqGcZboewEBaScacFdaEXrPMA>
    <xmx:t2AiZyDqvv2N1CgxniNbexpjH33ZD4lubBfV5djvhrJ7qthDB85rbA>
    <xmx:t2AiZyYBwJjgORuTh0C_3WsWfT4rkItkc0SanqyEI_d40a1nX3CmPw>
    <xmx:uGAiZ6NzHUyuggVl19ndkuPBAPG0HeoOv_xM3DZAmfecmpFQm7DLebBx>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Oct 2024 12:37:11 -0400 (EDT)
Date: Wed, 30 Oct 2024 17:37:07 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v11 06/23] ovpn: introduce the ovpn_peer object
Message-ID: <ZyJgs6Vrvzji8qvS@hog>
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-6-de4698c73a25@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241029-b4-ovpn-v11-6-de4698c73a25@openvpn.net>

2024-10-29, 11:47:19 +0100, Antonio Quartulli wrote:
> +static void ovpn_peer_release(struct ovpn_peer *peer)
> +{
> +	ovpn_bind_reset(peer, NULL);
> +
> +	dst_cache_destroy(&peer->dst_cache);

Is it safe to destroy the cache at this time? In the same function, we
use rcu to free the peer, but AFAICT the dst_cache will be freed
immediately:

void dst_cache_destroy(struct dst_cache *dst_cache)
{
[...]
	free_percpu(dst_cache->cache);
}

(probably no real issue because ovpn_udp_send_skb gets called while we
hold a reference to the peer?)

> +	netdev_put(peer->ovpn->dev, &peer->ovpn->dev_tracker);
> +	kfree_rcu(peer, rcu);
> +}


[...]
> +static int ovpn_peer_del_p2p(struct ovpn_peer *peer,
> +			     enum ovpn_del_peer_reason reason)
> +	__must_hold(&peer->ovpn->lock)
> +{
> +	struct ovpn_peer *tmp;
> +
> +	tmp = rcu_dereference_protected(peer->ovpn->peer,
> +					lockdep_is_held(&peer->ovpn->lock));
> +	if (tmp != peer) {
> +		DEBUG_NET_WARN_ON_ONCE(1);
> +		if (tmp)
> +			ovpn_peer_put(tmp);

Does peer->ovpn->peer need to be set to NULL here as well? Or is it
going to survive this _put?

> +
> +		return -ENOENT;
> +	}
> +
> +	tmp->delete_reason = reason;
> +	RCU_INIT_POINTER(peer->ovpn->peer, NULL);
> +	ovpn_peer_put(tmp);
> +
> +	return 0;
> +}

-- 
Sabrina

