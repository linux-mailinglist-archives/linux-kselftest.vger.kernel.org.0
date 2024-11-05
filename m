Return-Path: <linux-kselftest+bounces-21451-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0129BCA22
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 11:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EBF81F232F0
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 10:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4951D1E68;
	Tue,  5 Nov 2024 10:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="SXDMvxNW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gVbzc6GC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-b1-smtp.messagingengine.com (flow-b1-smtp.messagingengine.com [202.12.124.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF3818BC21;
	Tue,  5 Nov 2024 10:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730801812; cv=none; b=Egl5o59YltMxSlEskcuwT18LQRBDvjHgzoCzVBoqC9QBfu4ytOlwSVOEmoWPQeKBh8mccm+zpfsOHlYX1NDHnEBYRwo/llOHI3UfduhEMKeRkbbVfpQLTBm5wNctNYNUbj3pAZJ3gP0XUNmmBjdL0K99ntMjFDPUnqVOyKHADRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730801812; c=relaxed/simple;
	bh=gZJL5qYt1xTrvOjGX3++AJUT/lFHM04H6Ei8g+IXzes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jqutSGZODBRnSiJSaXh9CIII4NY5eO9yHqcwHG7vUNY30C0IFMgzNtXnU4fG6p/tgl/2KL0qAvGKpUrtx1unEMtMiu5/K0S+Fs0xqRiFnpgojufQQoYCVk6d+BzGA+raTOBX/T8IJA+Jg6UC15VoF9DfU6CcyjG9bRqtCxxPjUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=SXDMvxNW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gVbzc6GC; arc=none smtp.client-ip=202.12.124.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailflow.stl.internal (Postfix) with ESMTP id A06E11D401E9;
	Tue,  5 Nov 2024 05:16:47 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 05 Nov 2024 05:16:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1730801807; x=
	1730805407; bh=VMl+IW+FdIouLKEuIFSXfbNqh2FBd8YbJVQ1lbm+tG8=; b=S
	XDMvxNWxAb1qjhxD2uFZpjWyPfCtLNnV/o1YA7mmiTlfoojmuemaK5yTav+CAapE
	NT/cBahur79oHxZIxcjJJo4l/0xFWWyMV9S9ArQk/QDVZhc/EaawAVyF9ecWcEww
	bnI8vn57F1MILq5lZQIhu7FgpekEOjMBffI+4qqNGg4KQpSV2zj4qmbOSt/1SvjK
	p4gBrd4MfHWwZYEE4p12ng9YIcScmidBK339SMASDxzguqkSBG4DmDTRGepAVn3B
	n9Cnu/ZhS8uLqXMDIlgB3wPc/uk9fudaSwVBZzDwhQ+Z5SsXmrAnY8DJB83HAs82
	5H1b6uS+b5Pp+0RwlWedA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730801807; x=1730805407; bh=VMl+IW+FdIouLKEuIFSXfbNqh2FBd8YbJVQ
	1lbm+tG8=; b=gVbzc6GC7q8l9jxKq8BZjycqsEjByCftlxo+xxbsKOqiEdKiygc
	p7gkeu3jMuda1qAu2eRMdhcOuEmGJ0A9CblS3zjc77YPz0x3///OdyRLBrXM/74F
	MQ9P/d0XbV3SZEZLWtntv3UHgAxW+4E/tUxP+VBEh95oXv4vDl76PiAQxoWVmUyz
	DyeNp3aJCAoT7PYpe5I1fw/PYgJec10xc0OsH3F6TEbm7xvaHLtMpZaiclFq60JQ
	jKitAz6GjnVYWIhCS4ALR1wZwk6f6pf6bWYsZ+B6CiTNf/Hu9AQkm0xeT9hKCKPq
	Z/9yBtkSe9oO/P1ZRHRQqsVuIbl3mrQImcw==
X-ME-Sender: <xms:jvApZxEkTnCPkXVU4lryyBeyr0WpJs7YswF-lHiz11HytyOKMreDZQ>
    <xme:jvApZ2W9TkuoU8Pk1v6FEWezjSAQ0wLzVw11OXIOVd5LaBzKbxTAQ1_J3OdDhBJwK
    FwszUzWr7-KIlZVv38>
X-ME-Received: <xmr:jvApZzK6K_VlxCwRgEEUyl0cg1cFhXYTD1cEJcppShHEHOqGPYqxHoGpxbtu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdelkedgudegucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:jvApZ3Gf4vN3EaceYPPgtYNRwRt74FqiVyOOpQuVmpF_Pskr8lJj5A>
    <xmx:jvApZ3UtLanBcNCy3hau75ZhJv3iljh9X9CIdGK2QjjF1wsLRiFTfw>
    <xmx:jvApZyMV1n2aZ5yVY2BVuStAZRjV5FWrCek8NoL0FXqwqah1UwTI8A>
    <xmx:jvApZ20DBjRDguhrIAqevwfuQCwizitOscABNrhih4G6N_iuxyticQ>
    <xmx:j_ApZzqT5e0t0a3OHmSP0Wr890EFTtRI7pslgmm3ogdfBu5mRSPDFqyf>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 05:16:46 -0500 (EST)
Date: Tue, 5 Nov 2024 11:16:44 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v11 19/23] ovpn: implement key add/get/del/swap
 via netlink
Message-ID: <ZynwjJNz6kLa4p7x@hog>
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-19-de4698c73a25@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241029-b4-ovpn-v11-19-de4698c73a25@openvpn.net>

2024-10-29, 11:47:32 +0100, Antonio Quartulli wrote:
> This change introduces the netlink commands needed to add, get, delete
> and swap keys for a specific peer.
> 
> Userspace is expected to use these commands to create, inspect (non
> sensible data only), destroy and rotate session keys for a specific

nit: s/sensible/sensitive/

> +int ovpn_crypto_config_get(struct ovpn_crypto_state *cs,
> +			   enum ovpn_key_slot slot,
> +			   struct ovpn_key_config *keyconf)
> +{
[...]
> +
> +	rcu_read_lock();
> +	ks = rcu_dereference(cs->slots[idx]);
> +	if (!ks || (ks && !ovpn_crypto_key_slot_hold(ks))) {
> +		rcu_read_unlock();
> +		return -ENOENT;
> +	}
> +	rcu_read_unlock();

You could stay under rcu_read_lock a little bit longer and avoid
taking a reference just to release it immediately.

> +	keyconf->cipher_alg = ovpn_aead_crypto_alg(ks);
> +	keyconf->key_id = ks->key_id;
> +
> +	ovpn_crypto_key_slot_put(ks);
> +
> +	return 0;
> +}


[...]
>  int ovpn_nl_key_get_doit(struct sk_buff *skb, struct genl_info *info)
>  {
[...]
> +	if (NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_KEYCONF], attrs,
> +			      OVPN_A_KEYCONF_PEER_ID))
> +		return -EINVAL;
> +
> +	peer_id = nla_get_u32(attrs[OVPN_A_KEYCONF_PEER_ID]);
> +
> +	peer = ovpn_peer_get_by_id(ovpn, peer_id);
> +	if (!peer) {
> +		NL_SET_ERR_MSG_FMT_MOD(info->extack,
> +				       "cannot find peer with id %u", 0);

                                                                       peer_id?

> +		return -ENOENT;
> +	}
> +
> +	if (NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_KEYCONF], attrs,
> +			      OVPN_A_KEYCONF_SLOT))
> +		return -EINVAL;

Move this check before ovpn_peer_get_by_id? We're leaking a reference
on the peer.


> +
> +	slot = nla_get_u32(attrs[OVPN_A_KEYCONF_SLOT]);
> +
> +	ret = ovpn_crypto_config_get(&peer->crypto, slot, &keyconf);
> +	if (ret < 0) {
> +		NL_SET_ERR_MSG_FMT_MOD(info->extack,
> +				       "cannot extract key from slot %u for peer %u",
> +				       slot, peer_id);
> +		goto err;
> +	}
> +
> +	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
> +	if (!msg) {
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +
> +	ret = ovpn_nl_send_key(msg, info, peer->id, slot, &keyconf,
> +			       info->snd_portid, info->snd_seq, 0);

info->snd_portid and info->snd_seq can be extracted from info directly
in ovpn_nl_send_key since there's no other caller, and flags=0 can be
skipped as well.

> +	if (ret < 0) {
> +		nlmsg_free(msg);
> +		goto err;
> +	}
> +
> +	ret = genlmsg_reply(msg, info);
> +err:
> +	ovpn_peer_put(peer);
> +	return ret;
>  }



[...]
>  int ovpn_nl_key_del_doit(struct sk_buff *skb, struct genl_info *info)
>  {
> -	return -EOPNOTSUPP;
> +	struct nlattr *attrs[OVPN_A_KEYCONF_MAX + 1];
> +	struct ovpn_struct *ovpn = info->user_ptr[0];
> +	enum ovpn_key_slot slot;
> +	struct ovpn_peer *peer;
> +	u32 peer_id;
> +	int ret;
> +
> +	if (GENL_REQ_ATTR_CHECK(info, OVPN_A_KEYCONF))
> +		return -EINVAL;
> +
> +	ret = nla_parse_nested(attrs, OVPN_A_KEYCONF_MAX,
> +			       info->attrs[OVPN_A_KEYCONF],
> +			       ovpn_keyconf_nl_policy, info->extack);
> +	if (ret)
> +		return ret;
> +
> +	if (NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_KEYCONF], attrs,
> +			      OVPN_A_KEYCONF_PEER_ID))
> +		return -EINVAL;
> +
> +	if (ret)
> +		return ret;

leftover?


> +	if (NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_KEYCONF], attrs,
> +			      OVPN_A_KEYCONF_SLOT))
> +		return -EINVAL;

-- 
Sabrina

